From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Oct 2019 16:19:57 +0200
Subject: [LTP] [PATCH] controllers/cgroup_regression_test.sh: mitigate
 potential mount error
In-Reply-To: <d9f667f7-f836-8918-2a3a-180e37c9e2a0@linux.alibaba.com>
References: <9b3247beedd55b5a2c2ef638b26416d175775c77.1550815364.git.xuyu@linux.alibaba.com>
 <20190404091051.GA20565@rei.lan>
 <d9f667f7-f836-8918-2a3a-180e37c9e2a0@linux.alibaba.com>
Message-ID: <20191008141956.GA17636@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > There is always better solution than sprinking the code with sleeps,
> > here we can retry the mount instead, which would be faster and more
> 
> thanks for your kind reply!
> 
> retry mount cannot help here(at least for the current kernel), because 
> `umount cgroup/` **immediately** after `rmdir cgroup/0` corrupts the 
> cgroup_root refcnt, and it will always cause the subsequent remount 
> failure(s) whenever remounting overlapping controllers later.
> 
> so I simply put a sleep between between `umount cgroup/` and `rmdir 
> cgroup/0` to synchronize them.  <- any good idea to this point?
> 
> and attach the related kernel issue again:
> https://marc.info/?t=155021167400005&r=1&w=2

We are not working around kernel bugs in tests.

Too bad that it seems that nobody is interested in fixing the v1 cgroup
API. I guess this is a signal that we should stop using it as fast as
possible and migrate to v2.

-- 
Cyril Hrubis
chrubis@suse.cz
