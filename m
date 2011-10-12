Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RDybB-0005sP-9q
	for ltp-list@lists.sourceforge.net; Wed, 12 Oct 2011 13:11:53 +0000
Date: Wed, 12 Oct 2011 15:15:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111012131527.GA21031@saboteur.suse.cz>
References: <1317360651-19857-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1317362906-22726-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<20111005153603.GA29960@saboteur.suse.cz>
	<4E8CF9D5.7020402@cn.fujitsu.com> <4E92526F.3030704@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E92526F.3030704@cn.fujitsu.com>
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
> > Sure, but I saw that when read_mem() goes first and become the first running
> > thread, it should cause segment fault all the time now.
> > 
> > So, if the first running thread is not read_mem(), it will not fail with segment
> > fault all the time. So, I think there's no wrong with the signal or others' handling.
> > 
> > We just make sure that read_mem() is not the first running thread, it will be enough.
> 
> 
> Any comment ?
> 

Stay tuned, I'll get to this till the end of the week.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
