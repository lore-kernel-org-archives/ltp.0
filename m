Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qr9RT-0005FA-5H
	for ltp-list@lists.sourceforge.net; Wed, 10 Aug 2011 14:07:31 +0000
Date: Wed, 10 Aug 2011 15:55:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110810135518.GE8687@saboteur.suse.cz>
References: <1609707634.578233.1312258810042.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<474812428.578270.1312259338813.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<CAGH67wRZx=iRqR0fMEuGV83Gz686Bq1nLjC8rtJpFCYCT5QWVA@mail.gmail.com>
	<20110802131543.GA17783@sergelap>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110802131543.GA17783@sergelap>
Subject: Re: [LTP] Running only kernel syscall tests
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
To: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I'm curious - what exactly do people find they can run reliably with no
> hangs on a known good system?  On ec2 instances I find even runltp -f
> syscalls to hang.  I know, I know :)  I do intend to look into it.  But
> is there anything people find they can use as a gross "this works on good
> kernel, let's see if it breaks on test kernel" metric?

That is probably sched_yield() testcase, the culprit is writing to
stderr while plaing the ping pong with sched_yield() which would make
the disk writing thread lock (not really kernel bug as the test blocked
all cpus but one which on which it plays ping pong with sched_yield()).
At least it locks with some older kernels. I will commit a patch that
just removes useless printf().

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
