From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Wed, 29 Apr 2020 13:56:41 +0000
Subject: [LTP] LTP driver testsuite
Message-ID: <BM1PR01MB22279080FA97CD05A583FA0CEEAD0@BM1PR01MB2227.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I am running LTP on risc V on 5.4.3 with custom distro but all the driver related tests are getting skipped,
saying  Failed to find module.

e.g. when i am running block_dev then the test is getting skipped with the error msg like
block_dev    1  TCONF  :  tst_module.c:69: Failed to find module 'ltp_block_dev.ko'
block_dev    2  TCONF  :  tst_module.c:69: Remaining cases not appropriate for configuration
<<<execution_status>>>
same msg when running other tests like tbio,rtc,zram01 etc.

why tests are getting,what could be reason??


Thanks!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200429/46c6bfca/attachment.htm>
