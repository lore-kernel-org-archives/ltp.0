From: Xiao Yang <ice_yangxiao@163.com>
Date: Thu, 11 Jul 2019 18:59:41 +0800
Subject: [LTP] [PATCH v3] rcu/rcu_torture.sh: Rewrite test
In-Reply-To: <20190711104226.GA23477@dell5510>
References: <1562769310-4918-1-git-send-email-ice_yangxiao@163.com>
 <20190711060357.GA28190@dell5510> <5D26F438.5010706@cn.fujitsu.com>
 <20190711104226.GA23477@dell5510>
Message-ID: <d6c9e8af-b84c-7dd6-803b-c8b76a50ed49@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/11/2019 06:42 PM, Petr Vorel wrote:
> Hi Xiao,
>
>> Thanks for your detailed review.  Just one question:
>>> Maybe print dmesg (for automated tests, when you don't have direct access to
>>> machine).
>> Do you have any simple way to only print related dmesg for the every run
>> when running it in loops?
> Maybe some -c or -C dmesg switch? (at least cgroup_regression_test.sh or
> pm_sched_mc.py uses that).
> But that's maybe too aggressive (removes dmesg for all previous tests).
> So feel free to ignore this.
Hi Petr,

It's aggressive to me as well. :-)
I will send v4 patch as you suggested.

Best Regards,
Xiao Yang
>
> Kind regards,
> Petr

