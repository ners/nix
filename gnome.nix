{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		gnome3.adwaita-icon-theme
		gnome3.gnome-tweak-tool
		gnome3.networkmanagerapplet
		gnomeExtensions.appindicator
		libappindicator
		yaru-theme
	];
	
	services = {
		xserver = {
			displayManager.gdm = {
				enable = true;
				wayland = true;
			};
			desktopManager.gnome.enable = true;
		};
		gnome = {
			core-os-services.enable = true;
			core-shell.enable = true;
		};
	};

	fonts = {
		fontconfig.enable = true;
		fontDir.enable = true;
		enableGhostscriptFonts = true;
		fonts = with pkgs; [
			(nerdfonts.override { fonts = [ "RobotoMono" ]; })
			carlito
			corefonts
			dejavu_fonts
			inconsolata
			inter
			inter-ui
			noto-fonts
			noto-fonts-emoji
			noto-fonts-extra
			roboto
			roboto-mono
			source-code-pro
			source-sans-pro
			source-serif-pro
		];
		fontconfig.localConf = ''
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
	<alias binding="weak">
		<family>monospace</family>
		<prefer>
			<family>emoji</family>
		</prefer>
	</alias>
	<alias binding="weak">
		<family>sans-serif</family>
		<prefer>
			<family>emoji</family>
		</prefer>
	</alias>
	<alias binding="weak">
		<family>serif</family>
		<prefer>
			<family>emoji</family>
		</prefer>
	</alias>
</fontconfig>
		'';
		fontconfig.defaultFonts = {
			sansSerif = ["Arimo"];
			serif = ["Tinos"];
			monospace = ["Cousine"];
			emoji = ["Noto Color Emoji"];
		};
	};
	
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
	};

	programs = {
		dconf.enable = true;
		mtr.enable = true;
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
		nm-applet.enable = true;
	};
}
