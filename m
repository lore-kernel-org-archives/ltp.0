Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NJ2EY-0000k5-G9
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 09:56:22 +0000
Received: from mail-gx0-f224.google.com ([209.85.217.224])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NJ2ES-0004jo-U7
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 09:56:22 +0000
Received: by gxk24 with SMTP id 24so844854gxk.6
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Dec 2009 01:56:11 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <000001ca79f4$7869a110$693ce330$@co.jp>
Date: Fri, 11 Dec 2009 01:56:08 -0800
Message-Id: <135282C4-83A6-43D5-9D26-D711482A88A1@gmail.com>
References: <000001ca79f4$7869a110$693ce330$@co.jp>
Subject: Re: [LTP] "libevent01" test failure with ltp-2009-12-10 cvs
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

On Dec 10, 2009, at 3:57 PM, Mitani wrote:

> Hi,
> 
> I got following message when I ran test of "libevent01" with 
> ltp-2009-12-10 cvs.
> 
> ------------
> sh: run_libevent.sh: command not found
> ------------
> 
> This occured because "run_libevent.sh" was not installed under the 
> "/opt/ltp" directory, I think.
> 
> Certainly, this test successed when I copied 
> "${LTPROOT}/testcases/kernel/syscalls/libevent/run_libevent.sh" file 
> to the "/opt/ltp/testcases/bin" directory.
> 
> So, I want to suggest the following revision:
> 
> 1. Install "run_libevent.sh" to under the "/opt/ltp/testcases/bin" 
>   directory by default.
>  (I don't know how to revise Makefile etc.)
> 
> 2. Apply the following patch to "run_libevent.sh".
> 
> ============
> --- run_libevent.sh	2009-11-20 04:08:36.000000000 +0900
> +++ run_libevent.sh.new	2009-12-10 16:44:02.000000000 +0900
> @@ -31,7 +31,7 @@
> 	tst_resm TCONF "You need to be root to run these tests"
> 	TST_EXIT=0
> else
> -	"$LTPROOT/testcases/bin/tests/test-libevent.sh"
> +	"$LTPROOT/testcases/bin/libevent/test/test-libevent.sh"
> 	TST_EXIT=$?
> fi
> tst_cleanup
> ============

Done -- thanks!
-Garrett

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
