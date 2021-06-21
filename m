From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Jun 2021 15:17:07 +0200
Subject: [LTP] [PATCH 7/7] io_submit01: Add docparse formatting and more
 detailed description
In-Reply-To: <20210618094210.183027-8-xieziyao@huawei.com>
References: <20210618094210.183027-1-xieziyao@huawei.com>
 <20210618094210.183027-8-xieziyao@huawei.com>
Message-ID: <YNCRU7dN7puCLcSp@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * 1. io_submit fails and returns -EINVAL if ctx is invalid.
> + * 2. io_submit fails and returns -EINVAL if nr is invalid.
> + * 3. io_submit fails and returns -EFAULT if iocbpp pointer is invalid.
> + * 4. io_submit fails and returns -EBADF if fd is invalid.
> + * 5. io_submit() succeeds and returns the number of iocbs submitted.
> + * 6. io_submit() succeeds and returns 0 if nr is zero.

Did the same change here and pushed as well, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
