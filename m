From: Jan Kara <jack@suse.cz>
Date: Tue, 19 Apr 2016 15:05:43 +0200
Subject: [LTP] [PATCH v2] inotify: Add test for inotify mark destruction
 race
In-Reply-To: <57145692.6070205@cn.fujitsu.com>
References: <20150811141432.GA21861@rei.suse.de>
 <20150811142035.GD2659@quack.suse.cz>
 <20150825092925.GA19905@rei.suse.de>
 <20150825103803.GA15280@quack.suse.cz>
 <20150825112920.GB20082@rei.suse.de>
 <570EFB43.3020704@cn.fujitsu.com>
 <20160414081516.GA2753@quack2.suse.cz>
 <570F5161.7060806@cn.fujitsu.com>
 <20160414084611.GC2753@quack2.suse.cz>
 <57145692.6070205@cn.fujitsu.com>
Message-ID: <20160419130543.GA22413@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello!

On Mon 18-04-16 11:37:54, Xiaoguang Wang wrote:
> On 04/14/2016 04:46 PM, Jan Kara wrote:
> > On Thu 14-04-16 16:14:25, Xiaoguang Wang wrote:
> >> On 04/14/2016 04:15 PM, Jan Kara wrote:
> >>> Hello,
> >>>
> >>> On Thu 14-04-16 10:06:59, Xiaoguang Wang wrote:
> >>>> On 08/25/2015 07:29 PM, Cyril Hrubis wrote:
> >>>>> Hi!
> >>>>>> Interesting, probably SRCU is much slower with this older kernel. From my
> >>>>>> experiments 100 iterations isn't quite reliable to trigger the oops in my
> >>>>>> testing instance. But 400 seem to be good enough.
> >>>>>
> >>>>> I've changed the nuber of iterations to 400 and pushed it to git,
> >>>>> thanks.
> >>>>>
> >>>>
> >>>> In upstream kernel v4.6-rc3-17-g1c74a7f and RHEL7.2GA, I sometimes get such
> >>>> error:
> >>>> ---------------------------------------------------------------------------
> >>>> inotify06    1  TBROK  :  inotify06.c:104: inotify_init failed: errno=EMFILE(24): Too many open files
> >>>> inotify06    2  TBROK  :  inotify06.c:104: Remaining cases broken
> >>>> ---------------------------------------------------------------------------
> >>>> But look at the inotify06.c, inotify_fd is closed every iteration.
> >>>> For normal file descriptors, "close(fd) succeeds" does not mean related kernel
> >>>> resources have been released immediately(processes may still reference fd).
> >>>>
> >>>> Then inotify_fd  also has similar behavior? Even close(inotify_fd) returns,
> >>>> that does not mean the number of current inotify instances have decreased one
> >>>> immediately, then later inotify_init() calls may exceeds the /proc/sys/fs/inotify/max_user_instances and
> >>>> return EMFILE error?  I had added some debug code in kernel, it seems that close(inotify_fd)
> >>>> does not make sure current inotify instances decreases one immediately.
> >>>>
> >>>> So I'd like to know this is expected behavior for inotify? If yes, we can
> >>>> echo 400 > /proc/sys/fs/inotify/max_user_instances to avoid EMFILE error.
> >>>> If not, this is a kernel bug?
> >>>
> >>> Interesting, I've never seen this. Number of inotify instances is maintaned
> >>> immediately - i.e., it is dropped as soon as the last descriptor pointing to
> >>> the instance is closed. So I'm not sure how what you describe can happen.
> >>> How do you reproduce the issue?
> >> I just call ./inotify06 directly, and about 50% chance, it'll fail(return EMFILE).
> > 
> > Hum, I've just tried 4.6-rc1 which I have running on one test machine and
> > it survives hundreds of inotify06 calls in a loop without issues. I have
> > max_user_instances set to 128 on that machine... So I suspect the problem
> > is somewhere in your exact userspace setup. Aren't there other processes
> > using inotify heavily for that user?
> I doubted so, but please see my debug results in my virtual machine, it still
> seems that it's a kernel issue...
> I add some simple debug code to kernel and ltp test case inotify06, and switched
> to a normal user "lege" to have a test.

Thanks for the debugging! So I was looking more into the code and I now see
what is likely going on. The group references from fsnotify marks are
dropped only after srcu period expires and inotify instance count is
decreased only after group reference count drops to zero. I will think what
we can do about this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
