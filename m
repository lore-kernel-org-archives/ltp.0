Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QrZhf-0002fW-0U
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 18:09:59 +0000
Date: Thu, 11 Aug 2011 20:13:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110811181358.GA25487@saboteur.suse.cz>
References: <120e211c585b71f27c1bfc13d48e0f535b3201d5.1312279518.git.czhang@redhat.com>
	<1313075860-20655-1-git-send-email-czhang@redhat.com>
	<20110811163258.GB21959@saboteur.suse.cz>
	<4E44067B.2000200@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E44067B.2000200@redhat.com>
Subject: Re: [LTP] [PATCH v3] mm/ksm05: new testcase
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> >Commited, however it seems like half of the ksm tests are missing some
> >checks. On my workstation (which is obviously not a numa system) half of
> >them prints that numa system is required while the other half crashes
> >and segfaults.
> >
> Hmmm, ksm0[1-5] work well on my workstation (Gentoo + 3.0.0 / RHEL6);
> ksm01/05: normal ksm
> ksm02: ksm + NUMA
> ksm03: ksm + memcg
> ksm04: ksm + memcg + NUMA
> 
> Thus, non-NUMA system showing "numa system is required" for ksm02
> and ksm04 is expected.
> 
> What's the exact crash/segfaults info and which they occur in which tests?

ksm01

TBROK : unexpected signal 1 recieved (pid = 27438)
...

ksm03

TBROK : mount /dev/cgroup: errno=ENOENT
 and much more ENOENTS

ksm05

TBROK : open: errno=ENOENT(2): No such file or directory
TBROK : open: errno=ENOENT(2): No such file or directory
TBROK : open: errno=ENOENT(2): No such file or directory
TBROK : open: errno=ENOENT(2): No such file or directory
TBROK : open: errno=ENOENT(2): No such file or directory
TBROK : open: errno=ENOENT(2): No such file or directory
TBROK : open: errno=ENOENT(2): No such file or directory
...
Segfault

 - The infinite loop is actually caused by passing the
   cleanup function to tst_brkm() that is called from cleanup.


I suppose that at least ksm03 and ksm05 should return TCONF instead of
TBROK.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
