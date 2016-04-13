From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 13 Apr 2016 15:05:43 +0800
Subject: [LTP] question about running input testcase
Message-ID: <570DEFC7.4080300@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cedric!

When we run input04 on RHEL 5.11GA and 6.7GA, it still fails. It gives
error message like this:

input04 0 TINFO : Found uinput dev at /dev/uinput
input04 0 TINFO : Unexpected ev type=0 code=0 value=0
input04 1 TFAIL : input04.c:65: Data received /dev/inputX

I think that this failure is because kernel sends empty events. i.e
If we only send EV_SYN to input device, nothing should be received in
/dev/input/eventX.
Actually, data is received in /dev/input/eventX. This investigation
shows that it may be
improved by following patch: 'commit 4369c64c79a2 ("Input: Send events
one packet at a time")'.

Could tell me the real reason for the case failure. I'm just not
familiar enough with the code.

Regards,
Xiao Yang


