From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2020 11:20:02 +0200
Subject: [LTP] [PATCH 2/5] syscalls: settimeofday: Use gettimeofday()
In-Reply-To: <931bddab3d92f73f07f32dd7e1770078fdc07e0e.1589877853.git.viresh.kumar@linaro.org>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <931bddab3d92f73f07f32dd7e1770078fdc07e0e.1589877853.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a3LkUoJs-2yj_F8LpgiGQC6auLVSSuB3QCKOr+NwUhnHQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 19, 2020 at 10:51 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Use gettimeofday() instead of calling it with tst_syscall().
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

I think the change makes it work reliably, but it does change what you
are testing for: instead of testing the low-level system call interface,
this will now test the libc interface, which is implemented on top
of the vdso or clock_gettime().

I think all variants (vdso, syscall(__NR_gettimeofday), libc
gettimeofday, emulation with clock_gettime syscall/vdso/libc)
need to be tested. It's possible they all are, but that should
be clarified in the changelog text.

       Arnd
