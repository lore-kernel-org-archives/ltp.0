From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Aug 2021 11:37:26 +0200
Subject: [LTP] [COMMITTED] setsockopt08: includes netinet/in.h
In-Reply-To: <CAEemH2cNk-L1kRRHy=vvLVjcEm0HPQXaz8fJR00M1TyzoJAynw@mail.gmail.com>
References: <20210806025659.1962902-1-liwang@redhat.com>
 <YQzLUUKbLcoJjRVb@pevik> <YQzOxg35JjpDOj7X@pevik>
 <CAEemH2cNk-L1kRRHy=vvLVjcEm0HPQXaz8fJR00M1TyzoJAynw@mail.gmail.com>
Message-ID: <YQ0C1givEZ8/H7hN@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Hi Petr,



> > > > See:
> > https://www.mail-archive.com/netdev@vger.kernel.org/msg132711.html

> > > Thanks for fixing it, it's not a first time we got hit by this.
> > > I wonder where <linux/in.h> is included. It's not directly in
> > setsockopt08.c,
> > > it must be in our lapi header. But it's not in tst_safe_net.h, not in
> > > safe_net_fn.h nor in tst_net.h and both actually include <netinet/in.h>,
> > thus it must be
> > > before. But there is only tst_test.h.

> > > I'm asking because it'd be better to add <netinet/in.h> into header
> > before
> > > <linux/in.h>.

> > OK, it's in lapi/ip_tables.h, which includes
> > <linux/netfilter_ipv4/ip_tables.h>
> > which includes <linux/if.h>. But I wonder why inclusion of <netinet/in.h>
> > from


> No, it's not caused by the lapi/ip_tables.h which finally includes
> <linux/if.h>.
> See experiment commit:
> https://github.com/wangli5665/ltp/commit/f1a37712c63472b19d3355446fb66e651b4a186e
Yep, I also found myself it does not help.

> The conflict happened early in tst_test.h and I guess some header files
> between line#14 to line#44 probably involves <linux/if.h>, but I'm not sure
> which one is the culprit.
Interesting, really something in in tst_test.h with combination of
lapi/ip_tables.h. This combination is only in 2 tests, setsockopt0{3,8}.c,
setsockopt03.c already had <netinet/in.h>.

> If we simply put the <netinet/in.h> at the top of tst_test.h, the
> conflict disappears
> as well.
> See experiment commit:
> https://github.com/wangli5665/ltp/commit/0155df479811d9a51f30e09accb330238607f73d

I'd be for adding it there, with comment why it's there. We can prevent problems
with failing another test in the future. (+ remove it from both tests).

Kind regards,
Petr

> $ cat include/tst_test.h  -n
> ...
>     14 #include <unistd.h>
>     15 #include <limits.h>
>     16 #include <string.h>
>     17 #include <errno.h>
>     18
>     19 #include "tst_common.h"
>     20 #include "tst_res_flags.h"
>     21 #include "tst_test_macros.h"
>     22 #include "tst_checkpoint.h"
>     23 #include "tst_device.h"
>     24 #include "tst_mkfs.h"
>     25 #include "tst_fs.h"
>     26 #include "tst_pid.h"
>     27 #include "tst_cmd.h"
>     28 #include "tst_cpu.h"
>     29 #include "tst_process_state.h"
>     30 #include "tst_atomic.h"
>     31 #include "tst_kvercmp.h"
>     32 #include "tst_kernel.h"
>     33 #include "tst_minmax.h"
>     34 #include "tst_get_bad_addr.h"
>     35 #include "tst_path_has_mnt_flags.h"
>     36 #include "tst_sys_conf.h"
>     37 #include "tst_coredump.h"
>     38 #include "tst_buffers.h"
>     39 #include "tst_capability.h"
>     40 #include "tst_hugepage.h"
>     41 #include "tst_assert.h"
>     42 #include "tst_lockdown.h"
>     43 #include "tst_fips.h"
>     44 #include "tst_taint.h"
> ...
>     93 #include "tst_safe_macros.h"
>     94 #include "tst_safe_file_ops.h"
>     95 #include "tst_safe_net.h"    <===== includes the <netinet/in.h> here
>     96 #include "tst_clone.h"
