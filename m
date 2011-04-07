Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q7nuG-0008W3-3a
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 12:01:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q7nuE-0006TW-VQ
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 12:01:48 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p37C1elP022386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Apr 2011 08:01:40 -0400
Message-ID: <4D9DA7A1.7000901@redhat.com>
Date: Thu, 07 Apr 2011 20:01:37 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
Subject: [LTP] mem/libmm usage?
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

Hi, in mem/libmm directory, I found there's a library libmm.a been
built, and mem/ dir, hugetlb/ dir both include the lib in their
Makefiles, However, I can't see who is using the functions in the lib.
Anyone who knows its usage, or it could be removed from mem/ dir?

Thanks,
Caspar
-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
