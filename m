Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOq6b-0000Ao-QP
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 09:39:53 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOq6U-0003Xc-Gp
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 09:39:53 +0000
Received: by yxe33 with SMTP id 33so35943yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Jul 2009 02:39:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907081953.18802.vapier@gentoo.org>
References: <364299f40907061722v45417bddhac499efa1415d6af@mail.gmail.com>
	<200907081953.18802.vapier@gentoo.org>
Date: Thu, 9 Jul 2009 02:39:46 -0700
Message-ID: <364299f40907090239p3c5bb571l6bc9acfe972476b0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/4] Refactor top-level Makefiles,
	modularize 	autoconf logic
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
Cc: ltp-list@lists.sourceforge.net

On Wed, Jul 8, 2009 at 4:53 PM, Mike Frysinger<vapier@gentoo.org> wrote:

One note:

> there is a $(basename ...) make function so you dont need to use `basename`

$(basename) has a different meaning, compared to the standard c libcall:

From http://www.gnu.org/software/make/manual/make.html#File-Name-Functions:

$(basename names...)
    Extract the base name (name without suffix) of each file name.
    See Functions for File Names.

$(notdir) is the actual preferred built-in. Now I remember why I was
doing $(notdir) :)...

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
