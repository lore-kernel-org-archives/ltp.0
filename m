From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 May 2021 11:06:27 +0200
Subject: [LTP] [PATCH 6/6] sched/cgroup: Add cfs_bandwidth01
In-Reply-To: <87y2c8juyu.fsf@suse.de>
References: <20210513152125.25766-1-rpalethorpe@suse.com>
 <20210513152125.25766-7-rpalethorpe@suse.com>
 <YKT7xfzaUD7nNPzX@yuki> <871ra1lrf3.fsf@suse.de>
 <87y2c8juyu.fsf@suse.de>
Message-ID: <YKy+E935XKO91pOd@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I think maybe this API makes a fundamental mistake of mixing memory/object
> management with actual creation and deletion of CGroups. OTOH that is
> not really clear either.
> 
> But if a child process starts deleting CGroups, which might be a
> reasonable thing to do, then we will get a mismatch between child and
> parent. Then the cleanup will be wrong.

Good point. I guess that we can make up rules that would make sure we do
not run cleanup both in the parent and child, but that would probably
overcomplicate the library.

> Also any kind of linked list or array implementation uses more lines of
> code than the cleanup function and more complex for sure... even if we
> have 10 test cases like this is it really work saving a few lines in
> each case?
> 
> I don't know. But I think we need to see a few more cases.

Makes sense.

-- 
Cyril Hrubis
chrubis@suse.cz
