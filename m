Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC97C4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 03:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA1213CA8A4
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 04:19:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F12533C694C
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 04:19:20 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0C280140004B
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 04:19:18 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A327Qwo032638;
 Thu, 3 Nov 2022 03:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=RT/NtN0Z9GHlkqkSIcli6oLN+l0D+4JDUsxrj72uRSw=;
 b=krV7OUS6SjXzZk9KmiyXeshH9YGYORiOU4TeXm0BtYmo84ViBUIuGNvFyW9chkI6aWrf
 SqKSWT43cG/ZmB97CaIKIshSBgFkiWAg5soTz+56ukfnfVqk+ZyORj/867Tz/7ATrfqB
 yhHTzoTtwf3o+i76XBuly/zaWm5KGDIIfGpsjqrP/IIuxNgXbaBkuMZWYLB2tBSAzPRt
 FVcNlnrShl16Fj4iNrTcYkDmHiX5ZCHAHtLGIEgJhNKoOZD56pWE5lJBbIt9LLFe2lwk
 dFRzAcgA07+9493q4GJLZEyE+R+MG3eqD9j0AZzKo71znOKZYsHMo647U+Q7GwQzIexy zA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km26hderm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 03:19:16 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A335Ugh029563;
 Thu, 3 Nov 2022 03:19:13 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma01fra.de.ibm.com with ESMTP id 3kgut9dxg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 03:19:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A33JA3M393938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Nov 2022 03:19:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05CDB5204E;
 Thu,  3 Nov 2022 03:19:10 +0000 (GMT)
Received: from tarunpc (unknown [9.43.64.81])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2ACEF5204F;
 Thu,  3 Nov 2022 03:19:06 +0000 (GMT)
Date: Thu, 3 Nov 2022 08:48:59 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221103031859.f7opjgfr2uuqwasw@tarunpc>
References: <20221102114923.447871-1-tsahu@linux.ibm.com>
 <20221102114923.447871-3-tsahu@linux.ibm.com>
 <Y2KQy7ez6XUgRRcT@yuki>
Content-Disposition: inline
In-Reply-To: <Y2KQy7ez6XUgRRcT@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8PTuhiHZkB0ibBvIS_gQaiWJan4Nor-O
X-Proofpoint-GUID: 8PTuhiHZkB0ibBvIS_gQaiWJan4Nor-O
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030020
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/4] Hugetlb: Migrating libhugetlbfs
 brk_near_huge
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Nov 02 2022, Cyril Hrubis wrote:
> Hi!
> > --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> > @@ -9,3 +9,8 @@ include $(abs_srcdir)/../Makefile.inc
> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> >  
> >  hugemmap06: CFLAGS+=-pthread
> > +
> > +hugemmap07:
> > +ifeq ($(ARCH),ppc)
> > +	CPPFLAGS += -DPPC_NO_SEGMENTS
> > +endif
> 
> I do not think that ARCH is defined in LTP build system. Where does it
> come from in the original test?
> 
yeah, right. I will amend the code to check for the ARCH.
In original code, it explicitly check for ARCH.
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> > new file mode 100644
> > index 000000000..73ed4b0d6
> > --- /dev/null
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> > + * Author: David Gibson & Adam Litke
> > + */
> > +
> > +/*\
> > + *
> > + * [Description]
> > + *
> > + * brk() near hugepage:
>            ^
> 	   I would just remove this, it does not render nicely in the
> 	   asciidoc and it's not useful either.
> 
Ok.

--skip
> >  
> > +#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
> 
> We do have a LTP_ALIGN() please make use of that one instead.
Ok.
> 
> > +#define PALIGN(p, a) ((void *)ALIGN((unsigned long)(p), (a)))
> > +
> >  #define SHM_RD	0400
> >  #define SHM_WR	0200
> >  #define SHM_RW	(SHM_RD|SHM_WR)
> 
> Have you run 'make check-hugemmap07' in the respecive directory, did it
> report any problems?
> 
Yes, It didn't report any error/warnings.
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
