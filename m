Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XHAF6-0001wC-9j
	for ltp-list@lists.sourceforge.net; Tue, 12 Aug 2014 11:27:52 +0000
Date: Tue, 12 Aug 2014 13:26:52 +0200
From: chrubis@suse.cz
Message-ID: <20140812112652.GA1656@rei.suse.cz>
References: <20140520144246.GA30023@rei.suse.cz>
	<1402996098-12697-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140811150413.GC2022@rei.suse.cz> <53E9C7B8.1040504@oracle.com>
	<20140812090446.GA2533@rei.suse.cz> <53E9F644.5000101@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53E9F644.5000101@oracle.com>
Subject: Re: [LTP] [PATCH V2 3/3] ltp_rt_sigaction.h: added SPARC support
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Sorry, I was incorrect.
> 
> If a sigaction.c includes kernel_sigaction.h, it implies that the 
> sigaction() implementation uses 'struct kernel_sigaction'.
> 
> But this fact doesn't mean that 'struct sigaction' for this platform 
> has/doesn't have .sa_restorer member.
> 
> It seems that only:
>   * alpha
>   * ia64
>   * hppa
> 
> platforms don't have .sa_restorer in 'struct sigaction'.

That seems to be consistent with my expectations, however I cannot test
LTP compilation on alpha and hppa.

But in the end I think that we are fine with ifdefing out the
sa_restorer on these platfors. Can you plase push such patch?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
