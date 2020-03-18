From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Wed, 18 Mar 2020 07:29:56 +0000
Subject: [LTP] LTP build failure
Message-ID: <MAXPR0101MB1468D80C07532533C7698F85EEF70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I am trying to build LTP on x86 i am facing following issue,can someone please help me out to figure it??


root@LAPTOP-NQBOH0V5:/home/pankaj/pankaj_work/exaleap_ltp/ltp# make
/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/env_pre.mk:111: /home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/config.mk: No such file or directory
/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/env_pre.mk:112: /home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/features.mk: No such file or directory
make -C /home/pankaj/pankaj_work/exaleap_ltp/ltp help; false
make[1]: Entering directory '/home/pankaj/pankaj_work/exaleap_ltp/ltp'
Please read the Configuration section in /home/pankaj/pankaj_work/exaleap_ltp/ltp/INSTALL
Makefile:198: recipe for target 'help' failed
make[1]: *** [help] Error 1
make[1]: Leaving directory '/home/pankaj/pankaj_work/exaleap_ltp/ltp'
/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/automake.mk:115: recipe for target '/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/features.mk' failed
make: *** [/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/features.mk] Error 1
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200318/bef42c88/attachment.htm>
