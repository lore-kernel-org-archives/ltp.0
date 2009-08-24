Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfVvO-0002L2-OB
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:33:14 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfVvI-00036J-Uh
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:33:14 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7O9RR4r011356
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 03:27:27 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7O9X3HA235112
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 03:33:03 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7O9X2bW026478
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 03:33:03 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 24 Aug 2009 15:02:54 +0530
Message-Id: <20090824093253.31997.86880.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
References: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 02/02] Script that will actually create the COMMAND
	File entries
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4162505530069842778=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

--===============4162505530069842778==

This is again a simple perl file which takes the temporary COMMAND file generated
by "runltp", parses it one line by line, and then recreates single or multiple
entries which will contain instruction for "cmdline" to invoke the "Valgrind"
tool in it�� various forms:
	1) Full "Memory Leak Check",
	2) Full "Thread Concurrency Check",
	3) Both the above,

This has been written(code reused) from the "create_kernel_faults_in_loops_and_probability.pl",
and works on the similar logic for creating "cmdline" entries in the temporary
COMMAND file generated. Now, this increases Garrett�� work again as he hates perl.
I hope he will agree to work on this to convert to Shell Script ;-)

Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
---

--- ltp-full-20090731.orig/tools/create_valgrind_check.pl	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090731/tools/create_valgrind_check.pl	2009-08-24 12:08:08.000000000 +0530
@@ -0,0 +1,106 @@
+#!/usr/bin/perl
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2009                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and/or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+################################################################################
+#                                                                             ##
+# File :        create_valgrind_check					      ##
+#                                                                             ##
+# Usage:        create_valgrind_check\					      ##
+#		<LTP_COMMAND_FILE> <VALGRIND_CHECK_TYPE>		      ##
+#                                                                             ##
+# Description:  This is a simple perl script which will take ltp command file ##
+#		as input and then create a final command file while will have ##
+#		the following entries for each test tag:		      ##
+#		1) <tag_name> <test_binary_name>			      ##
+#		2) <tag_name_valgrind_check_type> <valgrind test_binary_name> ##
+#                                                                             ##
+# Author:       Subrata Modak <subrata@linux.vnet.ibm.com>                    ##
+#                                                                             ##
+# History:      Aug 23 2009 - Created - Subrata Modak.                        ##
+################################################################################
+
+my $command_file	= shift (@ARGV) || syntax();
+my $valgrind_check_type	= shift (@ARGV) || syntax();
+
+sub syntax() {
+	print "syntax: create_valgrind_check\
+	<LTP_COMMAND_FILE> <VALGRIND_CHECK_TYPE>\n";
+	exit (1);
+}
+
+sub print_memory_leak_check {
+	$sub_line = shift;
+	@sub_tag_and_actual_command = split(/\ /, $sub_line);
+	my $sub_token_counter = 0;
+	foreach my $sub_token (@sub_tag_and_actual_command) {
+		if ($sub_token_counter == 0 ) {#print the tagname now
+			print $sub_token . "_valgrind_memory_leak_check " .
+				" valgrind -q --leak-check=full --trace-children=yes ";
+			$sub_token_counter++;
+			next;
+		}
+		print " " . $sub_token . " ";
+	}
+	print "\n";
+}
+
+sub print_thread_concurrency_check {
+	$sub_line = shift;
+	@sub_tag_and_actual_command = split(/\ /, $sub_line);
+	my $sub_token_counter = 0;
+	foreach my $sub_token (@sub_tag_and_actual_command) {
+		if ($sub_token_counter == 0 ) {#print the tagname now
+			print $sub_token . "_valgrind_thread_concurrency_check " .
+				" valgrind -q --tool=helgrind --trace-children=yes ";
+			$sub_token_counter++;
+			next;
+		}
+		print " " . $sub_token . " ";
+	}
+	print "\n";
+}
+
+open (FILE, $command_file) || die "Cannot open file: $command_file\n";
+while ($line = <FILE>) {
+	if ($line =~ /^#/) {
+		print "$line";
+		next;
+	}
+	if ($line =~ /^\n$/) {
+		next;
+	}
+	chomp $line;
+	print "$line\n"; #Print one instance for normal execution
+
+	if ($valgrind_check_type == 3) {
+		#Print for both Memory Leak and Thread Concurrency Checks
+		print_memory_leak_check($line);
+		print_thread_concurrency_check($line);
+	}
+	if ($valgrind_check_type == 2) {
+		#Print only for Thread concurrency Check
+		print_thread_concurrency_check($line);
+	}
+	if ($valgrind_check_type == 1) {
+		#Print only for Memory leak Check
+		print_memory_leak_check($line);
+	}
+}
+close (FILE);
+

---
Regards--
Subrata



--===============4162505530069842778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============4162505530069842778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4162505530069842778==--
