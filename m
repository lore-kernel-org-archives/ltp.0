Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v0n-0007Yk-6V
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:56:45 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v0l-0001xg-Qm
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:56:45 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466rWkO010847
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:53:32 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o466ubGx155840
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:56:37 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o466ubpE006141
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:56:37 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:26:25 +0530
Message-Id: <20100506065624.23879.58089.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [02/12 FAILURE] LTPX File Capabilities tests becomes defunct and does not complete beyond 12 hours
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0243015076229197796=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============0243015076229197796==

Subject: LTP�� File Capabilities tests becomes defunct and does not complete beyond 12 hours

Issues Description Below:
===================================
I know Serge and Garret is already working on them and a considerable fix
is already in the pipeline.

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
[root@alien5 ltp]# ps ajxf 
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

[root@alien5 ltp]# getenforce
Permissive
[root@alien5 ltp]# tail -f /var/log/messages
2010-04-21T18:00:15.752320+05:18 alien5 setroubleshoot: SELinux is preventing
/sbin/rsyslogd access to a leaked/opt/ltp/output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output file descriptor. For
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
[root@alien5 ltp]# sealert -l 894e0d2d-23c3-45d1-9108-71ad97f5a45e
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
Host                          
Source RPM Packages           rsyslog-4.4.2-6.fc13
Target RPM Packages           
Policy RPM                    selinux-policy-3.7.15-4.fc13
Selinux Enabled               True
Policy Type                   targeted
Enforcing Mode                Enforcing
Plugin Name                   leaks
Host Name                     
Platform                      Linux 
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

Regards--
Subrata



--===============0243015076229197796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============0243015076229197796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0243015076229197796==--
