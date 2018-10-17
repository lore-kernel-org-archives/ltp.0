From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Oct 2018 06:42:17 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/fcntl: make OFD commands use fcntl64()
 syscall on 32-bit
In-Reply-To: <CAEemH2dKJTaxwCCqF0=Pjwy5J88S3APumouvgbt3oHmZLfZamw@mail.gmail.com>
References: <20d04a28a6254edd95f0bee0e3662c147603665b.1537174128.git.jstancek@redhat.com>
 <CAEemH2dKJTaxwCCqF0=Pjwy5J88S3APumouvgbt3oHmZLfZamw@mail.gmail.com>
Message-ID: <352136754.58874141.1539772937845.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Mon, Sep 17, 2018 at 4:53 PM, Jan Stancek <jstancek@redhat.com> wrote:
> 
> > OFD commands require 64-bit argument (struct flock64). Until
> > glibc commit 06ab719d30b0 ("Fix Linux fcntl OFD locks for
> > non-LFS architectures (BZ#20251)") we relied on glibc passing
> > arg directly to syscall.
> >
> > This creates problem for 32-bit version of the test, because old
> > glibc is passing arg directly, while new one is casting it to
> > struct flock.
> >
> > We could add a configure check for glibc version, but that may
> > not help with other libc libraries.
> >
> > We could do a runtime check that exploits non-zero l_pid returning
> > EINVAL. This however complicates SAFE_FCNTL macro substantially.
> >
> > This patch changes 32-bit version of test to use syscall directly.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/fcntl/fcntl34.c      | 10 ++++++--
> >  testcases/kernel/syscalls/fcntl/fcntl36.c      | 19 +++++++++++----
> >  testcases/kernel/syscalls/fcntl/fcntl_common.h | 33
> > ++++++++++++++++++++++++++
> >  3 files changed, 56 insertions(+), 6 deletions(-)
> >  create mode 100644 testcases/kernel/syscalls/fcntl/fcntl_common.h
> >
> > diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c
> > b/testcases/kernel/syscalls/fcntl/fcntl34.c
> > index aa29cf9ea0d8..90c40f9cf4c6 100644
> > --- a/testcases/kernel/syscalls/fcntl/fcntl34.c
> > +++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
> > @@ -28,6 +28,7 @@
> >  #include "lapi/fcntl.h"
> >  #include "tst_safe_pthread.h"
> >  #include "tst_test.h"
> > +#include "fcntl_common.h"
> >
> >  static int thread_cnt;
> >  static const int max_thread_cnt = 32;
> > @@ -68,7 +69,12 @@ void *thread_fn_01(void *arg)
> >
> >         memset(buf, (intptr_t)arg, write_size);
> >
> > +/* see explanation in fcntl_common.h */
> > +#ifdef USE_STRUCT_FLOCK64
> >         struct flock64 lck = {
> > +#else
> > +       struct flock lck = {
> > +#endif
> >
> 
> It seems the 'struct flock64' can satisfy both 64-bit and 32-bit platform,
> why here adding 'struct flock' here? Eventually, as the code comment says:
> On 32-bit, ..., recent one treats it as 'struct flock' and converts it to
> 'struct flock64'. Why not use 'struct flock64'  directly?

I wanted to make it clear that we use glibc+flock and syscall+flock64, but
we could use just flock64 - it should work, as you said. I can send v2.

Regards,
Jan

> 
> --
> Regards,
> Li Wang
> 
