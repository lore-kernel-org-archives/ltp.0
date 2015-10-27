From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Oct 2015 17:35:17 +0100
Subject: [LTP] [PATCH 1/2] Optimise grep action in power_management.
In-Reply-To: <1444872089-30094-1-git-send-email-sunyuan3@huawei.com>
References: <1444872089-30094-1-git-send-email-sunyuan3@huawei.com>
Message-ID: <20151027163516.GC22962@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> root@p1:~# time (grep siblings /proc/cpuinfo > /dev/null)
> real	0m0.003s
> user	0m0.001s
> sys	0m0.002s
> root@p1:~# time (cat /proc/cpuinfo | grep siblings > /dev/null)
> real	0m0.004s
> user	0m0.002s
> sys	0m0.003s

I wouldn't say optimise in the commit message but rather simplify. Since
the difference in speed is not that big.

Otherwise the patches looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
