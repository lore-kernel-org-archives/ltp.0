From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 14 Apr 2016 10:06:59 +0800
Subject: [LTP] [PATCH v2] inotify: Add test for inotify mark destruction
 race
In-Reply-To: <20150825112920.GB20082@rei.suse.de>
References: <1439215460-15670-1-git-send-email-jack@suse.com>
 <20150811141432.GA21861@rei.suse.de> <20150811142035.GD2659@quack.suse.cz>
 <20150825092925.GA19905@rei.suse.de> <20150825103803.GA15280@quack.suse.cz>
 <20150825112920.GB20082@rei.suse.de>
Message-ID: <570EFB43.3020704@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hello,

On 08/25/2015 07:29 PM, Cyril Hrubis wrote:
> Hi!
>> Interesting, probably SRCU is much slower with this older kernel. From my
>> experiments 100 iterations isn't quite reliable to trigger the oops in my
>> testing instance. But 400 seem to be good enough.
> 
> I've changed the nuber of iterations to 400 and pushed it to git,
> thanks.
> 

In upstream kernel v4.6-rc3-17-g1c74a7f and RHEL7.2GA, I sometimes get such
error:
---------------------------------------------------------------------------
inotify06    1  TBROK  :  inotify06.c:104: inotify_init failed: errno=EMFILE(24): Too many open files
inotify06    2  TBROK  :  inotify06.c:104: Remaining cases broken
---------------------------------------------------------------------------
But look at the inotify06.c, inotify_fd is closed every iteration.
For normal file descriptors, "close(fd) succeeds" does not mean related kernel
resources have been released immediately(processes may still reference fd).

Then inotify_fd  also has similar behavior? Even close(inotify_fd) returns,
that does not mean the number of current inotify instances have decreased one
immediately, then later inotify_init() calls may exceeds the /proc/sys/fs/inotify/max_user_instances and
return EMFILE error?  I had added some debug code in kernel, it seems that close(inotify_fd)
does not make sure current inotify instances decreases one immediately.

So I'd like to know this is expected behavior for inotify? If yes, we can
echo 400 > /proc/sys/fs/inotify/max_user_instances to avoid EMFILE error.
If not, this is a kernel bug?


Regards,
Xiaoguang Wang



