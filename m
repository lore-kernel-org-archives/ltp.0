From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Apr 2020 17:13:13 +0800
Subject: [LTP] hugemmap01 warnings with -i [was Re: LTP compilation
 broken with -fno-common]
In-Reply-To: <20200415101955.GA21676@dell5510>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
 <20200409074505.GA2601@dell5510>
 <CAEemH2fo2HOsgrS7q8s3gr5-BdLfO530f0WGszDDWmpw_V=KOg@mail.gmail.com>
 <20200415101955.GA21676@dell5510>
Message-ID: <CAEemH2cfYNLwbSuDi+_GUi-rWxhw2TE201DzSiLOX3MnQnee+g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Wed, Apr 15, 2020 at 6:20 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > After building LTP with CFLAGS="-fno-common" locally, I just find more
> > places that need to do the same improvement.
>
> >     ltp/testcases/kernel/controllers/libcontrollers/libcontrollers.h:56:
> > multiple definition of `num_line'
> >     ltp/lib/../include/tst_hugepage.h:16: multiple definition of `Hopt'
>
> > Sorry for involving the definition in tst_hugetlb.h without 'extern'
> issue
> > many hours ago. It'd be appreciated if you can fix them together in your
> > coming patch.
> BTW that's a fix 156f91396 ("hugetlb: move nr_opt to tst_hugepage.h")
>
> I haven't checked whether -i worked without warning before, but not it
> produces it:
>

This is not introduced by hugetlb recent fixes, the warning always exists
there in tag ltp-full-20200120.
Anyway, it's a tiny issue and I will have a look when available :).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200416/1abdc025/attachment-0001.htm>
