Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwcDZ-0005iK-Gs
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 15:51:45 +0000
Date: Thu, 25 Aug 2011 17:56:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825155657.GC20282@saboteur.suse.cz>
References: <4E3F8C85.2020704@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E3F8C85.2020704@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX] [PATCH] sched_setparam: fix the wrong file path.
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> Modify the file path to "/dev/null" when call ftok().

Technically yes, but these tests are invalid for many other reasons and
needs to be redesigned as whole.

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
