From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Jul 2021 13:40:59 +0200
Subject: [LTP] [PATCH 1/2] lib: limit the size of tmpfs in LTP
In-Reply-To: <CAEemH2dJ4FYh-7-8C5na-uB1jg31mdV8wC+7w_DHG1463XudHA@mail.gmail.com>
References: <20210701055208.715395-1-liwang@redhat.com> <YN7afAs3Mup5UbIf@yuki>
 <CAEemH2dJ4FYh-7-8C5na-uB1jg31mdV8wC+7w_DHG1463XudHA@mail.gmail.com>
Message-ID: <YN77SxjQ2tHeXJfp@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +
> > > +             if (!strcmp(tdev.fs_type, "tmpfs"))
> > > +                     tst_test->mnt_data = mnt_data;
> >
> > I guess that we are doing this in order to export the changes in the
> > mnt_data to the test, right?
> >
> > Is that needed for something or are you doing this just in a case that
> > somebody will use that?
> >
> 
> No, you probably mis-read this part.
> 
> In contrast, this is just to restore it to the original value,
> because we don't want to export the changed tst_test->mnt_data
> take effect on other filesystems.

I'm just asking why we are setting it in the first place?

If we do not change it there is no need to restore the value, so the
real question is, do we need to change the tst_test->mnt_data at all?

-- 
Cyril Hrubis
chrubis@suse.cz
