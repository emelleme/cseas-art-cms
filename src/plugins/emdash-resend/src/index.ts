import type { PluginDescriptor } from "emdash";

export interface ResendPluginOptions {
	apiKey?: string;
}

export function resendPlugin(options: ResendPluginOptions = {}): PluginDescriptor {
	return {
		id: "emdash-resend",
		version: "1.0.0",
		format: "standard",
		entrypoint: "emdash-resend/sandbox",
		options,
		capabilities: ["email:provide", "network:fetch"],
		allowedHosts: ["api.resend.com"],
		storage: {},
		admin: {
			settingsSchema: {
				apiKey: {
					type: "secret",
					label: "Resend API Key",
					description: "Your Resend API key (starts with re_)",
				},
			},
		},
	};
}
