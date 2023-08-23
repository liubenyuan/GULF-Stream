GULF_Stream_IPCore:
	$(MAKE) -C src
	$(MAKE) -C ip_repo/assembled_ips

loopback_example: GULF_Stream_IPCore
	$(MAKE) -C examples loopback_server

benchmark_example: GULF_Stream_IPCore
	$(MAKE) -C ip_repo/assembled_ips GULF_Stream_benchmark
	$(MAKE) -C examples benchmark

clean_all:
	$(MAKE) -C examples clean
	$(MAKE) -C ip_repo/hls_ips clean
