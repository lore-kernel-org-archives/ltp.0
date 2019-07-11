From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Jul 2019 12:42:26 +0200
Subject: [LTP] [PATCH v3] rcu/rcu_torture.sh: Rewrite test
In-Reply-To: <5D26F438.5010706@cn.fujitsu.com>
References: <1562769310-4918-1-git-send-email-ice_yangxiao@163.com>
 <20190711060357.GA28190@dell5510> <5D26F438.5010706@cn.fujitsu.com>
Message-ID: <20190711104226.GA23477@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Thanks for your detailed review.  Just one question:
> > Maybe print dmesg (for automated tests, when you don't have direct access to
> > machine).
> Do you have any simple way to only print related dmesg for the every run
> when running it in loops?
Maybe some -c or -C dmesg switch? (at least cgroup_regression_test.sh or
pm_sched_mc.py uses that).
But that's maybe too aggressive (removes dmesg for all previous tests).
So feel free to ignore this.

Kind regards,
Petr

