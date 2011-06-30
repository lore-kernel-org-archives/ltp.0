Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QcJ4T-0003wz-Nu
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 15:22:25 +0000
Date: Thu, 30 Jun 2011 17:22:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110630152249.GC20254@saboteur.suse.cz>
References: <1305183593-25512-1-git-send-email-lliubbo@gmail.com>
	<5004B0F2-AD73-437F-995E-71B88F329A8E@gmail.com>
	<BANLkTik9irk3Yket8uK79H4d2X-5a8bYcg@mail.gmail.com>
	<20110531153741.GB1901@saboteur.suse.cz>
	<BANLkTik3Q9WgB_86S8f98cCYz091ZDpO=A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTik3Q9WgB_86S8f98cCYz091ZDpO=A@mail.gmail.com>
Subject: Re: [LTP] [PATCH] testcases: syscall: sockioctl: fix except return
 val
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
To: Bob Liu <lliubbo@gmail.com>
Cc: ltp-list@lists.sf.net

Hi!
> >> Whether using tst_kvercmp() can be accepted ?
> >
> > Sure. Ideally please add pointer to kernel commit that caused this
> > change in the test souce as a comment.
> >
> 
> Sorry for that, tst_kvercmp() can't be used since it's in struct define.
> Maybe a macro is needed, but I don't know which one to use.
> 
> Any ideas?

Initalize this field of the structure in test init function depending on
the kernel version.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
