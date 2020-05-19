From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 19 May 2020 14:58:58 +0530
Subject: [LTP] [PATCH 3/5] syscalls: Don't use tst_syscall()
 unnecessarily
In-Reply-To: <CAK8P3a2+OMw4dGWkwNT1GLkBtgVN=-zYZt2G955M--WG2fyjgA@mail.gmail.com>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
 <CAK8P3a2+OMw4dGWkwNT1GLkBtgVN=-zYZt2G955M--WG2fyjgA@mail.gmail.com>
Message-ID: <20200519092858.yryokifjisufysti@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19-05-20, 11:22, Arnd Bergmann wrote:
> On Tue, May 19, 2020 at 10:51 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > @@ -472,7 +471,7 @@ static uint64_t get_current_time(void)
> >  {
> >         struct timespec ts;
> >
> > -       tst_clock_gettime(CLOCK_MONOTONIC, &ts);
> > +       clock_gettime(CLOCK_MONOTONIC, &ts);
> 
> Again, you are changing from the low-level syscall interface that is not
> present on new 32-bit architectures which only have clock_gettime64
> to a high-level interface.
> 
> This change correctly changes it to pass matching timespec variant, but
> the changelog text does not mention that.

Right, I can actually mention why this change was necessary.

-- 
viresh
