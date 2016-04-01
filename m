From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Apr 2016 14:18:37 +0800
Subject: [LTP] [PATCH V2 2/3] mm/ksm: extend 'max_page_sharing' before
	ksm testing
In-Reply-To: <20160331133114.GC21298@rei.lan>
References: <1458707157-31233-1-git-send-email-liwang@redhat.com>
 <1458707157-31233-2-git-send-email-liwang@redhat.com>
 <20160331133114.GC21298@rei.lan>
Message-ID: <CAEemH2c_qhiqkLW4=foRjAMmF-qB0qqf4J3Y5cueLRikS+GQdg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 31, 2016 at 9:31 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> >  testcases/kernel/mem/include/mem.h |  3 +++
> >  testcases/kernel/mem/ksm/ksm01.c   |  4 ++++
> >  testcases/kernel/mem/ksm/ksm02.c   |  3 +++
> >  testcases/kernel/mem/ksm/ksm03.c   |  4 ++++
> >  testcases/kernel/mem/ksm/ksm04.c   |  4 ++++
> >  testcases/kernel/mem/ksm/ksm06.c   |  4 ++++
> >  testcases/kernel/mem/lib/mem.c     | 22 +++++++++++++++++++++-
> >  7 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/mem/include/mem.h
> b/testcases/kernel/mem/include/mem.h
> > index 43988fe..69d08dd 100644
> > --- a/testcases/kernel/mem/include/mem.h
> > +++ b/testcases/kernel/mem/include/mem.h
> > @@ -43,7 +43,10 @@ void testoom(int mempolicy, int lite, int retcode,
> int allow_sigkill);
> >  /* KSM */
> >
> >  #define PATH_KSM             "/sys/kernel/mm/ksm/"
> > +int max_page_sharing;
>
> This value is not modified outside the library. It makes no sense to
> declare it in the header.
>
> As a matter of fact it would be far better to declare it as static int
> inside the library so that there is no chance that it will be modified
> by the testcases.
>

sounds good, could you help to fix that, or need I format a patch next
version?


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160401/43f874f8/attachment.html>
