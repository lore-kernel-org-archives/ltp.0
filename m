From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Nov 2020 13:37:51 +0100
Subject: [LTP] [PATCH v2] sycalls: select03: Make nfds use the correct
 value
In-Reply-To: <1604575034-17799-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1604575034-17799-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <20201105123751.GB10395@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When running select03 with runltp in /opt/ltp, this case failed as below:
> select03.c:52: TFAIL: Invalid readfds: select() passed unexpectedly with 0
> select03.c:52: TFAIL: Invalid writefds: select() passed unexpectedly with 0
> select03.c:52: TFAIL: Invalid exceptfds: select() passed unexpectedly with 0

Also I do not get how runltp changes the test behavior, does ltp-pan
leak file descriptors? If so it should be fixed to open files with
O_CLOEXEC.

-- 
Cyril Hrubis
chrubis@suse.cz
