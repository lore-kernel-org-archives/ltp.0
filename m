From: Helge Deller <deller@gmx.de>
Date: Tue, 22 Dec 2015 20:01:22 +0100
Subject: [LTP] [PATCH v4] hugetlb/hugemmap: add new testcase hugemmap06.c
In-Reply-To: <CAEemH2fHsmU5K3-3Jja112O_1X8MUKUfaNiYZ3j=Nh3XN8_P4A@mail.gmail.com>
References: <1450696613-6847-1-git-send-email-liwang@redhat.com>
 <56780067.1020704@gmx.de>
 <CAEemH2fHsmU5K3-3Jja112O_1X8MUKUfaNiYZ3j=Nh3XN8_P4A@mail.gmail.com>
Message-ID: <56799E02.20108@gmx.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 22.12.2015 03:36, Li Wang wrote:
> Hi,
> 
> On Mon, Dec 21, 2015 at 9:36 PM, Helge Deller <deller@gmx.de <mailto:deller@gmx.de>> wrote:
> 
>     ...
>     > +#define _GNU_SOURCE
>     > +#include <errno.h>
>     > +#include <pthread.h>
>     > +#include <stdio.h>
>     > +#include <stdlib.h>
>     > +#include <sys/mman.h>
>     > +#include <sys/types.h>
>     > +#include <unistd.h>
>     > +
>     > +#include "test.h"
>     > +#include "mem.h"
>     > +#include "hugetlb.h"
>     > +
>     > +char *TCID = "hugemmap06";
>     > +int TST_TOTAL = 5;
>     > +
>     > +static long hpage_size;
>     > +static long hugepages;
>     > +
>     > +struct mp {
>     > +     char *addr;
>     > +     int sz;
>     > +};
>     > +
>     > +#define ARSZ 50
>     > +
>     > +void setup(void)
>     > +{
>     > +     tst_require_root();
>     > +     check_hugepage();
>     > +
>     > +     hpage_size = read_meminfo("Hugepagesize:") * 1024;
>     > +     orig_hugepages = get_sys_tune("nr_hugepages");
>     > +
>     > +     hugepages = (ARSZ + 1) * TST_TOTAL;
>     > +
>     > +     if (hugepages * read_meminfo("Hugepagesize:") > read_meminfo("MemTotal:"))
>     > +             tst_brkm(TCONF, NULL, "System RAM is not enough to test.");
> 
> 
>     Just a general note:
> 
>     What happens on architectures where no hugepages are available?
>     Maybe you should add a check and return TCONF() in those cases?
> 
> 
> thanks for you kind note, the function above  ?check_hugepage()? do that work.
> you could find details in the include file: /hugetlb/lib/hugetlb.h

Ah - great!
I didn't saw that.

Thanks,
Helge



