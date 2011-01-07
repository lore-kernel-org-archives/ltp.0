Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PbDAg-0007Fu-RB
	for ltp-list@lists.sourceforge.net; Fri, 07 Jan 2011 14:20:02 +0000
Date: Fri, 7 Jan 2011 15:36:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110107143607.GA12323@saboteur.suse.cz>
References: <4D259E4A.2050704@cn.fujitsu.com>
	<AANLkTinX9M3EsBxSDsVy56iKqskSWKQE4vMhXy0kcxNG@mail.gmail.com>
	<20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
	<AANLkTi=L8Vai5_=fn0psJeovura_Y=VjdN28ufiqBiiA@mail.gmail.com>
	<AANLkTin-yaUcPd8GZHgWnoYkxpOxDFs4enEik8afaeEc@mail.gmail.com>
	<AANLkTinFbVBZtA_hCfRqTK=sZW+ZBSi3KbjA7Butkfum@mail.gmail.com>
	<F3972A55-1F53-4B70-A858-E041E01F246D@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <F3972A55-1F53-4B70-A858-E041E01F246D@gmail.com>
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
> 
> 	Ok -- good to note for next time I guess. I fixed all of the compilation errors so now people can report runtime issues. There are a handful of them.
>

I still could not compile the latest git. I've got a bunch of:

pipe declared with warn_unused_result
write declared with warn_unused_result
read declared with warn_unused_result

little less of:

getcwd declared with warn_unused_result
chdir declared with warn_unused_result
ftruncate declared with warn_unused_result
system declared with warn_unused_result

plus some printf() formatting issues

And after disabling -Werror it stops on getdelays.c with

getdelays.c: In function 'main':
getdelays.c:525: warning: implicit declaration of function 'tst_exit'
getdelays.c:526: warning: control reaches end of non-void function
getdelays.c:266: warning: 'cmd_type' may be used uninitialized in this
function
../../../../lib/libltp.a(tst_res.o): In function `cat_file':
/home/metan/Work/git/ltp-dev/lib/tst_res.c:710: undefined reference to `TCID'
/home/metan/Work/git/ltp-dev/lib/tst_res.c:728: undefined reference to `TCID'
/home/metan/Work/git/ltp-dev/lib/tst_res.c:720: undefined reference to `TCID'
../../../../lib/libltp.a(tst_res.o): In function `tst_res':
/home/metan/Work/git/ltp-dev/lib/tst_res.c:321: undefined reference to `TCID'
../../../../lib/libltp.a(tst_res.o): In function `tst_condense':
/home/metan/Work/git/ltp-dev/lib/tst_res.c:377: undefined reference to `TCID'
../../../../lib/libltp.a(tst_res.o):/home/metan/Work/git/ltp-dev/lib/tst_res.c:3
05: more undefined references to `TCID' follow
../../../../lib/libltp.a(tst_res.o): In function `tst_brk':
/home/metan/Work/git/ltp-dev/lib/tst_res.c:613: undefined reference to `TST_TOTAL'

The same goes for testcases/kernel/io/ltp-aiodio/dirty.c and
testcases/kernel/security/cap_bound/dummy.c

Then it hangs on securebits but is suppose that this is bug somewhere in
configure not detecting securebits headers right. I'll look into this
later.


The realtime tests hangs on:

async_handler_jk.c: In function 'main':
async_handler_jk.c:162: warning: implicit declaration of function
'tst_exit'
async_handler_jk.c:163: warning: control reaches end of non-void
function
/tmp/ccGU6ubN.o: In function `main':
/home/metan/Work/git/ltp-dev/testcases/realtime/func/async_handler/async_handler_jk.c:162:
undefined reference to `tst_exit'
collect2: ld returned 1 exit status
make[2]: *** [async_handler_jk] Error 1
make[2]: Leaving directory
`/home/metan/Work/git/ltp-dev/testcases/realtime/func/async_handler'
make[1]: *** [all] Error 2
make[1]: Leaving directory
`/home/metan/Work/git/ltp-dev/testcases/realtime/func'
make: *** [all] Error 2


The rest seems to compile fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
