From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 25 Apr 2017 03:52:59 -0400 (EDT)
Subject: [LTP] [PATCH 1/2] syscalls/splice04: add test for splice()
	from	pipe to pipe
In-Reply-To: <1492143621-30829-1-git-send-email-bxue@redhat.com>
References: <1492143621-30829-1-git-send-email-bxue@redhat.com>
Message-ID: <1211226225.1635207.1493106779255.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: Boyang Xue <bxue@redhat.com>
> 
> This test case covers pipe to pipe splice operation, which was introduced
> in kernel commit 7c77f0b3f920 ("splice: implement pipe to pipe splicing").
> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---
>  runtest/syscalls                            |  1 +
>  testcases/kernel/syscalls/splice/splice04.c | 98

Hi,

Needs entry also in .gitignore

> +static void pipe_pipe(void)
> +{
> +	int pp1[2], pp2[2], i, ret;
> +
> +	SAFE_PIPE(pp1);
> +	SAFE_PIPE(pp2);
> +	SAFE_WRITE(1, pp1[1], arr_in, num_len_data);

This relies on pipe capacity of certain size, which is discouraged
by man(7) pipe, but it seems pretty unlikely it will be less than 64k.
One has to override the default:

# echo 4096 > /proc/sys/fs/pipe-max-size
# sudo -u dummy ./splice04
<hangs on write>

> +	ret = splice(pp1[0], NULL, pp2[1], NULL, num_len_data, SPLICE_F_MOVE);

man(2) splice: "It transfers up to len bytes of data".
Is it really error if it moves less data?

Regards,
Jan
