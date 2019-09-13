From: Vladut Magas <vladut.m@l4b-software.com>
Date: Fri, 13 Sep 2019 13:18:28 +0000
Subject: [LTP] Kdump update required
Message-ID: <VI1PR0101MB2557DC78E7B6994F8429AE11F0B30@VI1PR0101MB2557.eurprd01.prod.exchangelabs.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

I am writing to you about the kdump. I am trying to run kdump on Debian 9 (Stretch), but the "setup.sh" has a small error as you can see below, based on the error received:

  CC      /root/Desktop/ltp/testcases/kdump/lib/lkdtm/lkdtm.mod.o
  LD [M]  /root/Desktop/ltp/testcases/kdump/lib/lkdtm/lkdtm.ko
make[3]: Leaving directory '/usr/src/linux-headers-4.9.0-9-amd64'
make[2]: Leaving directory '/root/Desktop/ltp/testcases/kdump/lib/lkdtm'
make[1]: Leaving directory '/root/Desktop/ltp/testcases/kdump/lib'
+ echo Modify Boot Loader.
Modify Boot Loader.
+ [ x86_64 = ppc64 ]
+ [ x86_64 = i686 ]
+ [ x86_64 = ia64 ]
+ args=crashkernel=256M@128M
+ [ -x /sbin/grubby ]
+ echo Warn: please make sure the following arguments are in Boot Loader:
Warn: please make sure the following arguments are in Boot Loader:
+ echo crashkernel=256M@128M
crashkernel=256M@128M
+ echo Hit any key when ready.
Hit any key when ready.
+ read
./setup.sh: 105: read: arg count
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 2


In DEbian 9 there is no grubby tool and no way to install it, so the /sbin/grubby will never be found and the error will always occur. Is there something I can do about this problem?

Thank you!

Best regards,

        Emanuel-Vladut Magas

L4B Software, Iasi, Romania
E-mail: vladut.m@l4b-software.com

[cid:7b200dcc-c609-4121-9302-956d034fc458]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190913/f4cffaea/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Outlook-zupgpryx.png
Type: image/png
Size: 13801 bytes
Desc: Outlook-zupgpryx.png
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190913/f4cffaea/attachment-0001.png>
