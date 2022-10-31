Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3726ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 18:03:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4CC13CABD6
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 19:03:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 129DA3C9ED2
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 19:02:49 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C506C10004BA
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 19:02:48 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHC3uo029914;
 Mon, 31 Oct 2022 18:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=wC9gXbIRlYVcJxwPVWTaTms2FByPB6Kc6zmTrYR+rDo=;
 b=fzXYKXpj5GAOVrLvHj9e+hneEduCieFEA0FkWrLocqMFfbKsT6+XfRP6GgLYr7ioo7wv
 YhGi0sFon01AZB2+DIefEtyOs4Lsd/12iYgsQMFTCTaSx9C+ATJCVzCLo0Je3JmkH2Hw
 9db2F4IbJXT35Z7H+kPpvTjIyPIjiT3i79lgyirMMIFXntzB0EqWDlU3gQj2KJouI+u6
 Lzeo6e18j/sa+7OTzsNa64iJm772JA6N/oGyZ+TgsNa9C+Pj12+pNTQSpI+6JGDez0sQ
 7oxOlK2oDVji7sbZCdqDuug/IrdWgiq/sKOrYC48dZKyC/etvaRFtYvZoYrf+52W1Xvr nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjgykd1m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 18:02:45 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29VFQ7Bh007555;
 Mon, 31 Oct 2022 18:02:45 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjgykd1jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 18:02:45 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29VHpbZw017243;
 Mon, 31 Oct 2022 18:02:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 3kgut8ubuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 18:02:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29VI2dH32163232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Oct 2022 18:02:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8252542049;
 Mon, 31 Oct 2022 18:02:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E66C4203F;
 Mon, 31 Oct 2022 18:02:35 +0000 (GMT)
Received: from tarunpc (unknown [9.43.72.21])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 31 Oct 2022 18:02:34 +0000 (GMT)
Date: Mon, 31 Oct 2022 23:32:31 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221031180231.hgxcngfrwkkajii5@tarunpc>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-2-tsahu@linux.ibm.com>
 <CAEemH2e+FUZnQws-9pW5E25Uq01T0zaHzsk8QUa2KJsCKQpDBA@mail.gmail.com>
 <Y1/iBcq+iYFsxDJ+@yuki>
Content-Disposition: inline
In-Reply-To: <Y1/iBcq+iYFsxDJ+@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UztcmLA-Qs77g8sMJZjOVXoodvk9wni0
X-Proofpoint-GUID: 4TFTQX186DFFxNHDMSZLeABsezU5ZXoR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310112
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Hugetlb: Add new tst_test options for
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,
Please find my comments inline.

On Oct 31 2022, Cyril Hrubis wrote:
> Hi!
> > Why not consider encapsulating these two new fields in 'struct
> > tst_hugepage' ?
> > 
> > Then the tst_test in the case can simply initialize to:
> > 
> > ....
> > static struct tst_test test = {
> >     .needs_root = 1,
> >     .taint_check = TST_TAINT_D | TST_TAINT_W,
> >     .setup = setup,
> >     .test_all = run_test,
> >     .hugepages = {1, TST_NEEDS, 1, 1},
> > };
> 
> I do not like that we have magic constants in the .hugepages that are
> not self describing. I would treat the hugetltbfs just as we treat
> devfs, that would be:
> 
> #define MNTPOINT "hugetlbfs/"
> #define HUGEFILE MNTPOINT "hugefile"
> 
> static int huge_fd;
> 
> static void setup(void)
> {
> 	huge_fd = tst_creat_unlinked(HUGEFILE);
> 	...
> }
> 
> static void cleanup(void)
> {
> 	if (huge_fd > 0)
> 		SAFE_CLOSE(huge_fd);
> }
> 
> static struct tst_test test = {
> 	...
> 	.mntpoint = MNTPOINT,
> 	.needs_hugetlbfs = 1,
> 	.setup = setup,
> 	.cleanup = cleanup,
> 	...
> }
> 
> 
> What do you think?
> 
My original idea behind putting it in tst_test struct instead of
tst_hugepages was based on below two reasoning-

1. tst_hugepages seems to have only hugepages related info. It would be
better to rename it to tst_hugetlb and rename <hugepages> field in tst_test
struct to <hugetlb>. If we rename it which will require changes in already
existing tests. and Moreover, there were similar field like needs_tmpdir
in tst_test so I put it(needs_unlinked_hugetlb_file) in tst_test.
2. There was already related fields in tst_test for mounting fs, like
needs_devfs, needs_rofs, So keeping all the needs_ABCfs at same structure.

> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
