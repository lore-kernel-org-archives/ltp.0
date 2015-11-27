From: Li Wang <liwang@redhat.com>
Date: Fri, 27 Nov 2015 13:32:18 +0800
Subject: [LTP] [PATCH v2] hugetlb: checking if hugepage is supported on
 target system
In-Reply-To: <20151126134908.GA9276@rei.lan>
References: <1448506629-12150-1-git-send-email-liwang@redhat.com>
 <5656C72C.4090203@oracle.com>
 <CAEemH2cUXFEMk1MXt=-eyjc3s0sinn4X2J89CxPmyKy5uZr3uw@mail.gmail.com>
 <20151126134908.GA9276@rei.lan>
Message-ID: <CAEemH2fPOevoL3=gGnrVEQXEChEvyB+wwhnWLhszwSBS=X=vvA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Thu, Nov 26, 2015 at 9:49 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > forgot "static"?
> > >
> >
> > no, it will be conflict with the prototype in mem.h and get compiler
> error
> > like:
> > -------
> > hugemmap05.c:253: error: static declaration of ???cleanup??? follows
> non-static
> > declaration
> >
> /mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150903/testcases/kernel/mem/include/mem.h:100:
> > note: previous declaration of ???cleanup??? was here
> > hugemmap05.c:295: error: static declaration of ???setup??? follows
> non-static
> > declaration
> >
> /mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150903/testcases/kernel/mem/include/mem.h:101:
> > note: previous declaration of ???setup??? was here
> > make: *** [hugemmap05] Error 1
>
> Why have you added the function into the mem/include/mem.h in the first
> place? There is kernel/mem/hugetlb/lib/ directory allready, just make
> use of it.
>

sounds good. how about moving the current hugetlb/lib/* two file:

ipcshm.h ---> hugetlb.h
libipc.c    ----> hugetlb.c

and re-write some functions in it?
then we can take a good use of it to build a lib_hugetlb.a.

if all of you have no objection, I can do that.


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151127/f3d51b5e/attachment.html>
