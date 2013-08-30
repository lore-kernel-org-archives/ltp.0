Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1VFI2E-0005qP-1Q
	for ltp-list@lists.sourceforge.net; Fri, 30 Aug 2013 06:18:18 +0000
Received: from mail-lb0-f180.google.com ([209.85.217.180])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VFI2C-00017l-0F
	for ltp-list@lists.sourceforge.net; Fri, 30 Aug 2013 06:18:18 +0000
Received: by mail-lb0-f180.google.com with SMTP id q8so1491874lbi.25
	for <ltp-list@lists.sourceforge.net>;
	Thu, 29 Aug 2013 23:18:09 -0700 (PDT)
Date: Fri, 30 Aug 2013 08:22:59 +0200
From: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20130830062259.GD18729@nexon.se>
References: <1377761241-17744-1-git-send-email-anders.roxell@linaro.org>
	<1377761241-17744-3-git-send-email-anders.roxell@linaro.org>
	<CA+icZUWpYYd__ZKdX6SBbbpN9tJHGnywVhrawHo_UJ3ub=3cOA@mail.gmail.com>
	<201308292016.29360.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201308292016.29360.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/2] runltp: remove bashisms
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, patches@linaro.org

Hi,

On 2013-08-29 20:16, Mike Frysinger wrote:
> On Thursday 29 August 2013 04:41:33 Sedat Dilek wrote:
> > On Thu, Aug 29, 2013 at 9:27 AM, Anders Roxell wrote:
> > > -    echo -e "LOG File: \c"
> > > +    echo -n "LOG File: "
> > 
> > Yesterday, I looked through diverse GIT repos where I saw a commit
> > saying that "echo" (dunno if it was "-e" or "-n") is not
> > POSIX-compliant and "printf" should be used.
> > I am no POSIX guy, but maybe someone can confirm this?
> 
> use `printf` please for both -e and -n issues
I did resend the patch yesterday, with subject: "[PATCHv2 0/2] Rework to
printf and added required import"

/Anders

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
