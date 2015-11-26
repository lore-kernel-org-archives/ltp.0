From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Nov 2015 14:49:08 +0100
Subject: [LTP] [PATCH v2] hugetlb: checking if hugepage is supported on
 target system
In-Reply-To: <CAEemH2cUXFEMk1MXt=-eyjc3s0sinn4X2J89CxPmyKy5uZr3uw@mail.gmail.com>
References: <1448506629-12150-1-git-send-email-liwang@redhat.com>
 <5656C72C.4090203@oracle.com>
 <CAEemH2cUXFEMk1MXt=-eyjc3s0sinn4X2J89CxPmyKy5uZr3uw@mail.gmail.com>
Message-ID: <20151126134908.GA9276@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > forgot "static"?
> >
> 
> no, it will be conflict with the prototype in mem.h and get compiler error
> like:
> -------
> hugemmap05.c:253: error: static declaration of ???cleanup??? follows non-static
> declaration
> /mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150903/testcases/kernel/mem/include/mem.h:100:
> note: previous declaration of ???cleanup??? was here
> hugemmap05.c:295: error: static declaration of ???setup??? follows non-static
> declaration
> /mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150903/testcases/kernel/mem/include/mem.h:101:
> note: previous declaration of ???setup??? was here
> make: *** [hugemmap05] Error 1

Why have you added the function into the mem/include/mem.h in the first
place? There is kernel/mem/hugetlb/lib/ directory allready, just make
use of it.

-- 
Cyril Hrubis
chrubis@suse.cz
