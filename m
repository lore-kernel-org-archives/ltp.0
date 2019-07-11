From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 11 Jul 2019 16:32:56 +0800
Subject: [LTP] [PATCH v3] rcu/rcu_torture.sh: Rewrite test
In-Reply-To: <20190711060357.GA28190@dell5510>
References: <1562769310-4918-1-git-send-email-ice_yangxiao@163.com>
 <20190711060357.GA28190@dell5510>
Message-ID: <5D26F438.5010706@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/07/11 14:03, Petr Vorel wrote:
Hi Petr,

Thanks for your detailed review.  Just one question:
> Maybe print dmesg (for automated tests, when you don't have direct access to
> machine).
Do you have any simple way to only print related dmesg for the every run 
when running it in loops?

Best Regards,
Xiao Yang


