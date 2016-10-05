From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Oct 2016 15:43:03 +0200
Subject: [LTP] [PATCH] syscalls/signal06: fix test for regression with
 earlier version of gcc and kernel
In-Reply-To: <1470380281-20334-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1470380281-20334-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161005134303.GA23476@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
First of all sorry for the delay.

> 1. Currently, following code is incorrect on some releases with
>    earlier version of gcc(tested on RHEL5.11GA):
> 
> 	while (D == d && loop < LOOPS) {
>
>    Because the argument in function test(double d) is used via (%rsp),
>    but here we actually need a xmm register to trigger the fpu bug.
>    So use global value instead to make sure to take use of xmm.

This looks OK.

> 2. Although this regression test is designed to trigger SIGSEGV
>    intentionally, on some releases with old kernel(tested on RHEL5.11GA),
>    this will still lead to segmentation fault that terminate the program
>    and break the test even though compiling with -O2.  So slightly adjust
>    the weight of the codes in child thread to depress SIGSEGV trigger's
>    chance while increase LOOPS to ensure reproducible.

Hmm, what is the exact problem here? Does the old kernel break if we
send the signal too fast?

I do not like much that the test takes ten times more time to finish
now.

-- 
Cyril Hrubis
chrubis@suse.cz
