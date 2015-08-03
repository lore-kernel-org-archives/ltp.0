Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMEEO-0004Md-BB
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 11:48:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMEEK-0007SK-Vy
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 11:48:36 +0000
Date: Mon, 3 Aug 2015 13:48:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150803114812.GA1648@rei.suse.de>
References: <751019010.974973.1438321471218.JavaMail.zimbra@redhat.com>
	<1010625653.980528.1438323855616.JavaMail.zimbra@redhat.com>
	<20150803083908.GA31324@rei.suse.de>
	<CAEemH2dOo=3Gq=c4eLuYL=itfYHLZMqFMDh_88k7ttUikqLA9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dOo=3Gq=c4eLuYL=itfYHLZMqFMDh_88k7ttUikqLA9Q@mail.gmail.com>
Subject: Re: [LTP] How to compie a ltp-case into 32-bit on the 64bit system
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Yes, you are right.
> 
> But I hope to finish the  'msgrcv08' test by LTP automatically. To
> recompile the whole LTP-Lib in 32-bit only for this one case is not my
> expected.  I tend to give up the testcase if we don't have any other  way.
> :(

This is not how this works. You have to compile and run LTP for both
32bit and 64bit to test both 64bit and 32bit versions of syscalls.

So the right solution is to make the test exit with TCONF when compiled
for 64bit.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
