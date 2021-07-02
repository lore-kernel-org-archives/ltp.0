From: Li Wang <liwang@redhat.com>
Date: Fri, 2 Jul 2021 20:20:37 +0800
Subject: [LTP] [PATCH 1/2] lib: limit the size of tmpfs in LTP
In-Reply-To: <YN77SxjQ2tHeXJfp@yuki>
References: <20210701055208.715395-1-liwang@redhat.com> <YN7afAs3Mup5UbIf@yuki>
 <CAEemH2dJ4FYh-7-8C5na-uB1jg31mdV8wC+7w_DHG1463XudHA@mail.gmail.com>
 <YN77SxjQ2tHeXJfp@yuki>
Message-ID: <CAEemH2cDM819aXG7yGwP77FjUNG8GSp-qYxbzZa-RWyJgtFVMw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 2, 2021 at 8:06 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > > +
> > > > +             if (!strcmp(tdev.fs_type, "tmpfs"))
> > > > +                     tst_test->mnt_data = mnt_data;
> > >
> > > I guess that we are doing this in order to export the changes in the
> > > mnt_data to the test, right?
> > >
> > > Is that needed for something or are you doing this just in a case that
> > > somebody will use that?
> > >
> >
> > No, you probably mis-read this part.
> >
> > In contrast, this is just to restore it to the original value,
> > because we don't want to export the changed tst_test->mnt_data
> > take effect on other filesystems.
>
> I'm just asking why we are setting it in the first place?
>
> If we do not change it there is no need to restore the value, so the
> real question is, do we need to change the tst_test->mnt_data at all?
>

Alright, we can just return a new pointer buf, and do nothing
for the tst_test->mnt_data itself.

Seems the misread person is me (I need more coffee now:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210702/32ade573/attachment.htm>
