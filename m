From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Mar 2020 02:20:33 +0100
Subject: [LTP] [PATCH V2 2/2] syscalls/clone3: New tests
In-Reply-To: <20200319161834.4hdz4q75yyk4cfy2@vireshk-i7>
References: <cover.1584618969.git.viresh.kumar@linaro.org>
 <c64b9c05053d500a95cc920e332fa229085217b6.1584618969.git.viresh.kumar@linaro.org>
 <20200319230111.GC29386@yuki.lan>
 <20200319151956.3rwix5oint6cmt4f@vireshk-i7>
 <20200319232426.GD29386@yuki.lan>
 <20200319161834.4hdz4q75yyk4cfy2@vireshk-i7>
Message-ID: <20200320012033.GC1430@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> What's happening is that parent is able to send the signal before the
> child calls pause() and so it hangs. If I simply remove pause() it all
> works fine for me, but is pidfd_send_signal() synchronous ? Does it
> wait until the time child signal is executed ? If yes, then we don't
> have a problem, else we may run into timing issue.
> 
> We can add a delay in parent before sending the signal, but that is
> still racy in worst cases.

In that case we can add a loop over a volatile varible changed from the
signal handler with a short usleep. Something as:

static volatile int wait_for_signal;

The do_child() would do:

	wait_for_signal = 1;

	TST_CHECKPOINT_WAKE(..);

	while (wait_for_signal)
		usleep(100);


And the handler would do:

	wait_for_signal = 0;

-- 
Cyril Hrubis
chrubis@suse.cz
