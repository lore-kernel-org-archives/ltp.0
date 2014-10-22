Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XguiB-0006Ld-Pj
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 12:08:19 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XguiA-0002eK-Jg
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 12:08:19 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s9MC8Bem001586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 12:08:12 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9MC8BMi017136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 12:08:11 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9MC8ASt017106
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 12:08:11 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 22 Oct 2014 16:10:08 +0400
Message-Id: <1413979808-11229-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2] network/tcp_fastopen: add support for IPv6
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Support for TCP Fast Open over IPv6 has been added to Linux 3.16

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: fix long line warning (over 80)

 runtest/network_stress.features                    |    1 +
 testcases/network/tcp_fastopen/tcp_fastopen.c      |   52 ++++++++++++++------
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |   24 ++++++---
 3 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index 14fa2d9..4cce78d 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -3,6 +3,7 @@
 #
 
 tcp_fastopen tcp_fastopen_run.sh
+tcp_fastopen tcp_fastopen_run.sh -6
 
 vxlan01 vxlan01.sh
 vxlan02 vxlan02.sh
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen.c b/testcases/network/tcp_fastopen/tcp_fastopen.c
index 77d7437..7e938e8 100644
--- a/testcases/network/tcp_fastopen/tcp_fastopen.c
+++ b/testcases/network/tcp_fastopen/tcp_fastopen.c
@@ -101,6 +101,8 @@ static char *rpath		= "./tfo_result";
 
 static int force_run;
 static int verbose;
+static int ipv6;
+static int af_inet;
 
 static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ;
 
@@ -119,6 +121,7 @@ static const option_t options[] = {
 	{"d:", NULL, &rpath},
 
 	/* common */
+	{"6", &ipv6, NULL},
 	{"g:", NULL, &tcp_port},
 	{"F", &force_run, NULL},
 	{"l", &tcp_mode, NULL},
@@ -136,6 +139,7 @@ static void help(void)
 	printf("  -O      TFO support is off, default is on\n");
 	printf("  -l      Become TCP Client, default is TCP server\n");
 	printf("  -g x    x - server port, default is %s\n", tcp_port);
+	printf("  -6      Run over IPv6");
 
 	printf("\n          Client:\n");
 	printf("  -H x    x - server name or ip address, default is '%s'\n",
@@ -269,7 +273,7 @@ static int client_recv(int *fd, char *buf)
 
 static int client_connect_send(const char *msg, int size)
 {
-	int cfd = socket(AF_INET, SOCK_STREAM, 0);
+	int cfd = socket(af_inet, SOCK_STREAM, 0);
 	const int flag = 1;
 	setsockopt(cfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
 
@@ -422,10 +426,13 @@ static void client_init(void)
 
 	struct addrinfo hints;
 	memset(&hints, 0, sizeof(struct addrinfo));
-	hints.ai_family = AF_INET;
+	hints.ai_family = af_inet;
 	hints.ai_socktype = SOCK_STREAM;
-	if (getaddrinfo(server_addr, tcp_port, &hints, &remote_addrinfo) != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "getaddrinfo failed");
+	int err = getaddrinfo(server_addr, tcp_port, &hints, &remote_addrinfo);
+	if (err) {
+		tst_brkm(TBROK, cleanup, "getaddrinfo of '%s' failed, %s",
+			server_addr, gai_strerror(err));
+	}
 
 	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_client_start);
 	int i;
@@ -586,13 +593,13 @@ static void server_init(void)
 {
 	struct addrinfo hints;
 	memset(&hints, 0, sizeof(struct addrinfo));
-	hints.ai_family = AF_INET;
+	hints.ai_family = af_inet;
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_flags = AI_PASSIVE;
 	if (getaddrinfo(NULL, tcp_port, &hints, &local_addrinfo) != 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "getaddrinfo failed");
 
-	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	sfd = socket(af_inet, SOCK_STREAM, 0);
 	if (sfd == -1)
 		tst_brkm(TBROK, cleanup, "Failed to create a socket");
 
@@ -628,8 +635,11 @@ static void server_cleanup(void)
 
 static void server_run(void)
 {
-	struct sockaddr_in client_addr;
-	socklen_t addr_size = sizeof(client_addr);
+	struct sockaddr_in addr;
+	struct sockaddr_in6 addr6;
+	struct sockaddr *sock_addr = (ipv6) ? (void *)&addr6 : (void *)&addr;
+	socklen_t addr_size = (ipv6) ? sizeof(addr6) : sizeof(addr);
+
 	pthread_attr_init(&attr);
 
 	/*
@@ -640,17 +650,19 @@ static void server_run(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "setdetachstate failed");
 
 	while (1) {
-		int client_fd = accept(sfd, (struct sockaddr *) &client_addr,
-			&addr_size);
+		int client_fd = accept(sfd, sock_addr, &addr_size);
+
 		if (client_fd == -1)
 			tst_brkm(TBROK, cleanup, "Can't create client socket");
 
-		if (client_addr.sin_family == AF_INET) {
-			if (verbose) {
-				tst_resm(TINFO, "conn: port '%d', addr '%s'",
-					client_addr.sin_port,
-					inet_ntoa(client_addr.sin_addr));
-			}
+		if (verbose) {
+			char addr_buf[INET6_ADDRSTRLEN];
+			tst_resm(TINFO, "conn: port '%d', addr '%s'",
+				(ipv6) ? addr6.sin6_port : addr.sin_port,
+				inet_ntop(af_inet, (ipv6) ?
+				(void *)&addr6.sin6_addr :
+				(void *)&addr.sin_addr, addr_buf,
+				INET6_ADDRSTRLEN));
 		}
 		server_thread_add(client_fd);
 	}
@@ -706,6 +718,14 @@ static void setup(int argc, char *argv[])
 			"Test must be run with kernel 3.7 or newer");
 	}
 
+	if (ipv6 && tst_kvercmp(3, 16, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 3.16 or newer");
+	}
+
+	af_inet = (ipv6) ? AF_INET6 : AF_INET;
+	tst_resm(TINFO, "TCP Fast Open over IPv%s", (ipv6) ? "6" : "4");
+
 	/* check tcp fast open knob */
 	if (!force_run && access(tfo_cfg, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "Failed to find '%s'", tfo_cfg);
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index eab8cfd..cc8b8ac 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -21,7 +21,6 @@
 
 # default command-line options
 user_name="root"
-remote_addr=$RHOST
 use_ssh=0
 clients_num=2
 client_requests=2000000
@@ -31,29 +30,31 @@ TST_TOTAL=1
 TCID="tcp_fastopen"
 
 . test_net.sh
+tst_read_opts $*
 
 bind_timeout=5
 tfo_result="${TMPDIR}/tfo_result"
+tfo_ipv=${TST_IPV6:-4}
 
-while getopts :hu:H:sr:p:n:R: opt; do
+while getopts :hu:sr:p:n:R:6 opt; do
 	case "$opt" in
 	h)
 		echo "Usage:"
 		echo "h        help"
 		echo "u x      server user name"
-		echo "H x      server hostname or IP address"
 		echo "s        use ssh to run remote cmds"
 		echo "n x      num of clients running in parallel"
 		echo "r x      the number of client requests"
 		echo "R x      num of requests, after which conn. closed"
+		echo "6        run over IPv6"
 		exit 0
 	;;
 	u) user_name=$OPTARG ;;
-	H) remote_addr=$OPTARG ;;
 	s) export TST_USE_SSH=1 ;;
 	n) clients_num=$OPTARG ;;
 	r) client_requests=$OPTARG ;;
 	R) max_requests=$OPTARG ;;
+	6) ;;
 	*)
 		tst_brkm TBROK "unknown option: $opt"
 	;;
@@ -87,17 +88,20 @@ run_client_server()
 {
 	# kill tcp server on remote machine
 	tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	local tfo_ipv_opt=
+	[ "$TST_IPV6" ] && tfo_ipv_opt="-6"
 
-	port=$(tst_rhost_run -c "tst_get_unused_port ipv4 stream")
+	port=$(tst_rhost_run -c "tst_get_unused_port ipv${tfo_ipv} stream")
 	[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
 
 	# run tcp server on remote machine
-	tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests $1 -g $port"
+	tst_rhost_run -s -b -c "tcp_fastopen $tfo_ipv_opt \
+		-R $max_requests $1 -g $port"
 	sleep $bind_timeout
 
 	# run local tcp client
-	tcp_fastopen -a $clients_num -r $client_requests -l \
--H $remote_addr $1 -g $port -d $tfo_result
+	tcp_fastopen $tfo_ipv_opt -a $clients_num -r $client_requests -l \
+		-H $(tst_ipaddr rhost) $1 -g $port -d $tfo_result
 	[ "$?" -ne 0 ] && tst_brkm TBROK "Last test has failed"
 
 	run_time=$(read_result_file)
@@ -111,7 +115,9 @@ tst_require_root
 tst_kvercmp 3 7 0
 [ $? -eq 0 ] && tst_brkm TCONF "test must be run with kernel 3.7 or newer"
 
-[ -z $remote_addr ] && tst_brkm TBROK "you must specify server address"
+tst_kvercmp 3 16 0
+[ $? -eq 0 -a "$TST_IPV6" ] && \
+	tst_brkm TCONF "test must be run with kernel 3.16 or newer"
 
 run_client_server "-o -O"
 time_tfo_off=$run_time
-- 
1.7.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
