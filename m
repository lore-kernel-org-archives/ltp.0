From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Sep 2017 15:11:46 +0200
Subject: [LTP] keyctl tests failing with EDQUOT
In-Reply-To: <5c79ec8d-d93c-8588-5a94-ee09381de256@cn.fujitsu.com>
References: <20170926155802.GG4884@rei.lan>
 <5c79ec8d-d93c-8588-5a94-ee09381de256@cn.fujitsu.com>
Message-ID: <20170927131146.GB25847@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The keyctl03 and sometimes keyctl05 fails with EDQUOT when executed
> > right after keyctl02 which creates and revokes keys in the loop and also
> > adjusts the quota temporarily. It fails for me on kernel 3.16 inside of
> > a qemu virtual machine. Looks like the keys are not deleted after the
> > keyctl02 test exits. Have anybody seen a failure like this one?
> > 
> 
> I tested on RHEL7.4GA(Kernel 3.10.0-693.el7.x86_64) in my virtual
> machine and physical machine, keyctl03 right after keyctl02 or
> keyctl05 right after keyctl02, both worked well.

I've managed to reproduce it on 3.12 as well. The problem is visible on
SLES12 SP1 as well as Debian 8.8.

> On mainline kernel 3.16, keyctl02 and keyctl03 triggered the bug
> and crashed the system.

You have to have the patch that fixes the kernel crash backported
obviously, which happens mostly for distribution maintained kernels.

The question is if we care enough about these failures to do something
about them before the release. I guess that we do not.

-- 
Cyril Hrubis
chrubis@suse.cz
