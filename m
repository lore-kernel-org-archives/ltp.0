From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 6 May 2021 17:27:28 +0200
Subject: [LTP] [PATCH 2/2] syscalls/inotify06: Raise inotify instance
 limit in /proc
In-Reply-To: <20210505164757.GC9615@quack2.suse.cz>
References: <20210505153847.6106-1-mdoucha@suse.cz>
 <20210505153847.6106-2-mdoucha@suse.cz>
 <20210505164757.GC9615@quack2.suse.cz>
Message-ID: <32425668-9713-c216-38b1-46b57fce2197@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05. 05. 21 18:47, Jan Kara wrote:
> On Wed 05-05-21 17:38:47, Martin Doucha wrote:
>> inotify_init() sometimes fails with EMFILE because there are too many
>> partially closed instances waiting for garbage collection. Bump the limit
>> in /proc/sys/fs/inotify/max_user_instances for the duration of the test.
>>
>> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>> ---
>>
>> I thought about only reading the procfile and calling yield() after every
>> proc_limit/2 iterations to wait for garbage collection but I'm afraid that
>> it might reduce the likelihood of triggering the bug. Since I currently have
>> no system where I could reproduce the race, I've decided to play it safe and
>> bump the /proc limit.
> 
> So waiting would be fine as well. One process simply creates & deletes
> files in a loop until the other performs TEARDOWNS teardowns. It doesn't
> really matter how fast teardowns happen for the race to trigger. But I have
> no problem with this solution either.

Let's go with the patch as is then. Like I said, when I don't have a
system where the issue is reproducible, I prefer to play it safe.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
