From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Jan 2017 11:37:58 +0100
Subject: [LTP] Building LTP despite failures
In-Reply-To: <b375a149-eda4-7179-1e5e-99240494b321@synopsys.com>
References: <b375a149-eda4-7179-1e5e-99240494b321@synopsys.com>
Message-ID: <20170118103758.GB29948@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We use LTP regularly to check the health of ARC Linux. One the pain points have
> been out of tree patches to LTP to avoid building lot of stuff which are either
> not provided by C library (say uClibc) or not configured in uClibc etc.

The obvious answer is here are:

* If there is a functionality not provided by you C library you should
  write a configure check like we do for many testcases already which
  is something that could most likely be then accepted upstream

* There is also some added support for skipping test compilation under
  UCLIBC, see testcases/kernel/syscalls/Makefile that skips profil
  directory if UCLIBC has been defined for build. We may add more if
  there are features not provided by the uClibc library.

-- 
Cyril Hrubis
chrubis@suse.cz
