From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 16:45:24 +0100
Subject: [LTP] [PATCH V2 04/32] build: Add option to select libc
 implementation
In-Reply-To: <1452302060-103643-4-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-4-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202154524.GE19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There are more than glibc for C library implementation available on
> linux now a days, uclibc cloaked like glibc but musl e.g. is very
> different and does not implement all GNU extentions
> 
> Disable tests specifically not building _yet_ on musl based systems

What should be done, instead of this musl specific hacks, is to add
configure checks for the features that are not supported on musl and
uses these as criteria for disabling the testcases. This will work
correctly for any libc implementaion and the testcases will be enabled
automatically if musl decides to actually implement anything that is not
supported at the moment.

-- 
Cyril Hrubis
chrubis@suse.cz
