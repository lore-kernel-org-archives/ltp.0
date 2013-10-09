Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maxim.uvarov@linaro.org>) id 1VTuWD-0006hK-AX
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 14:13:41 +0000
Received: from mail-lb0-f178.google.com ([209.85.217.178])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VTuWC-0006qI-6E
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 14:13:41 +0000
Received: by mail-lb0-f178.google.com with SMTP id z5so844111lbh.9
	for <ltp-list@lists.sourceforge.net>;
	Wed, 09 Oct 2013 07:13:33 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed,  9 Oct 2013 18:13:26 +0400
Message-Id: <1381328006-9432-1-git-send-email-maxim.uvarov@linaro.com>
Subject: [LTP] [PATCH]  syslog-lib.sh bash posix compliance
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
Cc: linaro-networking@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.com>

/opt/ltp/testcases/bin/syslog02: 69: [: syslog-ng: unexpected operator
+ [ syslog-ng == syslog-ng ]
Accoding to:
http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
[ STRING1 == STRING2 ]  True if the strings are equal. "=" may be
used instead of "==" for strict POSIX compliance.

Because of busybox and other bash like shells look for posix syntax
make it so.
Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.com>
---
 testcases/kernel/syscalls/syslog/syslog-lib.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index 0885805..6b19b8d 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -65,11 +65,11 @@ setup()
 		tst_resm TBROK "Testing is terminating due to a signal"
 		cleanup 1' $TRAP_SIGS || exit 1
 
-	if [ "$SYSLOG_DAEMON" == "syslog" ]; then
+	if [ "$SYSLOG_DAEMON" = "syslog" ]; then
 		CONFIG_FILE="/etc/syslog.conf"
-	elif [ "$SYSLOG_DAEMON" == "syslog-ng" ]; then
+	elif [ "$SYSLOG_DAEMON" = "syslog-ng" ]; then
 		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
-	elif [ "$SYSLOG_DAEMON" == "rsyslog" ]; then
+	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
 		CONFIG_FILE="/etc/rsyslog.conf"
 		RSYSLOG_CONFIG='$ModLoad imuxsock.so'
 	else
-- 
1.7.9.5


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
