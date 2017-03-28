From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 10:34:11 +0200
Subject: [LTP] [PATCH] commands/keyctl01: Add new regression test
In-Reply-To: <58DA06C2.6050703@cn.fujitsu.com>
References: <1489576439-15122-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170327134232.GA21272@rei.lan> <58DA06C2.6050703@cn.fujitsu.com>
Message-ID: <20170328083411.GB1045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Yes, it is necessary, without the sleep, this test fails to
> reproduce the bug on RHEL7.2GA(buggy kernel), since I found
> that it actually takes some time to free the key.
> 
> 
> With 100ms sleep, the whole test takes about 2s.

Two seconds is not that bad but can we make it faster? Does the test
still reproduce the issue when we decrease the sleep a bit?

-- 
Cyril Hrubis
chrubis@suse.cz
