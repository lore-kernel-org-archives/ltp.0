From: Wei, Jiangang <weijg.fnst@cn.fujitsu.com>
Date: Tue, 24 Nov 2015 06:19:44 +0000
Subject: [LTP] [PATCH 1/2] kernel/io/disktest: cleanup upon failure
	occurs
In-Reply-To: <1448345330-23620-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1448345330-23620-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Message-ID: <1448345982.1818.2.camel@localhost>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Sorry for that this patch has indent problem.
Please ignore both of them.
I will resend v2.

On Tue, 2015-11-24 at 14:08 +0800, Wei Jiangang wrote:
> Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/io/disktest/dump.c | 2 ++
>  testcases/kernel/io/disktest/main.c | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/io/disktest/dump.c b/testcases/kernel/io/disktest/dump.c
> index 615e8b4..d83e571 100644
> --- a/testcases/kernel/io/disktest/dump.c
> +++ b/testcases/kernel/io/disktest/dump.c
> @@ -192,12 +192,14 @@ int do_dump(child_args_t * args)
>  		pMsg(ERR, args, "could not open %s.\n", args->device);
>  		pMsg(ERR, args, "%s: Error = %u\n", args->device,
>  		     GETLASTERROR());
> +                FREE(buff);
>  		return (-1);
>  	}
>  
>  	TargetLBA = Seek(fd, args->start_lba * BLK_SIZE);
>  	if (TargetLBA != (args->start_lba * (OFF_T) BLK_SIZE)) {
>  		pMsg(ERR, args, "Could not seek to start position.\n");
> +                FREE(buf);
>  		CLOSE(fd);
>  		return (-1);
>  	}
> diff --git a/testcases/kernel/io/disktest/main.c b/testcases/kernel/io/disktest/main.c
> index 9484ec1..050ddea 100644
> --- a/testcases/kernel/io/disktest/main.c
> +++ b/testcases/kernel/io/disktest/main.c
> @@ -501,6 +501,7 @@ test_ll_t *run()
>  			     &cleanArgs,
>  			     "%s is not a regular file, could not be opened for reading, or was not found.",
>  			     filespec);
> +                        FREE(aFilespec);
>  
>  			return newTest;
>  		}


-- 
This message has been scanned for viruses and
dangerous content by FCNIC, and is
believed to be clean.

