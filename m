Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330E2C352A1
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 12:51:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B35A33CC124
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 13:51:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 090703CC0C5
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 13:51:39 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EADB1A00643
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 13:51:38 +0100 (CET)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B7BLh98027779; Wed, 7 Dec 2022 12:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=sNxdD9aFuNzvgc7SP3M3gTP/mM0rGOJ9M56tkLxEBEI=;
 b=tHtIRNO0IN0K7WjzOXKHDxliLpYvjrfvpqdNluYQth/VOnf4VdA8+FG5VVxtEFyYRhRO
 3Cj2gP33QFAsA+7HFkmimg9U4OsiHb/ilrRWC4Ssgx9rRGCldzVDA8VQMm6RZIFgb9K3
 Oe0EtouD5wpEfNR5ztLH3q0rNLsG8O9UXChs9VhczTB1OCxCJT94qatsvrEnJjoTeLKw
 vjS5ASHOhKU1Th9QNBehYMMHdWux0M35LWLF4eXLFhsuHZk9sS2YdShzzPPlCJmkIQEz
 bkXldmqZH2sHEY16hDMX2rs/naqFwN4KCWi7yrPbBgWATcgkApJqo4b3oEeoK9BnvDXB 4w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3masvut2pb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Dec 2022 12:51:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7BfkPs008300;
 Wed, 7 Dec 2022 12:51:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3m9m5y2xs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Dec 2022 12:51:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2B7CpVlw41288112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Dec 2022 12:51:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4D862004B;
 Wed,  7 Dec 2022 12:51:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC59F20040;
 Wed,  7 Dec 2022 12:51:29 +0000 (GMT)
Received: from tarunpc (unknown [9.43.68.243])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Dec 2022 12:51:29 +0000 (GMT)
Date: Wed, 7 Dec 2022 18:21:26 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20221207125126.jk3hhn254ngnk64d@tarunpc>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-4-tsahu@linux.ibm.com>
 <87ilioucob.fsf@suse.de>
Content-Disposition: inline
In-Reply-To: <87ilioucob.fsf@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JJnkhPSJtEo9ApGNBMi1C-Affvd3GEjn
X-Proofpoint-GUID: JJnkhPSJtEo9ApGNBMi1C-Affvd3GEjn
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_05,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070108
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/8] Hugetlb: Migrating libhugetlbfs
 huge_below_4GB_normal_above
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

On Dec 06 2022, Richard Palethorpe wrote:
> Hello,
> 
> Tarun Sahu <tsahu@linux.ibm.com> writes:
> 
> > Migrating the libhugetlbfs/testcases/huge_below_4GB_normal_above.c test
> >
> > Test Description: Designed to pick up a bug on ppc64 where
> > touches_hugepage_low_range() could give false positives because of the
> > peculiar (undefined) behaviour of << for large shifts
> >
> > Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> > + *
> > + * Designed to pick up a bug on ppc64 where touches_hugepage_low_range()
> > + * could give false positives because of the peculiar (undefined)
> > + * behaviour of << for large shifts
> > + *
> > + * WARNING: The offsets and addresses used within are specifically
> > + * calculated to trigger the bug as it existed.  Don't mess with them
> > + * unless you *really* know what you're doing.
> 
> I guess the test is good insofar that I can tell. As with hugemmap13 it
> would be nice to have a reference to the bugfix though.
> 
> > +
> > +static struct tst_test test = {
> > +	.needs_root = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.needs_hugetlbfs = 1,
> > +	.needs_tmpdir = 1,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = run_test,
> > +	.hugepages = {2, TST_NEEDS},
> 
> If we can find the bugfix commit then it can be referenced in the tags
> here.
>
Yeah, Will update the bug-fix references in v2
> -- 
> Thank you,
> Richard.
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
