From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Nov 2017 15:20:44 +0100
Subject: [LTP] [PATCH] kernel/input: fix failure on an old kernel
In-Reply-To: <1507543023-21605-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1507543023-21605-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171107142043.GA32659@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On some old kernels(e.g. v2.6.32), we always triggered the following
> error when running input04 and input05:
> --------------------------------------------------------------------
> TINFO  :  Found uinput dev at /dev/uinput
> TINFO  :  Unexpected ev type=0 code=0 value=0
> TFAIL  :  Data received /dev/inputX
> ---------------------------------------------------------------------
> 
> After investigation, the single EV_SYN event can be processed on an
> old kernel.  However, the EV_SYN event handling has been modfied by
> the following patch:
> '4369c64c79a2("Input: Send events one packet at a time")'
> 
> The patch is designed to reduce the time taken for processing a lot of
> events.  As a side effect, the single EV_SYN event handling depends on
> one or more other events(e.g. EV_REL), so it should be processed
> together with others, since this action is atomic.
> 
> Only when the number of queued events(include EV_SYN) is greater than
> one can these events be processed.
> Please see the kenrel code in drivers/input/input.c, as below:
> --------------------------------------------------------------------
> static void input_handle_event(struct input_dev *dev,
> ...
>     if (disposition & INPUT_FLUSH) {
>             // num_vals: number of values queued in the current frame
>             if (dev->num_vals >= 2)
>                     input_pass_values(dev, dev->vals, dev->num_vals);
>                     dev->num_vals = 0;
> ...
> --------------------------------------------------------------------
> 
> For example, steps to send an empty move and EV_SYN:
> -----------------------------------------------------
> send_event(fd, EV_REL, REL_X, 0);
> send_event(fd, EV_SYN, 0, 0);
> -----------------------------------------------------
> 
> On an old kernel(before v3.7.0), the EV_SYN/SYN_REPORT event can be
> processed independently, so it is passed into /dev/input/eventX.
> 
> On a new kernel(since v3.7.0), the EV_SYN/SYN_REPORT event depends on
> EV_REL/REL_X which is an empty move, so it is ignored.
> 
> We feel this failure is due to the different mechanism of processing
> EV_SYN instead of a kernel bug, so we update no_events_queued() to
> fix it.

Well, I guess that we can change the tests to ignore stray sync events
on older kernels, but new ones empty sync events would be regression.

Hence we should enable the backward compatibility only on old kernels
where the tests actually fails.

-- 
Cyril Hrubis
chrubis@suse.cz
