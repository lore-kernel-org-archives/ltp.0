Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MWTME-0004Gx-U7
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 10:59:34 +0000
Received: from an-out-0708.google.com ([209.85.132.248])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWTM8-0007Yi-Mt
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 10:59:34 +0000
Received: by an-out-0708.google.com with SMTP id c38so674231ana.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 03:59:23 -0700 (PDT)
Message-ID: <4A717D05.2070603@petalogix.com>
Date: Thu, 30 Jul 2009 12:59:17 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <20090730075802.GE3058@console-pimps.org>
In-Reply-To: <20090730075802.GE3058@console-pimps.org>
Subject: Re: [LTP] fcntl24,25,26 fail when run on tmpfs
Reply-To: michal.simek@petalogix.com
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
To: Matt Fleming <matt@console-pimps.org>
Cc: ltp-list@lists.sourceforge.net

Hi Matt,
> Attached is a patch to skip testcases fcntl24, fcntl25 and fcntl26 if
> the host is running on tmpfs. The reason being that, as documented here
> http://bugzilla.kernel.org/show_bug.cgi?id=13626, F_SETLEASE and F_WRLCK
> cannot work on tmpfs.
>   
I tested it and works. The same issue is for RAMFS. But for this fs in
necessary to create
tst_is_cwd_ramfs function. Maybe worth to add together
tst_is_cwd_tmpfs.c and tst_cwd_has_free.c too.

Regards,
Michal

>   
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
