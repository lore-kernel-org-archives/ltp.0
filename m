Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E29AC38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 17:10:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B10DF3CA76F
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 19:10:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B23F33C0475
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 19:09:56 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7DE3210005C0
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 19:09:54 +0200 (CEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QGjQx5022677;
 Wed, 26 Oct 2022 17:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=qsN/Tl/ZwJuMWRg2Bkdi0Y2580jk/2SCRagjvC5vd3I=;
 b=G4jXB/seRMEOJG3cIGW9mOUcTi9g/0J3i+kGfizl3lxCn1zK3vH3yzCXyKTAYlFI7rhH
 tzBocOWJpSYpIBuHXhEQaXMwFuwHiMBXYtuPzjSv2TOQCQ22w85+hwtp1n1TegErW+a1
 82Tj094DZCAFUqt9C94LKHk8UAbqK3WOS8PEI5ODVksm4o036d31z+B44ktuxaRa9qEm
 QNU8eW40Wcxm9Swdmmby9Kxx53mrOGuvcsNDXWBvAVRQjpY5yjxNnRdCIBqsaYofMwOP
 s7ccxHUHOuL3KVuKyIlIGhOMzBsrBqAyTmk6ft3KnYMJ2GpwITk5mHP4n2aC5xPStxWK IA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kf8pg0v8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Oct 2022 17:09:52 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29QH6As7013381;
 Wed, 26 Oct 2022 17:09:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04fra.de.ibm.com with ESMTP id 3kc859pmrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Oct 2022 17:09:51 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29QH9l807209528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Oct 2022 17:09:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B826152051;
 Wed, 26 Oct 2022 17:09:47 +0000 (GMT)
Received: from tarunpc (unknown [9.43.25.184])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8034C5204F;
 Wed, 26 Oct 2022 17:09:45 +0000 (GMT)
Message-ID: <7951cad5022973849caf54884732000e7e9cb2e3.camel@linux.ibm.com>
From: Tarun Sahu <tsahu@linux.ibm.com>
To: rpalethorpe@suse.de
Date: Wed, 26 Oct 2022 22:39:43 +0530
In-Reply-To: <8735bcxicr.fsf@suse.de>
References: <20221019184846.89318-1-tsahu@linux.ibm.com>
 <20221019184846.89318-4-tsahu@linux.ibm.com> <8735bcxicr.fsf@suse.de>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NIaveOnACSOxyJKAZJY5PT5-FXQWsnJR
X-Proofpoint-ORIG-GUID: NIaveOnACSOxyJKAZJY5PT5-FXQWsnJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=637 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260096
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Hugetlb: Migrating libhugetlbfs
 corrupt-by-cow-opt
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

On Tue, 2022-10-25 at 12:04 +0100, Richard Palethorpe wrote:
> Hello,
> 
> Tarun Sahu <tsahu@linux.ibm.com> writes:
> 
> > Migrating the libhugetlbfs/testcases/corrupt-by-cow-opt.c test
> > 
> > Test Description: Test sanity of cow optimization on page cache. If
> > a page
> > in page cache has only 1 ref count, it is mapped for a private
> > mapping
> > directly and is overwritten freely, so next time we access the
> > page, we
> > can see corrupt data.
> 
> Seems like this and 2/3 follow the same pattern. The setups are
> reasonably similar and could be encapsulated in tst_hugepage.
Do you mean by a encapsulating in a function. and call it from setup.
becuase it will anyway require explicit cleanup.

Or by defining a new field in struct tst_hugepage, if that is true,
that setup will automatically be done in do_setup in tst_test file.
which means it will require change in tst_test.c too. also change in 
do_cleanup in tst_test.c will also be required. 

> 
> > +
> > +static struct tst_test test = {
> > +	.needs_root = 1,
> > +	.needs_tmpdir = 1,
> > +	.options = (struct tst_option[]) {
> > +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H
> > /var/hugetlbfs"},
> > +		{"s:", &nr_opt, "Set the number of the been allocated
> > hugepages"},
> 
> nr_opt also seems suspicious. The test only ever allocates one page
> at a
> time regardless of what this is set to. Changing it will just change
> how
> much free memory we check for unless I am mistaken.
yes, Will update it and also will check for other test cases if not
required. 

> 
> > +		{}
> > +	},
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = run_test,
> > +	.hugepages = {2, TST_NEEDS},
> > +};
> > -- 
> > 2.31.1
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
