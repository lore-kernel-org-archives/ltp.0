Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1NRoMJ-0004RI-Iq
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 14:56:39 +0000
Received: from mail-bw0-f212.google.com ([209.85.218.212])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NRoMH-0002bR-RV
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 14:56:39 +0000
Received: by mail-bw0-f212.google.com with SMTP id 4so9452726bwz.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Jan 2010 06:56:36 -0800 (PST)
Message-ID: <4B420158.4060504@petalogix.com>
Date: Mon, 04 Jan 2010 15:55:20 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <000001ca8cfb$e04fb340$a0ef19c0$@co.jp>
In-Reply-To: <000001ca8cfb$e04fb340$a0ef19c0$@co.jp>
Subject: Re: [LTP] nanosleep testcase problem
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

Mitani wrote:
> Hi,
> 
> I want to wish you happy new year.
> 
> 
> ------
> 
> By the way, I found a new problem with the "nanosleep02" testcase.
> 
> "main()" function executes fork(), and child process calls "do_child()"
> function.
> "do_child()" function must be ended by "exit()". But in "nanosleep02"
> testcase, there is a case in which "exit()" isn't executed.
> Therefore, the child process lives after "do_child()" function, 
> and it executes "wait()" function which must be executed in parent
> process only.

On Microblaze this test failed too. The patch fix it.

Michal

> 
> Here is the patch fixes these problem:
> 
> ============
> --- nanosleep02.c	2009-12-23 02:35:13.000000000 +0900
> +++ nanosleep02.c.new	2010-01-04 10:15:08.000000000 +0900
> @@ -277,6 +277,9 @@
>  		tst_resm(TPASS, "call succeeded");
>  		exit(0);
>  	}
> +	
> +	/* Everything is fine, exit normally */
> +	exit(0);
>  }
>  
>  /*
> ============
> 
> 
> Regards--
> 
> 
> -Tomonori Mitani
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
