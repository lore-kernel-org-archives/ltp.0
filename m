Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YqMRT-00086h-Gg
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 14:06:23 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YqMRS-0008MO-Jm
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 14:06:23 +0000
Message-ID: <554B7127.7000606@oracle.com>
Date: Thu, 07 May 2015 17:05:27 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1430907502-30493-3-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1430907502-30493-3-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/3] kernel/mem/mmapstress: fix resource leak
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
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

On 05/06/2015 01:18 PM, Wei,Jiangang wrote:
> Including memory and fd leak.
>
> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>   testcases/kernel/mem/mmapstress/mmapstress01.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
> index 0baf0e2..1db8147 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress01.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
> @@ -657,6 +657,8 @@ int fileokay(char *file, uchar_t * expbuf)
>   			perror("read error");
>   			/***** LTP Port *****/
>   			local_flag = FAILED;
> +			free(readbuf);

We could allocate readbuf on the stack... readbuf[pagesize] so free() 
not needed.

> +			close(fd);
>   			anyfail();

anyfail() calls tst_brkm() - the program terminates and closes fd.

>   			/*****	**	*****/
>   			return 0;
> @@ -668,6 +670,8 @@ int fileokay(char *file, uchar_t * expbuf)
>   				(void)fprintf(stderr, "read %d of %ld bytes\n",
>   					      (i * pagesize) + cnt,
>   					      (long)mapsize);
> +				free(readbuf);
> +				close(fd);
>   				return 0;
>   			}
>   		}
> @@ -688,10 +692,13 @@ int fileokay(char *file, uchar_t * expbuf)
>   					      "(fsize %ld)\n", i, j,
>   					      statbuf.st_size);
>   #endif /* LARGE_FILE */
> +				free(readbuf);
> +				close(fd);
>   				return 0;

In both above cases it'll call anyfail() after checking fileokay()'s 
return value.
If it seems not obvious we can close 'fd' here and it'd be better to use 
SAFE_CLOSE() macro from safe_macros.h.

>   			}
>   		}
>   	}
> +	free(readbuf);
>   	close(fd);
>   
>   	return 1;

Thanks,
Alexey

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
