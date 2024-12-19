# Neural_Correlates_of_Mislocalization

This repository includes the sample data and codes for the following paper: [Neural_Correlates_of_Mislocalization](https://www.nature.com/articles/s41467-024-50545-0#code-availability)

mislocalization.m loads the behavioral data for mislocalization and localization errors and generates Fig. 1b-c.

spatial_bias.m loads the spatial bias averaged across delay 50-100 ms and generates Fig. 3d&f. The spatial bias values were computed from spatiotemporal kernels using the custom function find_bias.m.

neural_response.m loads the normalized model-predicted and neuron responses and generates Fig. 5c and Fig. 6c.

decoder.m loads the confusion matrices from the decoding results based on single neurons and generates Supplementary Fig. 4.
