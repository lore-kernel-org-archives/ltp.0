From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Feb 2018 08:09:42 +0100
Subject: [LTP] [PATCH] netstress: set port dynamically on the server-side
In-Reply-To: <1518777047-24192-1-git-send-email-alexey.kodanev@oracle.com>
References: <1518777047-24192-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180227070942.GD876@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> This simplifies tst_netload setup because previously the script had to:
>   * Find an available port on the remote machine
>   * Start the server with this port on a remote machine. Moreover, the port
>     might not be available at the time it is started.
>   * Wait for the server to bind and be in the listen state

> With this patch, tst_netload has to:
>   * Start the server. When the server completes its setup (after bind())
>     it goes to background and tst_netload goes to the next step.
>   * read a file with the server port

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/lib/test_net.sh               |   38 +++++---------------------
>  testcases/network/netstress/netstress.c |   44 ++++++++++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 33 deletions(-)

> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 1e001f7..95e13ee 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -392,7 +392,7 @@ tst_wait_ipv6_dad()

>  tst_dump_rhost_cmd()
>  {
> -	tst_rhost_run -c "cat $TST_TMPDIR/bg.cmd"
> +	tst_rhost_run -c "cat $TST_TMPDIR/netstress.log"
>  }

>  # Run network load test, see 'netstress -h' for option description
> @@ -447,39 +447,17 @@ tst_netload()
>  	local expect_ret=0
>  	[ "$expect_res" != "pass" ] && expect_ret=1

> -	local ptype="stream"
> -	[ "$type" = "udp" ] && ptype="dgram"
> -
> -	local port=$(tst_rhost_run -c "tst_get_unused_port ipv6 $ptype")
> -	[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
> -
>  	tst_rhost_run -c "pkill -9 netstress\$"
> -
> -	c_opts="${cs_opts}${c_opts}-a $c_num -r $c_requests -d $rfile -g $port"
> -	s_opts="${cs_opts}${s_opts}-R $s_replies -g $port"
> -
> +	s_opts="${cs_opts}${s_opts}-R $s_replies -B $TST_TMPDIR"
>  	tst_resm TINFO "run server 'netstress $s_opts'"
> -	tst_rhost_run -s -B -c "netstress $s_opts"
> -
> -	tst_resm TINFO "check that server port in 'LISTEN' state"
> -	local sec_waited=
> -
> -	local sock_cmd=
> -	if [ "$type" = "sctp" ]; then
> -		sock_cmd="netstat -naS | grep $port | grep -q LISTEN"
> -	else
> -		sock_cmd="ss -ln$(echo $type | head -c1) | grep -q $port"
> +	tst_rhost_run -c "netstress $s_opts" > tst_netload.log 2>&1
> +	if [ $? -ne 0 ]; then
> +		cat tst_netload.log
> +		tst_brkm TFAIL "server failed"
>  	fi

> -	for sec_waited in $(seq 1 1200); do
> -		tst_rhost_run -c "$sock_cmd" && break
> -		if [ $sec_waited -eq 1200 ]; then
> -			tst_dump_rhost_cmd
> -			tst_rhost_run -c "ss -dutnp | grep $port"
> -			tst_brkm TFAIL "server not in LISTEN state"
> -		fi
> -		tst_sleep 100ms
> -	done
> +	local port=$(tst_rhost_run -s -c "cat $TST_TMPDIR/netstress_port")
> +	c_opts="${cs_opts}${c_opts}-a $c_num -r $c_requests -d $rfile -g $port"

>  	tst_resm TINFO "run client 'netstress -l $c_opts'"
>  	netstress -l $c_opts > tst_netload.log 2>&1 || ret=1
> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
> index 64fdc91..0a73321 100644
> --- a/testcases/network/netstress/netstress.c
> +++ b/testcases/network/netstress/netstress.c
> @@ -83,9 +83,10 @@ static int max_rand_msg_len;
>  static int server_max_requests	= 3;
>  static int client_max_requests	= 10;
>  static int clients_num;
> -static char *tcp_port		= "61000";
> +static char *tcp_port;
>  static char *server_addr	= "localhost";
>  static char *source_addr;
> +static char *server_bg;
>  static int busy_poll		= -1;
>  static int max_etime_cnt = 12; /* ~30 sec max timeout if no connection */

> @@ -112,6 +113,8 @@ static int wait_timeout = 60000;

>  /* in the end test will save time result in this file */
>  static char *rpath = "tfo_result";
> +static char *port_path = "netstress_port";
> +static char *log_path = "netstress.log";

>  static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg, *targ,
>  	    *Aarg;
> @@ -644,6 +647,9 @@ static void server_init(void)
>  	hints.ai_socktype = sock_type;
>  	hints.ai_flags = AI_PASSIVE;

> +	if (!source_addr && !tcp_port)
> +		tcp_port = "0";
> +
>  	if (source_addr && !strchr(source_addr, ':'))
>  		SAFE_ASPRINTF(&src_addr, "::ffff:%s", source_addr);
>  	setup_addrinfo(src_addr ? src_addr : source_addr, tcp_port,
> @@ -659,6 +665,14 @@ static void server_init(void)

>  	freeaddrinfo(local_addrinfo);

> +	int port = TST_GETSOCKPORT(sfd);
> +
> +	tst_res(TINFO, "bind to port %d", port);
> +	if (server_bg) {
> +		SAFE_CHDIR(server_bg);
> +		SAFE_FILE_PRINTF(port_path, "%d", port);
> +	}
> +
>  	if (sock_type == SOCK_DGRAM)
>  		return;

> @@ -674,8 +688,7 @@ static void server_init(void)

>  	SAFE_LISTEN(sfd, max_queue_len);

> -	tst_res(TINFO, "Listen on the socket '%d', port '%s'", sfd, tcp_port);
> -
> +	tst_res(TINFO, "Listen on the socket '%d'", sfd);
>  }

>  static void server_cleanup(void)
> @@ -683,8 +696,28 @@ static void server_cleanup(void)
>  	SAFE_CLOSE(sfd);
>  }

> +static void move_to_background(void)
> +{
> +	if (SAFE_FORK())
> +		exit(0);
> +
> +	SAFE_SETSID();
> +
> +	close(0);
> +	SAFE_OPEN("/dev/null", O_RDONLY);
> +
> +	close(1);
> +	close(2);
Minor nit: maybe using STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO is "correct way", but everyone
knows these numbers.

> +	int fd = SAFE_OPEN(log_path, O_CREAT | O_TRUNC | O_RDONLY, 00444);
> +
> +	SAFE_DUP(fd);
> +}
> +
>  static void server_run_udp(void)
>  {
> +	if (server_bg)
> +		move_to_background();
> +
>  	pthread_t p_id = server_thread_add(sfd);

>  	SAFE_PTHREAD_JOIN(p_id, NULL);
> @@ -692,6 +725,9 @@ static void server_run_udp(void)

>  static void server_run(void)
>  {
> +	if (server_bg)
> +		move_to_background();
> +
>  	/* IPv4 source address will be mapped to IPv6 address */
>  	struct sockaddr_in6 addr6;
>  	socklen_t addr_size = sizeof(addr6);
> @@ -946,11 +982,13 @@ static struct tst_option options[] = {

>  	{"R:", &Rarg, "Server:\n-R x     x requests after which conn.closed"},
>  	{"q:", &qarg, "-q x     x - TFO queue"},
> +	{"B:", &server_bg, "-B x     run in background, x - process directory"},
>  	{NULL, NULL, NULL}
>  };

>  static struct tst_test test = {
>  	.test_all = do_test,
> +	.forks_child = 1,
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.options = options

Nice simplification, thanks!
Acked-by: Petr Vorel <pvorel@suse.cz>
