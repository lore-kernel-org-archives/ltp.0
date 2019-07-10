From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Jul 2019 11:11:50 +0200
Subject: [LTP] [PATCH v2] rcu/rcu_torture.sh: Rewrite test
In-Reply-To: <5D25788A.6040506@cn.fujitsu.com>
References: <7ad6c506-e195-db0d-3b2b-a30b95c42f8a@oracle.com>
 <1559922050-15221-1-git-send-email-ice_yangxiao@163.com>
 <20190709154536.GA8195@rei.lan> <5D25788A.6040506@cn.fujitsu.com>
Message-ID: <20190710091150.GA30934@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also I guess that some modprobe implementations may not support
> > --first-time e.g. busybox.
> Is there any way to check if rcutorture is only built as a module?

I guess that we can try to instert the module and then remove it and if
both works fine the module does exists and it's not build in.

-- 
Cyril Hrubis
chrubis@suse.cz
