Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Xih3b-0007kl-Fy
	for ltp-list@lists.sourceforge.net; Mon, 27 Oct 2014 09:57:47 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xih3a-0006Wg-BX
	for ltp-list@lists.sourceforge.net; Mon, 27 Oct 2014 09:57:47 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s9R9vdZN014411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 27 Oct 2014 09:57:40 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9R9vc94006925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 27 Oct 2014 09:57:39 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9R9vcE9006919
	for <ltp-list@lists.sourceforge.net>; Mon, 27 Oct 2014 09:57:38 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 27 Oct 2014 13:59:32 +0400
Message-Id: <1414403972-9624-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v3] network/tcp_fastopen: add support for IPv6
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

Support for TCP Fast Open over IPv6 has been added to Linux 3.16.
Determine IP protocol from defined IP address. Also, make use of IPv6
server socket because it is backward compatible with IPv4 connections.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features                    |    1 +
 testcases/network/tcp_fastopen/tcp_fastopen.c      |   43 ++++++++++++--------
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |   19 +++++----
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index 14fa2d9..6638b65 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -3,6 +3,7 @@
 #
 
 tcp_fastopen tcp_fastopen_run.sh
+tcp_fastopen6 tcp_fastopen_run.sh -6
 
 vxlan01 vxlan01.sh
 vxlan02 vxlan02.sh
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen.c b/testcases/network/tcp_fastopen/tcp_fastopen.c
index 77d7437..e3dde38 100644
--- a/testcases/network/tcp_fastopen/tcp_fastopen.c
+++ b/testcases/network/tcp_fastopen/tcp_fastopen.c
@@ -269,7 +269,7 @@ static int client_recv(int *fd, char *buf)
 
 static int client_connect_send(const char *msg, int size)
 {
-	int cfd = socket(AF_INET, SOCK_STREAM, 0);
+	int cfd = socket(remote_addrinfo->ai_family, SOCK_STREAM, 0);
 	const int flag = 1;
 	setsockopt(cfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
 
@@ -422,10 +422,15 @@ static void client_init(void)
 
 	struct addrinfo hints;
 	memset(&hints, 0, sizeof(struct addrinfo));
-	hints.ai_family = AF_INET;
 	hints.ai_socktype = SOCK_STREAM;
-	if (getaddrinfo(server_addr, tcp_port, &hints, &remote_addrinfo) != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "getaddrinfo failed");
+	int err = getaddrinfo(server_addr, tcp_port, &hints, &remote_addrinfo);
+	if (err) {
+		tst_brkm(TBROK, cleanup, "getaddrinfo of '%s' failed, %s",
+			server_addr, gai_strerror(err));
+	}
+
+	tst_resm(TINFO, "TCP Fast Open over IPv%s",
+		(remote_addrinfo->ai_family == AF_INET6) ? "6" : "4");
 
 	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_client_start);
 	int i;
@@ -586,13 +591,14 @@ static void server_init(void)
 {
 	struct addrinfo hints;
 	memset(&hints, 0, sizeof(struct addrinfo));
-	hints.ai_family = AF_INET;
+	hints.ai_family = AF_INET6;
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_flags = AI_PASSIVE;
 	if (getaddrinfo(NULL, tcp_port, &hints, &local_addrinfo) != 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "getaddrinfo failed");
 
-	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	/* IPv6 socket is also able to access IPv4 protocol stack */
+	sfd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (sfd == -1)
 		tst_brkm(TBROK, cleanup, "Failed to create a socket");
 
@@ -628,8 +634,10 @@ static void server_cleanup(void)
 
 static void server_run(void)
 {
-	struct sockaddr_in client_addr;
-	socklen_t addr_size = sizeof(client_addr);
+	/* IPv4 source address will be mapped to IPv6 address */
+	struct sockaddr_in6 addr6;
+	socklen_t addr_size = sizeof(addr6);
+
 	pthread_attr_init(&attr);
 
 	/*
@@ -640,18 +648,19 @@ static void server_run(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "setdetachstate failed");
 
 	while (1) {
-		int client_fd = accept(sfd, (struct sockaddr *) &client_addr,
+		int client_fd = accept(sfd, (struct sockaddr *)&addr6,
 			&addr_size);
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
+				addr6.sin6_port, inet_ntop(AF_INET6,
+				&addr6.sin6_addr, addr_buf, INET6_ADDRSTRLEN));
 		}
+
 		server_thread_add(client_fd);
 	}
 }
@@ -731,8 +740,8 @@ static void setup(int argc, char *argv[])
 		tfo_bit_num = 2;
 	break;
 	case TCP_CLIENT:
-		tst_resm(TINFO, "connection: %s:%s",
-		server_addr, tcp_port);
+		tst_resm(TINFO, "connection: addr '%s', port '%s'",
+			server_addr, tcp_port);
 		tst_resm(TINFO, "client max req: %d", client_max_requests);
 		tst_resm(TINFO, "clients num: %d", clients_num);
 		tst_resm(TINFO, "client msg size: %d", client_msg_size);
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index eab8cfd..65dbdd3 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -21,7 +21,6 @@
 
 # default command-line options
 user_name="root"
-remote_addr=$RHOST
 use_ssh=0
 clients_num=2
 client_requests=2000000
@@ -31,32 +30,32 @@ TST_TOTAL=1
 TCID="tcp_fastopen"
 
 . test_net.sh
+tst_read_opts $*
 
 bind_timeout=5
 tfo_result="${TMPDIR}/tfo_result"
 
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
-	*)
-		tst_brkm TBROK "unknown option: $opt"
+	6) # skip, test_net library already processed it
 	;;
+	*) tst_brkm TBROK "unknown option: $opt" ;;
 	esac
 done
 
@@ -88,7 +87,7 @@ run_client_server()
 	# kill tcp server on remote machine
 	tst_rhost_run -c "pkill -9 tcp_fastopen\$"
 
-	port=$(tst_rhost_run -c "tst_get_unused_port ipv4 stream")
+	port=$(tst_rhost_run -c "tst_get_unused_port ipv6 stream")
 	[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
 
 	# run tcp server on remote machine
@@ -97,7 +96,7 @@ run_client_server()
 
 	# run local tcp client
 	tcp_fastopen -a $clients_num -r $client_requests -l \
--H $remote_addr $1 -g $port -d $tfo_result
+		-H $(tst_ipaddr rhost) $1 -g $port -d $tfo_result
 	[ "$?" -ne 0 ] && tst_brkm TBROK "Last test has failed"
 
 	run_time=$(read_result_file)
@@ -111,7 +110,9 @@ tst_require_root
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
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
