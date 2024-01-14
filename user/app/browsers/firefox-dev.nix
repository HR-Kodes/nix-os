{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox-devedition-bin-unwrapped
  ];
  
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-devedition-bin-unwrapped {
      # forceWayland = true;
      extraPolicies = {
        ExtensionSettings = { };
      };

      };


        profiles = {
            me = {
                id = 0;
                name = "dev-edition-default";
                search = {
                    force = true;
                    # default = "DuckDuckGo";
                    engines = {
                        "Nix Packages" = {
                            urls = [{
                                template = "https://search.nixos.org/packages";
                                params = [
                                    { name = "type"; value = "packages"; }
                                    { name = "query"; value = "{searchTerms}"; }
                                ];
                            }];
                            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                            definedAliases = [ "@np" ];
                        };
                        # "Google".metaData.hidden = true;
                        "Amazon.com".metaData.hidden = true;
                        "Bing".metaData.hidden = true;
                        "eBay".metaData.hidden = true;
                    };
                };
                settings = {
                    "general.smoothScroll" = true;
                };
            };
        };


      };


   # profiles.personal = {
   #   
   #   bookmarks = [
   #     {
   #       name = "wikipedia";
   #       tags = [ "wiki" ];
   #       keyword = "wiki";
   #       url = "https://en.wikipedia.org/";
   #     }
   #   ];

   # };

  # profiles = {
  #   dev-edition-default = {
  #     id = 0;
  #     name = "Personal";
  #     bookmarks = [
  #       {
  #         name = "wikipedia";
  #         tags = [ "wiki" ];
  #         keyword = "wiki";
  #         url = "https://en.wikipedia.org/";
  #       }
  #     ];
  #   };
  #   personal = {
  #     id = 1;
  #     name = "College";
  #   };
  #  };

  #};
}
