Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4t0J-000241-15
	for ltp-list@lists.sourceforge.net; Thu, 01 Aug 2013 13:33:19 +0000
Date: Thu, 1 Aug 2013 15:33:08 +0200
From: chrubis@suse.cz
Message-ID: <20130801133308.GA1819@rei.scz.novell.com>
References: <1374548876-24829-1-git-send-email-liuhangbin@gmail.com>
	<20130731143448.GB2698@rei.scz.novell.com>
	<51F92131.7090406@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51F92131.7090406@redhat.com>
Subject: Re: [LTP] [PATCH] testcases/network/sctp: update sctp test to
 upstream version 1.0.15
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
To: Daniel Borkmann <dborkman@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>, Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

Hi!
> >> SCTP test in ltp is based on lksctp. But the last patch for sctp in ltp is
> >> 2006. It has changed a lot and fixed many bugs. Update sctp test to upstream
> >> version 1.0.15 now.
> >
> > I'm a bit confused here. Is the SCTP testsuite developed elsewhere? In
> 
> Still at the old SF place: http://lksctp.org/
> Git repo from the website: git://github.com/borkmann/lksctp-tools.git

So what about making it git submodule or including it only in the
released tarballs leaving only a README with URL to the original project
in the git?

It IMHO does not make much sense to have the code in two different git
repos and synchronizing them from time to time with really big patch is
even worse.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
