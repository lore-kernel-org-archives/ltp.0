From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Jan 2021 18:03:43 +0800
Subject: [LTP] [RFC PATCH 2/5] CGroup API rewrite
In-Reply-To: <87eej1dpgm.fsf@suse.de>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
 <20201216100121.16683-3-rpalethorpe@suse.com>
 <CAEemH2ddomP4XO=61vNx5=3vQYNj4WOurUX2zcuC-46RxhMk0g@mail.gmail.com>
 <87eej1dpgm.fsf@suse.de>
Message-ID: <CAEemH2diKwkvjZ=20+MGpNJsWzM3OskDbcyuY7MH3tEsGV4U=Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jan 4, 2021 at 5:24 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Li,
>
> Li Wang <liwang@redhat.com> writes:
>
> >>
> >
> > As I was mentioned in 0/5 that maybe we should create test_cgroup_dir
> > for different progress so that the test could use the same controller
> with
> > various configurations in parallel.
> >
> > e.g. child_1 set SIZE to memory.limit_in_bytes
> >        child_2 set SIZE/2 to memory.limit_in_bytes
> >
> > Any possibility to move this to tst_cgroup_move_current?
>
> Yes I suppose we can try this. Is there a test which already requires it?
>

So far we don't have such a test, I remember that in the previous Lib is
also to keep expandability.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210104/38a04d2e/attachment.htm>
