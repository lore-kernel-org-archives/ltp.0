Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MPJI6-0007yE-T0
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 16:49:42 +0000
Received: from an-out-0708.google.com ([209.85.132.243])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPJHv-0001bf-3C
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 16:49:37 +0000
Received: by an-out-0708.google.com with SMTP id c38so507316ana.37
	for <ltp-list@lists.sourceforge.net>;
	Fri, 10 Jul 2009 09:49:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810907100201p514cb9a2p44faaaa42bc59a32@mail.gmail.com>
References: <364299f40907070906v174de45ci6765d3111f64a279@mail.gmail.com>
	<f5a7b3810907090750lde8e9carc9fe8a6317e67153@mail.gmail.com>
	<364299f40907091040v73e1dc3dm8c8eada4221abc7b@mail.gmail.com>
	<20090710.135215.615775074055320747.yamato@redhat.com>
	<f5a7b3810907100201p514cb9a2p44faaaa42bc59a32@mail.gmail.com>
Date: Fri, 10 Jul 2009 09:49:29 -0700
Message-ID: <364299f40907100949t53d57f5eyb2ec00f0e8074a9a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Jul 10, 2009 at 2:01 AM, naresh kamboju<naresh.kernel@gmail.com> wrote:
> Garrett,
>
> However, before concluding problem/issue need some more Investigation
> Please remove
> -kill(getpid(),signal);
> from rt_sigaction01.c
> And complie and execute and share the results.

    That worked without segfaulting, but doesn't that negate the whole
purpose of the test?
Thanks,
-Garrett

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
