From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 May 2020 09:58:48 +0200
Subject: [LTP] [PATCH V2 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <20200511073315.gws5lhw6tsaaijpi@vireshk-i7>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
 <CAK8P3a1x+uK_WgVn9O8LVcLoZH=oJ_jQcePwcwzqpyhewApX9w@mail.gmail.com>
 <20200511064929.pa4lydt2vfryl7ve@vireshk-i7>
 <CAK8P3a2y+8kv0Wa4iiU+vGeNTudmx3aJJQ87zfi9WyfWKJ7WYg@mail.gmail.com>
 <20200511073315.gws5lhw6tsaaijpi@vireshk-i7>
Message-ID: <CAK8P3a3VrcpdmGZB_VOLk17uDMxAfYyfM57yUUUSuqEdKvROOQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 11, 2020 at 9:33 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-05-20, 09:20, Arnd Bergmann wrote:
> > It looks like you are still missing a test for the libc semtimedop function with
> > TST_LIBC_TIMESPEC, but perhaps this is in a different place?
>
> The libc test is missing for few of the syscalls, as it was already missing for
> them because the headers may not have the definition.
>
> And so I didn't add them separately.

Ok, I see. This one just looked curious because the you add tests for the kernel
syscall (semtimedop) in a file that checks an older libc syscall (semop).

The libc semop is implemented in terms of the kernel's semtimedop for
architectures that don't have their own semop by passing a NULL timeout
argument. We should still check that five variants of it (sys_semop,
sys_semtimedop, sys_semtimedop64, ipc(SEMTIMEDOP) and ipc(SEMOP))
correctly implement the semop semantics, but I would also note that
testing the differences of the time types is only meaningful when you
actually pass a non-NULL timeout.

      Arnd
