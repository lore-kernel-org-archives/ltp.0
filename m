From: Li Wang <liwang@redhat.com>
Date: Tue, 22 Dec 2015 10:36:17 +0800
Subject: [LTP] [PATCH v4] hugetlb/hugemmap: add new testcase hugemmap06.c
In-Reply-To: <56780067.1020704@gmx.de>
References: <1450696613-6847-1-git-send-email-liwang@redhat.com>
 <56780067.1020704@gmx.de>
Message-ID: <CAEemH2fHsmU5K3-3Jja112O_1X8MUKUfaNiYZ3j=Nh3XN8_P4A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Mon, Dec 21, 2015 at 9:36 PM, Helge Deller <deller@gmx.de> wrote:

> ...
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <pthread.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/mman.h>
> > +#include <sys/types.h>
> > +#include <unistd.h>
> > +
> > +#include "test.h"
> > +#include "mem.h"
> > +#include "hugetlb.h"
> > +
> > +char *TCID = "hugemmap06";
> > +int TST_TOTAL = 5;
> > +
> > +static long hpage_size;
> > +static long hugepages;
> > +
> > +struct mp {
> > +     char *addr;
> > +     int sz;
> > +};
> > +
> > +#define ARSZ 50
> > +
> > +void setup(void)
> > +{
> > +     tst_require_root();
> > +     check_hugepage();
> > +
> > +     hpage_size = read_meminfo("Hugepagesize:") * 1024;
> > +     orig_hugepages = get_sys_tune("nr_hugepages");
> > +
> > +     hugepages = (ARSZ + 1) * TST_TOTAL;
> > +
> > +     if (hugepages * read_meminfo("Hugepagesize:") >
> read_meminfo("MemTotal:"))
> > +             tst_brkm(TCONF, NULL, "System RAM is not enough to test.");
>
>
> Just a general note:
>
> What happens on architectures where no hugepages are available?
> Maybe you should add a check and return TCONF() in those cases?
>

thanks for you kind note, the function above  ?check_hugepage()? do that
work.
you could find details in the include file: /hugetlb/lib/hugetlb.h


> I think this is missing for the other existing hugepage testcases as
> well...
>
> Helge
>
>

---
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151222/3b1f1661/attachment.html>
