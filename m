From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Apr 2019 12:07:14 +0300
Subject: [LTP] [PATCH 2/4] syscalls/fanotify13: new test to verify
 FAN_REPORT_FID functionality
In-Reply-To: <20190419083743.GA15974@lithium.mbobrowski.org>
References: <cover.1554197461.git.mbobrowski@mbobrowski.org>
 <da7bbaf1f0661dec476e636ed250ab640f5d2c31.1554197461.git.mbobrowski@mbobrowski.org>
 <20190416134105.GA20437@rei>
 <CAOQ4uxhQ_Yk9=085eN+TF6rX8CQhzdv7Ze+_Hp8t00CLL2k7+w@mail.gmail.com>
 <20190419083743.GA15974@lithium.mbobrowski.org>
Message-ID: <CAOQ4uxj=sjusSfN91dOAKH9t0XRS1+0MZK_Bi8=2R=T5DZjWMA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Apr 19, 2019 at 11:37 AM Matthew Bobrowski
<mbobrowski@mbobrowski.org> wrote:
>
> On Tue, Apr 16, 2019 at 05:23:14PM +0300, Amir Goldstein wrote:
> > On Tue, Apr 16, 2019 at 4:41 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> > >
> > > Hi!
> > > > Newly defined test file to validate the fanotify FAN_REPORT_FID
> > > > functionality.
> > > >
> > > > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  testcases/kernel/syscalls/fanotify/.gitignore   |   1 +
> > > >  testcases/kernel/syscalls/fanotify/fanotify.h   |  19 +-
> > > >  testcases/kernel/syscalls/fanotify/fanotify13.c | 329 ++++++++++++++++++++++++
> > >
> > > This is missing the runtest entry in runtest/syscalls so that the test
> > > is picked up by the testrunner.
> > >
> > > And the same bug slipped in during review for fanotify12 so I've
> > > commited a fix that adds it there.
> > >
> > > ...
> > >
>
> My apologies, this was a simple oversight. I've gone ahead and updated it
> accordingly.
>
> > > > +static void do_test(unsigned int number)
> > > > +{
> > > > +     unsigned int i;
> > > > +     int len, fds[ARRAY_SIZE(objects)];
> > > > +
> > > > +     struct file_handle *event_file_handle;
> > > > +     struct fanotify_event_metadata *metadata;
> > > > +     struct fanotify_event_info_fid *event_fid;
> > > > +     struct test_case_t *tc = &test_cases[number];
> > > > +     struct fanotify_mark_type *mark = &tc->mark;
> > > > +
> > > > +     tst_res(TINFO,
> > > > +             "Test #%d: FAN_REPORT_FID with mark flag: %s",
> > > > +             number, mark->name);
> > > > +
> > > > +     /* Gets the filesystem fsid and file handle for each object */
> > > > +     get_object_stats(tc);
> > >
> > > Is there a reason why are are not calling this function once in the test
> > > setup? It will be called for every test iteration when the test is
> > > passed the -i option...
> > >
> >
> > I think that's an oversight. It could be called once during setup.
>
> Indeed. I've changed this so that the function is now only called once from
> within do_setup(). There was one code snippet (added below) that I had to move
> out from get_object_stats() as there's a setup dependency for each test case.
>
> --
> event_set[i].expected_mask = tc->mask;
> if (!objects[i].is_dir)
>         event_set[i].expected_mask &= ~FAN_ONDIR;
> --
>
> I've added this snippet within setup_marks() as we're already iterating over
> the objects array and passing in a task_struct_t object, which means we could
> also setup the expected mask for each expected event there. Unless anyone
> objects?
>

Sounds good to me.

Thanks,
Amir.
