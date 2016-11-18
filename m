From: nousi <bnousilal@gmail.com>
Date: Fri, 18 Nov 2016 18:08:17 +0530
Subject: [LTP] syslog tests are failed.
Message-ID: <CAJ5vXcQHixS8UOzeFDQ7TNNHzGN5QhWONhXYT67eWCwitynyyQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

Please someone help in debugging the syslog test case failure.

I am not able to understand the reason for the failure from the debug logs.

I could not find anything wrong in the debug logs.

I am using ltp version 20150119


 <<<test_output>>>
+ . syslog-lib.sh
++ readonly MAILLOG=/var/log/maillog
++ MAILLOG=/var/log/maillog
++ readonly 'TRAP_SIGS=1 2 3 6 11 15'
++ TRAP_SIGS='1 2 3 6 11 15'
++ CONFIG_FILE=
++ RSYSLOG_CONFIG=
++ WAIT_COUNT=60
++ export TST_TOTAL=1
++ TST_TOTAL=1
++ export TST_COUNT=1
++ TST_COUNT=1
+++ basename /opt/ltp/testcases/bin/syslog01
++ export TCID=syslog01
++ TCID=syslog01
++ . cmdlib.sh
+++ set -u
+++ export SHELL_DEBUG=0
+++ SHELL_DEBUG=0
+++ '[' x0 = x1 ']'
+++ TCID=syslog01
+++ '[' -z syslog01 ']'
++++ echo syslog01
++++ awk '{ sub( /[0-9]+$/,""); print; }'
+++ TC=syslog
+++ . daemonlib.sh
++++ command -v systemctl
++++ HAVE_SYSTEMCTL=0
++++ SYSLOG_DAEMON=
++++ command -v syslogd
++++ SYSLOG_DAEMON=syslog
++++ CROND_DAEMON=
++++ command -v crond
++++ CROND_DAEMON=crond
+ export TST_TOTAL=1
+ TST_TOTAL=1
+ export TST_COUNT=1
+ TST_COUNT=1
+ export TCID=syslog01
+ TCID=syslog01
+ tst_resm TINFO 'Send messages to syslogd at some level '
syslog01    0  TINFO  :  Send messages to syslogd at some level
+ tst_resm TINFO 'and facility and grep for those messages.'
syslog01    0  TINFO  :  and facility and grep for those messages.
+ setup
+ tst_require_root
++ id -u
+ '[' x0 '!=' x0 ']'
+ trap '        disable_traps
                tst_resm TBROK "Testing is terminating due to a signal"
                cleanup 1' 1 2 3 6 11 15
+ '[' syslog = syslog ']'
+ CONFIG_FILE=/etc/syslog.conf
+ '[' -f /etc/syslog.conf ']'
+ '[' -f /etc/syslog.conf.ltpback -a 60 -gt 0 ']'
+ '[' 60 -eq 0 ']'
+ cp /etc/syslog.conf /etc/syslog.conf.ltpback
+ syslog_case1
+ tst_resm TINFO 'testing whether messages are logged into log file'
syslog01    0  TINFO  :  testing whether messages are logged into log file
+ case "$CONFIG_FILE" in
+ echo ''
+ echo '*.crit          /var/log/messages'
+ echo 'mail.info       /var/log/maillog'
+ restart_syslog_daemon
+ '[' 0 -eq 0 ']'
+ cleanup_command='cleanup 1'
+ tst_resm TINFO 'restarting syslog daemon'
syslog01    0  TINFO  :  restarting syslog daemon
+ '[' -n syslog ']'
+ restart_daemon syslog
+ '[' 0 -eq 1 ']'
+ service syslog restart
+ '[' 127 -eq 0 ']'
+ restart_daemon syslog
+ '[' 0 -eq 1 ']'
+ service syslog restart
+ '[' 127 -ne 0 ']'
+ cleanup 1
+ disable_traps
+ trap - 1 2 3 6 11 15
+ exit_code=1
+ '[' -f /etc/syslog.conf.ltpback ']'
+ mv /etc/syslog.conf.ltpback /etc/syslog.conf
+ restart_syslog_daemon 'return 1'
+ '[' 1 -eq 0 ']'
+ cleanup_command='return 1'
+ tst_resm TINFO 'restarting syslog daemon'
syslog01    0  TINFO  :  restarting syslog daemon
+ '[' -n syslog ']'
+ restart_daemon syslog
+ '[' 0 -eq 1 ']'
+ service syslog restart
+ '[' 127 -eq 0 ']'
+ restart_daemon syslog
+ '[' 0 -eq 1 ']'
+ service syslog restart
+ '[' 127 -ne 0 ']'
+ return 1
+ '[' 1 -ne 1 ']'
+ exit 1
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>

-- 
Thanks & Regards,
B.Nousilal,
