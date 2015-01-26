Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YFma9-0002b1-Sq
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 16:32:09 +0000
Date: Mon, 26 Jan 2015 17:31:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150126163110.GA29158@rei>
References: <1420769778.369.14.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1420769778.369.14.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH] Fix warning
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> diff --git a/testcases/kernel/io/disktest/dump.c b/testcases/kernel/io/disktest/dump.c
> index eef119b..ffb5ce1 100644
> --- a/testcases/kernel/io/disktest/dump.c
> +++ b/testcases/kernel/io/disktest/dump.c
> @@ -173,7 +173,7 @@ int dump_data(FILE * stream, const char *buff, const size_t buff_siz,
>  
>  int do_dump(child_args_t * args)
>  {
> -	size_t NumBytes = 0;
> +	ssize_t NumBytes = 0;
>  	OFF_T TargetLBA, TotalBytes = 0;
>  	char *buff;
>  	fd_t fd;
> diff --git a/testcases/kernel/syscalls/munmap/munmap01.c b/testcases/kernel/syscalls/munmap/munmap01.c
> index 67eb74b..0c16f34 100644
> --- a/testcases/kernel/syscalls/munmap/munmap01.c
> +++ b/testcases/kernel/syscalls/munmap/munmap01.c
> @@ -152,7 +152,7 @@ int main(int ac, char **av)
>   */

This one is OK.

>  void setup(void)
>  {
> -	size_t page_sz;		/* system page size */
> +	int page_sz;
>  
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);


Here we can drop the check, because getpagesize() cannot fail.

> diff --git a/testcases/kernel/syscalls/munmap/munmap02.c b/testcases/kernel/syscalls/munmap/munmap02.c
> index 2832e24..b7eca33 100644
> --- a/testcases/kernel/syscalls/munmap/munmap02.c
> +++ b/testcases/kernel/syscalls/munmap/munmap02.c
> @@ -83,7 +83,7 @@
>  char *TCID = "munmap02";
>  int TST_TOTAL = 1;
>  
> -size_t page_sz;			/* system page size */
> +static int page_sz;
>  char *addr;			/* addr of memory mapped region */
>  int fildes;			/* file descriptor for tempfile */
>  unsigned int map_len;		/* length of the region to be mapped */

Here as well.


> diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
> index 42ed804..6a45ebf 100644
> --- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
> +++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
> @@ -92,7 +92,7 @@
>  /* Test case defines */
>  #define WINDOW_START 0x48000000
>  
> -size_t page_sz;
> +static int page_sz;

> diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
> index d00d7ce..003ac77 100644
> --- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
> +++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
> @@ -83,7 +83,7 @@
>  /* Test case defines */
>  #define WINDOW_START 0x48000000
>  
> -size_t page_sz;
> +static int page_sz;

These two as well.

We may also remove sizeof(char) because that is 1 by the definition of
the C language.

>  size_t page_words;
>  size_t cache_pages;
>  size_t cache_sz;
> diff --git a/testcases/network/tcp_cmds/perf_lan/pingpong.c b/testcases/network/tcp_cmds/perf_lan/pingpong.c
> index d02b552..746891e 100644
> --- a/testcases/network/tcp_cmds/perf_lan/pingpong.c
> +++ b/testcases/network/tcp_cmds/perf_lan/pingpong.c
> @@ -207,7 +207,7 @@ int main(int argc, char *argv[])
>  		while (1) {
>  
>  			len = sizeof(packet);
> -			size_t cc;
> +			ssize_t cc;
>  			socklen_t fromlen;
>  
>  			/* Receive packet from socket */
> @@ -239,7 +239,7 @@ int echopkt(int datalen, int npackets)
>  	static uint8_t outpack[MAXPACKET];
>  	register icmp_t *icp = (icmp_t *) outpack;
>  	int i;
> -	size_t cc;
> +	ssize_t cc;
>  
>  	register u_char *datap = &outpack[8];
>  
> @@ -282,7 +282,7 @@ int echopkt(int datalen, int npackets)
>  		if (i < 0 || i != cc) {
>  			if (i < 0)
>  				perror("sendto");
> -			tst_resm(TINFO, "wrote %s %d chars, ret=%d",
> +			tst_resm(TINFO, "wrote %s %zd chars, ret=%d",
>  				 hostname, cc, i);
>  			fflush(stdout);
>  		}

This one looks OK.

> diff --git a/utils/sctp/lib/connectx.c b/utils/sctp/lib/connectx.c
> index b691f6b..cf8f5ed 100644
> --- a/utils/sctp/lib/connectx.c
> +++ b/utils/sctp/lib/connectx.c
> @@ -66,7 +66,7 @@ static int __connectx_addrsize(const struct sockaddr *addrs,
>  
>  int __sctp_connectx(int fd, struct sockaddr *addrs, int addrcnt)
>  {
> -	socklen_t addrs_size = __connectx_addrsize(addrs, addrcnt);
> +	int addrs_size = __connectx_addrsize(addrs, addrcnt);
>  
>  	if (addrs_size < 0)
>  		return addrs_size;
> @@ -117,7 +117,7 @@ static int __connectx(int fd, struct sockaddr *addrs, socklen_t addrs_size,
>  int sctp_connectx2(int fd, struct sockaddr *addrs, int addrcnt,
>  		      sctp_assoc_t *id)
>  {
> -	socklen_t addrs_size = __connectx_addrsize(addrs, addrcnt);
> +	int addrs_size = __connectx_addrsize(addrs, addrcnt);
>  
>  	if (addrs_size < 0)
>  		return addrs_size;
> @@ -128,7 +128,7 @@ int sctp_connectx2(int fd, struct sockaddr *addrs, int addrcnt,
>  int sctp_connectx3(int fd, struct sockaddr *addrs, int addrcnt,
>  		      sctp_assoc_t *id)
>  {
> -	socklen_t addrs_size = __connectx_addrsize(addrs, addrcnt);
> +	int addrs_size = __connectx_addrsize(addrs, addrcnt);
>  	int status;
>  	struct sctp_getaddrs_old param;
>  	socklen_t opt_len = sizeof(param);

This is also OK.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
