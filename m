From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Apr 2018 11:46:17 +0000
Subject: [LTP] [RFC PATCH] mm: correct status code which move_pages()
 returns for zero page
In-Reply-To: <20180418112916.GX17484@dhcp22.suse.cz>
References: <20180417110615.16043-1-liwang@redhat.com>
 <20180417130300.GF17484@dhcp22.suse.cz>
 <20180417141442.GG17484@dhcp22.suse.cz>
 <CAEemH2dQ+yQ-P-=5J3Y-n+0V0XV-vJkQ81uD=Q3Bh+rHZ4sb-Q@mail.gmail.com>
 <20180417190044.GK17484@dhcp22.suse.cz>
 <7674C632-FE3E-42D2-B19D-32F531617043@cs.rutgers.edu>
 <20180418090722.GV17484@dhcp22.suse.cz>
 <20180418091943.GW17484@dhcp22.suse.cz>
 <CAEemH2evD8Gk6y_q41ygBZVwu--U9oKvnPh8xsrb5R27oLCBDA@mail.gmail.com>
 <20180418112916.GX17484@dhcp22.suse.cz>
Message-ID: <CAEemH2eENKctW3xTJcQOLNTosz0-vai+EkGQdf5hhkDbPBk73Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Wed, Apr 18, 2018, 19:29 Michal Hocko <mhocko@suse.com> wrote:

> On Wed 18-04-18 18:39:19, Li Wang wrote:
> > On Wed, Apr 18, 2018 at 5:19 PM, Michal Hocko <mhocko@suse.com> wrote:
> >
> > > On Wed 18-04-18 11:07:22, Michal Hocko wrote:
> > > > On Tue 17-04-18 16:09:33, Zi Yan wrote:
> > > [...]
> > > > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > > > index f65dd69e1fd1..32afa4723e7f 100644
> > > > > --- a/mm/migrate.c
> > > > > +++ b/mm/migrate.c
> > > > > @@ -1619,6 +1619,8 @@ static int do_pages_move(struct mm_struct
> *mm,
> > > nodemask_t task_nodes,
> > > > >                         if (err)
> > > > >                                 goto out;
> > > > >                 }
> > > > > +               /* Move to next page (i+1), after we have saved
> page
> > > status (until i) */
> > > > > +               start =3D i + 1;
> > > > >                 current_node =3D NUMA_NO_NODE;
> > > > >         }
> > > > >  out_flush:
> > > > >
> > > > > Feel free to check it by yourselves.
> > > >
> > > > Yes, you are right. I never update start if the last page in the
> range
> > > > fails and so we overwrite the whole [start, i] range. I wish the co=
de
> > > > wasn't that ugly and subtle but considering how we can fail in
> different
> > > > ways and that we want to batch as much as possible I do not see an
> easy
> > > > way.
> > > >
> > > > Care to send the patch? I would just drop the comment.
> > >
> > > Hmm, thinking about it some more. An alternative would be to check for
> > > list_empty on the page list. It is a bit larger diff but maybe that
> > > would be tiny bit cleaner because there is simply no point to call
> > > do_move_pages_to_node on an empty list in the first place.
> > >
> >
> > =E2=80=8BHi Michal, Zi
> >
> > I tried your patch separately, both of them works fine to me.
>
> Thanks for retesting! Do you plan to post a patch with the changelog or
> should I do it?
>

You better.

Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180418/43a89c60/att=
achment.html>
