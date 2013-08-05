Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V6Jda-0002tY-AC
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 12:11:46 +0000
Date: Mon, 5 Aug 2013 14:11:36 +0200
From: chrubis@suse.cz
Message-ID: <20130805121135.GB8739@rei>
References: <1374548876-24829-1-git-send-email-liuhangbin@gmail.com>
	<20130731143448.GB2698@rei.scz.novell.com>
	<51F92131.7090406@redhat.com>
	<20130801133308.GA1819@rei.scz.novell.com>
	<20130802013524.GN14331@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130802013524.GN14331@localhost.localdomain>
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>, Daniel Borkmann <dborkman@redhat.com>, Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

Hi!
> > > Still at the old SF place: http://lksctp.org/
> > > Git repo from the website: git://github.com/borkmann/lksctp-tools.git
> > 
> > So what about making it git submodule or including it only in the
> > released tarballs leaving only a README with URL to the original project
> > in the git?
> > 
> > It IMHO does not make much sense to have the code in two different git
> > repos and synchronizing them from time to time with really big patch is
> > even worse.
> 
> The lksctp-tools project provides a Linux user space library for SCTP
> (libsctp) including C language header files (netinet/sctp.h) for accessing
> SCTP specific application programming interfaces not provided by the standard
> sockets, and also some helper utilities around SCTP.
> 
> The sctp test case is only a little part of lksctp-tools and used for
> sctp protocol stack testing. LTP include these test cases from 2002 for
> networking test. It is just like TCP/UDP/ICMP/IGMP testing. I don't see any
> reason why we should remove it from network stack testing.

I haven't said we should remove them from LTP. I'm just trying to figure
out if we can do better than having the sources maintained in two git
repos at the same time which is more work and prone to mistakes.

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
