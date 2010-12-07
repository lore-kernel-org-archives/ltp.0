Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PPuT6-0008H5-E8
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 10:08:20 +0000
Received: from out15.sjc.mx.trendmicro.com ([216.99.131.72])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PPuT5-00046d-2u
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 10:08:20 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.130])
	by out15.sjc.mx.trendmicro.com (Postfix) with ESMTP id 06CE1980434
	for <ltp-list@lists.sourceforge.net>;
	Tue,  7 Dec 2010 10:08:13 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 422253DD01C
	for <ltp-list@lists.sourceforge.net>;
	Tue,  7 Dec 2010 10:08:12 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Dec 2010 19:08:09 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 7 Dec 2010 19:08:09 +0900
Message-ID: <000001cb95f6$a6565400$f302fc00$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] [PATCH] fix \"timer_create/10-1\" and \"timer_create/11-1\"
	tests
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


How about my patch for "timer_create/10-1" and "11-1"?

I am glad if I get some opinion.

Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
