From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Aug 2020 16:16:38 +0200
Subject: [LTP] [PATCH v1 0/3] increase msgrcv coverage
In-Reply-To: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200813141638.GF13292@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1. The first patch add check for msg_lrpid and msg_rtime.
> 2. The second patch tests different msgtyp.
> 3. The third patch tests MSG_COPY flag(basic error test),not functional
> test because kernel selftest[1] has tested this.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/ipc/msgque.c

Looking at the code there it actually does not seem to be automated
test, so I think that we should include a test for MSG_COPY in LTP.

We can put a simple one into msgrcv07 we would call msgrcv() with
MSG_COPY if we got an EINVAL we will skip the test since MSG_COPY is not
supported.

Otherwise msgrcv with id 0 and 1 should retrieve our two messages, so we
would check that the data are correct, then we would check that there
are still two messages queue in the queue, we can do that with msgctl()
and/or read them with regular msgrcv.

-- 
Cyril Hrubis
chrubis@suse.cz
