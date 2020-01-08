From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jan 2020 16:25:44 +0100
Subject: [LTP] LTP Release plans
In-Reply-To: <c3c2588b-edc5-ddeb-eb0d-992041d4ff67@cn.fujitsu.com>
References: <20191213125435.GB20795@rei.lan> <20200106150329.GC26880@rei.lan>
 <c3c2588b-edc5-ddeb-eb0d-992041d4ff67@cn.fujitsu.com>
Message-ID: <20200108152544.GC31750@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Yes. I also sent a pipe test[1]to ltp(it has undefined F_GETPIPE_SZ 
> error on old kernel [2]and I will fix it in v2), as below:
> syscalls/pipe12: add new test for piep when write bytes > PIPE_BUF

I will have a look.

> Also, Cypresslin has a pull[3] about syscalls/statx05: add mkfs.ext4 
> package version check.

The patch works only on debian, and I do not see a v2 there, so this has
to wait.

-- 
Cyril Hrubis
chrubis@suse.cz
