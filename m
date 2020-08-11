From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Aug 2020 15:19:18 +0200
Subject: [LTP] [PATCH v2] ipc/msgrcv0*: cleanup && convert to new API
In-Reply-To: <1594962618-26004-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1593001917-11075-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1594962618-26004-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200811131918.GB27583@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Good work, applied with a minor changes, thanks.

* Used exit() instead of _exit() unless in signal handler

* Added linux-git tag to struct tst_test for msgrcv08

-- 
Cyril Hrubis
chrubis@suse.cz
