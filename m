From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jun 2018 16:10:40 +0200
Subject: [LTP] [PATCH] ksm05: Fix build warning/error with
 -Wnull-dereference
In-Reply-To: <20180622215710.126661-2-astrachan@google.com>
References: <20180622215710.126661-1-astrachan@google.com>
 <20180622215710.126661-2-astrachan@google.com>
Message-ID: <20180625141040.6gwbkgdx3eqxqeef@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alistair,

> Using the Android clang build, which uses -Werror -Wnull-dereference,
> the following error is seen:

> testcases/kernel/mem/ksm/ksm05.c:81:3: error: indirection of
> non-volatile null pointer will be deleted, not trap
> [-Werror,-Wnull-dereference]
>   *(char *)NULL = 0;      /* SIGSEGV occurs as expected. */
>   ^~~~~~~~~~~~~
> testcases/kernel/mem/ksm/ksm05.c:81:3: note: consider using
> __builtin_trap() or qualifying pointer with 'volatile'
> 1 error generated.

> Change it to "volatile char *" which avoids this build issue, without
> negatively affecting the test.

> Signed-off-by: Alistair Strachan <astrachan@google.com>

Pushed, thanks for your patch.


Kind regards,
Petr
