From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 11 Oct 2018 17:20:54 +0800
Subject: [LTP] [PATCH] syslog/syslog-lib.sh: Match rsyslog config written by
	RainerScript
Message-ID: <1539249654-24401-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since rsyslog commit 3b55048094d759adf8162f0829f239e115ebf2c0, rsyslog
by default deletes log socket during restart, unless socket is provided
by systemd.

If default rsyslog config written by RainerScript uses imjournal module
(e.g. module(load="imjournal"...) and doesn't specify $SystemLogSocketName,
syslog-lib.sh cannot match imjournal module and just write imuxsock module
into the rsyslog.conf constructed by test.  In this case, "/dev/log" is
owned by journald but rsyslog deletes it as its default log socket after
testing.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/syslog/syslog-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index 35c13da..30c797a 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -71,7 +71,7 @@ setup()
 		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
 	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
 		CONFIG_FILE="/etc/rsyslog.conf"
-		if grep -q -r '^\$ModLoad[[:space:]]*imjournal' /etc/rsyslog.conf /etc/rsyslog.d/ ; then
+		if grep -qri '^[^#].*load.*imjournal' /etc/rsyslog.conf /etc/rsyslog.d/ ; then
 			systemd_journal=$(grep -Ehoi "^[^#].*(imjournal|workdirectory).*" -r /etc/rsyslog.conf /etc/rsyslog.d/)
 			RSYSLOG_CONFIG=$(cat <<EOF
 $systemd_journal
-- 
1.8.3.1



