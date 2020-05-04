From: Jan Kara <jack@suse.cz>
Date: Mon, 4 May 2020 22:27:27 +0200
Subject: [LTP] [PATCH v2 2/4] syscalls/fanotify15: Add a test case for
 inode marks
In-Reply-To: <20200504184936.GA92715@x230>
References: <20200502162744.9589-1-amir73il@gmail.com>
 <20200502162744.9589-3-amir73il@gmail.com>
 <20200504080715.GA1741@quack2.suse.cz>
 <CAOQ4uxgJQ2MGdnib9gvc=PcoWxveUpyqDZ1YybT-Hxrhba9ApQ@mail.gmail.com>
 <20200504141516.GC1741@quack2.suse.cz>
 <20200504184936.GA92715@x230>
Message-ID: <20200504202727.GC17863@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon 04-05-20 20:49:36, Petr Vorel wrote:
> Hi Jan,
> 
> ...
> > > > > The new test case is a regression test for commit f367a62a7cad:
> 
> > > > >     fanotify: merge duplicate events on parent and child
> 
> > > > The test looks OK but do we want a test for this? I mean: A test like this
> > > > seems to imply we promise to merge identical events. Although that is a
> > > > good general guideline, I consider it rather an optimization that may or
> > > > may not happen but userspace should not rely on it. Thoughts?
> 
> > > The thing is, those are not really two identical events.
> > > This is in fact the same event (fsnotify_change() hook was called once).
> > > The fact that listener process may have an inode watch, parent directory
> > > watch and a filesystem watch should not affect the number of read events.
> 
> > Yeah, I agree that in this case we should be merging the event if sanely
> > possible (which is why I've merged that patch).
> 
> > > Now it's true that internally, fsnotify_dentry() emits two event flavors to
> > > parent and to victim. For inotify it even made some sense, because listener
> > > would read two different event flavors with two different formats.
> > > With fanotify (either reporting fd or fid) receiving two events makes very
> > > little sense.
> 
> > > I agree that the fix (merging those events) is best effort and we cannot
> > > commit to merging the events, but this isolated regression test does
> > > check the best effort fix reliably and this is the reason I think it
> > > should stay.
> 
> > OK, I'm not too concerned about this test. But still the functionality is
> > more in the area of "nice to have" than "must have" so in future we may
> > break this if the implementation would get too hairy. But I guess we can
> > remove the test in that case.
> Yes, nothing is set in stone.
> 
> > > Upcoming FAN_REPORT_NAME is about to change the picture a bit
> > > towards the inotify behavior - victim watch gets event without name,
> > > parent watch gets event with name, filesystem watch gets both event
> > > flavors... that is, if you will agree to this behavior, but we shall continue
> > > this discussion on the fanotiify_name patches....
> 
> > Yes.
> Can I add your ack tag to the whole patchset?
> Or do you still consider whether any of them should be merged?

Feel free to add my Ack-by tag:

Acked-by: Jan Kara <jack@suse.cz>

I didn't check all the details but overall the patches look good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
