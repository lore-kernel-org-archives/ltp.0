From: Yu Xu <xuyu@linux.alibaba.com>
Date: Wed, 10 Apr 2019 15:04:47 +0800
Subject: [LTP] [PATCH] controllers/cgroup_regression_test.sh: mitigate
 potential mount error
In-Reply-To: <20190404091051.GA20565@rei.lan>
References: <9b3247beedd55b5a2c2ef638b26416d175775c77.1550815364.git.xuyu@linux.alibaba.com>
 <20190404091051.GA20565@rei.lan>
Message-ID: <d9f667f7-f836-8918-2a3a-180e37c9e2a0@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 4/4/19 5:10 PM, Cyril Hrubis wrote:
> Hi!
> First of all sorry for the delayed response.
> 
>> Immediately `umount cgroup/` after `rmdir cgroup/0` is very likely to
>> make the corresponding num_cgroups not decrease, and causes the
>> following mount operation with overlapping subsys to fail.
>>
>> A demo test script can be:
>> mount -t cgroup -o hugetlb,pids xxx cgroup/
>> mkdir cgroup/0
>> rmdir cgroup/0
>> umount cgroup/
>> mount -t cgroup -o pids xxx cgroup/  <-- FAIL
>>
>> The root cause is that `rmdir cgroup/0` is asynchronous in the kernel
>> implementation, causing `umount cgroup/` to enter `cgroup_put` path,
>> instead of `percpu_ref_kill` path.
>>
>> There is no good kernel solution yet[1]. Therefore, we temporarily add
>> `sleep` in the test script to ensure `umount cgroup/` is executed
>> after `rmdir cgroup/0` is completed. Note that we only add `sleep` in
>> the clean up phase of each test in the cgroup_regression_test.sh.
>> No `sleep` is added in the cgroup_regression_6_1.sh and
>> cgroup_regression_10_1.sh for the sake of pressure test.
> 
> There is always better solution than sprinking the code with sleeps,
> here we can retry the mount instead, which would be faster and more

thanks for your kind reply!

retry mount cannot help here(at least for the current kernel), because 
`umount cgroup/` **immediately** after `rmdir cgroup/0` corrupts the 
cgroup_root refcnt, and it will always cause the subsequent remount 
failure(s) whenever remounting overlapping controllers later.

so I simply put a sleep between between `umount cgroup/` and `rmdir 
cgroup/0` to synchronize them.  <- any good idea to this point?

and attach the related kernel issue again:
https://marc.info/?t=155021167400005&r=1&w=2

thanks, Yu.

> reliable. And we even have functions for this see
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#retry-a-function-in-limited-time
> 
