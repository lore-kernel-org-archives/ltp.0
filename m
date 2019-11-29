From: Xiao Yang <ice_yangxiao@163.com>
Date: Fri, 29 Nov 2019 11:19:49 +0800
Subject: [LTP] [COMMITTED PATCH] mmap1: include lapi/abisize.h header
 file
In-Reply-To: <CAEemH2cW+XUARCzyreQQgJnd1HSV506JEn4rt=oGyezXRtLKFw@mail.gmail.com>
References: <20191128082945.6495-1-liwang@redhat.com>
 <1766813779.14211710.1574930105928.JavaMail.zimbra@redhat.com>
 <CAEemH2cW+XUARCzyreQQgJnd1HSV506JEn4rt=oGyezXRtLKFw@mail.gmail.com>
Message-ID: <16eba1ee-8b23-13c5-f496-3758c2b29fc8@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/28/19 4:37 PM, Li Wang wrote:
>
>
> On Thu, Nov 28, 2019 at 4:35 PM Jan Stancek <jstancek@redhat.com 
> <mailto:jstancek@redhat.com>> wrote:
>
>
>     ----- Original Message -----
>     > To get rid of this BROK on i686:
>     >? mmap1.c:204: BROK: mmap((nil),2147483648,3,34,-1,0) failed:
>     ENOMEM (12)
>     >
>     > Reported-by: Zhijun Wang <zhijwang@redhat.com
>     <mailto:zhijwang@redhat.com>>
>     > Signed-off-by: Li Wang <liwang@redhat.com
>     <mailto:liwang@redhat.com>>
>     > ---
>     >? testcases/kernel/mem/mtest06/mmap1.c | 1 +
>     >? 1 file changed, 1 insertion(+)
>     >
>     > diff --git a/testcases/kernel/mem/mtest06/mmap1.c
>     > b/testcases/kernel/mem/mtest06/mmap1.c
>     > index c5417444f..5c7d3df2f 100644
>     > --- a/testcases/kernel/mem/mtest06/mmap1.c
>     > +++ b/testcases/kernel/mem/mtest06/mmap1.c
>     > @@ -30,6 +30,7 @@
>     >? #include <stdlib.h>
>     >? #include "lapi/abisize.h"
>     >? #include "tst_test.h"
>     > +#include "lapi/abisize.h"
>
>     This sounds familiar:
>     ? 74d9fe32fda9 ("mtest06/mmap1: add missing lapi/abisize.h include")
>
>
> Ah, sorry I was blind for missing this commit. Seems I just git 
> pull&push my patch.

Hi Li,

Perhaps, you should git revert the duplicated patch. :-)

Thanks

Xiao Yang

>
> -- 
> Regards,
> Li Wang
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191129/2b5eeada/attachment.htm>
