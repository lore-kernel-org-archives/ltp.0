From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 10:30:30 +0200
Subject: [LTP] Failing tests (aio01/aio02) show up in log file but not
 failed list
In-Reply-To: <1490715743.19074.106.camel@caviumnetworks.com>
References: <201703272218.v2RMIp4R006418@sellcey-dt.caveonetworks.com>
 <20170328122708.GE1045@rei>
 <1490715743.19074.106.camel@caviumnetworks.com>
Message-ID: <20170329083030.GA7089@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Here is the output for aio01. ??Is there an aio01 command that I am
> missing? ??It looks like this is something that should have been built
> when I built LTP but I don't see it in the install directory and I
> ??don't see any reference to it in my build output. ??I do see aio01.c
> and a Makefile for it in the source tree.

Looking into the testcases/kernel/io/Makefile the aio directories are
skipped on compilation when there are no aio libs installed instead the
more usual way where we build stubs binaries that report TCONF. May be
worth of fixing but this is not very important.

-- 
Cyril Hrubis
chrubis@suse.cz
