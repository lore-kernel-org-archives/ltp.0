From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 8 Mar 2019 11:43:38 +0100
Subject: [LTP] [PATCH] Fix build with libnuma-dev on some distributions
In-Reply-To: <361211632.5905441.1551973237001.JavaMail.zimbra@redhat.com>
References: <20190307143453.9808-1-chrubis@suse.cz>
 <361211632.5905441.1551973237001.JavaMail.zimbra@redhat.com>
Message-ID: <20190308104338.GA16584@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> ----- Original Message -----
> > On some distributions when libnuma-dev is installed the tst_numa.o,
> > which was added to libltp.a pulls in symbols from numa library to random
> > unrealted tests which breaks the build.

> > This commit hence moves the tst_numa to a separate libltpnuma.a library
> > that is used for linking only for tests that actually use it and link
> > with -lnuma.

> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > CC: Jan Stancek <jstancek@redhat.com>
> > ---

> > This should fix the build failures, beware not build tested yet.
The problem persists [1] [2]:
/usr/src/ltp/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c:105: undefined reference to `numa_allocate_nodemask'
/usr/src/ltp/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c:110: undefined reference to `numa_bitmask_setbit'
/usr/src/ltp/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c:112: undefined reference to `set_mempolicy'

> I'm fine with approach. I'd suggest different directory name, but
> it's hard to come up with something nice. Maybe:
> libnumafn, libnumautils (maybe taken), libtstnuma

> Might be less confusing if it doesn't share same name as existing
> library.
Agree.

+ other LTP libraries are hidden in some subdirectories (which might be
confusing), but I like there is not lib/ and lib<foo>/ in root directory.

Kind regards,
Petr

[1] https://api.travis-ci.org/v3/job/503536791/log.txt
[2] https://travis-ci.org/pevik/ltp/jobs/503536791
