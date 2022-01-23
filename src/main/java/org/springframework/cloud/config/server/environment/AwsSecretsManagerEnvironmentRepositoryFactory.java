package org.springframework.cloud.config.server.environment;

import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.secretsmanager.AWSSecretsManager;
import com.amazonaws.services.secretsmanager.AWSSecretsManagerClientBuilder;
import org.springframework.cloud.config.server.config.ConfigServerProperties;

public class AwsSecretsManagerEnvironmentRepositoryFactory implements
		EnvironmentRepositoryFactory<AwsSecretsManagerEnvironmentRepository, AwsSecretsManagerEnvironmentProperties> {

	private final ConfigServerProperties configServerProperties;

	public AwsSecretsManagerEnvironmentRepositoryFactory(ConfigServerProperties configServerProperties) {
		this.configServerProperties = configServerProperties;
	}

	@Override
	public AwsSecretsManagerEnvironmentRepository build(AwsSecretsManagerEnvironmentProperties environmentProperties) {
		AWSSecretsManagerClientBuilder clientBuilder = AWSSecretsManagerClientBuilder.standard();

		if (environmentProperties.getRegion() != null) {
			if (environmentProperties.getEndpoint() != null) {
				AmazonS3ClientBuilder.EndpointConfiguration endpointConfiguration = new AmazonS3ClientBuilder.EndpointConfiguration(
						environmentProperties.getEndpoint(), environmentProperties.getRegion());
				clientBuilder.withEndpointConfiguration(endpointConfiguration);
			}
			else {
				clientBuilder.withRegion(environmentProperties.getRegion());
			}
		}

		AWSSecretsManager client = clientBuilder.build();
		return new AwsSecretsManagerEnvironmentRepository(client, configServerProperties, environmentProperties);
	}

}
