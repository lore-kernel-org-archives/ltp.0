From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Jun 2016 14:47:24 +0200
Subject: [LTP] [PATCH 2/3] syscalls/pipe02: Cleanup && convert to new API
In-Reply-To: <1464058556-7675-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1464058556-7675-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1464058556-7675-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160601124724.GD19762@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* The SAFE_FORK() cannot fail

* Used checkpoints for synchronization instead of SIGUSR1

* Report failure if child wasn't signaled

-- 
Cyril Hrubis
chrubis@suse.cz
