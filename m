Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MZElM-0001p2-5T
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 02:00:56 +0000
Received: from qw-out-1920.google.com ([74.125.92.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZElL-0002d0-Ec
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 02:00:56 +0000
Received: by qw-out-1920.google.com with SMTP id 5so500884qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Aug 2009 19:00:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
	<0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
	<b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
Date: Thu, 6 Aug 2009 18:37:23 -0700
Message-ID: <364299f40908061837r4f27c93at80061628cb8e880c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/4] tst_is_cwd: Add support for ramfs
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, monstr@monstr.eu

On Mon, Aug 3, 2009 at 6:24 AM, <michal.simek@petalogix.com> wrote:
> From: Michal Simek <monstr@monstr.eu>
>
> I added support for testing ramfs and add together
> tests for nfs, tmpfs and ramfs.

[...]

Hi Michal,

I'm looking at this code to solve another interesting problem, but
just out of curiosity -- why did you #define the constants instead of
using the definitions in sys/vfs.h? To ensure that the manpage was
correct :)?

Thanks,
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
