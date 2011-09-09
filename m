Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R1yqz-0004uJ-Dw
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 11:02:37 +0000
Date: Fri, 9 Sep 2011 13:03:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110909110320.GC855@saboteur.suse.cz>
References: <4E64A1DB.5020301@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E64A1DB.5020301@linux.vnet.ibm.com>
Subject: Re: [LTP] [Patch] sockioctl01 test case fix
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
To: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> sockioctl01:
> Before patch:
> ...
> sockioctl01    4  TFAIL  :  ATMARK on UDP ; returned -1 (expected
> -1), errno 25 (expected 22)
> ...
> 
> After patch:
> ...
> sockioctl01    4  TPASS  :  ATMARK on UDP successful
> ...
> 
> 
> Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> 
> -- 
> Regards
> R.Nageswara Sastry
> 

> --- ltp.orig/testcases/kernel/syscalls/sockioctl/sockioctl01.c	2011-09-05 08:42:12.000000000 +0200
> +++ ltp/testcases/kernel/syscalls/sockioctl/sockioctl01.c	2011-09-05 08:47:52.000000000 +0200
> @@ -227,6 +227,12 @@ void setup1(void)
>  			 strerror(errno));
>  	}
>  	sinlen = sizeof(fsin1);
> +
> +	if (strncmp(tdat[testno].desc, "ATMARK on UDP", 14) == 0) {
> +                if ( tst_kvercmp(2,6,39) >= 0 || tst_kvercmp(3,0,0) >= 0 ) {
> +                        tdat[testno].experrno = ENOTTY;
> +                }
> +        }
>  }
>  
>  void setup2(void)
> @@ -254,4 +260,4 @@ void cleanup1(void)
>  {
>  	(void)close(s);
>  	s = -1;
> -}
> \ No newline at end of file
> +}

Same as the previous one.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Why Cloud-Based Security and Archiving Make Sense
Osterman Research conducted this study that outlines how and why cloud
computing security and archiving is rapidly being adopted across the IT 
space for its ease of implementation, lower cost, and increased 
reliability. Learn more. http://www.accelacomm.com/jaw/sfnl/114/51425301/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
