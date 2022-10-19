Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A69C433FE
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 05:12:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A9003CB0F9
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 07:12:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 430BF3C010A
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 07:12:13 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ADE451A00CC4
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 07:12:11 +0200 (CEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J5C3AL012440;
 Wed, 19 Oct 2022 05:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=k/s5iX0L4yafAjR+ynnmF0fpygAr16mGdXJ+VMTse48=;
 b=PR5H5ZyYttVnQLsmfBLRxEG23t/vdnEiz3l6FNxiQJ1vq/eCw9/rnpNJgmwQnrs8N4o8
 XxGltCACE/Ylkazqh50AcxTwE9mslXKH7JZApGPsB+hCJYOZ3RBcAh6FwzHAdIrCW9gs
 QkCVNwIC+l9FSp6ddLIyJVI0CWtW3ebFBzya825edGrdwLB1/sWGaaZWa3pphtLLpbzD
 HMCAlXDElVZBOcYpibaNqgWQ7epJA82NBnLOhamngD3+uBPUTmg0rv7lXJxONEyDp98u
 jtokpvvIxuPSEW6a8F8+GbAsO2c7JH6BioAKbrzBLsZ/9ukpvgwqDkMIbxxDQDObgJ1d dQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kaavhg04y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Oct 2022 05:12:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29J56ulV001857;
 Wed, 19 Oct 2022 05:12:06 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3k7m4jpeyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Oct 2022 05:12:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29J5C3Ql29032724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Oct 2022 05:12:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42F75AE051;
 Wed, 19 Oct 2022 05:12:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC4EBAE045;
 Wed, 19 Oct 2022 05:12:00 +0000 (GMT)
Received: from tarunpc (unknown [9.43.98.97])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 19 Oct 2022 05:12:00 +0000 (GMT)
Message-ID: <dc7d25a51e20a186048e4fa26ba2c69cc3cb21dd.camel@linux.ibm.com>
From: Tarun Sahu <tsahu@linux.ibm.com>
To: rpalethorpe@suse.de
Date: Wed, 19 Oct 2022 10:41:59 +0530
In-Reply-To: <87wn8xi61v.fsf@suse.de>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <87wn8xi61v.fsf@suse.de>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b2FR_6tuaLLwfE425TBWBwqpC5gCi1a4
X-Proofpoint-GUID: b2FR_6tuaLLwfE425TBWBwqpC5gCi1a4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_02,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=773 mlxscore=0 spamscore=0 clxscore=1011 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190027
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/29] Hugetlb: Migrating libhugetlbfs tests
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
Reply-To: tsahu@linux.ibm.com
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi Richard, 

Understood, I will repost the patch, with first 2/3 in the series.

Thanks,

On Tue, 2022-10-18 at 14:51 +0100, Richard Palethorpe wrote:
> Hello,
> 
> Tarun Sahu <tsahu@linux.ibm.com> writes:
> 
> > Hi,
> > Libhugetlbfs is not being maintained actively, and some distro is
> > dropping
> > support for it. There are some tests that are good for testing
> > hugetlb
> > functionality in kernel.
> > 
> > As per previous dicussion in RFC[1], Here, this patch series
> > consists
> > of hugetlb tests taken from libhugetlbfs modified to work in ltp
> > environment. This series do not include all the tests, I
> > will post another series for the remaining tests soon.
> 
> Perhaps Cyril already said this, but I suggest just getting one or
> two
> of the tests merged first then working through the rest.
> 
> This reduces the iteration time and batch size.
> 
> At least in terms of what you submit to the mailing list. Perhaps if
> it
> gets to the point where most tests pass review first time, you can
> submit everything remaining.
> 
> Also note that submitting this many new tests, once they are merged
> we
> will probably get failure reports (including compilation failures).
> It
> will make life easier to stagger that.
> 
> I'm going to mark this patch-set as changes requested in patchwork.
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
