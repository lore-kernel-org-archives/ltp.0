From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Apr 2018 22:28:33 +0800
Subject: [LTP] [RFC PATCH] mm: correct status code which move_pages()
 returns for zero page
In-Reply-To: <20180417141442.GG17484@dhcp22.suse.cz>
References: <20180417110615.16043-1-liwang@redhat.com>
 <20180417130300.GF17484@dhcp22.suse.cz>
 <20180417141442.GG17484@dhcp22.suse.cz>
Message-ID: <CAEemH2dQ+yQ-P-=5J3Y-n+0V0XV-vJkQ81uD=Q3Bh+rHZ4sb-Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Tue, Apr 17, 2018 at 10:14 PM, Michal Hocko <mhocko@suse.com> wrote:

> On Tue 17-04-18 15:03:00, Michal Hocko wrote:
> > On Tue 17-04-18 19:06:15, Li Wang wrote:
> > [...]
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index f65dd69..2b315fc 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -1608,7 +1608,7 @@ static int do_pages_move(struct mm_struct *mm,
> nodemask_t task_nodes,
> > >                     continue;
> > >
> > >             err = store_status(status, i, err, 1);
> > > -           if (err)
> > > +           if (!err)
> > >                     goto out_flush;
> >
> > This change just doesn't make any sense to me. Why should we bail out if
> > the store_status is successul? I am trying to wrap my head around the
> > test case. 6b9d757ecafc ("mm, numa: rework do_pages_move") tried to
> > explain that move_pages has some semantic issues and the new
> > implementation might be not 100% replacement. Anyway I am studying the
> > test case to come up with a proper fix.
>
> OK, I get what the test cases does. I've failed to see the subtle
> difference between alloc_pages_on_node and numa_alloc_onnode. The later
> doesn't faul in anything.
>
> Why are we getting EPERM is quite not yet clear to me.
> add_page_for_migration uses FOLL_DUMP which should return EFAULT on
> zero pages (no_page_table()).
>
>         err = PTR_ERR(page);
>         if (IS_ERR(page))
>                 goto out;
>
> therefore bails out from add_page_for_migration and store_status should
> store that value. There shouldn't be any EPERM on the way.
>

Yes, I print the the return value and confirmed the
add_page_for_migration()​
do right things for zero page. and after store_status(...) the status saves
-EFAULT.
So I did the change above.



>
> Let me try to reproduce and see what is going on. Btw. which kernel do
> you try this on?
>

​The latest mainline kernel-4.17-rc1.



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180417/9d58d972/attachment.html>
