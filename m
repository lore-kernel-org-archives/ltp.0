Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hakehuang@gmail.com>) id 1PDbYb-0005nB-Sd
	for ltp-list@lists.sourceforge.net; Wed, 03 Nov 2010 11:31:09 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PDbYa-0002rt-P9
	for ltp-list@lists.sourceforge.net; Wed, 03 Nov 2010 11:31:09 +0000
Received: by gxk26 with SMTP id 26so393967gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Nov 2010 04:31:03 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 3 Nov 2010 19:31:03 +0800
Message-ID: <AANLkTi=xfASFpmmRWFGMPofEBU+Uzp+TQ4OZ-vw2C_83@mail.gmail.com>
From: hake huang <hakehuang@gmail.com>
Subject: [LTP] keyutils.h not exist when cross compile
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

when I try to cross compile the ltp
git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp
make autotools
./configure --host=arm-none-linux-gnueabi
make

the build stops at keyctrl, below is the log, it looks like the ltp
now depend on the libkeyutils-dev package, should we avoid this
dependency?
/usr/local/gcc-4.4.4-glibc-2.11.1-multilib-1.0/arm-fsl-linux-gnueabi/bin/arm-none-linux-gnueabi-gcc
-DFSL_ARM=1 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/smb/vte/testcases/kernel/include -I../../../../include
-I../../../../include   -L../../../../lib  keyctl01.c   -lltp -o
keyctl01
keyctl01.c:44:22: error: keyutils.h: No such file or directory
keyctl01.c: In function 'main':
keyctl01.c:117: error: 'key_serial_t' undeclared (first use in this function)
keyctl01.c:117: error: (Each undeclared identifier is reported only once
keyctl01.c:117: error: for each function it appears in.)
keyctl01.c:117: error: expected ';' before 'ne_key'
keyctl01.c:144: error: 'ne_key' undeclared (first use in this function)
keyctl01.c:144: error: 'INT32_MAX' undeclared (first use in this function)
keyctl01.c:144: error: 'INT32_MIN' undeclared (first use in this function)
make[4]: *** [keyctl01] Error 1
make[4]: Leaving directory `/home/smb/vte/testcases/kernel/syscalls/keyctl'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/home/smb/vte/testcases/kernel/syscalls'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/smb/vte/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/smb/vte/testcases'
make: *** [testcases-all] Error 2

Regards,

Hake

------------------------------------------------------------------------------
Achieve Improved Network Security with IP and DNS Reputation.
Defend against bad network traffic, including botnets, malware, 
phishing sites, and compromised hosts - saving your company time, 
money, and embarrassment.   Learn More! 
http://p.sf.net/sfu/hpdev2dev-nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
