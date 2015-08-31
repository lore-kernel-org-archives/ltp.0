Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZWPv7-0000lT-6A
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2015 14:18:49 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZWPv3-0001so-9B
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2015 14:18:49 +0000
Date: Mon, 31 Aug 2015 16:18:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150831141804.GB18106@rei.suse.cz>
References: <5a7d12cf.debc.14f6ed773c1.Coremail.qianshuijiaolong@126.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a7d12cf.debc.14f6ed773c1.Coremail.qianshuijiaolong@126.com>
Subject: Re: [LTP] Linux 3.10
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
To: ???????? <qianshuijiaolong@126.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> hello dear:
>     Does ltp support Linux 3.10?

Yes.

> I want write a virtual usb device and I wan to reference the tusb
> module. But when I compile the module on ubuntu 12.04,I get many
> errors.

Looks like nobody has touched the test code for some quite time (there
was one minor change but apart from that nothing), it's not build by
default and basically abandoned.

The problem is that in-kernel API is not stable. So if the kernel part
of the test fails to compile you have to figure out what part of the API
has changed and fix the code accordingly. Patches for the testcases are
of course welcomed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
