Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Uflmu-0000Yv-MI
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 06:47:41 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uflmr-00056H-PT
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 06:47:40 +0000
Date: Fri, 24 May 2013 02:47:31 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1144009370.6914397.1369378051140.JavaMail.root@redhat.com>
In-Reply-To: <1369364619-24704-1-git-send-email-shuang.qiu@oracle.com>
References: <1369364619-24704-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] dup07:Close the file before unlink it.
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
> Sent: Friday, 24 May, 2013 5:03:39 AM
> Subject: [LTP] [PATCH] dup07:Close the file before unlink it.
> 
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> When unlink() a file in nfs environment,it will rename the file to a
> .nfs<xxxxx> file if any process still has that file open.And this file
> could not be deleted until it is closed.So we always get the following
> warning which makes testcase "dup07" failed:
> 0  TWARN  :  tst_rmdir: rmobj(/mnt/nfsv3/ltp-ZtzSE27611/dupKuEr3H)
> failed:
> unlink(/mnt/nfsv3/ltp-ZtzSE27611/dupKuEr3H/.nfs000000000110cb3800000066)
> failed; errno=16: Device or resource busy
> 
> Close the created/dup file before unlink() it to fix this issue.
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>

Looks good, ran fine for me with TMPDIR on nfsv3.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

> ---
>  testcases/kernel/syscalls/dup/dup07.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/dup/dup07.c
> b/testcases/kernel/syscalls/dup/dup07.c
> index 03b0ba4..025881f 100644
> --- a/testcases/kernel/syscalls/dup/dup07.c
> +++ b/testcases/kernel/syscalls/dup/dup07.c
> @@ -77,7 +77,9 @@ int main(int ac, char **av)
>  					tst_resm(TPASS,
>  					         "Passed in read mode.");
>  				}
> +				close(duprdo);
>  			}
> +			close(rdoret);
>  		}
>  
>  		unlink(testfile);
> @@ -97,7 +99,10 @@ int main(int ac, char **av)
>  					tst_resm(TPASS,
>  					         "Passed in write mode.");
>  				}
> +				close(dupwro);
>  			}
> +			close(wroret);
> +
>  		}
>  
>  		unlink(testfile);
> @@ -117,7 +122,9 @@ int main(int ac, char **av)
>  					tst_resm(TPASS,
>  					         "Passed in read/write mode.");
>  				}
> +				close(duprdwr);
>  			}
> +			close(rdwret);
>  		}
>  		
>  		unlink(testfile);
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
