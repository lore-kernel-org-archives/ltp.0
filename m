From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Wed, 4 Mar 2020 05:26:36 +0000
Subject: [LTP] LTP autoconfig
Message-ID: <MAXPR0101MB14687839FE18D4BC633BF475EEE50@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i have cloned git from github and going ahead with procedure i facing following problem

root@exaleapsemi:~/pankaj_ltp/ltp# make autotools
aclocal -I m4
Can't locate Exporter.pm in @INC (you may need to install the Exporter module) (@INC contains: /usr/share/automake-1.16 /usr/lib/perl5/site_perl/5.30.0/riscv64-linux /usr/lib/perl5/site_perl/5.30.0 /usr/lib/perl5/vendor_perl/5.30.0/riscv64-linux /usr/lib/perl5/vendor_perl/5.30.0 /usr/lib/perl5/5.30.0/riscv64-linux /usr/lib/perl5/5.30.0 .) at /usr/share/automake-1.16/Automake/Config.pm line 22.
Compilation failed in require at /usr/bin/aclocal line 37.
BEGIN failed--compilation aborted at /usr/bin/aclocal line 37.
make: *** [/home/root/pankaj_ltp/ltp/include/mk/automake.mk:45: aclocal.m4] Error 2


Thanks

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200304/eb9a0298/attachment.htm>
