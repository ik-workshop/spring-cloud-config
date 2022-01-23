package org.springframework.cloud.config.server.environment;

import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagement;
import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagementClientBuilder;

import org.springframework.cloud.config.server.config.ConfigServerProperties;

public class AwsParameterStoreEnvironmentRepositoryFactory implements
		EnvironmentRepositoryFactory<AwsParameterStoreEnvironmentRepository, AwsParameterStoreEnvironmentProperties> {

	private final ConfigServerProperties configServerProperties;

	public AwsParameterStoreEnvironmentRepositoryFactory(ConfigServerProperties configServerProperties) {
		this.configServerProperties = configServerProperties;
	}

	@Override
	public AwsParameterStoreEnvironmentRepository build(AwsParameterStoreEnvironmentProperties environmentProperties) {
		AWSSimpleSystemsManagementClientBuilder clientBuilder = AWSSimpleSystemsManagementClientBuilder.standard();

		if (environmentProperties.getRegion() != null) {
			if (environmentProperties.getEndpoint() != null) {
				AwsClientBuilder.EndpointConfiguration endpointConfiguration = new AwsClientBuilder.EndpointConfiguration(
						environmentProperties.getEndpoint(), environmentProperties.getRegion());
				clientBuilder.withEndpointConfiguration(endpointConfiguration);
			}
			else {
				clientBuilder.withRegion(environmentProperties.getRegion());
			}
		}

		AWSSimpleSystemsManagement client = clientBuilder.build();

		return new AwsParameterStoreEnvironmentRepository(client, configServerProperties, environmentProperties);
	}

}
