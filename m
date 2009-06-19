Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penguin-kernel@i-love.sakura.ne.jp>)
	id 1MHYIa-0003zQ-F9
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 07:14:08 +0000
Received: from www262.sakura.ne.jp ([202.181.97.72])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHYIV-0006Ev-Rm
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 07:14:08 +0000
Message-Id: <200906190637.n5J6bHYE034421@www262.sakura.ne.jp>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
MIME-Version: 1.0
Date: Fri, 19 Jun 2009 15:37:17 +0900
References: <1244775226.4982.3.camel@subratamodak.linux.ibm.com>
	<200906142044.ACJ21831.VHOJSFLtFOQOFM@I-love.SAKURA.ne.jp>
	<1245093386.4871.49.camel@subratamodak.linux.ibm.com>
	<1245346304.5041.37.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1245346304.5041.37.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [003][RFC] [TESTING linux-2.6.30] TOMOYO Linux	and
	pathname-basedsecurity
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net, haradats@nttdata.co.jp, sds@tycho.nsa.gov, casey@schaufler-ca.com, serue@linux.vnet.ibm.com, zohar@linux.vnet.ibm.com, takedakn@nttdata.co.jp

Hello.

Subrata Modak wrote:
> Do you feel the above information is sufficient for your to write tests
> for LTP ? Please feel free to ask us questions regarding anything to LTP
> tests.
Yes. I'm reading it now. Some random topics I noticed...



In http://ltp.sourceforge.net/ltpman.php ...
The "LTP test driver PAN" points to
http://ltp.sourceforge.net/ltpmantemp.php?file=man1/pan.html
but the content seems empty.
Same result for other topics.
Is ltpmantemp.php working?



In "Developing tests in ANSI-C using LTP test harness API's" at
http://ltp.sourceforge.net/documentation/how-to/ltp.php ...

> TFAIL
>    Print the test case result. The tst_resm/tst_res function prints related messages to the screen indicating a test failure. The test will exit with a non-zero exit value when tst_exit function is called.
>
>    test01    0  PASS  :  uname command exited with error code = 255
>
I think this is "FAIL  :  uname command exited with error code = 255".

>TWARN
>    Print warning messages. For example, when system resources are low.
>
>    test01    0  PASS  :  System low on memory, test case might fail.
I think this is "WARN  :  System low on memory, test case might fail."



There are several "amp;" which I think it meant '&'.



In "Recommendation on coding style"...

> Check for return values from system calls. Report reason appropriately using the tst_brkm() API. The recommended style is as follows:
> Use spaces instead of tab characters. Typically four spaces may be used instead of a tab character.

Ouch! I'm writing testcases in accordance with script/checkpatch.pl in Linux
kernel source tree. I expect that those who update/maintain testcases for
kernel source code likely have some experience in writing kernel patches.
Is it preferable to change codyng style in accordance with LTP?



http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/selinux-testsuite/
seems to be moved to
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/selinux-testsuite/



Many programs under
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/ seems
not using harness APIs...
Are these programs intended for executed by general LTP users?

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
