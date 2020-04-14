From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Tue, 14 Apr 2020 08:45:36 +0000
Subject: [LTP] LTP testcase analysis
Message-ID: <MAXPR0101MB14684E021A23A6B00ED69DC0EEDA0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am running LTP on x86 with 5.4.3 kernel.i gave $ ./runltp command to run the complete LTP but found some failures,like oom01,futex_wait05,select04 etc.

When i tried to run single test some of them turns into PASS which earlier got failed.like oom01 was failed then i gave coomand $./runltp -s oom01 and after that it got pass.

why it could be happened,any specific reason,if you know please suggest??


Thanks!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200414/f59e1c1f/attachment.htm>
