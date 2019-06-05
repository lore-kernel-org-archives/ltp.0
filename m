From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Jun 2019 09:02:29 +0200
Subject: [LTP] insmod01_sh test from commands test suite will make
 cve-2017-17053 test fail
In-Reply-To: <CAMy_GT-80RtX=qkXJ0NYN-3eY_N+MiH5Xq5iPGm41y=d-n3CAA@mail.gmail.com>
References: <CAMy_GT-kRs7_EZvrP-JdFc_wa8OMc3295N6FWUg7AxoY2O66fA@mail.gmail.com>
 <20190531083203.GA4224@rei.lan> <20190531094356.GC4224@rei.lan>
 <CAMy_GT-80RtX=qkXJ0NYN-3eY_N+MiH5Xq5iPGm41y=d-n3CAA@mail.gmail.com>
Message-ID: <20190605070228.GA778@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Yes you're right, the insmod test is not the cause here.
> 
> I found it's the block_dev test from kernel_misc, the ltp_block_dev
> module insertion will first set the taint flag to 12288:
> $ sudo insmod ltp_block_dev.ko
> $ cat /proc/sys/kernel/tainted
> 12288
> 
> But the test will generate kernel warnings and make it 12800
> $ sudo rmmod ltp_block_dev
> $ sudo ./block_dev
> block_dev    1  TPASS  :  Test-case '1'
> block_dev    2  TPASS  :  Test-case '2'
> block_dev    3  TPASS  :  Test-case '3'
> block_dev    4  TPASS  :  Test-case '4'
> block_dev    5  TPASS  :  Test-case '5'
> block_dev    6  TPASS  :  Test-case '6'
> block_dev    7  TPASS  :  Test-case '7'
> $ cat /proc/sys/kernel/tainted
> 12800
> 
> 12800 = 0011001000000000
> The W flag is here.
> 
> Traces could be found in dmesg:
> https://pastebin.ubuntu.com/p/gp9ZDHNj6J/

Looking at the test and at the kernel source the test is triggering
exactly the condition it's supposed to to trigger and the warning is to
be expected.

I guess that the best solution would be running the kernel_misc
testcases separately from the rest.

-- 
Cyril Hrubis
chrubis@suse.cz
