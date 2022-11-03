Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD21C433FE
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 09:34:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C4FB3CAD45
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 10:34:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E59E53C694C
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 10:33:57 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C62B5100095A
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 10:33:56 +0100 (CET)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A38Litk005401;
 Thu, 3 Nov 2022 09:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=pi8eWuiGZCYCLhKyo0IIm2432GH5+OxdS7VofiGvmxU=;
 b=iUWKWRlemYwN2xNBrBY+HDl4+jyVq8K2ZoNRfnoJZJas8eqPAYM/vC92hrBTCbKcQtvU
 6VXG/DF6uIqnKzw+Mu802Q6CeYdemuMcG3EJzoBvhPZdkk5+UK9q25HLUMRlwsQTmTru
 5UOeHfSpy0Dw8pKrfPFlJJkrq0jLmxW3QBCM/E1tiTd3gU+D1CljOTFkG2G/Sf7vt5ng
 ZztsP24X+Q6fuc3QGyQMLu1UjZZwWP5JWdZOLyD0M2KWssUVUa4rR4T7PurZT3SdM9c3
 clq3+Z0Ob9WYjhlFY11NK4pygR3SMfXdIFofzgspqX6oaptL7gHE6RMxL8euAWfO1PHB mg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kma2nj31b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 09:33:54 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A39XrgZ006601;
 Thu, 3 Nov 2022 09:33:53 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kma2nj271-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 09:33:52 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A39LcUI022405;
 Thu, 3 Nov 2022 09:31:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma01fra.de.ibm.com with ESMTP id 3kgut9ea4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 09:31:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A39VI3063308066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Nov 2022 09:31:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C4C0AE04D;
 Thu,  3 Nov 2022 09:31:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B191AE045;
 Thu,  3 Nov 2022 09:31:15 +0000 (GMT)
Received: from tarunpc (unknown [9.43.48.43])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  3 Nov 2022 09:31:15 +0000 (GMT)
Date: Thu, 3 Nov 2022 15:01:08 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <20221103093108.hs64zkkrd2mjhudk@tarunpc>
References: <20221103054317.499221-1-tsahu@linux.ibm.com>
 <20221103054317.499221-2-tsahu@linux.ibm.com>
 <CAEemH2dNhMq35OgCbTTPVO-Hfj62uVb1EsSTuH48P176V+ZJVA@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2dNhMq35OgCbTTPVO-Hfj62uVb1EsSTuH48P176V+ZJVA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wxVut7s-vrzJUa9RhLr-QhVgx67RQ6lA
X-Proofpoint-GUID: YXNFsZz_IXoJUb93ml-Wc8a5Tb9hxgAj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_01,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030067
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello, 
Thanks for reviewing.

I am thinking of adding following lines in "lib/hugetlb.h"

#define HUGEPAGE_TOTAL "HugePages_Total:"
#define HUGEPAGE_FREE "HugePages_Total:"
#define HUGEPAGE_RSVD "HugePages_Total:"
#define HUGEPAGE_Surp "HugePages_Total:"

There are all test that uses, TOTAL, MANY that uses FREE, few RSVD, SURP.
If we change it now, we can update this series now and, proceed further for
series of next tests.

What do you think?

On Nov 03 2022, Li Wang wrote:
> Tarun Sahu <tsahu@linux.ibm.com> wrote:
> 
> Most of libhugetlbfs test require mounted hugetlbfs.
> >
> > Here, this patch adds a new field in tst_test struct(include/tst_test.h)
> > which user can set if the test requires mounted hugetlbfs. Also, this
> > patch added support to create the unlinked file in the provided dirpath.
> >
> > Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> >
> 
> 
> Thanks for the patiently iteration. This looks pretty good.
> 
> Reviewed-by: Li Wang <liwang@redhat.com>
> 
> -- 
> Regards,
> Li Wang

> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
