Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fixed-term.Oleksij.Rempel@de.bosch.com>)
	id 1bL7rc-0008J6-Ft
	for ltp-list@lists.sourceforge.net; Thu, 07 Jul 2016 11:53:04 +0000
Received: from imta22.fe.bosch.de ([139.15.243.26])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bL7ra-0001rl-Jc
	for ltp-list@lists.sourceforge.net; Thu, 07 Jul 2016 11:53:04 +0000
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id A6A2A8403C2
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Jul 2016 13:52:55 +0200 (CEST)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 23565158016B
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Jul 2016 13:52:49 +0200 (CEST)
Received: from FE-HUB1001.de.bosch.com (vsgw24.fe.internet.bosch.com
	[10.4.98.24])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id C756AA402E1
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Jul 2016 13:52:48 +0200 (CEST)
From: fixed-term.Oleksij.Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Message-ID: <577E428F.3090801@de.bosch.com>
Date: Thu, 7 Jul 2016 13:52:47 +0200
MIME-Version: 1.0
Subject: [LTP] updating message_queue_test_02_*
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
To: ltp-list@lists.sourceforge.net, "Binh.LeCong" <Binh.LeCong@vn.bosch.com>, "Nga.HoangThiThuy@vn.bosch.com >> Nga.HoangThiThuy" <Nga.HoangThiThuy@vn.bosch.com>

Hallo all,

it is kind of a duplication of this case:
https://github.com/linux-test-project/ltp/issues/75

some of message_queue_test_02_* are fail on our configuration, it looks
like the reason is hardcoded tmp path, which is different in our test setup.

Looks like this tests should be updated to use current ltp bindings..
which should also fix this issue.  Do any one already working on it? If
not, me or some of us will try to do it.
-- 
Best regards,
Oleksij Rempel
CM-AI/ECO3
Tel.: +49(5121)49-2962

------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
