From: Li Wang <liwang@redhat.com>
Date: Tue, 24 Nov 2015 18:47:07 +0800
Subject: [LTP] [PATCH] hugetlb/hugemmap: add new testcase hugemmap06.c
In-Reply-To: <333425673.16140676.1448354764281.JavaMail.zimbra@redhat.com>
References: <1447925675-5047-1-git-send-email-liwang@redhat.com>
 <333425673.16140676.1448354764281.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fw4zU7X3ocEJLz8qHshsxqBtcyyxLcj=ncKH3g2uZX2g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,


On Tue, Nov 24, 2015 at 4:46 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > From: "Li Wang" <liwang@redhat.com>
> > To: ltp@lists.linux.it
> > Sent: Thursday, 19 November, 2015 10:34:35 AM
> > Subject: [LTP] [PATCH] hugetlb/hugemmap: add new testcase hugemmap06.c
> >
> > +#include <time.h>
>
> Hi,
>
> wait.h and time.h appear to be unnecessary
>
yes.


> > +};
> > +
> > +#define ARSZ 125
> > +
> > +void setup(void)
> > +{
> > +     tst_require_root();
> > +
> > +     hpage_size = read_meminfo("Hugepagesize:") * 1024;
> > +
> > +     orig_hugepages = get_sys_tune("nr_hugepages");
>
> Do we care about huge pages availability here? Or do we expect, that
> user running hugetlb runtest file is resposible for checking that?
>
> It's easy to imagine, that some kernels/systems won't support huge pages
> or they may not have enough of them. (For example with 16M pages this
> requires over 2GB)
>

yes, right, I'd like to add some checking here.


>
> > +     addr = mmap(NULL, sz * hpage_size,
> > +                     PROT_READ | PROT_WRITE,
> > +                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> > +                     -1, 0);
>
> How about allocating the largest area first and then mmaping smaller ones
> on top of it?
>
> That could prevent situation where first smallest area mmaps a gap between
> existing libraries/heap/etc. and then larger ones with same start overlap
> with those - since we write to those areas, bad things could happen.
>

Good catch! It is very possible to hit the memory area which belong to
libraries/heap...

let me try to mmap in reverse order. if it works, I will send patch V2.


>
> Regards,
> Jan
>
>
>
thanks for reviewing.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151124/139704d9/attachment.html>
