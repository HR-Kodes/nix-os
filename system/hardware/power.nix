{ config, pkgs, ... }:

{
  # services.auto-cpufreq.enable = true;
  # services.auto-cpufreq.settings = {
  #   charger = {
  #     governer = "performance";
  #     trubo = "auto";
  #   };
  #
  #   battery = {
  #     governer = "schedutil";
  #     scaling_max_freq = 3800000;
  #     turbo = "never";
  #   };
  # };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNER_ON_AC = "performance";
      CPU_SCALING_GOVERNER_ON_BAT = "schedutil";

      CPU_ENERGY_PREF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PREF_POLICY_ON_AC = "performance";

      CPU_MIN_PREF_ON_AC = 0;
      CPU_MAX_PREF_ON_AC = 100;
      CPU_MIN_PREF_ON_BAT = 0;
      CPU_MAX_PREF_ON_BAT = 80;

    };
  };
}
