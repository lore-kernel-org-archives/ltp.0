From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Wed, 18 Mar 2020 09:05:26 +0000
Subject: [LTP] LTP build failure
In-Reply-To: <MAXPR0101MB1468ACD2C1D67F06BB109198EEF70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB1468D80C07532533C7698F85EEF70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>,
 <CAF12kFvy41q24NOqrAbZe-2h6-q0B_0ifzDAyr3RPoVxeA5BQw@mail.gmail.com>,
 <MAXPR0101MB1468ACD2C1D67F06BB109198EEF70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <MAXPR0101MB1468457E110C4026E1EEA9C9EEF70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i yes.i did
make autotools
./configure and then i tried make but it failed with error
________________________________
From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Sent: Wednesday, March 18, 2020 2:32 PM
To: Cixi Geng <gengcixi@gmail.com>
Subject: Re: [LTP] LTP build failure

yes..i did
make autotools
./configure
make
________________________________
From: Cixi Geng <gengcixi@gmail.com>
Sent: Wednesday, March 18, 2020 2:03 PM
To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Subject: Re: [LTP] LTP build failure

HI Pankaj:
did you run ./configure before make ?
The quick start step
1. ./configure .2 make all 3. make install

Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com<mailto:Pankaj.VJ@exaleapsemi.com>> ?2020?3?18??? ??3:30???
Hi,
I am trying to build LTP on x86 i am facing following issue,can someone please help me out to figure it??


root@LAPTOP-NQBOH0V5:/home/pankaj/pankaj_work/exaleap_ltp/ltp# make
/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/env_pre.mk:111<http://env_pre.mk:111>: /home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/config.mk<http://config.mk>: No such file or directory
/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/env_pre.mk:112<http://env_pre.mk:112>: /home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/features.mk<http://features.mk>: No such file or directory
make -C /home/pankaj/pankaj_work/exaleap_ltp/ltp help; false
make[1]: Entering directory '/home/pankaj/pankaj_work/exaleap_ltp/ltp'
Please read the Configuration section in /home/pankaj/pankaj_work/exaleap_ltp/ltp/INSTALL
Makefile:198: recipe for target 'help' failed
make[1]: *** [help] Error 1
make[1]: Leaving directory '/home/pankaj/pankaj_work/exaleap_ltp/ltp'
/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/automake.mk:115<http://automake.mk:115>: recipe for target '/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/features.mk<http://features.mk>' failed
make: *** [/home/pankaj/pankaj_work/exaleap_ltp/ltp/include/mk/features.mk<http://features.mk>] Error 1

--
Mailing list info: https://lists.linux.it/listinfo/ltp
[EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200318/fb60b9a8/attachment-0001.htm>
