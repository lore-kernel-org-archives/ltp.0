Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28643C6379F
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 15:30:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 322363CBF91
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 16:30:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2213D3C1D84
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:29:52 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0423B600186
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:29:51 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31DEWS4X022856
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 15:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=BGRt+3WSgeee8GHOpM1cEmCYiwRm97op6PzYPsphUE8=;
 b=sv+iKVp4Yj48I+4uSYbjz868nCAasFvVz2DWDIRhk7VaI0bwVrt8VUAPx/RUYUeIsGWr
 bqDaOK7Ykq4bcKtOU+nsOOdqzde0facGprGM+tEY4GRJ9QUjkTSDyH0ColPdpL2fnhMO
 HgIWhTOFoD6kMbLA9e5i/gf/qrXeosjjjQK+gDU8y8jkqSiDYKqKVyLHJUAMGW4jYGHC
 t5XbAer2XsPU175ErGHLeapRzpGGoyehavbI4MbOSNOgrb8WZ1TQwGhje5q09q3l7VyF
 5yGIHZfV1FtEdOkhp+r9mbiQzit0ShqJfc5NujPed5DdXK5yBgI8lfySBxccxo2qPFAy zw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqq2dhj28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 15:29:49 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31D81W3C007478
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 15:29:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3np29fa3wk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 15:29:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 31DFTjNI18416008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 15:29:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D3AE2004F
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 15:29:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CA2920040
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 15:29:44 +0000 (GMT)
Received: from tarunpc (unknown [9.43.27.182])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 15:29:44 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
In-Reply-To: <20230210223342.240969-1-tsahu@linux.ibm.com>
References: <20230125222703.19943-2-pvorel@suse.cz>
 <20230210223342.240969-1-tsahu@linux.ibm.com>
Date: Mon, 13 Feb 2023 20:59:40 +0530
Message-ID: <87r0utinx7.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DpYnAHKgMUcrzZxsbJKeya1djw0xnK4r
X-Proofpoint-ORIG-GUID: DpYnAHKgMUcrzZxsbJKeya1djw0xnK4r
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_09,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130136
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugepage15: Resolve compile time warning
 generating with -O0
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Thanks for reviewing it, Petr.
Sent the re-based version.

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Instead of turning off the optimizaton with -O0 to resolve unwanted
> behaviour of clang with goto statements, this will make use of clang
> pragma to turn off the optimization for just clang compiler. This way,
> gcc won't throw unwanted warning on turning off optimization:
> "warning: _FORTIFY_SOURCE requires compiling with optimization (-O)".
>
> Also, removed redundant header-includes.
>
> Reported-by: Petr Vorel <pvorel@suse.cz>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/Makefile     |  1 -
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 12 ++++--------
>  2 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> index 6f10807cd..2d651b4aa 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> @@ -8,5 +8,4 @@ include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../Makefile.inc
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>  
> -hugemmap15: CFLAGS+=-O0
>  hugemmap06: CFLAGS+=-pthread
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> index 4730d8d18..aae234135 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> @@ -18,17 +18,13 @@
>   * remap, or because the icache happens to get flushed in the interim.
>   */
>  
> +#if defined(__clang__)
> +	#pragma clang optimize off
> +#endif
> +
>  #define _GNU_SOURCE
> -#include <stdio.h>
> -#include <stdlib.h>
>  #include <setjmp.h>
> -#include <unistd.h>
>  #include <signal.h>
> -#include <sys/mman.h>
> -#include <ucontext.h>
> -#include <limits.h>
> -#include <sys/param.h>
> -#include <sys/types.h>
>  
>  #include "hugetlb.h"
>  
> -- 
> 2.31.1
>
>
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
