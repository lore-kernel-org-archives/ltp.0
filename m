From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Apr 2021 16:16:43 +0200
Subject: [LTP] [PATCH v2] syscalls/getdents01: Add close() and open() at
 the end of run()
In-Reply-To: <20210425012240.6328-1-zhaogongyi@huawei.com>
References: <20210425012240.6328-1-zhaogongyi@huawei.com>
Message-ID: <YIbLS2DDXuiT/Owi@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When the test run with the option of '-i', we need call close
> and open at the end of run(), otherwist the test will fail,as follows:
> 
> $ getdents01 -i 2

Pushed thanks.

Also I've found another bug that breaks the test with large enough -i
parameter. We do increment the dirp in the do {} while loop at the end,
so after a few interations we get out of the buffer and the call fails
with EFAULT.

I've fixed that in a subsequent patch.

-- 
Cyril Hrubis
chrubis@suse.cz
