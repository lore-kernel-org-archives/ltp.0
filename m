From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 27 Sep 2017 16:47:41 +0800
Subject: [LTP] keyctl tests failing with EDQUOT
In-Reply-To: <20170926155802.GG4884@rei.lan>
References: <20170926155802.GG4884@rei.lan>
Message-ID: <5c79ec8d-d93c-8588-5a94-ee09381de256@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi!

在 09/26/2017 11:58 PM, Cyril Hrubis 写道:
> Hi!
> I've found another problem while doing pre-release testing.
> 
> The keyctl03 and sometimes keyctl05 fails with EDQUOT when executed
> right after keyctl02 which creates and revokes keys in the loop and also
> adjusts the quota temporarily. It fails for me on kernel 3.16 inside of
> a qemu virtual machine. Looks like the keys are not deleted after the
> keyctl02 test exits. Have anybody seen a failure like this one?
> 

I tested on RHEL7.4GA(Kernel 3.10.0-693.el7.x86_64) in my virtual
machine and physical machine, keyctl03 right after keyctl02 or
keyctl05 right after keyctl02, both worked well.

On mainline kernel 3.16, keyctl02 and keyctl03 triggered the bug
and crashed the system.


Best Regards,
Guangwen Feng



