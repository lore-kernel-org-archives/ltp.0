Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UhEoV-00040I-JU
	for ltp-list@lists.sourceforge.net; Tue, 28 May 2013 07:59:23 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UhEoP-0002Nt-5z
	for ltp-list@lists.sourceforge.net; Tue, 28 May 2013 07:59:23 +0000
Date: Tue, 28 May 2013 03:59:10 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <603409954.8691174.1369727950680.JavaMail.root@redhat.com>
In-Reply-To: <1369712528-9454-1-git-send-email-shuang.qiu@oracle.com>
References: <1369712528-9454-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mmapstress10:Close the file descriptor
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
> Sent: Tuesday, 28 May, 2013 5:42:08 AM
> Subject: [LTP]  [PATCH] mmapstress10:Close the file descriptor
> 
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> It does not close the file descriptor before return 1 in fileokey()
> function which may cause the following warning with nfs as TMPDIR:
> 0  TWARN  :  tst_rmdir: rmobj(/mnt/nfsv3/ltp-SDrfq17456/mmaq7TOqt)
> failed:
> unlink(/mnt/nfsv3/ltp-SDrfq17456/mmaq7TOqt/.nfs000000000110cb3600000004)
> failed; errno=16: Device or resource busy
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>

Looks good to me.
commit 76a720a381f351b33eb203c7c519e6f44bbe7219 added some to error paths,
but missed this one.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

> ---
>  testcases/kernel/mem/mmapstress/mmapstress10.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/mem/mmapstress/mmapstress10.c
> b/testcases/kernel/mem/mmapstress/mmapstress10.c
> index baddaff..8ee7c87 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress10.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress10.c
> @@ -876,6 +876,7 @@ int fileokay(char *file, uchar_t * expbuf)
>  		}
>  	}
>  
> +	close(fd);
>  	return 1;
>  }
>  
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
