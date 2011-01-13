Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PdQwj-0003M1-Ku
	for ltp-list@lists.sourceforge.net; Thu, 13 Jan 2011 17:26:49 +0000
Date: Thu, 13 Jan 2011 18:43:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110113174325.GA7180@saboteur.suse.cz>
References: <20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
	<AANLkTi=L8Vai5_=fn0psJeovura_Y=VjdN28ufiqBiiA@mail.gmail.com>
	<AANLkTin-yaUcPd8GZHgWnoYkxpOxDFs4enEik8afaeEc@mail.gmail.com>
	<AANLkTinFbVBZtA_hCfRqTK=sZW+ZBSi3KbjA7Butkfum@mail.gmail.com>
	<F3972A55-1F53-4B70-A858-E041E01F246D@gmail.com>
	<20110107143607.GA12323@saboteur.suse.cz>
	<C4CD5B9F-C198-44A7-996B-3D2C46C4AD86@gmail.com>
	<20110110184316.GB23413@saboteur.suse.cz>
	<AANLkTi=RGbG++FaG4AsZZkrZB14cuKPeuOZZPNVoNvSc@mail.gmail.com>
	<20110110200100.GC23413@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110110200100.GC23413@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH 00/13]Fix a few syntax error
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
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> > int
> > main(void)
> > {
> >     tst_brkm(TCONF, NULL, "gcc is dumb");
> > }
> 
> Well, that's the whole reason for attribute __noreturn__. The compiler
> is not smart enough and it's not easy to make it smarter, without a buch
> of matematicians and a lot of work. And as such code leads, usually, to
> bug, the gcc folks rather prints the warning. There are even parts of
> gcc compiler, that are compiled with warnings disabled...

Thinking of this again, even a bunch of matematicians wouldn't help
here. As the compiler doesn't have any means to find out, when main is
compiled, how tst_brkm() is actually implemented. That is not possible
before the linker comes into play and in case of dynamic linker, this
warning could be generated only at runtime. That's IMHO the whole reason
for attribute __noreturn__.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
