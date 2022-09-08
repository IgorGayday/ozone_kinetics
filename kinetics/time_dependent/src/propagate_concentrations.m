function [concentrations_per_m3, derivatives_per_m3_s] = propagate_concentrations(...
  o3_molecule, states, initial_concentrations_per_m3, equilibrium_constants_m3, time_s, ...
  sigma0_m2, temp_k, M_conc_per_m3, dE_j, transition_model, optional)
% Propagates states' concentrations
% Level specifies level of theory

  transition_matrix_m3_per_s = calculate_transition_matrix(o3_molecule, temp_k, sigma0_m2, states, dE_j, ...
    transition_model);
  decay_rates_per_s = get_decay_coeffs_2(o3_molecule, states, optional);
  transition_matrix_mod_m3_per_s = (transition_matrix_m3_per_s - diag(sum(transition_matrix_m3_per_s, 2)))';
  ode_func = @(t, y) do3dt(transition_matrix_mod_m3_per_s, decay_rates_per_s, equilibrium_constants_m3, ...
    M_conc_per_m3, y);

  options = odeset('RelTol', 1e-13, 'AbsTol', 1e-15);
  [~, concentrations_per_m3] = ode89(ode_func, time_s, initial_concentrations_per_m3, options);
  derivatives_per_m3_s = row_function(@(row) ode_func(0, row')', concentrations_per_m3);
end