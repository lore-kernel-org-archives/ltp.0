Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X9Yjq-0004Bz-GA
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 12:00:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X9Yjk-0006fq-9r
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 12:00:10 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6MBxuQ1025116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Jul 2014 07:59:57 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s6MBxtcf019496
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Jul 2014 07:59:56 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Jul 2014 13:59:49 +0200
Message-Id: <618b542aea7f9084ee9a725572a35cbd2b8e4142.1406030190.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] syslog-lib: add SystemLogSocketName to rsyslog.conf
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

If this parameter is ommitted, rsyslog will use default,
which is /dev/log. After rsyslog stop/restart, this node gets
deleted. This breaks further syslog() calls on distros
using systemd-journald when test performs cleanup, because
rsyslog doesn't re-create /dev/log. Default distro rsyslog
config is "/run/systemd/journal/syslog", so system ends
up with missing /dev/log.

For example:
  cp -f /etc/rsyslog.conf /etc/rsyslog.conf.backup
  echo '$ModLoad imuxsock.so'  > /etc/rsyslog.conf
  echo "*.crit            /var/log/messages"  >> /etc/rsyslog.conf
  systemctl restart rsyslog
  cp /etc/rsyslog.conf.backup /etc/rsyslog.conf
  systemctl restart rsyslog # --> PROBLEM: /dev/log is now gone

This patch will include "$SystemLogSocketName" line from
rsyslog configuration to rsyslog.conf defined by syslog* tests.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/syslog/syslog-lib.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index b67a8f2..ef33517 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -71,7 +71,12 @@ setup()
 		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
 	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
 		CONFIG_FILE="/etc/rsyslog.conf"
-		RSYSLOG_CONFIG='$ModLoad imuxsock.so'
+		log_socket=$(grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf /etc/rsyslog.d/ | head -1)
+		RSYSLOG_CONFIG=$(cat <<EOF
+\$ModLoad imuxsock.so
+$log_socket
+EOF
+)
 	else
 		tst_resm TBROK "Couldn't find syslogd, syslog-ng or rsyslogd"
 		cleanup 1
-- 
1.7.1


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
