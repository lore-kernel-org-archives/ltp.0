Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Skeck-0000o8-A3
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 17:04:50 +0000
Date: Fri, 29 Jun 2012 18:22:15 +0200
From: chrubis@suse.cz
Message-ID: <20120629162215.GA18851@saboteur.suse.cz>
References: <CANysfL_ya=ZMyZyyE__=3T-QTqFniRrj+nHMrNzeaVHMrnmA5A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANysfL_ya=ZMyZyyE__=3T-QTqFniRrj+nHMrNzeaVHMrnmA5A@mail.gmail.com>
Subject: Re: [LTP] crashme:fork12 test may kill other process that is not
 forked child
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ????????? <luobingjiun@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I proposed the solution for this is disable the OOM killer of=A0parent
> process and adjust child process's oom_score_adj to 500(or any
> other number larger than 0), this purpose just to make child process
> can be easily chosen.

I wouldn't do the increase in oom_score for the parent that doesn't help
much, because the test runs under pan which is started from a script
etc... So if any of the processes in the chain gets killed the testing
is done anyway.

Adjusting the child oom_score on the other hand is good idea is this
enough for the test to work okay?

And for the implementation, simple write would be far better solution
and please run you patch through checkpatch.pl before submitting next
time.

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
