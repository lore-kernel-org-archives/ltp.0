From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 25 Apr 2018 18:00:06 +0800
Subject: [LTP] [PATCH v2 2/2] sctp_big_chunk: make INIT packet in the
	test
In-Reply-To: <1524575041-16127-2-git-send-email-alexey.kodanev@oracle.com>
References: <1524575041-16127-1-git-send-email-alexey.kodanev@oracle.com>
 <1524575041-16127-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <5AE051A6.6090905@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

This patch set works well on my environment, and it looks good to me.

Thanks,
Xiao Yang
On 2018/04/24 21:04, Alexey Kodanev wrote:
> Since creating many different IP addresses and binding them
> to the same SCTP socket is a time consuming process, prepare
> SCTP INIT chunk in the test.
>
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> v2: * the test doesn't support IPv6 fragmentation, TCONF in that case
>     * add needs_root since we use a raw socket
>
>  runtest/cve                             |    1 -
>  testcases/network/sctp/sctp_big_chunk.c |  105 +++++++++++++++++++++++++++----
>  2 files changed, 93 insertions(+), 13 deletions(-)
>
> diff --git a/runtest/cve b/runtest/cve
> index 1d9569a..2f4171c 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -33,4 +33,3 @@ cve-2017-17052 cve-2017-17052
>  cve-2017-16939 cve-2017-16939
>  cve-2017-17053 cve-2017-17053
>  cve-2018-5803 sctp_big_chunk
> -cve-2018-5803_2 sctp_big_chunk -a 10000
> diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
> index 55a2969..89c5e0d 100644
> --- a/testcases/network/sctp/sctp_big_chunk.c
> +++ b/testcases/network/sctp/sctp_big_chunk.c
> @@ -24,12 +24,14 @@
>  #include <sys/types.h>
>  #include <sys/socket.h>
>  #include <netinet/in.h>
> +#include <netinet/ip.h>
> +#include <netinet/ip6.h>
>  #include <netdb.h>
>  #include <sys/syscall.h>
> -#include <fcntl.h>
>  
>  #include "tst_test.h"
>  #include "tst_safe_stdio.h"
> +#include "tst_checksum.h"
>  #include "lapi/netinet_in.h"
>  #include "lapi/socket.h"
>  #include "lapi/sctp.h"
> @@ -38,6 +40,8 @@ static int port;
>  static int sfd, cfd;
>  static struct sockaddr_in6 rmt, loc;
>  
> +static uint8_t packet[IP_MAXPACKET];
> +static int pkt_len;
>  static char *addr_param;
>  static int addr_num = 3273;
>  
> @@ -53,35 +57,108 @@ static void setup_server(void)
>  	tst_res(TINFO, "sctp server listen on %d", port);
>  
>  	SAFE_LISTEN(sfd, 1);
> +
> +	srand(port);
> +}
> +
> +static void update_packet_field(size_t *off, void *buf, size_t buf_len)
> +{
> +	memcpy(packet + *off, buf, buf_len);
> +	*off += buf_len;
>  }
>  
>  static void setup_client(void)
>  {
> -	struct sockaddr_in6 addr_buf[addr_num];
> +	struct ip6_hdr ip6;
> +	const size_t ip6_hdr_len = sizeof(ip6);
> +	size_t cmn_hdr_off;
> +	size_t off;
>  	int i;
>  
> -	cfd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, IPPROTO_SCTP);
> +	memset(&ip6, 0, sizeof(ip6));
> +	ip6.ip6_flow = htonl(6 << 28 | 2 << 20);
> +	ip6.ip6_hops = 64;
> +	ip6.ip6_nxt = IPPROTO_SCTP;
> +	ip6.ip6_src.s6_addr[15] = 1;
> +	ip6.ip6_dst.s6_addr[15] = 1;
>  	rmt.sin6_family = AF_INET6;
>  	rmt.sin6_addr = in6addr_loopback;
> -	rmt.sin6_port = htons(port);
>  
> -	tst_res(TINFO, "bind %d additional IP addresses", addr_num);
> +	/* SCTP common header */
> +	off = ip6_hdr_len;
> +
> +	uint16_t src_port = htons(port - 1);
> +	uint16_t dst_port = htons(port);
> +	uint32_t vtag = 0;
> +	uint32_t checksum = 0;
> +
> +	update_packet_field(&off, &src_port, 2);
> +	update_packet_field(&off, &dst_port, 2);
> +	update_packet_field(&off, &vtag, 4);
> +	update_packet_field(&off, &checksum, 4);
> +	cmn_hdr_off = off;
> +
> +	/* SCTP INIT chunk */
> +	uint16_t chunk_len;
> +
> +	packet[off++] = 1;
> +	packet[off++] = 0;
> +	off += 2; /* chunk length, will be set in the end */
> +
> +	uint32_t init_tag = rand();
> +	uint32_t rwnd = htonl(106496);
> +	uint16_t outs = htons(10);
> +	uint16_t ins = htons(65535);
> +	uint32_t init_tsn = rand();
> +
> +	update_packet_field(&off, &init_tag, 4);
> +	update_packet_field(&off, &rwnd, 4);
> +	update_packet_field(&off, &outs, 2);
> +	update_packet_field(&off, &ins, 2);
> +	update_packet_field(&off, &init_tsn, 4);
>  
> -	memset(addr_buf, 0, sizeof(addr_buf));
> +	/* SCTP optional parameter for IPv6 addresses */
> +	uint16_t param_type = htons(6);
> +	uint16_t param_len = htons(20);
> +
> +	/* IPv6(40) + SCTP_COMMON(12) + SCTP_CHUNK(20) + SCTP_OPT(65460)) */
>  	for (i = 0; i < addr_num; ++i) {
> -		addr_buf[i].sin6_family = AF_INET6;
> -		addr_buf[i].sin6_addr = in6addr_loopback;
> +		update_packet_field(&off, &param_type, 2);
> +		update_packet_field(&off, &param_len, 2);
> +		packet[off + 15] = 1;
> +		off += 16;
>  	}
> +	pkt_len = off;
> +
> +	tst_res(TINFO, "set chunk length %zu", pkt_len - cmn_hdr_off);
> +	chunk_len = htons(pkt_len - cmn_hdr_off);
> +	memcpy(packet + cmn_hdr_off + 2, &chunk_len, 2);
> +
> +	/* set checksum for SCTP: common header + INIT chunk */
> +	uint32_t csum = tst_crc32c(packet + ip6_hdr_len, pkt_len - ip6_hdr_len);
> +
> +	memcpy(packet + ip6_hdr_len + 8, &csum, 4);
> +
> +	ip6.ip6_plen = htons(pkt_len - ip6_hdr_len);
> +	memcpy(packet, &ip6, ip6_hdr_len);
>  
> -	SAFE_SETSOCKOPT(cfd, SOL_SCTP, SCTP_SOCKOPT_BINDX_ADD, addr_buf,
> -			sizeof(addr_buf));
> +	cfd = SAFE_SOCKET(AF_INET6, SOCK_RAW, IPPROTO_RAW);
>  }
>  
> +static const char mtu_path[] = "/sys/class/net/lo/mtu";
> +static const unsigned int max_mtu = 65535;
> +static unsigned int mtu;
> +
>  static void setup(void)
>  {
>  	if (tst_parse_int(addr_param, &addr_num, 1, INT_MAX))
>  		tst_brk(TBROK, "wrong address number '%s'", addr_param);
>  
> +	/* We don't fragment IPv6 packet here yet, check that MTU is 65535 */
> +	SAFE_FILE_SCANF(mtu_path, "%d", &mtu);
> +	if (mtu < max_mtu)
> +		tst_brk(TCONF, "Test needs that 'lo' MTU has %d", max_mtu);
> +
>  	setup_server();
>  	setup_client();
>  }
> @@ -89,6 +166,7 @@ static void setup(void)
>  static void run(void)
>  {
>  	int pid = SAFE_FORK();
> +	int i;
>  
>  	if (!pid) {
>  		struct sockaddr_in6 addr6;
> @@ -99,8 +177,10 @@ static void run(void)
>  		exit(0);
>  	}
>  
> -	fcntl(cfd, F_SETFL, O_NONBLOCK);
> -	connect(cfd, (struct sockaddr *)&rmt, sizeof(rmt));
> +	for (i = 0; i < 3; ++i) {
> +		SAFE_SENDTO(1, cfd, packet, pkt_len, 0,
> +			(struct sockaddr *)&rmt, sizeof(rmt));
> +	}
>  
>  	SAFE_KILL(pid, SIGKILL);
>  	SAFE_WAITPID(pid, NULL, 0);
> @@ -114,6 +194,7 @@ static struct tst_option options[] = {
>  };
>  
>  static struct tst_test test = {
> +	.needs_root = 1,
>  	.setup = setup,
>  	.forks_child = 1,
>  	.test_all = run,



