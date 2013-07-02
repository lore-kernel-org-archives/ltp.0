Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uu0ta-0003gt-Pv
	for ltp-list@lists.sourceforge.net; Tue, 02 Jul 2013 13:45:26 +0000
Date: Tue, 2 Jul 2013 15:46:54 +0200
From: chrubis@suse.cz
Message-ID: <20130702134654.GA6453@rei.suse.cz>
References: <1372662230-6993-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<20130701094958.GA12050@rei.suse.cz>
	<51D17373.3080908@cn.fujitsu.com>
	<20130701135519.GA21561@rei.suse.cz>
	<51D2CD13.7050002@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D2CD13.7050002@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib: add tst_rh_kvercmp to test RHEL kernel
	version
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> > So the case here is that the test is disabled because the we think that
> > it will not work. I'm fine with adding more information to the
> > tst_kvercmp() but we should do it more extensible and data driven
> > manner.
> > 
> > What about we create an array with extra version strings per
> > distribution that gets passed to tst_kvercmp2() function and is used
> > when particular distribution is detected?
> 
> RHEL kernel with a suffix like ".el5" on RHEL5 and ".el6" on RHEL6,
> I wonder how to detect SLES kernels?

We can use '/proc/version' and '/etc/SuSE-release' to identify SUSE
kernel running on the top of SLES userspace, which should be good enough
heuristics.

I can write that part of the code once we have the code for RHEL in
place.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
