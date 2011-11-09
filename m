Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RO4KU-0006l0-Uo
	for ltp-list@lists.sourceforge.net; Wed, 09 Nov 2011 09:20:22 +0000
Date: Wed, 9 Nov 2011 10:26:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111109092621.GB31394@saboteur.suse.cz>
References: <1317360651-19857-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1317362906-22726-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<20111005153603.GA29960@saboteur.suse.cz>
	<4E8CF9D5.7020402@cn.fujitsu.com> <4E92526F.3030704@cn.fujitsu.com>
	<20111012131527.GA21031@saboteur.suse.cz>
	<4EAE4C2A.7030509@cn.fujitsu.com>
	<20111103143141.GF12153@saboteur.suse.cz>
	<4EBA4431.7050403@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EBA4431.7050403@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] mtest06: avoid the segment fault of
	nul	address dereference
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>>>> So, if the first running thread is not read_mem(), it will not fail with segment
> >>>>> fault all the time. So, I think there's no wrong with the signal or others' handling.
> >>>>>
> >>>>> We just make sure that read_mem() is not the first running thread, it will be enough.
> >>>>
> >>>>
> >>>> Any comment ?
> >>>>
> >>>
> >>> Stay tuned, I'll get to this till the end of the week.
> >>>
> >>
> >>
> >> Maybe you missed this?
> > 
> > Sorry, should get to this ASAP.
> > 
> 
> 
> Yeah Cyril:
> I see you are back.
> Please don't miss this now.

Don't worry. I've spend one afternoon playing with the testcase and it's
full of misconceptions race conditions and broken code (and one of the
bugs disables the reading thread shortly after the start so no testing
is done at all no matter how long you run it). I have, so far, five
incremental patches that fixes most of the problems but it's not
finished yet. I expect to commit these hopefully this week.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
