Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Date: Mon, 16 Aug 2010 15:33:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100816133300.GA26474@saboteur.suse.cz>
References: <AANLkTi=xTEhb3pOfzMv5-GE6uT8iQa6xTRWHVY050t39@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=xTEhb3pOfzMv5-GE6uT8iQa6xTRWHVY050t39@mail.gmail.com>
Subject: Re: [LTP] Help....
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
To: ARJIT SHARMA <joyarjit@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Ltp-list-request@lists.sourceforge.net

Hi!
> please help me by telling that how to disable the function "tst_rmdir()" in
> LTP.
> this function is causing lots of failures in many testcases.
> mainly tests in dio testcase are failing because of some error in this
> function.
> i tried lots of things,like made the function "tst_rmdir()" to skip. Bt
> still there is same error.
> the error is like dat-----     "Tst_rmdir():failed:errno=16: device or
> resource busy."
> please help me out as soon as possible.
> 

Function tst_rmdir() does cleanup of temporary directories used for
testing, when it's failing either you test setup or system is broken.

Hmm errno 16 says that someone is still using these directories when
test is going to delete them and exit. You could try to track this down
with lsof and fuser.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
