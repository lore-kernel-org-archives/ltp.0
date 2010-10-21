Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1P8uaj-0003n4-Hh
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 12:49:57 +0000
Received: from out20.sjc.mx.trendmicro.com ([216.99.131.77])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P8uah-0006J3-R9
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 12:49:57 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.136])
	by out20.sjc.mx.trendmicro.com (Postfix) with ESMTP id D1A35980447
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Oct 2010 12:49:49 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 35EED9583E
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Oct 2010 12:49:48 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Oct 2010 21:49:47 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 21 Oct 2010 21:49:46 +0900
Message-ID: <000101cb711e$710bfe00$5323fa00$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About "aio_error/3-1" test
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


I tried to test "aio_error" test,  but "3-1" failed:
------------
conformance/interfaces/aio_error/2-1: execution: PASS
conformance/interfaces/aio_error/3-1: execution: FAILED: Output: 
aio_error/3-1.c errno is not EINVAL Success
conformance/interfaces/aio_error/1-1: execution: PASS
------------


I reported about the failure of this "3-1" test before, and I made patch.
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10796.html

And this testset was revised to become simpler.
But I do not understand about followings:
  - The reason that the test with "aio_write()" is not good. 
  - Isn't the test with "aio_write()" necessary? 
    ( The test with "aio_write()" is one of suitable tests for 
    "aio_error()", I think. )


Thank you--

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
