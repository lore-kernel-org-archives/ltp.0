From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2021 14:33:56 +0100
Subject: [LTP] [PATCH v2] syscalls/ipc: semctl07: Convert to new API and
 cleanup
In-Reply-To: <1611826857-21076-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1611826857-21076-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <YBK9RHrxEUI04S44@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two minor changes, thanks.

> +	if ((status = semctl(semid, 0, GETVAL)) == -1)

Since these calls are supposed to return positive value I've changed
this condition to foo() < 0 instead.

> +		tst_res(TFAIL, "semctl(GETVAL) failed errno = %d", errno);

And changed these to use TERRNO instead.

-- 
Cyril Hrubis
chrubis@suse.cz
