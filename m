From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Feb 2020 16:49:33 +0800
Subject: [LTP] [PATCH v3 2/3] Split off executable code from
 bpf/bpf_common.h
In-Reply-To: <7d52d4b5-c9ae-2cf8-5742-85ce4e55ff67@suse.cz>
References: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
 <20200217141622.26912-1-mdoucha@suse.cz>
 <20200217141622.26912-2-mdoucha@suse.cz>
 <CAEemH2fvquWe_+-Au-Z0wRaYt0V943A1zszJVPCXO6HrLWH9Yg@mail.gmail.com>
 <7d52d4b5-c9ae-2cf8-5742-85ce4e55ff67@suse.cz>
Message-ID: <CAEemH2esmZq12fFL4U-TzzvaKrKS1a-+nz7jZoN923880+dTZw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Feb 18, 2020 at 4:44 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 2/18/20 9:15 AM, Li Wang wrote:
> >     diff --git a/testcases/kernel/syscalls/bpf/Makefile
> >     b/testcases/kernel/syscalls/bpf/Makefile
> >     index 990c8c83c..2241bce9b 100644
> >     --- a/testcases/kernel/syscalls/bpf/Makefile
> >     +++ b/testcases/kernel/syscalls/bpf/Makefile
> >     @@ -5,6 +5,9 @@ top_srcdir              ?= ../../../..
> >
> >      include $(top_srcdir)/include/mk/testcases.mk <http://testcases.mk>
> >
> >     +FILTER_OUT_MAKE_TARGETS        := bpf_common
> >      CFLAGS                 += -D_GNU_SOURCE
> >
> >      include $(top_srcdir)/include/mk/generic_leaf_target.mk
> >     <http://generic_leaf_target.mk>
> >     +
> >     +$(MAKE_TARGETS): %: %.o bpf_common.o
> >
> >
> > May I ask why we need to reserve these *.o binary files in the compiling?
>
> Sorry, I don't understand the question.
>

Sorry for the unclear question. I mean can we modify the Makefile as:

--- a/testcases/kernel/syscalls/bpf/Makefile
+++ b/testcases/kernel/syscalls/bpf/Makefile
@@ -10,4 +10,4 @@ CFLAGS                        += -D_GNU_SOURCE

 include $(top_srcdir)/include/mk/generic_leaf_target.mk

-$(MAKE_TARGETS): %: %.o bpf_common.o
+$(MAKE_TARGETS): %: bpf_common.o


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200218/e77a3b69/attachment.htm>
