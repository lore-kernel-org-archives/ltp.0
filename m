Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Us8Wy-0001ER-IN
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 09:30:20 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Us8Ww-0003YA-Ks
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 09:30:20 +0000
Date: Thu, 27 Jun 2013 05:30:09 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <713408139.533295.1372325409445.JavaMail.root@redhat.com>
In-Reply-To: <1372322290-21498-1-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1372322290-21498-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] aio02: remove test for aio_fsync() and
	aio_fdsync()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "LTP" <ltp-list@lists.sourceforge.net>
> Cc: "Cyril Hrubis" <chrubis@suse.cz>, "Caspar Zhang" <caspar@casparzhang.com>, "Garrett Cooper" <yanegomi@gmail.com>,
> "Mike Frysinger" <vapier@gentoo.org>, jstancek@redhat.com, "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> Sent: Thursday, 27 June, 2013 10:38:10 AM
> Subject: [PATCH] aio02: remove test for aio_fsync() and aio_fdsync()
> 
> Linux filesystems doesn't support aio_fsync() and aio_fdsync()
> operations, so just remove test for these two.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Looks good to me.

Regards,
Jan


> ---
>  testcases/kernel/io/aio/aio02/aio_tio.c | 34
>  ---------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/testcases/kernel/io/aio/aio02/aio_tio.c
> b/testcases/kernel/io/aio/aio02/aio_tio.c
> index 9dda462..34fa9ed 100644
> --- a/testcases/kernel/io/aio/aio02/aio_tio.c
> +++ b/testcases/kernel/io/aio/aio02/aio_tio.c
> @@ -111,8 +111,6 @@ int io_tio(char *pathname, int flag, int n, int
> operation)
>  	for (i = 0; i < AIO_MAXIO; i++) {
>  
>  		switch (operation) {
> -		case IO_CMD_FSYNC:
> -		case IO_CMD_FDSYNC:
>  		case IO_CMD_PWRITE:
>  			if (posix_memalign(&bufptr, alignment, AIO_BLKSIZE)) {
>  				perror(" posix_memalign failed ");
> @@ -179,22 +177,6 @@ int io_tio(char *pathname, int flag, int n, int
> operation)
>  			}
>  		}
>  		break;
> -	case IO_CMD_FSYNC:
> -		for (i = 0; i < AIO_MAXIO; i++) {
> -			res = io_fsync(myctx, iocbps[i], work_done, fd);
> -			if (res < 0) {
> -				io_error("io_fsync write", res);
> -			}
> -		}
> -		break;
> -	case IO_CMD_FDSYNC:
> -		for (i = 0; i < AIO_MAXIO; i++) {
> -			res = io_fdsync(myctx, iocbps[i], work_done, fd);
> -			if (res < 0) {
> -				io_error("io_fsync write", res);
> -			}
> -		}
> -		break;
>  	}
>  
>  	close(fd);
> @@ -253,22 +235,6 @@ int test_main(void)
>  		return status;
>  	}
>  
> -	tst_resm(TINFO, "Running test 7 \n");
> -	status = io_tio("file2",
> -			O_TRUNC | O_DIRECT | O_WRONLY | O_CREAT | O_LARGEFILE,
> -			AIO_MAXIO, IO_CMD_FSYNC);
> -	if (status) {
> -		return status;
> -	}
> -
> -	tst_resm(TINFO, "Running test 8 \n");
> -	status = io_tio("file2",
> -			O_TRUNC | O_DIRECT | O_WRONLY | O_CREAT | O_LARGEFILE,
> -			AIO_MAXIO, IO_CMD_FDSYNC);
> -	if (status) {
> -		return status;
> -	}
> -
>  	return status;
>  }
>  
> --
> 1.8.3.1.448.gfb7dfaa
> 
> 

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
