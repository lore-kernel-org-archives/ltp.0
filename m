From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 May 2021 16:16:47 +0200
Subject: [LTP] [PATCH 2/3 v2] syscalls/chown: Rewrite chown/chown04.c
 with the new api
In-Reply-To: <20210430094513.162499-3-xieziyao@huawei.com>
References: <20210430094513.162499-1-xieziyao@huawei.com>
 <20210430094513.162499-3-xieziyao@huawei.com>
Message-ID: <YJAFz/tdPN6GWCWl@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 2. Add MAP_PRIVATE_EXCEPT_UCLINUX to SAFE_MMAP() for uClinux systems:
>    mmap() doesn't support MAP_PRIVATE on uClinux systems, so use
>    MAP_PRIVATE_EXCEPT_UCLINUX instead, which will skip the option on uClinux.
>    If MAP_PRIVATE really is required, the test can not be run on uClinux.

We no longer support uClinux, just remove the support from the test as
well.

-- 
Cyril Hrubis
chrubis@suse.cz
