import { definePlugin } from "emdash";
import type { PluginContext } from "emdash";
import type { ResendPluginOptions } from "./index";

export default definePlugin({
	hooks: {
		"email:deliver": {
			exclusive: true,
			handler: async (event, ctx) => {
				const { message } = event;
				const options = ctx.options as ResendPluginOptions;

				// Check options first (set via astro.config.mjs), then fall back to KV settings
				let apiKey = options.apiKey;
				if (!apiKey) {
					apiKey = await ctx.kv.get<string>("settings:apiKey");
				}

				if (!apiKey) {
					ctx.log.error("Resend API key not configured");
					return;
				}

				const body: Record<string, unknown> = {
					from: message.from,
					to: message.to,
					subject: message.subject,
					html: message.html,
				};

				if (message.text) {
					body.text = message.text;
				}

				if (message.replyTo) {
					body.reply_to = message.replyTo;
				}

				if (message.cc) {
					body.cc = message.cc;
				}

				if (message.bcc) {
					body.bcc = message.bcc;
				}

				await ctx.http!.fetch("https://api.resend.com/emails", {
					method: "POST",
					headers: {
						Authorization: `Bearer ${apiKey}`,
						"Content-Type": "application/json",
					},
					body: JSON.stringify(body),
				});

				ctx.log.info(`Email sent to ${message.to}`, { subject: message.subject });
			},
		},
	},
});
