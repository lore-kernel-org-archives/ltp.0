From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Feb 2021 09:30:15 +0100
Subject: [LTP] [PATCH] syscalls/ioctl: Remove requirement of loop driver
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB40387A866@dggeml511-mbs.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB40387A866@dggeml511-mbs.china.huawei.com>
Message-ID: <YDixlxtJN/sgu/2l@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > 1) I think .needs_driver can parse either CONFIG_BLK_DEV_LOOP=y or
> > CONFIG_BLK_DEV_LOOP=m correctly.
> >      Do you have any issue that .needs_driver cannot parse
> 
> I known the reason why test fail and report TCONF, there is no file modules.builtin on my system.

Then I would say that your system is broken.

-- 
Cyril Hrubis
chrubis@suse.cz
