From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Mar 2016 20:13:58 +0200
Subject: [LTP] [PATCH] input: add kernel version check
In-Reply-To: <56EBC7EA.1000703@cn.fujitsu.com>
References: <1455874725-31499-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160222111826.GA5704@rei.lan> <56EBC7EA.1000703@cn.fujitsu.com>
Message-ID: <20160331181358.GH21298@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> In this test case, the functionality of input has been improved by
> >> following patch:
> >> 'commit 4369c64c79a2 ("Input: Send events one packet at a time")'.
> >> So it's not appropriate for testing on kernels that are lower than
> >> 3.7.0 anymore.
> > Are you sure that you have pointed out right commit? The commit
> > description does not seem relevant.
> >
> > Also can you please describe why the testcases fail before 3.7.0 and
> > how? Does kernel send empty sync events?
> >
> Hi!
> When we run input04 on RHEL 5.11GA and 6.7GA, it still fails. It gives 
> error message like this:
> 
> input04 0 TINFO : Found uinput dev at /dev/uinput
> input04 0 TINFO : Unexpected ev type=0 code=0 value=0
> input04 1 TFAIL : input04.c:65: Data received /dev/inputX
> 
> This failure is because kernel sends empty events. i.e
> If we only send EV_SYN to input device, nothing should be received in 
> /dev/input/eventX.
> Actually, data is received in /dev/input/eventX. This investigation 
> shows that it may be
> improved by following patch:
> 'commit 4369c64c79a2 ("Input: Send events one packet at a time")'.
> 
> Do you think so ?

How did you figured out that this exact commit changes the behavior?
Have you bisected it? Have you asked kernel developers?

I've looked at the input core for a while now and at the patch as well
but it's not clear to me that this commit changed the behavior in this
way. It may have, but I'm just not familiar enough with the code to say
it for certain.

-- 
Cyril Hrubis
chrubis@suse.cz
