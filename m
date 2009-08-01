Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MXNFI-0000Ah-Sd
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2009 22:40:08 +0000
Received: from rv-out-0708.google.com ([209.85.198.246])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXNFH-0001Pj-MR
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2009 22:40:08 +0000
Received: by rv-out-0708.google.com with SMTP id b17so702520rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Sat, 01 Aug 2009 15:40:01 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 1 Aug 2009 15:40:01 -0700
Message-ID: <364299f40908011540p1ddaf44eo2a7059d1b793ef85@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Purpose for TCbin, TCsrc, etc?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

Hi guys,
    I'm reading through a bunch of scripts, and I'm trying to
understand what the need is for having TCbin, TCsrc, etc -- is it the
fact that we have 5~10 different similarly written utilities, crafted
for a specific purpose, which weren't made generic enough that one
could essentially `bind them all' to a unified purpose? If so, is
there any way where we could make an effort to fix these items as soon
as possible? I've identified some of the issues, but this is something
that will need to be fixed after the first Makefile cleanup drop
because it requires some recoding in bourne shell, to which extent I'm
not entirely sure which scripts need to be fixed, yet. I've included
the diffs that I was thinking about committing to the
makefile-infra-rework branch, but will revert for the sake of time.
    IMO these items should be easy to fix -- they're just not a high
priority now and the workaround is simple (change the install dir for
the Makefiles).
Thanks,
-Garrett

Index: runtest/tcp_cmds
===================================================================
RCS file: /cvsroot/ltp/ltp/runtest/tcp_cmds,v
retrieving revision 1.6
diff -u -r1.6 tcp_cmds
--- runtest/tcp_cmds    20 Sep 2007 07:26:38 -0000      1.6
+++ runtest/tcp_cmds    1 Aug 2009 22:29:27 -0000
@@ -3,19 +3,19 @@
 # PLEASE READ THE README FILE IN /tcp_cmds BEFORE RUNNING THESE.
 #
 arp arp01
-echo export TCbin=$LTPROOT/testcases/network/tcp_cmds/echo; echo01
+echo echo01
 finger finger01
-ftp export TCbin=$LTPROOT/testcases/network/tcp_cmds/ftp; ftp01
+ftp ftp01
 host host01
 netstat netstat01
-perf_lan export TCbin=$LTPROOT/testcases/network/tcp_cmds/perf_lan; perf_lan
+perf_lan perf_lan
 ping export LTPROOT; ping01
-rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
-rdist export TCbin=$LTPROOT/testcases/network/tcp_cmds/rdist; rdist01
+rcp rcp01
+rdist rdist01
 rlogin rlogin01
 rsh rsh01
 rwho rwho01
-sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
+sendfile sendfile01
 tcpdump tcpdump01
 telnet telnet01
 iptables iptables_tests.sh
Index: runtest/ipv6
===================================================================
RCS file: /cvsroot/ltp/ltp/runtest/ipv6,v
retrieving revision 1.11
diff -u -r1.11 ipv6
--- runtest/ipv6        28 Mar 2003 22:08:03 -0000      1.11
+++ runtest/ipv6        1 Aug 2009 22:29:27 -0000
@@ -1,13 +1,13 @@
 #DESCRIPTION:IPV6 related tests
-echo6 export TCbin=$LTPROOT/testcases/network/ipv6/echo6;echo601
+echo6 echo601
 finger6 finger601
-ftp6 export TCbin=$LTPROOT/testcases/network/ipv6/ftp6; ftp01
-perf_lan6 export TCbin=$LTPROOT/testcases/network/ipv6/perf_lan6; perf_lan6
+ftp6 ftp01
+perf_lan6 perf_lan6
 ping6 ping601
-rcp6 export TCbin=$LTPROOT/testcases/network/ipv6/rcp6; rcp01
+rcp6 rcp01
 rlogin6 rlogin01
 rsh6 rsh01
 rwho6 rwho01
-sendfile6 export TCbin=$LTPROOT/testcases/network/ipv6/sendfile6; sendfile601
+sendfile6 sendfile601
 tcpdump6 tcpdump601
 telnet6 telnet01
Index: runtest/ipv6_noexpect
===================================================================
RCS file: /cvsroot/ltp/ltp/runtest/ipv6_noexpect,v
retrieving revision 1.12
diff -u -r1.12 ipv6_noexpect
--- runtest/ipv6_noexpect       28 Mar 2003 23:06:13 -0000      1.12
+++ runtest/ipv6_noexpect       1 Aug 2009 22:29:27 -0000
@@ -1,11 +1,11 @@
 #DESCRIPTION:IPV6 related tests that do not require expect
-echo6 export TCbin=$LTPROOT/testcases/network/ipv6/echo6;echo601
+echo6 echo601
 finger6 finger601
-ftp6 export TCbin=$LTPROOT/testcases/network/ipv6/ftp6; ftp01
-perf_lan6 export TCbin=$LTPROOT/testcases/network/ipv6/perf_lan6; perf_lan6
+ftp6 ftp01
+perf_lan6 perf_lan6
 ping6 ping601
-rcp6 export TCbin=$LTPROOT/testcases/network/ipv6/rcp6; rcp01
+rcp6 rcp01
 rsh6 rsh01
 rwho6 rwho01
-sendfile6 export TCbin=$LTPROOT/testcases/network/ipv6/sendfile6; sendfile60
+sendfile6 sendfile60
 tcpdump6 tcpdump601
Index: runtest/stress.part3
===================================================================
RCS file: /cvsroot/ltp/ltp/runtest/stress.part3,v
retrieving revision 1.65.2.1
diff -u -r1.65.2.1 stress.part3
--- runtest/stress.part3        31 Jul 2009 08:50:56 -0000      1.65.2.1
+++ runtest/stress.part3        1 Aug 2009 22:29:27 -0000
@@ -1,5 +1,5 @@
 #DESCRIPTION:Part three for ltpstress.sh
-abort01 ulimit -c 1024;abort01
+abort01 ulimit -c 1024; abort01

 accept01 accept01

@@ -46,14 +46,14 @@
 chmod02 chmod02
 chmod03 chmod03
 chmod04 chmod04
-chmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMP;chmod05
-chmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMP;chmod06
+chmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMP; chmod05
+chmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMP; chmod06
 chmod07 chmod07

 chown01 chown01
 chown02 chown02
-chown03 export change_owner=$LTPROOT/testcases/bin/change_owner;chown03
-chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMP;chown04
+chown03 export change_owner=$LTPROOT/testcases/bin/change_owner; chown03
+chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMP; chown04
 chown05 chown05

 chroot01 chroot01
@@ -880,8 +880,8 @@
 hangup01 hangup01

 mc_cmds mc_cmds
-mc_opts export TCsrc=$LTPROOT/testcases/network/multicast/mc_opts; mc_opts
-rpc01 export TCbin=$LTPROOT/testcases/network/rpc/basic_tests/rpc01; rpc01
-run_rpc_tests.sh export
TCbin=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite;
run_rpc_tests.sh
-perf_lan export TCbin=$LTPROOT/testcases/network/tcp_cmds/perf_lan; perf_lan
+mc_opts mc_opts
+rpc01 rpc01
+run_rpc_tests.sh un_rpc_tests.sh
+perf_lan perf_lan

Index: runtest/tcp_cmds_noexpect
===================================================================
RCS file: /cvsroot/ltp/ltp/runtest/tcp_cmds_noexpect,v
retrieving revision 1.3
diff -u -r1.3 tcp_cmds_noexpect
--- runtest/tcp_cmds_noexpect   28 Mar 2003 23:06:14 -0000      1.3
+++ runtest/tcp_cmds_noexpect   1 Aug 2009 22:29:27 -0000
@@ -3,16 +3,16 @@
 # PLEASE READ THE README FILE IN /tcp_cmds BEFORE RUNNING THESE.
 #
 arp arp01
-echo export TCbin=$LTPROOT/testcases/network/tcp_cmds/echo; echo01
+echo echo01
 finger finger01
-ftp export TCbin=$LTPROOT/testcases/network/tcp_cmds/ftp; ftp01
+ftp ftp01
 host host01
 netstat netstat01
-perf_lan export TCbin=$LTPROOT/testcases/network/tcp_cmds/perf_lan; perf_lan
+perf_lan perf_lan
 ping ping01
-rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
-rdist export TCbin=$LTPROOT/testcases/network/tcp_cmds/rdist; rdist01
+rcp rcp01
+rdist rdist01
 rsh rsh01
 rwho rwho01
-sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
+sendfile sendfile01
 tcpdump tcpdump01

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
