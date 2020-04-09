From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Apr 2020 18:06:55 +0800
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <20200409074505.GA2601@dell5510>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
 <20200409074505.GA2601@dell5510>
Message-ID: <CAEemH2fo2HOsgrS7q8s3gr5-BdLfO530f0WGszDDWmpw_V=KOg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:

...
> > I guess that we can even drop the TCID extern definition from the
> tst_test.h
> > header if the weak attribute works fine.
>
> I'd be for adding this patch (both version works), Cyril, will you send it
> to ML / push it?
>
> I'd also be for adding -fno-common to Travis after this fix.
>

After building LTP with CFLAGS="-fno-common" locally, I just find more
places that need to do the same improvement.

    ltp/testcases/kernel/controllers/libcontrollers/libcontrollers.h:56:
multiple definition of `num_line'
    ltp/lib/../include/tst_hugepage.h:16: multiple definition of `Hopt'

Sorry for involving the definition in tst_hugetlb.h without 'extern' issue
many hours ago. It'd be appreciated if you can fix them together in your
coming patch.

Hope this is a timely reminder in case you formatting patch V2 :).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200409/10c1c32e/attachment.htm>
