From: Xiuzhe Xiao <xiuzhe.xiao@nautel.com>
Date: Thu, 15 Mar 2018 13:08:57 +0000
Subject: [LTP] SIGSEGV in faccessat01 and fchmodat01
In-Reply-To: <20180315115518.GB17877@rei>
References: <BY2PR13MB070967D607D2E7F4F797189A90D10@BY2PR13MB0709.namprd13.prod.outlook.com>,
 <20180315115518.GB17877@rei>
Message-ID: <BY2PR13MB0709FB070D6A4AC6FEEE5DD990D00@BY2PR13MB0709.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi


Here is the result from gdb

seems like it is getting really deep

(gdb) r
Starting program: /opt/ltp/testcases/bin/fchmodat01

Program received signal SIGSEGV, Segmentation fault.
strlen () at ../sysdeps/arm/strlen.S:33
33              sfi_breg r1, \
(gdb)


Thanks

Shawnx.

________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Thursday, March 15, 2018 4:55:18 AM
To: Xiuzhe Xiao
Cc: ltp@lists.linux.it
Subject: Re: [LTP] SIGSEGV in faccessat01 and fchmodat01

Hi!
> Have anyone had these problem?
> Is there any requirement for these test? or is anyone can give me a direction, I'll be appreciated
>
> <<<test_output>>>
> faccessat01    1  TBROK  :  tst_sig.c:233: unexpected signal SIGSEGV(11) received (pid = 2134).
> faccessat01    2  TBROK  :  tst_sig.c:233: Remaining cases broken
>
> <<<test_output>>>
> fchmodat01    1  TBROK  :  tst_sig.c:233: unexpected signal SIGSEGV(11) received (pid = 2289).
> fchmodat01    2  TBROK  :  tst_sig.c:233: Remaining cases broken

Can you run the test under gdb and send the backtrace?

--
Cyril Hrubis
chrubis@suse.cz
This communication, including any attached documentation, is intended only for the person or entity to which it is addressed, and may contain confidential, personal, and/or privileged information. Any unauthorized disclosure, copying, or taking action on the contents is strictly prohibited. If you have received this message in error, please contact us immediately so we may correct our records. Please then delete or destroy the original transmission and any subsequent reply. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180315/e6b32866/attachment.html>
