Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZXTSq-00022H-68
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2015 12:18:00 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZXTSn-0000S0-PH
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2015 12:18:00 +0000
Date: Thu, 3 Sep 2015 14:17:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150903121711.GA25522@rei.suse.cz>
References: <CANKSX+FjoktkpNQ4tRkEKLv_XKuDHF57-TaO13bs2wYAJDcQiw@mail.gmail.com>
	<20150903111522.GA24962@rei.suse.cz>
	<CANKSX+EGOtjDKHhX3sHRcxgeJRZbQDwSYoLa7zh64V3GROqnYA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANKSX+EGOtjDKHhX3sHRcxgeJRZbQDwSYoLa7zh64V3GROqnYA@mail.gmail.com>
Subject: Re: [LTP] Syscall/io_* tests failing to compile
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
To: "$rik@nth " <srikanth007m@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I haven't modified any of the config files at all. Even i cross
> checked on couple machines and faced similar issues.

Hmm, you are cross compiling right? Have you installed the libaio-dev on
the host machine? Because that will not work since that contains native
binaries and you cannot link against them.

If that is the case you can either cross compile the libaio and set
right path for linker etc. or set up an arm virtual machine or chroot
with qemu arm emulation and compile LTP there.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
