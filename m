Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F0EC43217
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 07:34:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 710623CB05C
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 09:34:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0810E3CA06D
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 09:33:55 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED74F600806
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 09:33:53 +0200 (CEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I76FlK025078;
 Tue, 18 Oct 2022 07:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=bxIpjcLxiwctw7YF7i4veYuQfMFWsbwnpKGnGpQCwJU=;
 b=W5hp2NvZQ/UTVTQphdMCl/YygQP87mIlpD0Z1ScBYckOKlopcfuoL13dTFvusI3HfqLR
 F/mRKCn1XZyMosf29lKBI4h2fISCv1lmGqvrHUCmWGEIbeRrwpDpyYCGs2gvQiC1aDuV
 3d9TEY/s+hmgLelP3jfmtGDbjwb7GM7K7dM7ujxpmxPTxRO1iqHQOQhSbJuMwcA/8e/r
 A6dEWmAvkrqM043twxHE4M8VhBFtus2EjHhiuxKVFjHBfDLbr4hcf/3i8knPA6Jm1ZCf
 4e81Z00rhu9Yg2kcQL+hb9DOspjjMH/PiJEW3xvF9zE7gbUTd2sdJvIj2pIDs+ydXECE 6A== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9bkwjwjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Oct 2022 07:33:51 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29I7K2Ma002449;
 Tue, 18 Oct 2022 07:33:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma02fra.de.ibm.com with ESMTP id 3k7mg93kh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Oct 2022 07:33:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29I7Xip126149454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Oct 2022 07:33:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D697A405B;
 Tue, 18 Oct 2022 07:33:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE630A4054;
 Tue, 18 Oct 2022 07:33:41 +0000 (GMT)
Received: from tarunpc (unknown [9.43.38.108])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 18 Oct 2022 07:33:41 +0000 (GMT)
Message-ID: <8ae7d26f5635cc858a657e78b0b806b576a98241.camel@linux.ibm.com>
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Oct 2022 13:03:40 +0530
In-Reply-To: <Y00g0NZYO8pVvC6M@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-2-tsahu@linux.ibm.com> <Y00g0NZYO8pVvC6M@yuki>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w0SjdCgqJ8SguH53mNWwF0P0YcntCJuf
X-Proofpoint-ORIG-GUID: w0SjdCgqJ8SguH53mNWwF0P0YcntCJuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_01,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210180042
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/29] Hugetlb: Migrating libhugetlbfs
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
Reply-To: tsahu@linux.ibm.com
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, 

Thanks Cyril for reviewing it.
Please check my comments below.

On
Mon, 2022-10-17 at 11:30 +0200, Cyril Hrubis wrote:

-- skip
> + *
> > + * Test Name: brk near hugepage
> > + *
> > + * Test Description: Certain kernels have a bug where brk() does
> > not perform
> > + * the same checks that a MAP_FIXED mmap() will, allowing brk() to
> > create a
> > + * normal page VMA in a hugepage only address region. This can
> > lead to oopses
> > + * or other badness.
> 
> This description has to be in a separate ascii-doc formatted comment
> that starts with /*\

Ok. I will update this in all of the patches in this series.

-- skip
> > +	p = SAFE_MMAP(hugemap_addr, hpage_size, PROT_READ|PROT_WRITE,
> > +			MAP_PRIVATE|MAP_FIXED, fd, 0);
> > +	if (p != hugemap_addr) {
> > +		tst_res(TFAIL, "mmap() at unexpected address %p instead
> > of %p\n", p,
> > +		     hugemap_addr);
> > +		goto fail;
> 
> Can we just do return here instead. The failure has been reported
> there
> is no point in calling tst_brk(TBROK, ...) as well.
When we run one iteration only, tst_brk does not make sense, I agree.
But if we are running more than one iteration (i >= 2), test
should not continue to next iteration if the current iteration fails.
Only way I could find is to use tst_brk(TBROK,... , as tst_brk(TFAIl...
is deprecated.

> 
> > +	}
> > +
> > +	err = test_addr_huge((void *)p);
> > +	if (err != 1) {
> > +		tst_res(TFAIL, "Mapped address is not hugepage");
> > +		goto fail;
> > +	}
> 
> I do not get why we even need this check. We map a file located on
> hugetlbfs and then we stat it and check that it indeed is on
> hutetlbfs.
> What did we expect to fail here? I would say that the mmap() with
> right
> path is enough to make sure that the file is created on hugetlbfs.
> 
I agree, this check is redundant, I will remove it.

> > +	newbrk = next_chunk(brk0) + getpagesize();
> > +	err = brk((void *)newbrk);
> > +	if (err == -1) {
> > +		/* Failing the brk() is an acceptable kernel response
> > */
> > +		tst_res(TPASS, "Failing the brk is an acceptable
> > response");
> > +	} else {
> > +		/* Suceeding the brk() is acceptable iff the new memory
> > is
> > +		 * properly accesible and we don't have a kernel blow
> > up when
> > +		 * we touch it.
> > +		 */
> > +		memset(brk0, 0, newbrk-brk0);
> > +		tst_res(TPASS, "Succeding brk is acceptable, as memset
> > confirms that "
> > +				"new memory is properly accessible
> > without kernel blow up");
> > +	}
> > +	SAFE_MUNMAP(p, hpage_size);
> > +	SAFE_CLOSE(fd);
> 
> Shouldn't we brk() back to the original brk0? Does the test work with
> -i 2?
> 
Yes, will update it back to brk0.
Yes -i 2.. working, may be becuase, we
are just moving it by 1 page.

--skip
> > +
> > +static void cleanup(void)
> > +{
> > +	if (fd >= 0)
> > +		SAFE_CLOSE(fd);
> > +	umount2(Hopt, MNT_DETACH);
> 
> We whould umount here only if we actually have mounted something.
umount only, will require explicit unmap when test fails or break.
For
that, all the local variable for address mapping will have to be
static defined so that they can be accessed in cleanup() function.

I tried to avoid it by using umount2 which eventually umount when
process unmaps all the mappings after it finishes.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
