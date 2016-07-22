From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Jul 2016 09:15:07 -0400 (EDT)
Subject: [LTP] [PATCH] controllers/cpuset:check for cpuset mount status
 and	prefix
In-Reply-To: <1468479240-4975-1-git-send-email-shuang.qiu@oracle.com>
References: <1468479240-4975-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <757741255.7369133.1469193307743.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "shuang qiu" <shuang.qiu@oracle.com>
> To: ltp@lists.linux.it
> Sent: Thursday, 14 July, 2016 8:54:00 AM
> Subject: [LTP] [PATCH] controllers/cpuset:check for cpuset mount status and	prefix
> 
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> * Update to handle the env that cpuset subsystem is already mounted

I'm assuming motivation here are systemd distros, that have memory
cgroup already mounted.

> 
> * Similar with commit 6ce94db5bbff0be40813f3fdfe61a55b3186c49a,need to check
> for cpuset prefix
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> ---
>  .../cpuset_base_ops_testset.sh                     |   28 +-
>  .../cpuset_exclusive_test/cpuset_exclusive_test.sh |  168 ++++----
>  .../kernel/controllers/cpuset/cpuset_funcs.sh      |   39 +-
>  .../cpuset_hierarchy_test/cpuset_hierarchy_test.sh |  416
>  ++++++++++----------
>  .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |    4 +-
>  .../cpuset_inherit_test/cpuset_inherit_testset.sh  |   12 +-
>  .../cpuset_memory_pressure_testset.sh              |   32 +-
>  .../cpuset_memory_spread_testset.sh                |    2 +-
>  .../cpuset_memory_test/cpuset_memory_testset.sh    |   22 +-
>  .../cpuset_syscall_test/cpuset_syscall_testset.sh  |    8 +-
>  10 files changed, 369 insertions(+), 362 deletions(-)

Looks OK to me. The changes look straight-forward, there's just
lot of them.

I've ran it on RHEL7.3 and these passed. I tried also upstream
4.7-rc7 and there were some failures, but that seems to be
because some input validation has changed on some files.

Can you also mention where/how you tested this change?

Thanks,
Jan
