Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PBMSq-00073V-7n
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 06:59:56 +0000
Received: from out13.sjc.mx.trendmicro.com ([216.99.131.50])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PBMSo-00030U-Pb
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 06:59:56 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.129])
	by out13.sjc.mx.trendmicro.com (Postfix) with ESMTP id 5BBDD98041E
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Oct 2010 06:59:48 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id A0B1B95810
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Oct 2010 06:59:47 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Oct 2010 15:59:45 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 28 Oct 2010 15:59:45 +0900
Message-ID: <000001cb766d$b3f5bbd0$1be13370$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] LTP make failed in recent git
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


I found that "make" of LTP failed with recent git "ltp-332cdb8.tar.gz".
------------
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../include
-I../../../include   -L../../../lib  ebizzy.c   -lpthread -o ebizzy
make[3]: Leaving directory
`/home/LTP/ltp-dev-20101027/utils/benchmark/ebizzy-0.3'
make[3]: Entering directory
`/home/LTP/ltp-dev-20101027/utils/benchmark/kernbench-0.42'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory
`/home/LTP/ltp-dev-20101027/utils/benchmark/kernbench-0.42'
make[2]: Leaving directory `/home/LTP/ltp-dev-20101027/utils/benchmark'
make[1]: Leaving directory `/home/LTP/ltp-dev-20101027/utils'
make -C "testcases" \
		-f "/home/LTP/ltp-dev-20101027/testcases/Makefile" all
make[1]: Entering directory `/home/LTP/ltp-dev-20101027/testcases'
make[2]: Entering directory `/home/LTP/ltp-dev-20101027/testcases/DOTS'
cd src;make
make[3]: Entering directory `/home/LTP/ltp-dev-20101027/testcases/DOTS/src'
mkdir -p ../classes/dots/framework
cd dots/framework;make
make[4]: Entering directory
`/home/LTP/ltp-dev-20101027/testcases/DOTS/src/dots/framework'
javac -d ../../../classes -classpath ../../../classes DotsConfig.java
make[4]: javac: Command not found
make[4]: *** [all] Error 127
make[4]: Leaving directory
`/home/LTP/ltp-dev-20101027/testcases/DOTS/src/dots/framework'
make[3]: *** [framework] Error 2
make[3]: Leaving directory `/home/LTP/ltp-dev-20101027/testcases/DOTS/src'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/LTP/ltp-dev-20101027/testcases/DOTS'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/LTP/ltp-dev-20101027/testcases'
make: *** [testcases-all] Error 2

------------

The new directory "DOTS" is going to be compiled, but "java" compiler 
not installed.

Perhaps, following revision caused this failure, I think:

http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp.git;a=blobdiff;f=tes
tcases/Makefile;h=f74de50bcd73321a950004027ca1e508ecc07c1b;hp=37c448f12a529e
155abca2d3c4a820a8b10f60a3;hb=6278b69ea79287a1a0d89593b4902aaf2c8c0016;hpb=7
e2cbbd9e762bee21a500ef7afdecec321f3f1cf

------------
-ifneq ($(UCLINUX),1)
-FILTER_OUT_DIRS                += audit-test DOTS realtime
+ifeq ($(UCLINUX),1)
+FILTER_OUT_DIRS                += DOTS realtime
------------

I don't know right way, but...
In the third line, isn't "+ifneq ($(UCLINUX),1)" right?
Or is it a more right method to install JAVA?


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
