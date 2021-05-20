From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 May 2021 10:10:23 +0200
Subject: [LTP] [PATCH 6/6] sched/cgroup: Add cfs_bandwidth01
In-Reply-To: <YKT7xfzaUD7nNPzX@yuki>
References: <20210513152125.25766-1-rpalethorpe@suse.com>
 <20210513152125.25766-7-rpalethorpe@suse.com>
 <YKT7xfzaUD7nNPzX@yuki>
Message-ID: <YKYZbytpV/BC1CfA@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hmm, I wonder if we can move this part of the cleanup to the test
> library as well. If we add all cgroups the user has created into a FIFO
                                                                     ^
								     LIFO
As we have to remove the last insterted first.

-- 
Cyril Hrubis
chrubis@suse.cz
