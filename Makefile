all: loopback_example

GULF_Stream_IPCore:
	$(MAKE) -C src hls_ip
	$(MAKE) -C src assemble_ip
	$(MAKE) -C src GULF_stream

loopback_example: GULF_Stream_IPCore
	$(MAKE) -C examples loopback_server

benchmark_example: GULF_Stream_IPCore
	$(MAKE) -C ip_repo/assembled_ips GULF_Stream_benchmark
	$(MAKE) -C examples benchmark

clean:
	$(MAKE) -C examples clean
	$(MAKE) -C ip_repo/hls_ips clean
	$(MAKE) -C ip_repo/assembled_ips clean
