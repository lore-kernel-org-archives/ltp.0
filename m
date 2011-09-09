Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R1yqB-0002xN-JH
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 11:01:47 +0000
Date: Fri, 9 Sep 2011 13:02:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110909110230.GB855@saboteur.suse.cz>
References: <4E64A1B8.6070501@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E64A1B8.6070501@linux.vnet.ibm.com>
Subject: Re: [LTP] [Patch] readlink03 test case fix
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
> --- ltp.orig/testcases/kernel/syscalls/readlink/readlink03.c	2011-09-05 08:42:12.000000000 +0200
> +++ ltp/testcases/kernel/syscalls/readlink/readlink03.c	2011-09-05 08:49:28.000000000 +0200
> @@ -172,7 +172,11 @@ int main(int ac, char **av)
>  			if (buf_size == 1) {
>  				buf_size = sizeof(buffer);
>  			}
> -
> +                        if (strncmp(test_desc, "Symlink Pathname is empty", 25) == 0) {
> +                                if ( tst_kvercmp(2,6,39) >= 0 || tst_kvercmp(3,0,0) >= 0 ) {

There shouldn't be anything special about 3.0.0 as 3.0.0 is greater
number than 2.6.39.

> +                                        Test_cases[i].exp_errno = EINVAL;
> +                                }
> +                        }
>  			/*
>  			 * Call readlink(2) to test different test conditions.
>  			 * verify that it fails with -1 return value and sets
> @@ -358,4 +362,4 @@ void cleanup()
>  
>  	tst_rmdir();
>  
> -}
> \ No newline at end of file
> +}

And please run through checkpatch.pl before resending.

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
