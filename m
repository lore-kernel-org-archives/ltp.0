From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 15 Dec 2016 10:37:46 +0800
Subject: [LTP] rt_sigtimedwait01 failed in armv7l
In-Reply-To: <20161213104352.GA750@rei.lan>
References: <584FBAE7.2010100@huawei.com> <20161213104352.GA750@rei.lan>
Message-ID: <585201FA.9010508@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/12/13 18:43, Cyril Hrubis wrote:
> I guess that the problem here is that the order in which the test
> children and parent are executed is undefined.
> 
> The signals should be delivered starting from lowest numbered but that
> applies only when both signals are pending at the point we call
> sigwaitinfo(). If, by a chance, the first child haven't had chance to
> finish until we get to the sigwaitinfo() call we will get the signo+1
> signal first, since that is the only one pending at that point.
> 
> So the fix here would be making sure that both children are finished
> before we call the sigwaitinfo(). Quite possibly doing waitpid() for
> both of them will suffice.
Thank you. I will try to fix it.

Thanks,
Cui Bixuan
