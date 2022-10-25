Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9F3C04A95
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 05:56:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F6013CA1C0
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 07:56:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93BFF3C98D6
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 07:56:35 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 666D71400B7C
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 07:56:33 +0200 (CEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P5g282029045;
 Tue, 25 Oct 2022 05:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=ofSpymP9YjcdaT/0Uzu7ohksh00b+GX9fHdmf7jBjV8=;
 b=NtpQVn6qqVtMNOp/wfNnj0kz/7nN89llTTvd509XMHwg2BB8VBCRMDc6zB139skP9r7m
 UQ7BrL5io8QK6pc/ODwwvnKNLOjbhtTM8R3fSG4c7j/eIHwPWLZqw9YZZt5MG975ZTKU
 J5XB8O6/4gkUZBTf3Mwi+121w+ztaZonDb44DNl1HbjSkfnwW+CY5hQWC60mu+TH+56t
 ruDTRTQO7pan2S4cL2+8s9m2PSgKwqyuOqusyZdWxY+tqgSapT2wEkvjKzymRFSgPWNS
 q7QXsx8/qm/bmLPHr+WXeqLW64RPR+PUWeK+htKb2b/NAB7/G5VFmk6/cpxHZFs5FlLY VA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ke9vhgc2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Oct 2022 05:56:31 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29P5oV3j018534;
 Tue, 25 Oct 2022 05:56:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma02fra.de.ibm.com with ESMTP id 3kc859ka6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Oct 2022 05:56:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29P5uPNC4850344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Oct 2022 05:56:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 770BAA405F;
 Tue, 25 Oct 2022 05:56:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FFCDA4054;
 Tue, 25 Oct 2022 05:56:22 +0000 (GMT)
Received: from tarunpc (unknown [9.43.55.146])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 25 Oct 2022 05:56:22 +0000 (GMT)
Message-ID: <ebb30e16cd63fdbff8520c68388f572fc6f5b9e0.camel@linux.ibm.com>
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 Oct 2022 11:26:20 +0530
In-Reply-To: <Y1JfP6TMo2BdMr5Y@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-2-tsahu@linux.ibm.com> <Y00g0NZYO8pVvC6M@yuki>
 <8ae7d26f5635cc858a657e78b0b806b576a98241.camel@linux.ibm.com>
 <Y1JfP6TMo2BdMr5Y@yuki>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 71gc6L3qazhq5pc7V1DAkeUUnf5zKucd
X-Proofpoint-GUID: 71gc6L3qazhq5pc7V1DAkeUUnf5zKucd
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_01,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250030
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

Hi Cyril, 

On Fri, 2022-10-21 at 10:58 +0200, Cyril Hrubis wrote:
> > -- skip
> > > > +	p = SAFE_MMAP(hugemap_addr, hpage_size,
> > > > PROT_READ|PROT_WRITE,
> > > > +			MAP_PRIVATE|MAP_FIXED, fd, 0);
> > > > +	if (p != hugemap_addr) {
> > > > +		tst_res(TFAIL, "mmap() at unexpected address %p
> > > > instead
> > > > of %p\n", p,
> > > > +		     hugemap_addr);
> > > > +		goto fail;
> > > 
> > > Can we just do return here instead. The failure has been reported
> > > there
> > > is no point in calling tst_brk(TBROK, ...) as well.
> > When we run one iteration only, tst_brk does not make sense, I
> > agree.
> > But if we are running more than one iteration (i >= 2), test
> > should not continue to next iteration if the current iteration
> > fails.
> > Only way I could find is to use tst_brk(TBROK,... , as
> > tst_brk(TFAIl...
> > is deprecated.
> 
> I do not see why we should abort on first failure as long as it's not
> unrecoverable error. The TBROK status is only for cases where
> something
> went really wrong and we cannot continue.

Understood. I have removed it & updated your suggestions here
https://lore.kernel.org/all/20221019184846.89318-1-tsahu@linux.ibm.com/
Here, I posted same patches in small batch (only 3 at first) based on
suggestion given by Richard.
> 
> > > > +static void cleanup(void)
> > > > +{
> > > > +	if (fd >= 0)
> > > > +		SAFE_CLOSE(fd);
> > > > +	umount2(Hopt, MNT_DETACH);
> > > 
> > > We whould umount here only if we actually have mounted something.
> > umount only, will require explicit unmap when test fails or break.
> > For
> > that, all the local variable for address mapping will have to be
> > static defined so that they can be accessed in cleanup() function.
> > 
> > I tried to avoid it by using umount2 which eventually umount when
> > process unmaps all the mappings after it finishes.
> 
> That's not what I meant, as long as you pass Hopt on a commandline
> the test shoud not attempt to umount it at all.

Hopt is supposed to be the location which test will use to mount/umount
the hugetlbfs fs. If Hopt is not provided, it will create a temp
location. It is only to avoid creating any temporary locations outside
user concerned test environment.

     if(!Hopt)
	Hopt = tst_get_tmpdir();
     SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);

It is not expecting any already mounted hugetlbfs.
Please, check 
https://lore.kernel.org/all/20221019184846.89318-1-
tsahu@linux.ibm.com/
 for updated patch.

Thanks, 
Tarun


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
