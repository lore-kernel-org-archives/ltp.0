Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yamato@redhat.com>) id 1MP865-0004Vc-Gt
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 04:52:33 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MP85s-0001uK-Mv
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 04:52:28 +0000
Date: Fri, 10 Jul 2009 13:52:15 +0900 (JST)
Message-Id: <20090710.135215.615775074055320747.yamato@redhat.com>
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <364299f40907091040v73e1dc3dm8c8eada4221abc7b@mail.gmail.com>
References: <364299f40907070906v174de45ci6765d3111f64a279@mail.gmail.com>
	<f5a7b3810907090750lde8e9carc9fe8a6317e67153@mail.gmail.com>
	<364299f40907091040v73e1dc3dm8c8eada4221abc7b@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [LTP] Compile failure with rt_sigaction on amd64
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net, naresh.kernel@gmail.com

I've found an interesting code in glibc about "rt_sigaction".

sysdeps/unix/sysv/linux/x86_64/sigaction.c:
int
__libc_sigaction (int sig, const struct sigaction *act, struct sigaction *oact)
{
  int result;
  struct kernel_sigaction kact, koact;

  if (act)
    {
      kact.k_sa_handler = act->sa_handler;
      memcpy (&kact.sa_mask, &act->sa_mask, sizeof (sigset_t));
      kact.sa_flags = act->sa_flags | SA_RESTORER;

      kact.sa_restorer = &restore_rt;
    }

  /* XXX The size argument hopefully will have to be changed to the
     real size of the user-level sigset_t.  */
  result = INLINE_SYSCALL (rt_sigaction, 4,
			   sig, act ? __ptrvalue (&kact) : NULL,
			   oact ? __ptrvalue (&koact) : NULL, _NSIG / 8);
--------------------------------------------------------------^^^^^^^^^



How do you think follow the way to glibc?
In addition man page is needed to update.

Masatake YAMATO

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
