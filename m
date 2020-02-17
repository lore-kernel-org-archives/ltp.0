From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 10:58:10 +0100
Subject: [LTP] [PATCH 4/7] syscalls/fsmount: New tests
In-Reply-To: <CAEemH2c28zj-+pec+sgoLzCq6iV627YvyH2hRpQN98eYZ_8geg@mail.gmail.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <1c61c673a02152c30edac0e25438257c23c3322e.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2f2pR1KhLAoKKphzh9fP++yyALbv4TiAh=4Vyv0M3SEdw@mail.gmail.com>
 <20200217082931.vbjkg2f53lek4uf3@vireshk-i7>
 <CAEemH2c28zj-+pec+sgoLzCq6iV627YvyH2hRpQN98eYZ_8geg@mail.gmail.com>
Message-ID: <20200217095810.GC13398@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> On Mon, Feb 17, 2020 at 4:29 PM Viresh Kumar <viresh.kumar@linaro.org>
> wrote:

> > ...
> > > Adding #include "lapi/fcntl.h" in case of ?AT_FDCWD? undeclared. It seems
> > > we have to do this for all the tests involves  ?AT_FDCWD?.

> > my fsmount.h header includes <fcntl.h>, won't that be enough ?


> I'm afraid it's not enough.

> After having a closer look, the reason is that the AT_FDCWD is defined with
> condition __USE_ATFILE,  the __USE_ATFILE depends on _ATFILE_SOURCE
> defined, and _ATFILE_SOURCE needs enable _GNU_SOURCE.

> So another effective way is to add '#define _GNU_SOURCE' in front of your
> test then that <fcntl.h> will be work for you.

OK, we can add #define _GNU_SOURCE to fsmount01.c, which actually needs it
+ keep <fcntl.h> there and load lapi/fsmount.h later (see below).
But generally this will be the approach for all uses of <fcntl.h> (and probably
some other headers) for old distros. IMHO this change is caused by:

c941736c92 Remove _BSD_SOURCE and _SVID_SOURCE. (glibc-2.20)
c688b41960 Add _DEFAULT_SOURCE feature test macro. (glibc-2.19)

So we can either add it to many places or detect this old glibc and compile with
-D_GNU_SOURCE (but this might break other things).
But that's another story.

> # rpm -qa glibc-headers
> glibc-headers-2.5-123

> # cat /usr/include/fcntl.h |grep AT_FDCWD -B 2 -A 2
> #ifdef __USE_ATFILE
> # define AT_FDCWD -100   /* Special value used to indicate
>                                                 the *at functions should
> use the
>                                                 current working directory.
> */

So is this diff to v7 better?

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fsmount/fsmount01.c testcases/kernel/syscalls/fsmount/fsmount01.c
index 464458080..21d0ae50b 100644
--- testcases/kernel/syscalls/fsmount/fsmount01.c
+++ testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -7,10 +7,11 @@
  * to mount a filesystem without any specified mount options.
  */
 
+#define _GNU_SOURCE
 #include <sys/mount.h>
+#include <fcntl.h>
 
 #include "tst_test.h"
-#include "lapi/fcntl.h"
 #include "lapi/fsmount.h"
 #include "tst_safe_stdio.h"
 
