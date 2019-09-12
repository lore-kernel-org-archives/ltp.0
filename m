From: Xu, =?unknown-8bit?b?WWFuZy/lvpAg5p2o?= <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 12 Sep 2019 15:00:26 +0800
Subject: [LTP] [PATCH] cgroup_regression_test.sh: fix test_5 possible
 mount failure because of cgroup hierarchy
In-Reply-To: <20190911133315.GA21378@rei.lan>
References: <1560250815-2308-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5D2D681D.1050909@cn.fujitsu.com> <5D440CAA.9080701@cn.fujitsu.com>
 <5D6CC86E.5020009@cn.fujitsu.com> <20190911133315.GA21378@rei.lan>
Message-ID: <5b2b7314-5d0a-1bc6-11ff-7088171b86e6@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/09/11 21:33, Cyril Hrubis wrote:

> Hi!
>> Have somebody noticed this patch? ping.:-)
> Sorry for the long delay.
>
> I'm looking at the original reproducer at:
>
> https://lists.openvz.org/pipermail/devel/2009-January/016345.html
>
> And as far as I can tell the test_5() was never actually doing what it
> takes to reproduce the bug, as far as I can tell the test was bogus to
> begin with. The main point of the reproducer is that the cgroup is
> unmounted while there is task in the group, then remounted again. As we
> cannot unmount the cgroup these days I would just go for removing the
> test instead of applying band aid over the code.

Hi Cyril

why we can't unmount the cgroup these days?

 From kernel commit 839ec545("cgroup: fix root_count when mount fails due to busy subsystem"),
it should be reproduced as the following step
1)mount two subsystem(A and B) mntpoint
2)mount one subsystem(A) mntpoint, it will get EBUSY error
3)without kernel commit, kill this process and task is still in cgroup, kernel will call cgroup_kill_sb()
to decrement root_count, then kernel crashes.

Is it right?

Thanks
Yang Xu



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190912/857f6612/attachment-0001.htm>
