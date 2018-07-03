From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Jul 2018 10:25:10 +0200
Subject: [LTP] [PATCH] {rt_,
 }sigsuspend01: Fix build for non-glibc platforms
In-Reply-To: <20180622215710.126661-3-astrachan@google.com>
References: <20180622215710.126661-1-astrachan@google.com>
 <20180622215710.126661-3-astrachan@google.com>
Message-ID: <20180703082509.sh46onpliouwnr36@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alistair,

> The tests dig inside the sigset_t to check if the kernel reverted any
> changes made to the signal mask. This is done by comparing the first
> 32 signal flag bits by dereferencing the sigset_t and reading __val[0],
> which is an unsigned long. If the field is not called __val (with
> Android's bionic it is called '__bits' instead) the build breaks.

> Change the tests to use memcmp for the first sizeof(unsigned long) bits,
> which should be equivalent. This makes the test more portable.

> Signed-off-by: Alistair Strachan <astrachan@google.com>

Thanks for your patch, merged.


Kind regards,
Petr
