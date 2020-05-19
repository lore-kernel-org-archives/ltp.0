From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2020 12:24:10 +0200
Subject: [LTP] [PATCH 2/5] syscalls: settimeofday: Use gettimeofday()
In-Reply-To: <20200519092539.klvwkmzduk3zkds3@vireshk-i7>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <931bddab3d92f73f07f32dd7e1770078fdc07e0e.1589877853.git.viresh.kumar@linaro.org>
 <CAK8P3a3LkUoJs-2yj_F8LpgiGQC6auLVSSuB3QCKOr+NwUhnHQ@mail.gmail.com>
 <20200519092539.klvwkmzduk3zkds3@vireshk-i7>
Message-ID: <CAK8P3a3TuR+K7Ho28pORzp4rrtBjDfQ8ibROfCqnR0iPesFUhw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 19, 2020 at 11:25 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-05-20, 11:20, Arnd Bergmann wrote:
> > On Tue, May 19, 2020 at 10:51 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Use gettimeofday() instead of calling it with tst_syscall().
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> >
> > I think the change makes it work reliably, but it does change what you
> > are testing for: instead of testing the low-level system call interface,
> > this will now test the libc interface, which is implemented on top
> > of the vdso or clock_gettime().
>
> Actually the testcase was for settimeofday() and we were unnecessarily
> calling gettimeofday with tst_syscall(). And so the testcase should
> remain unaffected that way. Had this been a testcase for
> gettimeofday(), I would have agreed with you.

Ok, makes sense. Just mention in the changelog text that this fixes
running against an updated libc with 64-bit time_t in that case.

       Arnd
