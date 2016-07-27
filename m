From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Jul 2016 13:45:54 +0300
Subject: [LTP] [PATCH] syscalls/fallocate04: add
 'FALLOC_FL_INSERT_RANGE' test-case
In-Reply-To: <20160726124522.GD11679@rei.lan>
References: <1466612145-13233-1-git-send-email-alexey.kodanev@oracle.com>
 <20160726124522.GD11679@rei.lan>
Message-ID: <579890E2.5010006@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 07/26/2016 03:45 PM, Cyril Hrubis wrote:
> ...
> +
> +	size_t size = buf_size;
> +	char tmp_buf[buf_size];
> +	char exp_buf[size];
> +
> +	fill_tst_buf(tmp_buf);
> +
> +	memcpy(exp_buf, tmp_buf, block_size);
> +	memcpy(exp_buf +  2 * block_size, tmp_buf + 2 * block_size,
> +	       buf_size - block_size * 2);
> +	memset(exp_buf + block_size - 1, 0, block_size + 2);
> +
> +	check_file_data(exp_buf, size);
> Why not just:
>
>          fill_tst_buf(exp_buf);
> 	memset(exp_buf + block_size - 1, 0, block_size + 2);

Correct, we returned to the state that was after test-case 3.


Thanks,
Alexey

