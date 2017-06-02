From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 2 Jun 2017 07:31:02 -0400 (EDT)
Subject: [LTP] [PATCH] ltp/numa: Fix compilation without MAP_HUGETLB
In-Reply-To: <5930C079.5010307@cn.fujitsu.com>
References: <1496226952-15147-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <5930C079.5010307@cn.fujitsu.com>
Message-ID: <1635934817.27708421.1496403062394.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Cyril, Jan
> 
> Ping. :-)
> 
> Compilation failed on RHEL5.11GA.

Pushed.

Thanks,
Jan

> 
> Thanks,
> Xiao Yang
> 
> On 2017/05/31 18:35, Xiao Yang wrote:
> > Compilation failed on some older distributions due to undefined
> > MAP_HUGETLB, so we include lapi/mmap.h to fix it.
> >
> > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > ---
> >  testcases/kernel/numa/support_numa.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/testcases/kernel/numa/support_numa.c
> > b/testcases/kernel/numa/support_numa.c
> > index b6aa8bd..4904cc5 100644
> > --- a/testcases/kernel/numa/support_numa.c
> > +++ b/testcases/kernel/numa/support_numa.c
> > @@ -39,6 +39,7 @@
> >  #include <sys/stat.h>
> >  #include <sys/mman.h>
> >  #include <fcntl.h>
> > +#include "lapi/mmap.h"
> >  
> >  /* Global Variables */
> >  #define MB (1<<20)
> 
> 
> 
> 
