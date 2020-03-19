From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 19 Mar 2020 21:48:34 +0530
Subject: [LTP] [PATCH V2 2/2] syscalls/clone3: New tests
In-Reply-To: <20200319232426.GD29386@yuki.lan>
References: <cover.1584618969.git.viresh.kumar@linaro.org>
 <c64b9c05053d500a95cc920e332fa229085217b6.1584618969.git.viresh.kumar@linaro.org>
 <20200319230111.GC29386@yuki.lan>
 <20200319151956.3rwix5oint6cmt4f@vireshk-i7>
 <20200319232426.GD29386@yuki.lan>
Message-ID: <20200319161834.4hdz4q75yyk4cfy2@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20-03-20, 00:24, Cyril Hrubis wrote:
> Huh? All that we have to is to move the code from the child_rx_signal()
> to the do_child() here, the child would setup a handler and call
> pause(), then it checks if correct values have been stored to a global
> varibles. And the same for the parent, the point is that we should do a
> minimal amount of work in the handler itself.

There is a problem with using pause() here.

Child is doing this:

static void do_child(int clone_pidfd, int n)
{
	SAFE_SIGACTION(CHILD_SIGNAL, &csig_action, NULL);

	TST_CHECKPOINT_WAKE(0);
	pause();
	TST_CHECKPOINT_WAIT(1);

	if (child_received_signal)
		tst_res(TPASS, "clone3() passed: Child received correct signal (index %d)", n);

        exit(0);
}

and parent:

        TST_CHECKPOINT_WAIT(0);

        TEST(pidfd_send_signal(pidfd, CHILD_SIGNAL, &uinfo, 0));
        if (TST_RET != 0) {
                tst_res(TFAIL | TTERRNO, "pidfd_send_signal() failed");
                return;
        }

        TST_CHECKPOINT_WAKE(1);


What's happening is that parent is able to send the signal before the
child calls pause() and so it hangs. If I simply remove pause() it all
works fine for me, but is pidfd_send_signal() synchronous ? Does it
wait until the time child signal is executed ? If yes, then we don't
have a problem, else we may run into timing issue.

We can add a delay in parent before sending the signal, but that is
still racy in worst cases.

-- 
viresh
