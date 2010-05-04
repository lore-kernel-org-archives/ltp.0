Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9N5U-0006V4-9H
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 18:43:20 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9N5R-0006vF-1J
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 18:43:19 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="=-lWu+FR+CDf1VpmH1VOzA"
Date: Tue, 04 May 2010 23:50:03 +0530
Message-Id: <1272997208.5342.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Fix FILECAPS test hanging for more than 12 hours
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sf.net>
Cc: Serge Hallyn <serue@linux.vnet.ibm.com>


--=-lWu+FR+CDf1VpmH1VOzA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,


Recently running FILECAPS test on my Fedora system:
# uname -a
Linux 2.6.33.1-19.fc13.ppc64 #1 SMP Tue Mar 23 06:32:38 EDT 2010 ppc64
ppc64 ppc64 GNU/Linux,

I found that the test hangs for more than 12 hours. The following patch
by Serge fixes the issue. Kindly include it inside LTP.

Tested-by: Subrata Modak <subrata@linux.vnet.ibm.com>,

Serge, please add a Sign-off.

Issue before the patch:
=============================
# ./runltp -f filecaps
<<<test_start>>>
tag=Filecaps stime=1271951563
cmdline="filecapstest.sh"
contacts=""
analysis=exit
<<<test_output>>>
Running in:
cap_sys_admin tests
testing for correct caps
...
The test hangs here for more than 12 hours.

Following are various info about the processes running this test:
# ps ajxf 
1608  1724  1608  1458 ?           -1 S        0   0:00  \_
/opt/ltp/bin/ltp-pan -e -S -a 1608 -n 1608 -p -f /tmp/ltp-71wskF3epE/alltests
-l /opt/ltp/results/LTP_RUN_ON-20
1724 30311 30311  1458 ?           -1 S        0   0:00      \_ /bin/sh
/opt/ltp/testcases/bin/filecapstest.sh
30311 30315 30311  1458 ?           -1 S        0   0:00          \_
verify_caps_exec 1
30315 30316 30311  1458 ?           -1 Z     1000   0:00              \_
[verify_caps_exe] <defunct>

STRACE on the PIDs does not show anything:
[root@alien5 ltp]# strace -p 30425
Process 30425 attached - interrupt to quit
waitpid(-1, ^C <unfinished ...>
Process 30425 detached
[root@alien5 ltp]# strace -p 30429
Process 30429 attached - interrupt to quit
open("caps_fifo", O_RDONLY^C <unfinished ...>
Process 30429 detached
[root@alien5 ltp]# strace -p 30430
attach: ptrace(PTRACE_ATTACH, ...): Operation not permitted

# getenforce
Permissive
[root@alien5 ltp]# tail -f /var/log/messages
2010-04-21T18:00:15.752320+05:18 alien5 setroubleshoot: SELinux is preventing
/sbin/rsyslogd access to a leaked
/opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output file descriptor. For
complete SELinux messages. run sealert -l 894e0d2d-23c3-45d1-9108-71ad97f5a45e
2010-04-21T18:00:15.794214+05:18 alien5 setroubleshoot: SELinux is preventing
/sbin/rsyslogd access to a leaked
/opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output file descriptor. For
complete SELinux messages. run sealert -l 894e0d2d-23c3-45d1-9108-71ad97f5a45e
2010-04-21T18:00:15.823557+05:18 alien5 setroubleshoot: SELinux is preventing
/sbin/rsyslogd access to a leaked
/opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output file descriptor. For
complete SELinux messages. run sealert -l 894e0d2d-23c3-45d1-9108-71ad97f5a45e
2010-04-21T18:00:17.721361+05:18 alien5 syslogtst: syslogtst:10 error level is
logged
Apr 21 18:00:19 alien5 kernel: imklog 4.4.2, log source = /proc/kmsg started.
Apr 21 18:00:19 alien5 rsyslogd: [origin software="rsyslogd" swVersion="4.4.2"
x-pid="2165" x-info="http://www.rsyslog.com"] (re)start
Apr 21 18:00:20 alien5 setroubleshoot: SELinux is preventing /sbin/rsyslogd
access to a leaked /opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output
file descriptor. For complete SELinux messages. run sealert -l
894e0d2d-23c3-45d1-9108-71ad97f5a45e
Apr 21 18:00:20 alien5 setroubleshoot: SELinux is preventing /sbin/rsyslogd
access to a leaked /opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output
file descriptor. For complete SELinux messages. run sealert -l
894e0d2d-23c3-45d1-9108-71ad97f5a45e
Apr 21 18:00:20 alien5 setroubleshoot: SELinux is preventing /sbin/rsyslogd
access to a leaked /opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output
file descriptor. For complete SELinux messages. run sealert -l
894e0d2d-23c3-45d1-9108-71ad97f5a45e

So, i executed the following command:
# sealert -l 894e0d2d-23c3-45d1-9108-71ad97f5a45e
exception when creating syslog handler: [Errno 2] No such file or directory
Summary:
SELinux is preventing /sbin/rsyslogd access to a leaked
/opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output file descriptor.

Detailed Description:

[rsyslogd has a permissive type (syslogd_t). This access was not denied.]

SELinux denied access requested by the rsyslogd command. It looks like this is
either a leaked descriptor or rsyslogd output was redirected to a file it is
not
allowed to access. Leaks usually can be ignored since SELinux is just closing
the leak and reporting the error. The application does not use the descriptor,
so it will run properly. If this is a redirection, you will not get output in
the /opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output. You should
generate a bugzilla on selinux-policy, and it will get routed to the
appropriate
package. You can safely ignore this avc.

Allowing Access:

You can generate a local policy module to allow this access - see FAQ
(http://docs.fedoraproject.org/selinux-faq-fc5/#id2961385)

Additional Information:

Source Context                unconfined_u:system_r:syslogd_t:s0
Target Context                unconfined_u:object_r:usr_t:s0
Target Objects                /opt/ltp/output/LTP_RUN_ON-
                              2010_Apr_21-17h_51m_22s.output [ file ]
Source                        rsyslogd
Source Path                   /sbin/rsyslogd
Port                          <Unknown>
Host                          alien5.ltc.austin.ibm.com
Source RPM Packages           rsyslog-4.4.2-6.fc13
Target RPM Packages           
Policy RPM                    selinux-policy-3.7.15-4.fc13
Selinux Enabled               True
Policy Type                   targeted
Enforcing Mode                Enforcing
Plugin Name                   leaks
Host Name                     alien5.ltc.austin.ibm.com
Platform                      Linux alien5.ltc.austin.ibm.com
                              2.6.33.1-19.fc13.ppc64 #1 SMP Tue Mar 23 06:32:38
                              EDT 2010 ppc64 ppc64
Alert Count                   186
First Seen                    Tue Apr 20 23:55:40 2010
Last Seen                     Wed Apr 21 18:00:19 2010
Local ID                      894e0d2d-23c3-45d1-9108-71ad97f5a45e
Line Numbers                  

Raw Audit Messages            

node= type=AVC msg=audit(1271853019.957:317): avc: 
denied  { append } for  pid=2164 comm="rsyslogd"
path="/opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output" dev=sda3
ino=1188363 scontext=unconfined_u:system_r:syslogd_t:s0
tcontext=unconfined_u:object_r:usr_t:s0 tclass=file

node= type=AVC msg=audit(1271853019.957:317): avc: 
denied  { append } for  pid=2164 comm="rsyslogd"
path="/opt/ltp/results/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.log" dev=sda3
ino=1188362 scontext=unconfined_u:system_r:syslogd_t:s0
tcontext=unconfined_u:object_r:usr_t:s0 tclass=file

node= type=AVC msg=audit(1271853019.957:317): avc: 
denied  { append } for  pid=2164 comm="rsyslogd"
path="/opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.failed" dev=sda3
ino=1188364 scontext=unconfined_u:system_r:syslogd_t:s0
tcontext=unconfined_u:object_r:usr_t:s0 tclass=file

node= type=SYSCALL msg=audit(1271853019.957:317):
arch=14 syscall=11 success=yes exit=0 a0=1026c900 a1=1026b5b0 a2=1026b640
a3=1026b5a8 items=0 ppid=2163 pid=2164 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=(none) ses=22 comm="rsyslogd" exe="/sbin/rsyslogd"
subj=unconfined_u:system_r:syslogd_t:s0 key=(null)
=============================

=============================
Test result after applying the patch
=============================
<<<test_start>>>
tag=Filecaps stime=1272996532
cmdline="filecapstest.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
Running in:
cap_sys_admin tests
filecaps    1  TPASS  :  could not set capabilities as non-root

testing for correct caps
filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  
caps are =

filecaps    0  TINFO  :  0

filecaps    0  TINFO  :  1

filecaps    0  TINFO  :  2

filecaps    0  TINFO  :  3

filecaps    0  TINFO  :  4

filecaps    0  TINFO  :  5

filecaps    0  TINFO  :  6

filecaps    0  TINFO  :  7

filecaps    0  TINFO  :  8

filecaps    0  TINFO  :  9

filecaps    0  TINFO  :  10

filecaps    0  TINFO  :  11

filecaps    0  TINFO  :  12

filecaps    0  TINFO  :  13

filecaps    0  TINFO  :  14

filecaps    0  TINFO  :  15

filecaps    0  TINFO  :  16

filecaps    0  TINFO  :  17

filecaps    0  TINFO  :  18

filecaps    0  TINFO  :  19

filecaps    0  TINFO  :  20

filecaps    0  TINFO  :  21

filecaps    0  TINFO  :  22

filecaps    0  TINFO  :  23

filecaps    0  TINFO  :  24

filecaps    0  TINFO  :  25

filecaps    0  TINFO  :  26

filecaps    0  TINFO  :  27

filecaps    0  TINFO  :  28

filecaps    0  TINFO  :  29

filecaps    0  TINFO  :  30

filecaps    0  TINFO  :  31

filecaps    0  TINFO  :  32

filecaps    0  TINFO  :  33

filecaps    1  TPASS  :  All tests passed

testing for correct pI checks
filecaps    0  TINFO  :  start
filecaps    0  TINFO  :  =ep
filecaps    0  TINFO  :  after raising all caps
filecaps    0  TINFO  :  =eip
filecaps    0  TINFO  :  after first drop cap_sys_admin
filecaps    0  TINFO  :  =eip cap_sys_admin-eip
filecaps    0  TINFO  :  after first raise cap_sys_admin
filecaps    0  TINFO  :  =eip cap_sys_admin-ep
filecaps    0  TINFO  :  after drop cappset
filecaps    0  TINFO  :  =ip cap_sys_admin-p
filecaps    0  TINFO  :  after second drop cap_sys_admin
filecaps    0  TINFO  :  =eip cap_setpcap-e cap_sys_admin-eip
filecaps    0  TINFO  :  final
filecaps    0  TINFO  :  =eip cap_setpcap-e cap_sys_admin-eip
filecaps    1  TPASS  :  pI is properly capped
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=4
<<<test_end>>>
=============================

Regards--
Subrata


--=-lWu+FR+CDf1VpmH1VOzA
Content-Disposition: attachment;
	filename=0001-make-filecaps-tests-succeed.patch
Content-Type: application/mbox; name=0001-make-filecaps-tests-succeed.patch
Content-Transfer-Encoding: 7bit

From 4b368ba90ba282bee61d8bc43fd8c1e178539a5a Mon Sep 17 00:00:00 2001
From: Serge E. Hallyn <serue@us.ibm.com>
Date: Wed, 28 Apr 2010 11:26:58 -0500
Subject: [PATCH 1/1] make filecaps tests succeed

Most of these are belated cleanup after the move to using /opt/ltp.
Also undoing an ill-advised replacement of return with tst_exit.  All
filecaps tests now succeed on fedora 10.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 testcases/kernel/security/filecaps/filecapstest.sh |    9 ++++++---
 testcases/kernel/security/filecaps/print_caps.c    |    3 ++-
 .../kernel/security/filecaps/verify_caps_exec.c    |   19 ++++++++++++++-----
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testcases/kernel/security/filecaps/filecapstest.sh
index 43582dc..6864de4 100755
--- a/testcases/kernel/security/filecaps/filecapstest.sh
+++ b/testcases/kernel/security/filecaps/filecapstest.sh
@@ -22,8 +22,11 @@
 echo "Running in:"
 #rm -f print_caps
 #cp $LTPROOT/testcases/bin/print_caps .
-mkfifo caps_fifo
-chmod 777 caps_fifo
+#FIFOFILE="$LTPROOT/testcases/bin/caps_fifo"
+FIFOFILE="/tmp/caps_fifo"
+rm -f $FIFOFILE
+mkfifo $FIFOFILE
+chmod 777 $FIFOFILE
 exit_code=0
 echo "cap_sys_admin tests"
 verify_caps_exec 0
@@ -46,5 +49,5 @@ if [ $tmp -ne 0 ]; then
 	exit_code=$tmp
 fi
 
-unlink caps_fifo
+unlink $FIFOFILE
 exit $exit_code
diff --git a/testcases/kernel/security/filecaps/print_caps.c b/testcases/kernel/security/filecaps/print_caps.c
index f0e9bce..b887738 100644
--- a/testcases/kernel/security/filecaps/print_caps.c
+++ b/testcases/kernel/security/filecaps/print_caps.c
@@ -36,7 +36,7 @@
 #include <sys/capability.h>
 #endif
 
-#define FIFOFILE "caps_fifo"
+#define FIFOFILE "/tmp/caps_fifo"
 
 int main(int argc, char *argv[])
 {
@@ -68,4 +68,5 @@ int main(int argc, char *argv[])
 #else
 	return 0;
 #endif
+	return 0;
 }
diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index 5250007..7360d4a 100644
--- a/testcases/kernel/security/filecaps/verify_caps_exec.c
+++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
@@ -43,7 +43,7 @@
 #include <sys/prctl.h>
 #include <test.h>
 
-#define TSTPATH "./print_caps"
+#define TSTPATH "print_caps"
 char *TCID = "filecaps";
 int TST_TOTAL=1;
 
@@ -70,7 +70,7 @@ void print_my_caps()
 	cap_free(txt);
 }
 
-int drop_root(int keep_perms)
+void drop_root(int keep_perms)
 {
 	int ret;
 
@@ -84,10 +84,19 @@ int drop_root(int keep_perms)
 	}
 	if (keep_perms) {
 		cap_t cap = cap_from_text("=eip");
-		cap_set_proc(cap);
+		int ret;
+		if (!cap) {
+			tst_resm(TBROK, "cap_from_text failed\n");
+			tst_exit();
+		}
+		ret = cap_set_proc(cap);
+		if (ret < 0) {
+			perror(cap_set_proc);
+			tst_resm(TBROK | TERRNO, "cap_set_proc failed\n");
+			tst_exit();
+		}
 		cap_free(cap);
 	}
-	tst_exit();
 }
 
 int perms_test(void)
@@ -114,7 +123,7 @@ int perms_test(void)
 	return ret;
 }
 
-#define FIFOFILE "caps_fifo"
+#define FIFOFILE "/tmp/caps_fifo"
 void create_fifo(void)
 {
 	int ret;
-- 
1.6.0.6


--=-lWu+FR+CDf1VpmH1VOzA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--=-lWu+FR+CDf1VpmH1VOzA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-lWu+FR+CDf1VpmH1VOzA--


