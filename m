From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Jun 2021 22:06:29 +0200
Subject: [LTP] [PATCH 2/3] syscalls/sendfile: Convert sendfile06 to the
 new API
In-Reply-To: <20210603033611.15619-3-xieziyao@huawei.com>
References: <20210603033611.15619-1-xieziyao@huawei.com>
 <20210603033611.15619-3-xieziyao@huawei.com>
Message-ID: <YMurRVXwyvKXnkjj@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

> 1. Convert sendfile06 to the new API with file descriptors instead
> of socket descriptors.
I wonder if this is ok, suppose yes, but better if other check.

> 2. Remove the support for UCLINUX.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +	TEST(sendfile(out_fd, in_fd, NULL, sb.st_size));
> +	after_pos = SAFE_LSEEK(in_fd, 0, SEEK_CUR);
> +
> +	if (TST_RET != sb.st_size)
nit: checkpatch.pl complains, it should be if (sb.st_size != TST_RET)
(can be fixed during merge)

Kind regards,
Petr
