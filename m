Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RLyFA-0003sk-2u
	for ltp-list@lists.sourceforge.net; Thu, 03 Nov 2011 14:26:12 +0000
Date: Thu, 3 Nov 2011 15:31:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111103143141.GF12153@saboteur.suse.cz>
References: <1317360651-19857-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1317362906-22726-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<20111005153603.GA29960@saboteur.suse.cz>
	<4E8CF9D5.7020402@cn.fujitsu.com> <4E92526F.3030704@cn.fujitsu.com>
	<20111012131527.GA21031@saboteur.suse.cz>
	<4EAE4C2A.7030509@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EAE4C2A.7030509@cn.fujitsu.com>
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
> >>> So, if the first running thread is not read_mem(), it will not fail with segment
> >>> fault all the time. So, I think there's no wrong with the signal or others' handling.
> >>>
> >>> We just make sure that read_mem() is not the first running thread, it will be enough.
> >>
> >>
> >> Any comment ?
> >>
> > 
> > Stay tuned, I'll get to this till the end of the week.
> > 
> 
> 
> Maybe you missed this?

Sorry, should get to this ASAP.

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
