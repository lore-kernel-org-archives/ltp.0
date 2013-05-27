Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UgrgO-0001Jr-59
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 07:17:28 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UgrgJ-00045M-BV
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 07:17:26 +0000
Date: Mon, 27 May 2013 03:17:16 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1819201728.7770590.1369639036314.JavaMail.root@redhat.com>
In-Reply-To: <1369636182-4730-1-git-send-email-shuang.qiu@oracle.com>
References: <1369636182-4730-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Unmap the mapped address region
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
To: shuang qiu <shuang.qiu@oracle.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "shuang qiu" <shuang.qiu@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 27 May, 2013 8:29:42 AM
> Subject: [LTP]  [PATCH] Unmap the mapped address region
> 
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> It does not unmap the mapped address region,so we sometimes still get
> such
> warning when cleanup with nfs as TMPDIR although the file descriptor is
> closed:
> 0  TWARN  :  tst_rmdir: rmobj(/mnt/nfsv3/ltp-MOeIFH7102/vma4FwRqb)
> failed:
> unlink(/mnt/nfsv3/ltp-MOeIFH7102/vma4FwRqb/.nfs000000000110cb3600000001)
> failed; errno=16: Device or resource busy
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>

Looks good to me. Useful also when test loops.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

> ---
>  testcases/kernel/mem/vma/vma03.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/mem/vma/vma03.c
> b/testcases/kernel/mem/vma/vma03.c
> index 54f605a..6af9960 100644
> --- a/testcases/kernel/mem/vma/vma03.c
> +++ b/testcases/kernel/mem/vma/vma03.c
> @@ -101,8 +101,10 @@ int main(int argc, char *argv[])
>  				tst_resm(TPASS, "mremap failed as expected.");
>  			else
>  				tst_resm(TFAIL | TERRNO, "mremap");
> +			munmap(map, pgsz);
>  		} else {
>  			tst_resm(TFAIL, "mremap succeeded unexpectedly.");
> +			munmap(remap, 2 * pgsz);
>  		}
>  
>  		close(fd);
> --
> 1.7.7
> 
> 
> ------------------------------------------------------------------------------
> Try New Relic Now & We'll Send You this Cool Shirt
> New Relic is the only SaaS-based application performance monitoring service
> that delivers powerful full stack analytics. Optimize and monitor your
> browser, app, & servers with just a few lines of code. Try New Relic
> and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
