Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <srikanth007m@gmail.com>) id 1ZrP95-0004IJ-Hp
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2015 11:43:59 +0000
Received: from mail-qg0-f48.google.com ([209.85.192.48])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZrP94-0002Bs-ME
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2015 11:43:59 +0000
Received: by qgbb65 with SMTP id b65so3384370qgb.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Oct 2015 04:43:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKq_7Fryb_CkGCiGghQ9gJtLBuh3Fv6T7tU1+WcH4zWub=9CkA@mail.gmail.com>
References: <CAKq_7Fryb_CkGCiGghQ9gJtLBuh3Fv6T7tU1+WcH4zWub=9CkA@mail.gmail.com>
Date: Wed, 28 Oct 2015 17:13:53 +0530
Message-ID: <CANKSX+GcymT_=YWqgnbF3w3VQNo4xwFG7ZshhFQ3HqpwuL-oFg@mail.gmail.com>
From: "$rik@nth " <srikanth007m@gmail.com>
Subject: Re: [LTP] error while compiling ltp statically
Reply-To: srikanth007m@gmail.com
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
To: Yesuraj Abraham <yesu4tech@gmail.com>, ltp-list@lists.sourceforge.net

ltp-list is no more maintaining. Adding new list for communication.

This is because openlog is already defined in the libc and which you
can't redefine it again.

On Wed, Oct 28, 2015 at 4:43 PM, Yesuraj Abraham <yesu4tech@gmail.com> wrote:
> Hi
> I tried compiling ltp statically using arm toolchain, as follows
> export
> CC=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-gcc
> export
> LD=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-ld
> export
> AR=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-ar
> export
> AS=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-as
> export
> RANLIB=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-ranlib
> export
> STRIP=/home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/arm-none-linux-gnueabi-strip
>
> ./configure --host=arm-linux
> --prefix=/home/ltblr/yesuraj/test_apps/ltp/arm-none-tool-chain/static_compilation/ltp-full-20150420/install
> --exec-prefix=/home/ltblr/yesuraj/test_apps/ltp/arm-none-tool-chain/static_compilation/ltp-full-20150420/install
> LDFLAGS="-static -pthread"
>  make
>
> It throws the following error(s),
>
> /home/ltblr/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux/bin/../arm-none-linux-gnueabi/libc/usr/lib/libc.a(syslog.o):
> In function `openlog': syslog.c:(.text+0x814): multiple definition of
> `openlog'
> /tmp/ccusZ6dp.o:/home/ltblr/yesuraj/test_apps/ltp/arm-none-tool-chain/static_compilation/ltp-full-20150420/testcases/kernel/fs/fs-bench/random-access.c:66:
> first defined here
>
> The same error is thrown for the file, random-access-del-create.c too.
>
> When i modified openlog to other name (openlog1) in both the files, then it
> compiles successfully.
>
> However when i build using x86 tool chain in the same manner (static flag
> enabled), it builds successfully without the above error(s).
>
> Regards,
> yesuraj
>
> ------------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
Thanks & Regards,
M.Srikanth Kumar.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
