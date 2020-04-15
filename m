From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 09:00:47 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <CAEemH2fo2HOsgrS7q8s3gr5-BdLfO530f0WGszDDWmpw_V=KOg@mail.gmail.com>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
 <20200409074505.GA2601@dell5510>
 <CAEemH2fo2HOsgrS7q8s3gr5-BdLfO530f0WGszDDWmpw_V=KOg@mail.gmail.com>
Message-ID: <20200415070047.GA24415@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> After building LTP with CFLAGS="-fno-common" locally, I just find more
> places that need to do the same improvement.

>     ltp/testcases/kernel/controllers/libcontrollers/libcontrollers.h:56:
> multiple definition of `num_line'
>     ltp/lib/../include/tst_hugepage.h:16: multiple definition of `Hopt'

> Sorry for involving the definition in tst_hugetlb.h without 'extern' issue
> many hours ago. It'd be appreciated if you can fix them together in your
> coming patch.

> Hope this is a timely reminder in case you formatting patch V2 :).
Thanks for info, working on the fix :).

Kind regards,
Petr
