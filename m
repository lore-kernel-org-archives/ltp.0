From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Aug 2021 11:38:39 +0200
Subject: [LTP] [PATCH] include/tst_test: Expose tst_tmpdir and tst_rmdir
 to newlib tests.
In-Reply-To: <20210805062812.7363-1-zhanglianjie@uniontech.com>
References: <20210805062812.7363-1-zhanglianjie@uniontech.com>
Message-ID: <YQuxn5BTaEBKw4/v@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The test temporary temporary directory is created in the test library
when the .needs_tmpdir flag is set and these functions are not exported
to new library API for this reason.

-- 
Cyril Hrubis
chrubis@suse.cz
