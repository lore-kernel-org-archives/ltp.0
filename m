From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Sep 2019 15:33:15 +0200
Subject: [LTP] [PATCH] cgroup_regression_test.sh: fix test_5 possible
 mount failure because of cgroup hierarchy
In-Reply-To: <5D6CC86E.5020009@cn.fujitsu.com>
References: <1560250815-2308-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5D2D681D.1050909@cn.fujitsu.com> <5D440CAA.9080701@cn.fujitsu.com>
 <5D6CC86E.5020009@cn.fujitsu.com>
Message-ID: <20190911133315.GA21378@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Have somebody noticed this patch? ping.:-)

Sorry for the long delay.

I'm looking at the original reproducer at:

https://lists.openvz.org/pipermail/devel/2009-January/016345.html

And as far as I can tell the test_5() was never actually doing what it
takes to reproduce the bug, as far as I can tell the test was bogus to
begin with. The main point of the reproducer is that the cgroup is
unmounted while there is task in the group, then remounted again. As we
cannot unmount the cgroup these days I would just go for removing the
test instead of applying band aid over the code.

-- 
Cyril Hrubis
chrubis@suse.cz
