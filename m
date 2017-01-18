From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Wed, 18 Jan 2017 09:13:20 -0800
Subject: [LTP] Building LTP despite failures
In-Reply-To: <20170118103758.GB29948@rei.lan>
References: <b375a149-eda4-7179-1e5e-99240494b321@synopsys.com>
 <20170118103758.GB29948@rei.lan>
Message-ID: <1fa879f4-f31f-16d8-5728-44a292151d1e@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/18/2017 02:39 AM, Cyril Hrubis wrote:
> Hi!
>> We use LTP regularly to check the health of ARC Linux. One the pain points have
>> been out of tree patches to LTP to avoid building lot of stuff which are either
>> not provided by C library (say uClibc) or not configured in uClibc etc.
> The obvious answer is here are:
>
> * If there is a functionality not provided by you C library you should
>   write a configure check like we do for many testcases already which
>   is something that could most likely be then accepted upstream
>
> * There is also some added support for skipping test compilation under
>   UCLIBC, see testcases/kernel/syscalls/Makefile that skips profil
>   directory if UCLIBC has been defined for build. We may add more if
>   there are features not provided by the uClibc library.

Indeed, my colleague Yuriy contributed the profil fix.

However above still doesn't help answer my question.
Some things are indeed provided in uClibc but just not configured by default and I
would like to test whatever is currently present and build (make -k style) but
that doesn't seem to be supported with current build system.

There's another issue - we need to test various hardware configs, not all of which
are available in silicon and only in slower FPGA targets (say 50 MHz). I would
like to reduce the number of iterations for some of the tests (e.g. float_exp_log,
hackbench01, fork13 ...). The easy way is to make a copy of corresponding runtest
file but thn the issue is keeping it in sync etc. Is there a approach where we can
optionally pass the reduced iters, based on some runtime env variable (akin to
make flag UCLIBC for affecting build)

Thx,
-Vineet
