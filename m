From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 04 Jun 2021 15:28:29 +0100
Subject: [LTP] [RFC PATCH v2 1/2] Add 'make check' and clang-check to
 build system
In-Reply-To: <YLo0XKY9b+S2ROQQ@pevik>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <20210604111434.21422-2-rpalethorpe@suse.com> <YLo0XKY9b+S2ROQQ@pevik>
Message-ID: <87zgw5iu0i.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hell Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> Allows the user to run 'make check' to check all source files or
>> 'make check-<target>' to check one source file corresponding to a
>> target.
>
>> Adds makefile pieces for tools/clang-check/main which will be a
>> libclang based tool. By default this is ran by 'make check'.
>
> I haven't looked at Coccinelle, but this LGTM.
>
> But, it still fails to compile:
>
> $ make autotools && ./configure && cd testcases/kernel/syscalls/chown/
> $ make clean; make
>
> make -C "/home/pvorel/install/src/ltp.git/lib" -f "/src/ltp/lib/Makefile" all
> make[1]: Entering directory '/src/ltp/lib'
> make[2]: Nothing to be done for 'all'.
> make[2]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/src/ltp/lib'
> CC testcases/kernel/syscalls/chown/chown01.o
> LD testcases/kernel/syscalls/chown/chown01
> CC testcases/kernel/syscalls/chown/chown02.o
> LD testcases/kernel/syscalls/chown/chown02
> CC testcases/kernel/syscalls/chown/chown03.o
> LD testcases/kernel/syscalls/chown/chown03
> CC testcases/kernel/syscalls/chown/chown04.o
> LD testcases/kernel/syscalls/chown/chown04
> CC testcases/kernel/syscalls/chown/chown05.o
> LD testcases/kernel/syscalls/chown/chown05
> make: *** No rule to make target 'chown01_16.c', needed by 'chown01_16'.  Stop.
> rm chown01.o chown03.o chown02.o chown05.o chown04.o
>
> This is a newly introduced failure caused by some change in include/mk/ in this
> commit.

I guess if Cyril likes the overall approach and doesn't spot what is
causing this, then I will try fixing it.

>
> Could we have also make check in the top level Makefile?

Yes, I didn't try it for the RFC though.

>
> $ make check
> make: *** No rule to make target 'check'.  Stop.
>
> $ cd lib && make check
> CHECK lib/cloner.c
> CHECK lib/get_path.c
> CHECK lib/parse_opts.c
> CHECK lib/random_range.c
> CHECK lib/safe_file_ops.c
> CHECK lib/safe_macros.c
> CHECK lib/safe_net.c
> CHECK lib/safe_pthread.c
> CHECK lib/safe_stdio.c
> CHECK lib/self_exec.c
> CHECK lib/tlibio.c
> tst_af_alg.c:16:2: CHECK ERROR: TEST() macro should not be used in library
> tst_af_alg.c:27:2: CHECK ERROR: TEST() macro should not be used in library
> tst_af_alg.c:74:2: CHECK ERROR: TEST() macro should not be used in library
> tst_af_alg.c:109:2: CHECK ERROR: TEST() macro should not be used in library
> tst_af_alg.c:119:2: CHECK ERROR: TEST() macro should not be used in library
> make: *** [../include/mk/rules.mk:46: check-tst_af_alg] Error 1
>
> Similarly what I added to my patchset which also adds new make target:
> https://patchwork.ozlabs.org/project/ltp/patch/20210603183827.24339-2-pvorel@suse.cz/
> Although my code has duplicate issue:
> ../include/mk/generic_trunk_target.inc:105: warning: overriding recipe for target 'check-c'
> ../include/mk/generic_leaf_target.inc:110: warning: ignoring old recipe for target 'check-c'
> ../include/mk/generic_trunk_target.inc:105: warning: overriding recipe for target 'check-shell'
> ../include/mk/generic_leaf_target.inc:118: warning: ignoring old recipe for target 'check-shell'
>
> Also make check on regular test expect it's a library. IMHO these two must be
> probably separated:
>
> $ cd testcases/kernel/syscalls/fchown/ && make check
> CHECK testcases/kernel/syscalls/fchown/fchown01.c
> CHECK testcases/kernel/syscalls/fchown/fchown02.c
> CHECK testcases/kernel/syscalls/fchown/fchown03.c
> CHECK testcases/kernel/syscalls/fchown/fchown04.c
> fchown05.c:80:4: CHECK ERROR: TEST() macro should not be used in library
> make: *** [../../../../include/mk/rules.mk:46: check-fchown05] Error 1

It fails because it is using the old test API, so there is no struct
tst_test test var. I don't think we need to separate the checker. It can
detect what type of file (translation unit) it is processing. In the
case of old API tests, I would simply disable any checks.

All the old tests and test libraries will have something in common. For
the tests, they all import "test.h" (even if through another header), so
we can identify them by that.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.
