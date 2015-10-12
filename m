From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Oct 2015 12:23:30 +0200
Subject: [LTP] [PATCH] inotify06: kernel version fix
In-Reply-To: <1444400804-3658-1-git-send-email-chnyda@suse.com>
References: <1444400804-3658-1-git-send-email-chnyda@suse.com>
Message-ID: <20151012102330.GA16397@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> inotify06 is a regression test for kernels >= 4.2.
> Add a condition so that only >= 4.2 kernels can run the test
> because previous kernel are likely to crash because of the test.

No, it's a regression test for a bug that was fixed in 4.2 and
backported to stable kernel branches. It's okay that it brings down
unpatched kernels, since they are buggy and should be updated.

-- 
Cyril Hrubis
chrubis@suse.cz
