From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 8 May 2020 09:21:14 +0200
Subject: [LTP] [PATCH V2 13/17] syscalls/select6: Add support for time64
 tests
In-Reply-To: <614763566d03f6d88fa0d60d15a719bbbc467cd0.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <614763566d03f6d88fa0d60d15a719bbbc467cd0.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a0ccSTeo4twSFRTfG9+HxLthrPDP-GHi3v9bmLKym5n2Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 8, 2020 at 6:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> +               };
> +#if defined(TST_ABI64)
> +               ret = tst_syscall(__NR_pselect6, nfds, readfds, writefds, exceptfds, &ts, NULL);

Again, this is not the actual ABI: __NR_pselect6 should be called with
a __kernel_old_timespec when the macro is defined, but it may not be defined
on new 32-bit architectures.

       Arnd
