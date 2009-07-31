Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWnjU-0000qs-5N
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 08:44:56 +0000
Received: from rv-out-0708.google.com ([209.85.198.245])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWnjM-00056G-Aj
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 08:44:56 +0000
Received: by rv-out-0708.google.com with SMTP id b17so514409rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Fri, 31 Jul 2009 01:44:42 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 31 Jul 2009 01:44:42 -0700
Message-ID: <364299f40907310144n1c691921td8c8b6257adcda41@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Remove getgid02 from ltplite runtest file
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

Looks like someone removed the source file but forgot to remove the
reference to it in the ltplite runtest file. This fixes that.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: runtest/ltplite
===================================================================
RCS file: /cvsroot/ltp/ltp/runtest/ltplite,v
retrieving revision 1.20.2.1
diff -u -r1.20.2.1 ltplite
--- runtest/ltplite     27 Jul 2009 00:21:16 -0000      1.20.2.1
+++ runtest/ltplite     31 Jul 2009 08:43:22 -0000
@@ -287,7 +287,6 @@
 geteuid01 geteuid01

 getgid01 getgid01
-getgid02 getgid02
 getgid03 getgid03

 getgroups01 getgroups01

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
