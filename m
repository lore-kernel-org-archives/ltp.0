Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PBh44-00011i-S1
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 04:59:44 +0000
Received: from out18.sjc.mx.trendmicro.com ([216.99.131.75])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PBh43-0007Sm-CV
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 04:59:44 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.6])
	by out18.sjc.mx.trendmicro.com (Postfix) with ESMTP id 594E598043E
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Oct 2010 04:59:37 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id E931D95852
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Oct 2010 04:59:36 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Oct 2010 13:59:35 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 29 Oct 2010 13:59:33 +0900
Message-ID: <000001cb7726$14164ee0$3c42eca0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About configuration failure
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
To: ltp-list@lists.sourceforge.net

Hi,

With recent git "ltp-43b57db.tar.gz", configuration failed:
------------
[...]
checking for gcj... no
checking for guavac... no
checking for jikes... no
checking for javac... no
configure: error: no acceptable Java compiler found in $PATH
------------

Java compiler isn't installed in my systems.


From yesterday, Java compiler has been necessary.
The Java compiler is necessary for a compilation of "DOTS", I think.

In the recent revision of "testcases/Makefile", if java compiler 
isn't found, "DOTS" will be worn a filter:
------------
--- a/testcases/Makefile
+++ b/testcases/Makefile
@@ -38,7 +38,12 @@ FILTER_OUT_DIRS              := ballista kdump mce-test
open% pounder21
 # XXX (garrcoop): kdump was in this list.
 # XXX (garrcoop): open_hpi_testsuite was in this list.
 ifeq ($(UCLINUX),1)
-FILTER_OUT_DIRS                += DOTS realtime
+FILTER_OUT_DIRS                += realtime+endif
+
+# DOTS requires javac
+ifeq ($(strip $(JAVAC)),)
+FILTER_OUT_DIRS                += DOTS
 endif
------------

But, the configuration fails by the lack of the Java compiler earlier 
than the making.



Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
