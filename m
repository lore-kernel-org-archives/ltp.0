Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D4BC4708E
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 12:48:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E0BD3CC11A
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 13:48:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 009783CC0C5
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 13:48:17 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A77756006D0
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 13:48:16 +0100 (CET)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B7BLlAS027887; Wed, 7 Dec 2022 12:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ST+7l0agp/JvmlveElE3u/XVqyNxdnz0XGRStihjFoo=;
 b=ditwIV56NZVPgM4SY1fKjhEIdIbGMHWkB42039oCP1/OF27vv65Kz/ZGcIsx4I0R4Zg8
 L8uDExk9xDmmAmTUJBkeNlVw4Ft3M9GDlKR3cDVYQD/4y3Wrg9vrif8LhteJxpCIst/q
 WDtIZMwGucgCGAWH6ZGeObDVw5dCll7km6OqOXVJcTHYzD2bgEy2zdlUHPuVKBDg5OUm
 leAXT26dejYyQ/PIsdtQiSq7MTyUHRemUk9mGJJk+1oeauSRILai+CeM3IlKvPfDD+ZK
 Y324E+h4lHH44xKrKMy0rKpwTPD2BiathwDvOwVGHUU1jge5F9wtXaT71+hFUglcB1kP CA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3masvut097-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Dec 2022 12:48:14 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B79A6ji002987;
 Wed, 7 Dec 2022 12:48:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3m9kur256r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Dec 2022 12:48:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2B7Cm9BZ17432908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Dec 2022 12:48:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1187420040;
 Wed,  7 Dec 2022 12:48:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0144E20043;
 Wed,  7 Dec 2022 12:48:07 +0000 (GMT)
Received: from tarunpc (unknown [9.43.68.243])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Dec 2022 12:48:06 +0000 (GMT)
Date: Wed, 7 Dec 2022 18:17:58 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20221207124758.e75o72ozwltbchyb@tarunpc>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-2-tsahu@linux.ibm.com>
 <87r0xet3pt.fsf@suse.de>
Content-Disposition: inline
In-Reply-To: <87r0xet3pt.fsf@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mBc-8d7QCAdeewLWwzlFcKTW2_G9_kfo
X-Proofpoint-GUID: mBc-8d7QCAdeewLWwzlFcKTW2_G9_kfo
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_05,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=882
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070108
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] Hugetlb: Migrating libhugetlbfs fork-cow
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
Cc: aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
 ltp@lists.linux.it, geetika@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
Thanks for reviewing it.
On Dec 05 2022, Richard Palethorpe wrote:
> Hello,
> 
> Tarun Sahu <tsahu@linux.ibm.com> writes:
> 
> > +
> > +#include <sys/wait.h>
> > +#include <sys/mman.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <sys/types.h>
> > +
> > +#include "hugetlb.h"
> > +
> > +#define RANDOM_CONSTANT		0x1234ABCD
> > +#define OTHER_CONSTANT		0xfeef5678
> 
> It seems their are actually 3 constants as "random" is inverted. I'd
> prefer it if they had names like C1, C2, C3 with no connotations.
> 
Yeah, Will be more cleaner, Will update it.

--skip
> > +
> > +	SAFE_WAITPID(pid, &status, 0);
> > +	if (WEXITSTATUS(status) != 0) {
> > +		tst_res(TFAIL, "Child failed: %d", WEXITSTATUS(status));
> > +		goto cleanup;
> > +	}
> 
> This can be replaced with tst_reap_children();
Ok. I will update it in v2.
> 
> > +
> > +	tst_res(TINFO, "child_readback = 0x%x, parent_readback = 0x%x",
> > +			*child_readback, parent_readback);
> > +
> > +	if (*child_readback != RANDOM_CONSTANT) {
> > +		tst_res(TFAIL, "Child read back 0x%x instead of 0x%x",
> > +		     *child_readback, RANDOM_CONSTANT);
> 
> I think this could be checked at the end of the child and the extra mmap
> for child_readback removed. The LTP lib already creats some shared
> memory with children to propagate results.
> 
> Assuming that mmap is not needed for the original bug reproducer.
>
Looking at the fix: 86df86424939d316 ("Correct hash flushing from huge_ptep_set_wrprotect()")
seems it can be done. I will look at it and will update it in v2.
> > +		goto cleanup;
> 
> I don't think this is necessary.
> 
> > +	}
> > +	if (parent_readback != ~RANDOM_CONSTANT) {
> 
> These comparisons could be replaced with TST_EXP_EQ_LU or TST_EXP_EXPR.
> 
Ok. Will update it.
> -- 
> Thank you,
> Richard.
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
