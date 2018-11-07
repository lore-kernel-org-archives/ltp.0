From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 7 Nov 2018 18:33:44 +0800
Subject: [LTP] Question about the usage of tst_brk()
Message-ID: <5BE2BF88.3090902@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan, Cyril

From old library(i.e. test.h), it seems that only TFAIL, TBROK and TCONF
are supported by tst_brkm().

From new library, are only TFAIL, TBROK and TCONF are supported by
tst_brk() as well?
I am not sure if tst_brk()should support TWARN.

Best Regards,
Xiao Yang


