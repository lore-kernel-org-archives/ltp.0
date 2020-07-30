From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 30 Jul 2020 18:13:44 +0200
Subject: [LTP] [PATCH 1/1] semctl: Fix 32 bit build
In-Reply-To: <20200730140912.GE3457@yuki.lan>
References: <20200730092637.487-1-pvorel@suse.cz>
 <20200730094842.GB3457@yuki.lan> <20200730101643.GA6381@dell5510>
 <20200730122226.GD3457@yuki.lan> <20200730125329.GA31867@dell5510>
 <20200730140912.GE3457@yuki.lan>
Message-ID: <20200730161344.GA18804@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Metan,

> Hi!  > > > I wonder what would be the easiest solution here.

> > > The main problem is that these flags are per-testcase defined and are
> > > not expanded before we enter rule to build a test. And as we are using
> > > implicit rules to compile C code we cannot easily change that.

> > > I guess that we can write down our rules and do whatever we want there
> > > though.
> > Thanks for info. Well, I'll probably merge the original fix then.

> So I've been looking into the problem for a while and due to a make
> limitations the best bet for a solution would be adding a special
> variable for the LTP libraries as:

> diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
> index bb22be82e..03937516a 100644
> --- a/include/mk/testcases.mk
> +++ b/include/mk/testcases.mk
> @@ -59,5 +59,8 @@ LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))

>  endif

> +%: %.c
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LTPLDLIBS) $(LDLIBS) -o $@
> +
>  $(LTPLIBS_DIRS) $(APICMDS_DIR) $(LIBLTP_DIR): %:
>  	mkdir -p "$@"
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
> index 0172bb495..2e0ed0ceb 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
> +++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
> @@ -10,7 +10,7 @@ shmctl05: LDLIBS += -lrt

>  include $(top_srcdir)/include/mk/testcases.mk

> -shmctl01 shmctl02 shmctl03 shmctl04 shmctl05: LDLIBS += -lltpipc
> -shmctl06: LDLIBS += -lltpnewipc
> +shmctl01 shmctl02 shmctl03 shmctl04 shmctl05: LTPLDLIBS = -lltpipc
> +shmctl06: LTPLDLIBS = -lltpnewipc

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk

Nice, it fixes problem here and in testcases/kernel/syscalls/ipc/semctl/Makefile
(the original problem, if I also change to LTPLDLIBS).

But various other dependencies across LTP fail:
https://travis-ci.org/github/pevik/ltp/builds/713370406

e.g.
https://travis-ci.org/github/pevik/ltp/jobs/713370415
gcc -L/usr/src/ltp/utils/sctp/func_tests/../lib -L/usr/src/ltp/utils/sctp/func_tests/../testlib -L../../../lib  test_fragments_v6.o  -lltp -lsctputil -lsctp -lpthread -o test_fragments_v6
/usr/lib/gcc/x86_64-alpine-linux-musl/9.3.0/../../../../x86_64-alpine-linux-musl/bin/ld: /tmp/ccBpdLjB.o: in function `setup':
/usr/src/ltp/testcases/kernel/syscalls/bpf/bpf_map01.c:133: undefined reference to `rlimit_bump_memlock'
/usr/lib/gcc/x86_64-alpine-linux-musl/9.3.0/../../../../x86_64-alpine-linux-musl/bin/ld: /tmp/ccBpdLjB.o: in function `run':
/usr/src/ltp/testcases/kernel/syscalls/bpf/bpf_map01.c:53: undefined reference to `bpf_map_create'
collect2: error: ld returned 1 exit status

https://travis-ci.org/github/pevik/ltp/jobs/713370407
/usr/bin/ld: /tmp/ccaGt1eJ.o: in function `main':
/usr/src/ltp/testcases/network/nfsv4/locks/locktests.c:1012: undefined reference to `configureClient'
/usr/bin/ld: /usr/src/ltp/testcases/network/nfsv4/locks/locktests.c:1015: undefined reference to `getConfiguration'
/usr/bin/ld: /usr/src/ltp/testcases/network/nfsv4/locks/locktests.c:1008: undefined reference to `configureServer'
/usr/bin/ld: /usr/src/ltp/testcases/network/nfsv4/locks/locktests.c:1009: undefined reference to `setupClients'

Obviously using LTPLDLIBS doesn't apply here. But I don't see what is missing /
wrong.

Kind regards,
Petr
