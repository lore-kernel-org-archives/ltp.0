From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Sep 2021 14:57:21 +0200
Subject: [LTP] [PATCH] gettid:Convert gettid01 to new API
In-Reply-To: <20210831024617.246758-1-threefifteen.wangkunfeng@huawei.com>
References: <20210831024617.246758-1-threefifteen.wangkunfeng@huawei.com>
Message-ID: <YS94sad/CSdCWaoA@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks good, apart from the license.

Also we should try to validate the tid. I guess that we can do that by
sending a signal and making sure that it has arrived. That could be done
by something as tgkill(getpid(), TST_RET, SIGUSR1); after setting up an
handler for SIGUSR1 that sets a flag if called and then checking if the
flag has been set after we have send the signal.

Also I guess that in the simple case that the process runs a single
thread the pid is the same as tid. We would have to clone a new process
with CLONE_THREAD and run the test from the cloned thread in order to
have the tid different from the pid in order to test the getpid() !=
gettid() case.

-- 
Cyril Hrubis
chrubis@suse.cz
