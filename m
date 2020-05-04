From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 May 2020 11:51:27 +0300
Subject: [LTP] [PATCH v2 2/4] syscalls/fanotify15: Add a test case for
 inode marks
In-Reply-To: <20200504080715.GA1741@quack2.suse.cz>
References: <20200502162744.9589-1-amir73il@gmail.com>
 <20200502162744.9589-3-amir73il@gmail.com>
 <20200504080715.GA1741@quack2.suse.cz>
Message-ID: <CAOQ4uxgJQ2MGdnib9gvc=PcoWxveUpyqDZ1YybT-Hxrhba9ApQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 4, 2020 at 11:07 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 02-05-20 19:27:42, Amir Goldstein wrote:
> > Test reporting events with fid also with recusrive inode marks:
> > - Test events "on self" (FAN_DELETE_SELF) on file and dir
> > - Test events "on child" (FAN_MODIFY) on file
> >
> > With recursive inode marks, verify that the FAN_MODIFY event reported
> > to parent "on child" is merged with the FAN_MODIFY event reported to
> > child.
> >
> > The new test case is a regression test for commit f367a62a7cad:
> >
> >     fanotify: merge duplicate events on parent and child
>
> The test looks OK but do we want a test for this? I mean: A test like this
> seems to imply we promise to merge identical events. Although that is a
> good general guideline, I consider it rather an optimization that may or
> may not happen but userspace should not rely on it. Thoughts?

The thing is, those are not really two identical events.
This is in fact the same event (fsnotify_change() hook was called once).
The fact that listener process may have an inode watch, parent directory
watch and a filesystem watch should not affect the number of read events.

Now it's true that internally, fsnotify_dentry() emits two event flavors to
parent and to victim. For inotify it even made some sense, because listener
would read two different event flavors with two different formats.
With fanotify (either reporting fd or fid) receiving two events makes very
little sense.

I agree that the fix (merging those events) is best effort and we cannot
commit to merging the events, but this isolated regression test does
check the best effort fix reliably and this is the reason I think it
should stay.

Upcoming FAN_REPORT_NAME is about to change the picture a bit
towards the inotify behavior - victim watch gets event without name,
parent watch gets event with name, filesystem watch gets both event
flavors... that is, if you will agree to this behavior, but we shall continue
this discussion on the fanotiify_name patches....

Thanks,
Amir.
