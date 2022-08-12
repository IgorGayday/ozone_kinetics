function [Keqs_m3, threshold_energies_j] = calculate_formation_decay_equilibrium_2(o3_molecule, states, temp_k, ...
  optional)
% Provides a simpler interface to calculate_formation_decay_equilibrium
  [threshold_energies_j, threshold_js] = get_threshold_energies_2(o3_molecule, states, optional);
  part_funcs_o2_m_3 = calculate_part_func_channels(o3_molecule, threshold_js, temp_k);
  Keqs_m3 = calculate_formation_decay_equilibrium(states, temp_k, part_funcs_o2_m_3, threshold_energies_j, optional);
end