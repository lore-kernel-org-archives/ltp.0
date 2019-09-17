From: Vladut Magas <vladut.m@l4b-software.com>
Date: Tue, 17 Sep 2019 10:59:42 +0000
Subject: [LTP] Running kdump on Debian
Message-ID: <VI1PR0101MB2557E0698D03D10A8A95D71BF08F0@VI1PR0101MB2557.eurprd01.prod.exchangelabs.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

I am trying to run the kdump  testsuite on a Debian 9 distribution, but every test  fails with "vmcore NOT FOUND".
From what I understand, it is because /proc/vmcore is missing from my machine configuration.

I have the "crashkernel=256M@128M" parameter inside /etc/default/grub, and also nmi_watchdog=1.
I also have inside the kernel configuration:
CONFIG_PROC_VMCORE=y
CONFIG_DEBUG_INFO=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
and everything described in the documents as needed.

Also, for example, when trying to simulate with the SysRq it doesn't even finish as at some point it hangs and you have to close and restart manually the machine.
A snapshot is attached.

Can anyone please offer some support for this?
Nothing I found on google worked until now!

Best regards,

        Emanuel-Vladut Magas

L4B Software, Iasi, Romania
E-mail: vladut.m@l4b-software.com

[cid:92784aba-bde0-48c9-940d-44af7ece18a6]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190917/6bf98529/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Outlook-zpwbmyue.png
Type: image/png
Size: 13801 bytes
Desc: Outlook-zpwbmyue.png
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190917/6bf98529/attachment-0002.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kdump crash.png
Type: image/png
Size: 31928 bytes
Desc: kdump crash.png
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190917/6bf98529/attachment-0003.png>
