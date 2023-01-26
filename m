Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA482C636BD
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:05:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83F603CD35E
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:05:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 191883CC736
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:05:22 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 802A014010F4
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:05:20 +0100 (CET)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30QKjl2F005528; Thu, 26 Jan 2023 21:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=D+Uww1VJQy/g1iDIMjrbZuZFxOSyEd6mq5VOnMp0ch0=;
 b=i/+4zM3VBuTWxicDi/VrYrXzB4N89Y4ZAVEUoLQ7dGlWJ83+StIfSfj0UTK0m88RFzIH
 P94fPx0Qvwyxkq4hYRKSOk3eK03FnC5mXgysWzwCAwAovTRzZkSBJAD9m6wUzRCkDovj
 YaLQ7tpP61aiA+DHSXlIoR1z5KxtU9UQObx5xa4sC0fOimR7wrL90Y1q6zNyWoNSlqWy
 Fm/4OdbHrDca+H4MQuRQll4ty+T5tztVeCumaHv4SrKruBNe6JklS+nDsRPqrBE94FfR
 iisnTRLI3TmTwYUAh2hDeFLh7v06J1eS+nn64MgHSUrKn/FZPekUasd44t9K4oYP0JhX xg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nc0ucrbk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jan 2023 21:05:17 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QF5UKh032034;
 Thu, 26 Jan 2023 21:05:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n87p64v44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jan 2023 21:05:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 30QL5D8S22544896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Jan 2023 21:05:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68A7220043;
 Thu, 26 Jan 2023 21:05:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EC6F20040;
 Thu, 26 Jan 2023 21:05:12 +0000 (GMT)
Received: from tarunpc (unknown [9.43.26.43])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 26 Jan 2023 21:05:11 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20230125222703.19943-2-pvorel@suse.cz>
References: <20230125222703.19943-1-pvorel@suse.cz>
 <20230125222703.19943-2-pvorel@suse.cz>
Date: Fri, 27 Jan 2023 02:35:09 +0530
Message-ID: <87edrh0zy2.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wylmlS_yqU5STtn-hvRWc6ig6SQ6kK4y
X-Proofpoint-ORIG-GUID: wylmlS_yqU5STtn-hvRWc6ig6SQ6kK4y
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260198
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] hugemmap15: Compile with -O
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, Cyril, all

Though It already got merged, please note this,

IIRC, I specifically turned off optimization for hugemmap15
because of clang compiler issue, it behaves weirdly with clang
without -O0 and test fails on the system.

Petr Vorel <pvorel@suse.cz> writes:

> -O0 originally used causes warning on gcc 12:
>
> In file included from /usr/include/bits/libc-header-start.h:33,
>                  from /usr/include/stdio.h:27,
>                  from hugemmap15.c:22:
> /usr/include/features.h:412:4: warning: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Wcpp]
>   412 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)
>
> Fixes: 15625f6185 ("Hugetlb: Migrating libhugetlbfs icache-hygiene")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> index 6f10807cde..503a35f7f1 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> @@ -8,5 +8,5 @@ include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../Makefile.inc
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>  
> -hugemmap15: CFLAGS+=-O0
> +hugemmap15: CFLAGS+=-O
>  hugemmap06: CFLAGS+=-pthread
> -- 
> 2.39.1
>
>
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
