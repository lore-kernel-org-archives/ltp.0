From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Mar 2019 13:22:32 +0100
Subject: [LTP] [PATCH v2 1/3] syscalls/tgkill01: add new test
In-Reply-To: <1552457573-1354-2-git-send-email-sumit.garg@linaro.org>
References: <1552457573-1354-1-git-send-email-sumit.garg@linaro.org>
 <1552457573-1354-2-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190314122232.GA17823@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The test itself looks good, my only concern is actually that checkpoints
cannot be used for the keeping the thread asleep during the test.
However I can easily add one function to the futex library:

TST_CHECKPOINT_SLEEP(id)

That would cause the thread to wait on the checkpoint until:

* we were woken up
* we timeouted

Which would basically loop on tst_checkpoint_wait() and retry in case of
EINTR.

Maybe it would be a good idea to retry on EINTR in the
TST_CHECKPOINT_WAIT(), then we could easily use that one here as well.
I'm not sure though if there are tests that depends on checkpoints being
interrupted by signals though, I would have to check.

For the second part we already have a function to wake all threads
waiting on checkpoint, but we have to specify exact number of threads to
wait for, which is there in order to avoid race coditions (i.e. thread
was not sleeping yet at the time we tried to wake it). So we would have
to count the number of threads we want to wake before the call to the
TST_CHECKPOINT_WAKE2().

-- 
Cyril Hrubis
chrubis@suse.cz
