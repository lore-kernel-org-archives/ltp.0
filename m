Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOlyn-0001Gd-1J
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 05:15:33 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOlyg-0006be-Pc
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 05:15:33 +0000
Received: by yxe33 with SMTP id 33so7980650yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 22:15:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A078D013C0@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078D013C0@svexch01.mvista.com>
Date: Wed, 8 Jul 2009 22:15:25 -0700
Message-ID: <364299f40907082215y1ff87894t1296be768bfa222e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] utimensat_test.sh, fix hardcoded tmp directory
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jul 8, 2009 at 8:23 PM, Henry Yei<hyei@mvista.com> wrote:
> Here is a patch for utimensat_test.sh to change the hardcoded tmp directory to use the LTP variable TMPDIR which may bet set by the user to point to other than /tmp

Looks good!
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
