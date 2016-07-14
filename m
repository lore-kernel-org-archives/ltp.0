From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Jul 2016 15:42:18 +0200
Subject: [LTP] Fwd: chmod06 is failing
In-Reply-To: <CAJ5vXcRKx-Qhh5fZyUHVXx96ejiOSbrN2eKSgM=i28Rp4=Abew@mail.gmail.com>
References: <CAJ5vXcQiXyc8dJkeh0K77HCmaFe5Ts-Yw+WHuK28b3iLhbKBkA@mail.gmail.com>
 <CAJ5vXcRKx-Qhh5fZyUHVXx96ejiOSbrN2eKSgM=i28Rp4=Abew@mail.gmail.com>
Message-ID: <20160714134218.GA12459@rei.scz.novell.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> root@nousi:/opt/ltp# ./testcases/bin/chmod06
> chmod06     0  TINFO  :  No free devices found
> chmod06     1  TCONF  :  chmod06.c:194: Failed to obtain block device
> chmod06     2  TCONF  :  chmod06.c:194: Remaining cases not appropriate for
> configuration
> chmod06     3  TBROK  :  chmod06.c:230: chmod(testdir_1) failed:
> errno=ENOENT(2): No such file or directory

This means that the loop device support is missing from kernel. The bug
here is that the test cleanup fails, it should not try to change a
directory that wasn't created. This part should be fixed.

> root@nousi:/opt/ltp#
> root@nousi:/opt/ltp#
> root@nousi:/opt/ltp# mknod /dev/loop-control b 7 10

This will not help you, you have to have the loop device support either
compiled in the kernel or as a module.

-- 
Cyril Hrubis
chrubis@suse.cz
