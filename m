From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 May 2020 11:49:05 +0200
Subject: [LTP] [PATCH V3 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <c47220ecab3c7570f5387cd71894c977009ad3d8.1590572545.git.viresh.kumar@linaro.org>
References: <c5428a9c88d18fac80e364281cfd4e3aefa38d2c.1590130423.git.viresh.kumar@linaro.org>
 <c47220ecab3c7570f5387cd71894c977009ad3d8.1590572545.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a3cj7Dd3dUsONPcOSr_cuDqgsjAZQgPgx=Wm75YW9OmtQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 27, 2020 at 11:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There are compatibility issues here as we are calling the direct
> syscalls (with tst_syscall()) with the "struct timespec" (which is a
> libc definition). Over that, an architecture may not define
> __NR_clock_getres (for example) and so we must have the fallback version
> in place.
>
> This updates the tst_clock_*() routines in core libraries and adds
> support for different syscall variants.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I would have expected this to be simpler without going through struct
tst_ts, but the implementation looks correct, and I suppose this
is more consistent.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
