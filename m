From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Jun 2019 16:01:32 +0800
Subject: [LTP] [PATCH 2/3] lib/test.sh: TCONF needs to be counted
In-Reply-To: <20190609154038.GA53103@linux.alibaba.com>
References: <f11c83459b71fbf399794fb8363f2b538b0b6346.1559207183.git.caspar@casparzhang.com>
 <5e8374fa7f4ea9d64cdfc39a2ca449761327c257.1559207183.git.caspar@casparzhang.com>
 <CAEemH2eV6RZKdZV0MMuogAzyvoXCsuvrfp3v_1TNtO1cOoAPGA@mail.gmail.com>
 <20190609154038.GA53103@linux.alibaba.com>
Message-ID: <CAEemH2dX6ESKrS0DnKYDogaTZQwpf9MbOo0W=TS0VnEeN2EbXg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Jun 9, 2019 at 11:41 PM Caspar Zhang <caspar@linux.alibaba.com>
wrote:

> On Fri, May 31, 2019 at 11:17:14AM +0800, Li Wang wrote:
> >
> >
> > On Thu, May 30, 2019 at 5:10 PM Caspar Zhang <[1]
> caspar@linux.alibaba.com>
> > wrote:
> >
> >     TCONF should also be one of exit statuses in a single test, else the
> >     output of TST_COUNT in shell tests could be wrong.
> >
> >     Wrong:
> >     <<<test_output>>>
> >     memcg_use_hierarchy_test 1 TINFO: Starting test 1
> >     memcg_use_hierarchy_test 1 TINFO: set
> /dev/memcg/memory.use_hierarchy to 0
> >     failed
> >     memcg_use_hierarchy_test 1 TPASS: process 28658 is killed
> >     memcg_use_hierarchy_test 2 TINFO: Starting test 2
> >     memcg_use_hierarchy_test 2 TINFO: set
> /dev/memcg/memory.use_hierarchy to 0
> >     failed
> >     memcg_use_hierarchy_test 2 TCONF: memory.use_hierarchy already been
> 1,
> >     blame systemd, skip
> >     memcg_use_hierarchy_test 2 TINFO: Starting test 3
> >     memcg_use_hierarchy_test 2 TINFO: set
> /dev/memcg/memory.use_hierarchy to 0
> >     failed
> >     memcg_use_hierarchy_test 2 TPASS: echo 0 >
> subgroup/memory.use_hierarchy
> >     failed as expected
> >     <<<execution_status>>>
> >
> >     Right:
> >     <<<test_output>>>
> >     memcg_use_hierarchy_test 1 TINFO: Starting test 1
> >     memcg_use_hierarchy_test 1 TINFO: set
> /dev/memcg/memory.use_hierarchy to 0
> >     failed
> >     memcg_use_hierarchy_test 1 TPASS: process 26825 is killed
> >     memcg_use_hierarchy_test 2 TINFO: Starting test 2
> >     memcg_use_hierarchy_test 2 TINFO: set
> /dev/memcg/memory.use_hierarchy to 0
> >     failed
> >     memcg_use_hierarchy_test 2 TCONF: memory.use_hierarchy already been
> 1,
> >     blame systemd, skip
> >     memcg_use_hierarchy_test 3 TINFO: Starting test 3
> >     memcg_use_hierarchy_test 3 TINFO: set
> /dev/memcg/memory.use_hierarchy to 0
> >     failed
> >     memcg_use_hierarchy_test 3 TPASS: echo 0 >
> subgroup/memory.use_hierarchy
> >     failed as expected
> >     <<<execution_status>>>
> >
> >
> > This is a good catch, but maybe it's not wise to simply regard the TCONF
> as a
> > single test, because there are many system-config detections in setup()
> > function, that will make LTP gives a mendacious report on the test
> numbers if
> > applying this patch.
> >
> > e.g.
> >
> > if tst_kvcmp -lt "3.10"; then
> >     tst_brk TCONF "test must be run with kernel 3.10 or newer"
> > fi
> > if dir path not exist; then
> >     tst_brk TCONF "system does not have xxxx/"
> > fi
> > and so on...
>
> TCONF usually report only once, I would still take it a valid report on
> numbers. Take your case as example, I guess we are able to see results
> like:
>

Okay, that sounds reasonable too.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190610/e109fe9c/attachment.html>
