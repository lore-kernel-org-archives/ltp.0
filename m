From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Thu, 5 Aug 2021 17:41:21 +0800
Subject: [LTP] [PATCH] include/tst_test: Expose tst_tmpdir and tst_rmdir
 to newlib tests.
In-Reply-To: <YQuxn5BTaEBKw4/v@yuki>
References: <20210805062812.7363-1-zhanglianjie@uniontech.com>
 <YQuxn5BTaEBKw4/v@yuki>
Message-ID: <50d2c17f-bfd8-0ce9-2c25-bb30521709f3@uniontech.com>+58910C767557FFCC
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Oh i see, thank you.

? 2021/8/5 17:38, Cyril Hrubis ??:
> Hi!
> The test temporary temporary directory is created in the test library
> when the .needs_tmpdir flag is set and these functions are not exported
> to new library API for this reason.
> 


