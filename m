Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C96C4332F
	for <ltp@archiver.kernel.org>; Thu, 29 Dec 2022 19:07:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 145333CD0E3
	for <ltp@archiver.kernel.org>; Thu, 29 Dec 2022 20:06:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F1333CB797
 for <ltp@lists.linux.it>; Thu, 29 Dec 2022 20:06:48 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 521656005F3
 for <ltp@lists.linux.it>; Thu, 29 Dec 2022 20:06:46 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BTJ15Oe011126; Thu, 29 Dec 2022 19:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=yI4kQnGVNCZENhckBmEJHtaTJ42oOwlqMMuMXsCAnNE=;
 b=c3NwRdTgXmOsJ9FBaRLOA25sdvX7j4WiixqU+Qj9N7vtwlL+2yyWhjGwM0y9WJ5oxomt
 RyGJvR+cUNQ6pZ+1tkxrU9LIdKCEDForV7EvZ9mhfP2PgkR/qjxgsl59G1Xog/2/zA5S
 MjdGUofRoMauMG8BmpeKqiTLWbz7g2F6zudgUaJccAZjVWHEM34KfKUQTkiWYOaCMWQt
 N5mnxeI4QBlDOXKyCFHuN9dW3wBD5KDP9imvCOZ5ov62wS/vpSomaaMNkPg1To0cYod9
 d7hmMdZPMY+xN1Y2GdXSswHbrwDA/xHHSP5dqUGePmfCCXpmgPIM3q7ocHwSfTOPaBZb Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3msgpbr3rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Dec 2022 19:06:44 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BTJ2oe5018543;
 Thu, 29 Dec 2022 19:06:44 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3msgpbr3r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Dec 2022 19:06:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BTExF3d005498;
 Thu, 29 Dec 2022 19:06:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mns26q95r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Dec 2022 19:06:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BTJ6c5H47251718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Dec 2022 19:06:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2BDE20043;
 Thu, 29 Dec 2022 19:06:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C97EA20040;
 Thu, 29 Dec 2022 19:06:35 +0000 (GMT)
Received: from tarunpc (unknown [9.43.1.115])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 29 Dec 2022 19:06:35 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
In-Reply-To: <87tu1gogg9.fsf@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-7-tsahu@linux.ibm.com>
 <CAEemH2fOB=NSnCt=JMhpDU49MwHvP+z7hjmUoEXi-BEM-tvqCw@mail.gmail.com>
 <87tu1gogg9.fsf@linux.ibm.com>
Date: Fri, 30 Dec 2022 00:36:31 +0530
Message-ID: <878riqghc8.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dmlT6W7DXcIHahh98NZ4HjXUYgt2piIQ
X-Proofpoint-GUID: YeUoWlGULUyN24waeXfRuAqzMapGkhAx
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-29_10,2022-12-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212290158
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

Hi,


Tarun Sahu <tsahu@linux.ibm.com> writes:

> Hi Li,
> Thanks for reviewing the patch.
> I will update it in next revision.
>
> --skip
>>> +static int do_readback(void *p, size_t size, const char *stage)
>>> +{
>>> +       unsigned int *q = p;
>>> +       size_t i;
>>> +
>>> +       tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")", __func__, p,
>>> +              (unsigned long)size, stage);
>>> +
>>> +       for (i = 0; i < (size / sizeof(*q)); i++)
>>> +               q[i] = RANDOM_CONSTANT ^ i;
>>> +
>>> +       for (i = 0; i < (size / sizeof(*q)); i++) {
>>> +               if (q[i] != (RANDOM_CONSTANT ^ i)) {
>>> +                       tst_res(TFAIL, "Stage \"%s\": Mismatch at offset
>>> 0x%lx: 0x%x "
>>> +                                       "instead of 0x%lx", stage, i,
>>> q[i], RANDOM_CONSTANT ^ i);
>>> +                       return -1;
>>> +               }
>>> +       }
>>> +       return 0;
>>> +}
>>> +
>>> +static int do_remap(void *target)
>>> +{
>>> +       void *a, *b;
>>> +       int ret;
>>> +
>>> +       a = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
>>> +                 MAP_SHARED|MAP_ANONYMOUS, -1, 0);
>>> +
>>> +       ret = do_readback(a, page_size, "base normal");
>>> +       if (ret)
>>> +               goto cleanup;
>>> +       b = mremap(a, page_size, page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
>>> +                  target);
>>> +
>>> +       if (b != MAP_FAILED) {
>>> +               do_readback(b, page_size, "remapped");
>>> +               a = b;
>>> +       } else
>>> +               tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED) disallowed");
>>> +
>>> +cleanup:
>>> +       SAFE_MUNMAP(a, page_size);
>>> +       return ret;
>>> +}
>>>
>>
>> Those two functions do_readback() and do_remap() are
>> copy&past from hugemmap2[4|5].c, what about extracting
>> them into a common header file(tst_hugetlb.h or mem.h) for
>> easy reusing?
>>
> ok, I think, hugetlb.h/.c will be better place to keep them.
>
These two functions are very specific to tests (specially the do_remap).
Also, they use values that are defined only inside the test.
Though do_readback is more general which can be put in hugetlb.h/c.

WDYT?
>> And I also noticed other tests (hugemmap27) using the same
>> macro mem barrier(), it'd be great to define it in a header file.
>>
> ok.
>>
>> -- 
>> Regards,
>> Li Wang
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
