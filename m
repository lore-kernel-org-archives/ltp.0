Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WcBFU-0008MO-Kw
	for ltp-list@lists.sourceforge.net; Mon, 21 Apr 2014 10:14:52 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WcBFT-0004R2-3P
	for ltp-list@lists.sourceforge.net; Mon, 21 Apr 2014 10:14:52 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3LAEht7028862
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Apr 2014 18:14:43 +0800
Message-ID: <5354EF1D.2000206@cn.fujitsu.com>
Date: Mon, 21 Apr 2014 18:12:45 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] compiling problems about mk/generic_leaf_target.inc
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
To: LTP <ltp-list@lists.sourceforge.net>

Hi,

When we made modifications to source files in lib/, for example lib/tst_mkfs.c, then back to
testcases/kernel/syscalls/access and execute  command make. This will not make the access[0-5]
to be re-compiled with the newly generated libltp.a, we need to touch access[0-5].c or remove access[0-5]
files first, then make. I think this will make no sense.  Users may expect just a make command to
ensure  a new access[0-5] is generated with new libltp.a.

This is because  the rules "target : normal-prerequisites | order-only-prerequisites" in generic_leaf_target.inc.
$(MAKE_TARGETS): | $(MAKE_DEPS)

Whether we should modify this to "$(MAKE_TARGETS): $(MAKE_DEPS)"? Thanks.


Regards,
Xiaoguang Wang

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
