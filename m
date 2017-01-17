From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Tue, 17 Jan 2017 11:25:14 -0800
Subject: [LTP] Building LTP despite failures
Message-ID: <b375a149-eda4-7179-1e5e-99240494b321@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

We use LTP regularly to check the health of ARC Linux. One the pain points have
been out of tree patches to LTP to avoid building lot of stuff which are either
not provided by C library (say uClibc) or not configured in uClibc etc. It seems
we can't use make -k to keep ignoring errors and continue with whatever can be
built. I'm not too bright with makefiles so perhaps there is something I'm missing.
Do people have ideas or have solved this already with LTP.

Thx,
-Vineet
