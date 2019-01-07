From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jan 2019 14:34:47 +0100
Subject: [LTP] [PATCH v3 3/3] lib/tst_test.c: Convert TFAIL to TWARN in
 test cleanup
In-Reply-To: <1544690160-13900-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20181211151733.GC1180@rei>
 <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1544690160-13900-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20190107133447.GB15221@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1) Both TBROK and TFAIL should be converted to TWARN in test cleanup.

Do we actually produce TFAIL somewhere in the test cleanups?

Actually producing TPASS or TFAIL in test cleanup sounds wrong to me.

> 2) Add a hint for the conversion.

I do not think that this very useful. Jan what do you think?

-- 
Cyril Hrubis
chrubis@suse.cz
