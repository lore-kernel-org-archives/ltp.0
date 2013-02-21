Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U8cKx-0004bB-S8
	for ltp-list@lists.sourceforge.net; Thu, 21 Feb 2013 20:01:47 +0000
Date: Thu, 21 Feb 2013 21:02:24 +0100
From: chrubis@suse.cz
Message-ID: <20130221200224.GA8559@rei.Home>
References: <1361470250-2489-1-git-send-email-vlee@twitter.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1361470250-2489-1-git-send-email-vlee@twitter.com>
Subject: Re: [LTP] [PATCH] syscalls/getrusage04: Link rt through LDLIBS
 instead of LDFLAGS.
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
To: Vinson Lee <vlee@twitter.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Fixes this build error on Ubuntu introduced with commit
> 07f4e5432dd3e7a60bc0235f13200640c82d8f89.
> 
> testcases/kernel/syscalls/getrusage/getrusage04.c:186: undefined reference to `clock_getres'
> 

Thanks, commited.

(And sorry that I got it wrong)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
