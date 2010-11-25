Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PLgKh-0005ng-Pb
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 18:14:11 +0000
Date: Thu, 25 Nov 2010 19:26:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101125182632.GA7551@saboteur.suse.cz>
References: <4CE61F95.0@cn.fujitsu.com>
	<20101119122145.GB19564@saboteur.suse.cz>
	<AANLkTim_uuAEQcuJ6o7=GJT7Gp0G_b2LYUYpxZKg15Jm@mail.gmail.com>
	<4CE9C778.6000703@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CE9C778.6000703@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH]Instead sem_wait by fcntl for sigaction
 test.
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

Hi!
> >>> Some days before, mitani-san reported some sigaction test failed at linux,
> >>> http://sourceforge.net/mailarchive/message.php?msg_id=000001cb798d%241aaa0210%244ffe0630%24%40co.jp
> >>>
> >>> As Garrett said, add Linux-isms is not advisably. So i want try to fix it by another method.
> >>>
> >>> I have seen the assertions.xml, these tests want to test sigaction with SA_RESTART
> >>> not sem_wait(it looks like there's a bug at older linux kernel), so i suggest to
> >>> instead sem_wait by fcntl.
> >>>
> >>> What about this one?  If you agree with me, i will post other patchs.
> >> As far as I understand this, you are trying to avoid a fact, that older
> >> kernels are not comforming to the POSIX specification. This is a case
> >> where the test is failing for a good reason, all we could do here is
> >> print message like:
> >>
> >> "this test is known to fail on linux kernel < 2.6.22"
> >>
> >> Before the test reports failure.
> > 
> > Well... I would actually record these items in a file somewhere. Once
> > upon a time the ltp-results@ list was a good source for this data, but
> > I don't know how useful this data is anymore or how much/well this
> > data is reported and subsequently mined (I'm not on the list for
> > instance)...
> > 
> >> On the other end I do not object to adding test for file locks with
> >> SA_RESTART. But you should not remove the sem_lock() test (as it's not
> >> broken).
> > 
> > Agreed.
> > 
> 
>   Well...
>   Then, do you have a plan to do it?

So far there are more important things on my TODO.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
