From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 May 2021 11:18:28 +0200
Subject: [LTP] [PATCH 1/2] syscalls/sendfile: Convert sendfile08 to the
 new API
In-Reply-To: <20210519084655.52780-2-xieziyao@huawei.com>
References: <20210519084655.52780-1-xieziyao@huawei.com>
 <20210519084655.52780-2-xieziyao@huawei.com>
Message-ID: <YKTX5BrGO9FT44Wf@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -/*
> +/*\
> + * [Description]
> + *
>   * Bug in the splice code has caused the file position on the write side
>   * of the sendfile system call to be incorrectly set to the read side file
>   * position. This can result in the data being written to an incorrect offset.
>   *
> - * This is a regression test for kernel commit
> - * 2cb4b05e7647891b46b91c07c9a60304803d1688
> + * This is a regression test for kernel commit 2cb4b05e7647.
                                                    ^
						    This should be added
						    to the tst_test
						    structure as a tags
						    as well.

-- 
Cyril Hrubis
chrubis@suse.cz
