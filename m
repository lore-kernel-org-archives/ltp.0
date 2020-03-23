From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Mar 2020 10:30:55 +0100
Subject: [LTP] Query: Supporting time64 syscalls
In-Reply-To: <CAKohpokaPiyGFkAXgG2oy_f5UGMCtsVUUAf4vA3Npa2ixAbNig@mail.gmail.com>
References: <CAKohpokaPiyGFkAXgG2oy_f5UGMCtsVUUAf4vA3Npa2ixAbNig@mail.gmail.com>
Message-ID: <CAK8P3a3nsCq5Ma4KN1bVpOhAkzjMEbXH_qL_2rsZ89aOW03KoA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 23, 2020 at 10:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi guys,
>
> I was looking to start working on the time64 syscalls
> (like clock_gettime64, timerfd_settime64, etc) and
> was looking for your suggestions on how to proceed on
> the same.
>
> AFAIU, the only difference is that the argument is 64 bit now
> instead of 32 bit and so I don't think I should be adding new
> tests but reusing the existing ones for both 32 bit and 64 bit
> variants.

I agree the tests should generally be the same in both cases.
However, there are a couple of other considerations:

- at the moment (at least when I last checked in summer 2019),
  there are two sets of tests: one for the libc interfaces and one
  for the low-level kernel interfaces.

- the low-level kernel interface tests use the type definitions from
  libc, which are wrong when building with 64-bit time_t, making
  all those tests fail or hang.

- I think we need to test all four combinations,
  - the existing 32-bit time_t libc interfaces (only on 32-bit architectures)
    with -D_TIME_BITS=32
  - the new 64-bit time_t libc interfaces with -D_TIME_BITS=64
  - the low-level kernel syscalls with 'typedef long __kernel_old_time_t'
    if the non-_time64 syscall numbers are defined
  - the low-level kernel syscalls with ''typedef long long __kernel_time64_t'
    if the _time64 syscall numbers are defined

- there may be some useful tests one can do on the _time64 syscalls
  to ensure that they actually work with the expected ranges, such as
  .tv_sec = 0x100000000ll' or .tv_sec = '0x7fffffffffffffffll', or explicitly
  bogus data in the padding field around .tv_nsec.

        Arnd
