From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Apr 2020 17:30:01 +0800
Subject: [LTP] [PATCH v3] add_key05: Avoid race with key garbage
 collection
In-Reply-To: <9439db89-016f-a498-cc28-fdcd73255f85@cn.fujitsu.com>
References: <20200409170239.13618-1-rpalethorpe@suse.com>
 <9439db89-016f-a498-cc28-fdcd73255f85@cn.fujitsu.com>
Message-ID: <CAEemH2dEF995WQQzS6ML4LAxX9+MurS+0=ai=Jos3xtjsqPAXQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:


> > The key subsystem independently tracks user info against UID. If a user
> is
> > deleted and the UID reused for a new user then the key subsystem will
> mistake
> > the new user for the old one.
> >
> > The keys/keyrings may not be accessible to the new user, but if they are
> not
> > yet garbage collected (which happens asynchronously) then the new user
> may be
> > exceeding its quota limits.
> >
> > This results in a race condition where this test can fail because the old
> > thread keyring is taking up the full quota. We can avoid this by creating
> > multiple users in parallel.
> >
> > This means when -i is used many users will be created. The number of new
> users
> > is limited to 10 and after the first 10 we begin reusing them. It seems
> best
> > to avoid creating a very large number of users as this may stress the
> system
> > in ways that doesn't make sense for this test. There is a one second
> delay
> > after every 10 iterations to give the system time to free keys. This
> won't be
> > enough on some systems, but I doubt running this test with -i and
> expecting a
> > consistent result is sane.
> >
> > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > Acked-by: Jan Stancek <jstancek@redhat.com>
> ...
> > +
> > +     if (SAFE_FORK()) {
> > +             tst_reap_children();
> > +             useri++;
> > +             return;
> > +     }
> > +
> It looks strange. Maybe only I think it is strange. Can we use old style?
>
> if (!SAFE_FORK()) {
>       ....
>       ....
>       test
>       exit
> }
>     tst_reap_children();
>     useri++;
>

Nice work, applied V3 with Xu's suggestion.


> > +             verify_max_btyes();
> It is typo(I introduced), I guess maintainer can fix this when merging
> this patch. btyes->bytes
>

Good eyesight!
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200413/feecc1a5/attachment.htm>
