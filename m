Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwYxQ-0005JZ-52
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 12:22:52 +0000
Date: Thu, 25 Aug 2011 14:28:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825122802.GD12466@saboteur.suse.cz>
References: <1314242727-22856-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4E55C2D4.4020102@redhat.com> <4E55E3C2.7030109@cn.fujitsu.com>
	<4E55E443.90606@redhat.com> <4E55E5E0.3020203@cn.fujitsu.com>
	<4E55EBFB.1060508@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E55EBFB.1060508@redhat.com>
Subject: Re: [LTP] [PATCH] mmap: fix testcase 11
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>This case is used to test regression of this bug (and trying to test
> >>whether this bug affects other releases/platforms), so if it couldn't
> >>reproduce on a buggy kernel, I would say the case itself makes little
> >>sense to us.
> >
> >It seems hard to produce, but have you ever produced it?
> 
> Yes, I reproduced it after applied with my previous patch[1], there
> were some issues still exist that Cyril thought it was not a good
> fix to merge in upstream[2]. So I'm looking for a good way to fix
> it, before that, I'd suggest disable mmap11 test in regular
> testings.

I could lend a helping hand and actually I've asked for clarifying how
is the bug triggered so we could get it working.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
