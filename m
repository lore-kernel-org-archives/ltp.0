Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NXSKO-0001yU-3e
	for ltp-list@lists.sourceforge.net; Wed, 20 Jan 2010 04:38:00 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NXSKM-00061V-KB
	for ltp-list@lists.sourceforge.net; Wed, 20 Jan 2010 04:38:00 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.28])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 81426211320
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Jan 2010 04:37:51 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id DA0A93DD024
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Jan 2010 04:37:50 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Jan 2010 13:37:49 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 20 Jan 2010 13:37:48 +0900
Message-ID: <000701ca998a$51aed7b0$f50c8710$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] 2010-01-20 cvs build failed
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

Thank you for your great effort for "make3.80" supporting.

But in my system, there are several problems.

Because it is necessary to report about them hastily, I report them 
without investigation first of all.

I tried to make with 2010-01-20 version cvs in my several systems.
 - RHEL5.4 x86
 - RHEL5.4 x86_64
 - RHEL5.4 ia64
 - RHEL4.8 x86 (using make3.80/3.81)
 - RHEL4.8 x86_64 (using make3.80/3.81)

I show below the results.


1) <RHEL5.4 x86>
"make" succeeded, but "make install" failed as follows:
------------
mkdir -m 00755 -p "//opt/ltp"
mkdir -m 00755 -p "//opt/ltp/bin"
make -C "doc" \
		-f "/home/LTP/ltp-2010-01-20/doc/Makefile" install
make[1]: Entering directory `/home/LTP/ltp-2010-01-20/doc'
make[2]: Entering directory `/home/LTP/ltp-2010-01-20/doc/man1'
make[2]: *** No rule to make target `/opt/ltp/share/man/man1', needed by
`/opt/ltp/share/man/man1/doio.1'.  Stop.
make[2]: Leaving directory `/home/LTP/ltp-2010-01-20/doc/man1'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/LTP/ltp-2010-01-20/doc'
make: *** [doc-install] Error 2
------------

2) <RHEL5.4 x86_64>
3) <RHEL5.4 ia64>
4) <RHEL4.8 x86> (using make3.81)
5) <RHEL4.8 x86_64> (using make3.81)
In above systems, results were same as <RHEL5.4 x86>.


6) <RHEL4.8 x86> (using make3.80)
Strangely, the "make" command returned immediately.
"echo $?" was 0. But log was only several lines as follows:

------------
make -C testcases/realtime autotools
make[1]: Entering directory `/home/LTP/ltp-2010-01-20/testcases/realtime'
autoheader
make[1]: Leaving directory `/home/LTP/ltp-2010-01-20/testcases/realtime'
------------

Is this message same as what is written in the "INSTALL" file?

Just in case, I tried "make install".
But the result was as follows:

------------
make -C "pan" \
        -f "/home/LTP/ltp-2010-01-20/pan/Makefile" install
make[1]: Entering directory `/home/LTP/ltp-2010-01-20/pan'
test -d "/opt/ltp/bin" || mkdir -p "/opt/ltp/bin"
install -m 00775 "/home/LTP/ltp-2010-01-20/pan/ltp-bump"
"/opt/ltp/bin/ltp-bump"
install: cannot stat `/home/LTP/ltp-2010-01-20/pan/ltp-bump': No such file
or directory
make[1]: *** [/opt/ltp/bin/ltp-bump] Error 1
make[1]: Leaving directory `/home/LTP/ltp-2010-01-20/pan'
make: *** [pan-install] Error 2
------------


7) <RHEL4.8 x86_64> (using make3.80)
Results were same as <RHEL4.8 x86> (using make3.80).





Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
