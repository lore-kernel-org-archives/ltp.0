Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A5AC4167B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 18:22:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 376A03CB841
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 19:22:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8691B3CB832
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 19:21:59 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EFA481000741
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 19:21:57 +0100 (CET)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BRFPvQ6027909; Tue, 27 Dec 2022 18:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=GCrhXgYBzNsEuY7VYoxAl1p7pvTocsYVSj5+bzjDjdw=;
 b=Wji/la4vYrGahZfo2+D8KlWZBKyOHyVO5xJyb/9ErPAgbr7CzEnBdbRiAfdXF9H1pOJ6
 Gw53709bqlbUZ1dW6DuRDwHb+YNOVkrCJOSGtNGsNWm+JaqyNV/jWGfe6jkkJ7pKCT95
 p1YeBUS/Dvz3cccK6VefwPfuOmU34afgb4TpJzGRi6M4Mv7S4UFHD+jBxOJkvkg6rnMc
 ySZ5v8G7fyQVlvRvWBhcKLjpGUYLUnst4f8YC/qnTtvI7kpibit0lfQ4bunnuuVC9alm
 qLnE2dNzW38CkdmjBLdb4fhVi/NfNbmTOk0DMEcn1/W4/Hq/6ylRlHdltjlSFKlyHj37 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mr3bgts4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Dec 2022 18:21:55 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BRIL7Ot008507;
 Tue, 27 Dec 2022 18:21:54 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mr3bgts45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Dec 2022 18:21:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRD336v006067;
 Tue, 27 Dec 2022 18:21:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mns26kvke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Dec 2022 18:21:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BRILmLc50004384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Dec 2022 18:21:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 598C120043;
 Tue, 27 Dec 2022 18:21:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9365C20040;
 Tue, 27 Dec 2022 18:21:45 +0000 (GMT)
Received: from tarunpc (unknown [9.43.18.197])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 27 Dec 2022 18:21:45 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
In-Reply-To: <CAEemH2fOB=NSnCt=JMhpDU49MwHvP+z7hjmUoEXi-BEM-tvqCw@mail.gmail.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-7-tsahu@linux.ibm.com>
 <CAEemH2fOB=NSnCt=JMhpDU49MwHvP+z7hjmUoEXi-BEM-tvqCw@mail.gmail.com>
Date: Tue, 27 Dec 2022 23:51:42 +0530
Message-ID: <87tu1gogg9.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1RX07Z3CL4UZN07PbcbTd1riSk_AMyL5
X-Proofpoint-GUID: Tw6Fd30VovJREvKBfP51Qbcz4CF53h3Q
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_13,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270149
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/13] Hugetlb: Migrating libhugetlbfs
 mremap-fixed-normal-near-huge
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

Hi Li,
Thanks for reviewing the patch.
I will update it in next revision.

--skip
>> +static int do_readback(void *p, size_t size, const char *stage)
>> +{
>> +       unsigned int *q = p;
>> +       size_t i;
>> +
>> +       tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")", __func__, p,
>> +              (unsigned long)size, stage);
>> +
>> +       for (i = 0; i < (size / sizeof(*q)); i++)
>> +               q[i] = RANDOM_CONSTANT ^ i;
>> +
>> +       for (i = 0; i < (size / sizeof(*q)); i++) {
>> +               if (q[i] != (RANDOM_CONSTANT ^ i)) {
>> +                       tst_res(TFAIL, "Stage \"%s\": Mismatch at offset
>> 0x%lx: 0x%x "
>> +                                       "instead of 0x%lx", stage, i,
>> q[i], RANDOM_CONSTANT ^ i);
>> +                       return -1;
>> +               }
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int do_remap(void *target)
>> +{
>> +       void *a, *b;
>> +       int ret;
>> +
>> +       a = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
>> +                 MAP_SHARED|MAP_ANONYMOUS, -1, 0);
>> +
>> +       ret = do_readback(a, page_size, "base normal");
>> +       if (ret)
>> +               goto cleanup;
>> +       b = mremap(a, page_size, page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
>> +                  target);
>> +
>> +       if (b != MAP_FAILED) {
>> +               do_readback(b, page_size, "remapped");
>> +               a = b;
>> +       } else
>> +               tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED) disallowed");
>> +
>> +cleanup:
>> +       SAFE_MUNMAP(a, page_size);
>> +       return ret;
>> +}
>>
>
> Those two functions do_readback() and do_remap() are
> copy&past from hugemmap2[4|5].c, what about extracting
> them into a common header file(tst_hugetlb.h or mem.h) for
> easy reusing?
>
ok, I think, hugetlb.h/.c will be better place to keep them.

> And I also noticed other tests (hugemmap27) using the same
> macro mem barrier(), it'd be great to define it in a header file.
>
ok.
>
> -- 
> Regards,
> Li Wang
>
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
