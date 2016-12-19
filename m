From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Dec 2016 16:30:55 +0300
Subject: [LTP] [PATCH v2] netstress.c: change default setup of sysctl
	parameters
Message-ID: <1482154255-4432-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Allow 'netstress' to use whatever is set in tcp_fastopen sysctl
  parameter. There are several advantages to do this:
  a. It allows to test default configuration in kernel;
  b. We can control this parameter externally and avoid races
     when server/client runs on the same machine;
  c. Simplifies code.

* Introduce new parameter '-t x' (instead of '-O') where x is the new
  value for tcp_fastopen sysctl parameter.

* Enable fastopen API only if '-f' option set, remove '-o'.

* Remove 'run_force' parameter '-F'. It didn't do anything useful,
  instead, invoke tst_require_root() only if we're going to update
  sysctl parameter.

* Update tcp_fastopen test with new options ('-t' & '-f').

Additional fixes:

* Set SO_REUSEADDR option before bind in server.

* Remove linger option and consolidate setting busy_poll socket option
  into one function: init_socket_opts().

* Move setting tcp_tw_reuse to client side code.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: * set tcp_tw_reuse in client only
    * add -f option, remove '-o'
    * remove setting linger socket option

 testcases/network/netstress/netstress.c            |  151 +++++++++++---------
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |   17 +--
 2 files changed, 87 insertions(+), 81 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 26fd217..95be098 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -59,17 +59,16 @@ enum {
 static int net_mode;
 
 enum {
-	TFO_ENABLED = 0,
-	TFO_DISABLED,
+	TFO_DISABLED = 0,
+	TFO_ENABLED,
 };
-static int tfo_support;
+static int tfo_value = -1;
 static int fastopen_api;
 
 static const char tfo_cfg[]		= "/proc/sys/net/ipv4/tcp_fastopen";
 static const char tcp_tw_reuse[]	= "/proc/sys/net/ipv4/tcp_tw_reuse";
 static int tw_reuse_changed;
 static int tfo_cfg_value;
-static int tfo_bit_num;
 static int tfo_cfg_changed;
 static int tfo_queue_size	= 100;
 static int max_queue_len	= 100;
@@ -103,10 +102,9 @@ static long wait_timeout = 60000000;
 /* in the end test will save time result in this file */
 static char *rpath		= "./tfo_result";
 
-static int force_run;
 static int verbose;
 
-static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg;
+static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg, *targ;
 
 static const option_t options[] = {
 	/* server params */
@@ -126,20 +124,18 @@ static const option_t options[] = {
 	{"g:", NULL, &tcp_port},
 	{"b:", NULL, &barg},
 	{"U", &use_udp, NULL},
-	{"F", &force_run, NULL},
 	{"l", &net_mode, NULL},
-	{"o", &fastopen_api, NULL},
-	{"O", &tfo_support, NULL},
+	{"f", &fastopen_api, NULL},
+	{"t:", NULL, &targ},
 	{"v", &verbose, NULL},
 	{NULL, NULL, NULL}
 };
 
 static void help(void)
 {
-	printf("\n  -F      Force to run\n");
-	printf("  -v      Verbose\n");
-	printf("  -o      Use old TCP API, default is new TCP API\n");
-	printf("  -O      TFO support is off, default is on\n");
+	printf("\n  -v      Verbose\n");
+	printf("  -f      Use new TCP API, default is old TCP API\n");
+	printf("  -t x    Set tcp_fastopen value\n");
 	printf("  -l      Become TCP Client, default is TCP server\n");
 	printf("  -g x    x - server port, default is %s\n", tcp_port);
 	printf("  -b x    x - low latency busy poll timeout\n");
@@ -180,7 +176,13 @@ static struct addrinfo *local_addrinfo;
 static struct sockaddr_storage remote_addr;
 static socklen_t remote_addr_len;
 
-static const struct linger clo = { 1, 3 };
+static void init_socket_opts(int sd)
+{
+	if (busy_poll >= 0) {
+		setsockopt(sd, SOL_SOCKET, SO_BUSY_POLL,
+			&busy_poll, sizeof(busy_poll));
+	}
+}
 
 static void do_cleanup(void)
 {
@@ -191,9 +193,6 @@ static void do_cleanup(void)
 		net.cleanup();
 
 	if (tfo_cfg_changed) {
-		SAFE_FILE_SCANF(NULL, tfo_cfg, "%d", &tfo_cfg_value);
-		tfo_cfg_value &= ~tfo_bit_num;
-		tfo_cfg_value |= !tfo_support << (tfo_bit_num - 1);
 		tst_resm(TINFO, "unset '%s' back to '%d'",
 			tfo_cfg, tfo_cfg_value);
 		SAFE_FILE_PRINTF(NULL, tfo_cfg, "%d", tfo_cfg_value);
@@ -284,16 +283,11 @@ static int client_connect_send(const char *msg, int size)
 {
 	int cfd = socket(remote_addrinfo->ai_family,
 			 remote_addrinfo->ai_socktype, 0);
-	const int flag = 1;
 
 	if (cfd == -1)
 		return cfd;
 
-	setsockopt(cfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
-	if (busy_poll >= 0) {
-		setsockopt(cfd, SOL_SOCKET, SO_BUSY_POLL,
-			   &busy_poll, sizeof(busy_poll));
-	}
+	init_socket_opts(cfd);
 
 	if (fastopen_api == TFO_ENABLED) {
 		/* Replaces connect() + send()/write() */
@@ -520,21 +514,14 @@ void *server_fn(void *cfd)
 {
 	int client_fd = (intptr_t) cfd;
 	int num_requests = 0, offset = 0;
-
 	/* Reply will be constructed from first client request */
 	char *send_msg = NULL;
 	int send_msg_size = 0;
-
 	char recv_msg[max_msg_len];
-
-	setsockopt(client_fd, SOL_SOCKET, SO_LINGER, &clo, sizeof(clo));
-	if (busy_poll >= 0) {
-		setsockopt(client_fd, SOL_SOCKET, SO_BUSY_POLL,
-			   &busy_poll, sizeof(busy_poll));
-	}
-
 	ssize_t recv_len;
 
+	init_socket_opts(client_fd);
+
 	while (1) {
 		recv_len = sock_recv_poll(client_fd, recv_msg,
 			max_msg_len, offset);
@@ -636,6 +623,8 @@ static void server_init(void)
 
 	/* IPv6 socket is also able to access IPv4 protocol stack */
 	sfd = SAFE_SOCKET(cleanup, AF_INET6, local_addrinfo->ai_socktype, 0);
+	const int flag = 1;
+	setsockopt(sfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
 
 	tst_resm(TINFO, "assigning a name to the server socket...");
 	SAFE_BIND(cleanup, sfd, local_addrinfo->ai_addr,
@@ -646,8 +635,7 @@ static void server_init(void)
 	if (use_udp)
 		return;
 
-	const int flag = 1;
-	setsockopt(sfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
+	init_socket_opts(sfd);
 
 	if (fastopen_api == TFO_ENABLED) {
 		if (setsockopt(sfd, IPPROTO_TCP, TCP_FASTOPEN, &tfo_queue_size,
@@ -729,6 +717,59 @@ static void check_opt_l(const char *name, char *arg, long *val, long lim)
 	}
 }
 
+static void check_tfo_value(void)
+{
+	/* Check if we can write to tcp_fastopen knob. We might be
+	 * inside netns and either have read-only permission or
+	 * doesn't have the knob at all.
+	 */
+	if (access(tfo_cfg, W_OK) < 0) {
+		/* TODO check /proc/self/ns/ or TST_USE_NETNS env var */
+		tst_resm(TINFO, "can't read %s, assume server runs in netns",
+			tfo_cfg);
+		return;
+	}
+
+	SAFE_FILE_SCANF(NULL, tfo_cfg, "%d", &tfo_cfg_value);
+	tst_resm(TINFO, "'%s' is %d", tfo_cfg, tfo_cfg_value);
+
+	/* The check can be the first in this function but set here
+	 * to allow to print information about the currently set config
+	 */
+	if (tfo_value < 0)
+		return;
+
+	if (tfo_cfg_value == tfo_value)
+		return;
+
+	tst_require_root();
+
+	tst_resm(TINFO, "set '%s' to '%d'", tfo_cfg, tfo_value);
+
+	SAFE_FILE_PRINTF(cleanup, tfo_cfg, "%d", tfo_value);
+	tfo_cfg_changed = 1;
+}
+
+static void check_tw_reuse(void)
+{
+	if (access(tcp_tw_reuse, W_OK) < 0)
+		return;
+
+	int reuse_value = 0;
+
+	SAFE_FILE_SCANF(cleanup, tcp_tw_reuse, "%d", &reuse_value);
+	if (reuse_value) {
+		tst_resm(TINFO, "tcp_tw_reuse is already set");
+		return;
+	}
+
+	tst_require_root();
+
+	SAFE_FILE_PRINTF(cleanup, tcp_tw_reuse, "1");
+	tw_reuse_changed = 1;
+	tst_resm(TINFO, "set '%s' to '1'", tcp_tw_reuse);
+}
+
 static void setup(int argc, char *argv[])
 {
 	tst_parse_opts(argc, argv, options, help);
@@ -744,29 +785,18 @@ static void setup(int argc, char *argv[])
 	check_opt("q", qarg, &tfo_queue_size, 1);
 	check_opt_l("T", Targ, &wait_timeout, 0L);
 	check_opt("b", barg, &busy_poll, 0);
+	check_opt("t", targ, &tfo_value, 0);
 
-	if (!force_run)
-		tst_require_root();
-
-	if (!force_run && tst_kvercmp(3, 7, 0) < 0) {
+	if (tfo_value > 0 && tst_kvercmp(3, 7, 0) < 0) {
 		tst_brkm(TCONF, NULL,
 			"Test must be run with kernel 3.7 or newer");
 	}
 
-	if (!force_run && busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0) {
+	if (busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0) {
 		tst_brkm(TCONF, NULL,
 			"Test must be run with kernel 3.11 or newer");
 	}
 
-	/* check tcp fast open knob */
-	if (!force_run && access(tfo_cfg, F_OK) == -1)
-		tst_brkm(TCONF, NULL, "Failed to find '%s'", tfo_cfg);
-
-	if (!force_run) {
-		SAFE_FILE_SCANF(NULL, tfo_cfg, "%d", &tfo_cfg_value);
-		tst_resm(TINFO, "'%s' is %d", tfo_cfg, tfo_cfg_value);
-	}
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	switch (net_mode) {
@@ -776,7 +806,6 @@ static void setup(int argc, char *argv[])
 		net.init	= server_init;
 		net.run		= (use_udp) ? server_run_udp : server_run;
 		net.cleanup	= (use_udp) ? NULL : server_cleanup;
-		tfo_bit_num = 2;
 	break;
 	case CLIENT_HOST:
 		tst_resm(TINFO, "connection: addr '%s', port '%s'",
@@ -789,7 +818,8 @@ static void setup(int argc, char *argv[])
 		net.init	= client_init;
 		net.run		= client_run;
 		net.cleanup	= client_cleanup;
-		tfo_bit_num = 1;
+
+		check_tw_reuse();
 	break;
 	}
 
@@ -803,26 +833,7 @@ static void setup(int argc, char *argv[])
 			(net_mode == SERVER_HOST) ? "server" : "client",
 			(fastopen_api == TFO_ENABLED) ? "Fastopen" : "old");
 
-		tfo_support = TFO_ENABLED == tfo_support;
-		if (((tfo_cfg_value & tfo_bit_num) == tfo_bit_num)
-		      != tfo_support) {
-			int value = (tfo_cfg_value & ~tfo_bit_num)
-				| (tfo_support << (tfo_bit_num - 1));
-			tst_resm(TINFO, "set '%s' to '%d'", tfo_cfg, value);
-			SAFE_FILE_PRINTF(cleanup, tfo_cfg, "%d", value);
-			tfo_cfg_changed = 1;
-		}
-
-		int reuse_value = 0;
-		SAFE_FILE_SCANF(cleanup, tcp_tw_reuse, "%d", &reuse_value);
-		if (!reuse_value) {
-			SAFE_FILE_PRINTF(cleanup, tcp_tw_reuse, "1");
-			tw_reuse_changed = 1;
-			tst_resm(TINFO, "set '%s' to '1'", tcp_tw_reuse);
-		}
-
-		tst_resm(TINFO, "TFO support %s",
-			(tfo_support) ? "enabled" : "disabled");
+		check_tfo_value();
 	}
 
 	net.init();
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index e506b87..9d0ce35 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -65,15 +65,8 @@ cleanup()
 
 read_result_file()
 {
-	if [ -f $tfo_result ]; then
-		if [ -r $tfo_result ]; then
-			cat $tfo_result
-		else
-			tst_brkm TBROK "Failed to read result file"
-		fi
-	else
-		tst_brkm TBROK "Failed to find result file"
-	fi
+	[ ! -f $tfo_result ] && echo "-1"
+	[ -r $tfo_result ] && cat $tfo_result || echo "-1"
 }
 
 tst_require_root
@@ -91,12 +84,14 @@ TST_CLEANUP="cleanup"
 tst_tmpdir
 
 tst_resm TINFO "using old TCP API"
-tst_netload $(tst_ipaddr rhost) $tfo_result TFO -o -O
+tst_netload $(tst_ipaddr rhost) $tfo_result TFO
 time_tfo_off=$(read_result_file)
+[ "$time_tfo_off" = "-1" ] && tst_brkm TFAIL "failed to find result file"
 
 tst_resm TINFO "using new TCP API"
-tst_netload $(tst_ipaddr rhost) $tfo_result TFO
+tst_netload $(tst_ipaddr rhost) $tfo_result TFO -f -t 3
 time_tfo_on=$(read_result_file)
+[ "$time_tfo_on" = "-1" ] && tst_brkm TFAIL "failed to find result file"
 
 tfo_cmp=$(( 100 - ($time_tfo_on * 100) / $time_tfo_off ))
 
-- 
1.7.1

