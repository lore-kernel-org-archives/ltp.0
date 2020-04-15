From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 12:19:55 +0200
Subject: [LTP] hugemmap01 warnings with -i [was Re: LTP compilation broken
 with -fno-common]
In-Reply-To: <CAEemH2fo2HOsgrS7q8s3gr5-BdLfO530f0WGszDDWmpw_V=KOg@mail.gmail.com>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
 <20200409074505.GA2601@dell5510>
 <CAEemH2fo2HOsgrS7q8s3gr5-BdLfO530f0WGszDDWmpw_V=KOg@mail.gmail.com>
Message-ID: <20200415101955.GA21676@dell5510>
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
BTW that's a fix 156f91396 ("hugetlb: move nr_opt to tst_hugepage.h")

I haven't checked whether -i worked without warning before, but not it
produces it:

./hugemmap01  -s 2 -i 2
tst_hugepage.c:48: INFO: 2 hugepage(s) reserved
tst_test.c:1244: INFO: Timeout per run is 0h 05m 00s
hugemmap01.c:61: PASS: call succeeded
hugemmap01.c:61: PASS: call succeeded
hugemmap01.c:69: WARN: Number of HUGEPAGES_FREE stayed the same. Okay if multiple copies running due to test collision.

Kind regards,
Petr
