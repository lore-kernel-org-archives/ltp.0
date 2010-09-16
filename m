Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannuxx@gmail.com>) id 1OwJhB-0000IV-Qu
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 19:00:33 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OwJhA-0001g4-Uy
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 19:00:33 +0000
Received: by bwz2 with SMTP id 2so2690678bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Sep 2010 12:00:27 -0700 (PDT)
Date: Thu, 16 Sep 2010 22:00:23 +0300
From: Hannu Heikkinen <hannuxx@iki.fi>
Message-ID: <20100916190023.GA11397@hannu-ubuntu>
References: <000401cb53c6$d7a16620$86e43260$@co.jp>
	<20100915134318.GD24784@hannu-debian.research.nokia.com>
	<AANLkTikYz9ppRN1FZBSnpyePoMV79GDWNA4umS7NLUn_@mail.gmail.com>
	<20100915182052.GA2750@hannu-ubuntu>
	<AANLkTik5HT2tDzaCfAU+7kgcsUNucrL6zPLZ3xdBF+kW@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTik5HT2tDzaCfAU+7kgcsUNucrL6zPLZ3xdBF+kW@mail.gmail.com>
Subject: Re: [LTP] POSIX "sched_yield/1-1.c" build failed
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
Cc: ext Mitani <mitani@ryobi.co.jp>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 15/09/10 12:01 -0700, Garrett Cooper wrote:
> >
> > Should this posixtest.h be kind of a must include for all test cases?
> > Currently not all cases include this.
> 
>     Well, every affected testcase should include this :). Not all
> files need to include this (there are a number of applications that
> don't need what's defined here) -- so there's no sense in generating
> more work than necessary :).
> Thanks,
> -Garrett

I must have been hald asleep writing that prev email. I meant that posixtest
cases should include that, and of course not all LTP cases.

Might be a consideration for having global ltp header file for all C test
cases
so that generic functionality could be better tweaked by changing certain
defines. Of course that needs more discussion and analysis, thoug.

br,
Hannu

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
