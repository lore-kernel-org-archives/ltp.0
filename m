Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PLhlx-0005pY-Vx
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 19:46:25 +0000
Date: Thu, 25 Nov 2010 20:58:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101125195848.GC10085@saboteur.suse.cz>
References: <197804608.229291290511437013.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1163307688.229311290511451623.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20101125171017.GE2853@saboteur.suse.cz>
	<AANLkTi=b5LsTayX9j8_yroYBLAr5=A-uSX_qkai8PMnM@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=b5LsTayX9j8_yroYBLAr5=A-uSX_qkai8PMnM@mail.gmail.com>
Subject: Re: [LTP] [PATCH] mbind_range() vma merge
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> 
> ...
> 
> > You should use tst_brkm(TBROK|TERRNO, tst_exit, "mmap") here. As
> > tst_brkm() exits when pointer to cleanup is not NULL.
> 
> Actually, the exit should be dropped and the tst_brkm invocation
> should be left alone. When NULL is specified as the second argument to
> tst_brkm, it automatically calls tst_exit.

I would disagree here. 

man tst_res

...

If func is NULL, tst_brk() and tst_brkm return to the caller after all
results have been printed.

...



And the corresponding code in the lib/tst_res.c is

...

	if (func != NULL) {
		(*func)();
		tst_exit();
	}

}


Which seems like a dump interface to me, but once used this way in whole
LTP, we cannot easily change that.

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
