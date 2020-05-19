From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2020 11:22:08 +0200
Subject: [LTP] [PATCH 3/5] syscalls: Don't use tst_syscall()
 unnecessarily
In-Reply-To: <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a2+OMw4dGWkwNT1GLkBtgVN=-zYZt2G955M--WG2fyjgA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 19, 2020 at 10:51 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> @@ -472,7 +471,7 @@ static uint64_t get_current_time(void)
>  {
>         struct timespec ts;
>
> -       tst_clock_gettime(CLOCK_MONOTONIC, &ts);
> +       clock_gettime(CLOCK_MONOTONIC, &ts);

Again, you are changing from the low-level syscall interface that is not
present on new 32-bit architectures which only have clock_gettime64
to a high-level interface.

This change correctly changes it to pass matching timespec variant, but
the changelog text does not mention that.

      Arnd
