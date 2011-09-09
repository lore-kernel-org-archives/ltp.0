Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R1yeb-0002P4-AP
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 10:49:49 +0000
Date: Fri, 9 Sep 2011 12:50:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110909105029.GA855@saboteur.suse.cz>
References: <4E69A455.7070908@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E69A455.7070908@linux.vnet.ibm.com>
Subject: Re: [LTP] [Patch v5 3/4] KSM test case fixes - mmap10
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
> --- ltp.orig/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-08 11:32:12.000000000 +0200
> +++ ltp/testcases/kernel/syscalls/mmap/mmap10.c	2011-09-09 07:22:35.000000000 +0200
> @@ -62,6 +62,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "config.h"
> +#include "../../mem/include/mem.h"
>  
>  #define SIZE (5*1024*1024)
>  
> @@ -94,6 +95,8 @@ int main(int argc, char *argv[])
>  
>  	if (opt_ksm)
>  	{
> +		if (access(PATH_KSM, F_OK) == -1)
> +			tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
>  #ifdef HAVE_MADV_MERGEABLE
>  		tst_resm(TINFO, "add to KSM regions.");
>  #else

I don't have a good feeling about including header files across several
directories, which could break things miraculously in the future. The
best solution would be creating one header file to store constants to in
ltp/include/. Or even duplicating the constant in the mmap10.c source
seems as better solution to me.

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
