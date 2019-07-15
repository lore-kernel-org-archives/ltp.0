From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Jul 2019 18:00:10 +0200
Subject: [LTP] [PATCH] syscalls/acct02.c: Read threshold from
 /proc/sys/kernel/acct
In-Reply-To: <1563203796-22102-1-git-send-email-ice_yangxiao@163.com>
References: <1563203796-22102-1-git-send-email-ice_yangxiao@163.com>
Message-ID: <20190715160010.GA30303@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Don't use hardcoded threshold(default 4%) to check free space
> because it can be changed by writing "/proc/sys/kernel/acct"
> or using sysctl.

Good catch, I missed the sysctl API since I haven't realized that the
proc handlers are all stuffed in a different file in kernel/sysctl.c.

What about we as well temporarily lower the value if needed while the
test is running?

-- 
Cyril Hrubis
chrubis@suse.cz
