Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8BFC4332F
	for <ltp@archiver.kernel.org>; Sat, 31 Dec 2022 05:08:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C35FF3CD083
	for <ltp@archiver.kernel.org>; Sat, 31 Dec 2022 06:08:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 934513CA941
 for <ltp@lists.linux.it>; Sat, 31 Dec 2022 06:08:45 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8960B600831
 for <ltp@lists.linux.it>; Sat, 31 Dec 2022 06:08:42 +0100 (CET)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BV1vvYS009643; Sat, 31 Dec 2022 05:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=otMgNVw38nQH8GHHDO1XG5x/YdoMbL9mKEQPVAKpMNk=;
 b=LMh21bnEUteWgWAjx6XlC0oYDVWoo7xtovW+LRPhFlwbic0RxyGz5ONx8k9FP6WxfPBb
 0J1L0Hpvs8bTHF9fp+hWeBkUhCmZTF8UOo/ngxRO/gUAEfLmFOwzdTr0i0gCXSrSYJVX
 GVZnc+6rgw+mNWzzlM64+TN+PfUUQYmyz1Fz0TsTPVq7VvHT8iZud/9OsVW95XjmpCLY
 mhjGut8OQwBzLix6diSoZFBwZsif9gPjKoLlFePMM+NYDlEiWhkETUjsGZzWp8uvkola
 ACMIexSr5rkkxTzywKJ9sno9TY3yZg7heey6yCOUMQs7CUWuBYq+fwOH3zpB6hZXHE+N GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtbvs1xp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 31 Dec 2022 05:08:40 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BV50FVN008461;
 Sat, 31 Dec 2022 05:08:40 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtbvs1xp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 31 Dec 2022 05:08:40 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BV2sfIG023612;
 Sat, 31 Dec 2022 05:08:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6823c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 31 Dec 2022 05:08:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BV58YPw21627462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 31 Dec 2022 05:08:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DDC920043;
 Sat, 31 Dec 2022 05:08:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36E9D20040;
 Sat, 31 Dec 2022 05:08:31 +0000 (GMT)
Received: from tarunpc (unknown [9.43.66.228])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 31 Dec 2022 05:08:30 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
In-Reply-To: <CAEemH2e3=uYh3ZSO1WsrM_MqS55jhe2bs+_LG6A+WT9ve623NA@mail.gmail.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-7-tsahu@linux.ibm.com>
 <CAEemH2fOB=NSnCt=JMhpDU49MwHvP+z7hjmUoEXi-BEM-tvqCw@mail.gmail.com>
 <87tu1gogg9.fsf@linux.ibm.com> <878riqghc8.fsf@linux.ibm.com>
 <CAEemH2e3=uYh3ZSO1WsrM_MqS55jhe2bs+_LG6A+WT9ve623NA@mail.gmail.com>
Date: Sat, 31 Dec 2022 10:38:27 +0530
Message-ID: <87o7rkgnxw.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2wmRn3dRXzQIH6zla4Vl0Z3mM1NB6CVP
X-Proofpoint-ORIG-GUID: mh-drW3afKslAuir_fDWjvkXdZpiFGFf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-31_02,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212310046
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

Li Wang <liwang@redhat.com> writes:

> On Fri, Dec 30, 2022 at 3:06 AM Tarun Sahu <tsahu@linux.ibm.com> wrote:
>
>> Hi,
>>
>>
>> Tarun Sahu <tsahu@linux.ibm.com> writes:
>>
>> > Hi Li,
>> > Thanks for reviewing the patch.
>> > I will update it in next revision.
>> >
>> > --skip
>> >>> +static int do_readback(void *p, size_t size, const char *stage)
>> >>> +{
>> >>> +       unsigned int *q = p;
>> >>> +       size_t i;
>> >>> +
>> >>> +       tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")", __func__, p,
>> >>> +              (unsigned long)size, stage);
>> >>> +
>> >>> +       for (i = 0; i < (size / sizeof(*q)); i++)
>> >>> +               q[i] = RANDOM_CONSTANT ^ i;
>> >>> +
>> >>> +       for (i = 0; i < (size / sizeof(*q)); i++) {
>> >>> +               if (q[i] != (RANDOM_CONSTANT ^ i)) {
>> >>> +                       tst_res(TFAIL, "Stage \"%s\": Mismatch at
>> offset
>> >>> 0x%lx: 0x%x "
>> >>> +                                       "instead of 0x%lx", stage, i,
>> >>> q[i], RANDOM_CONSTANT ^ i);
>> >>> +                       return -1;
>> >>> +               }
>> >>> +       }
>> >>> +       return 0;
>> >>> +}
>> >>> +
>> >>> +static int do_remap(void *target)
>> >>> +{
>> >>> +       void *a, *b;
>> >>> +       int ret;
>> >>> +
>> >>> +       a = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
>> >>> +                 MAP_SHARED|MAP_ANONYMOUS, -1, 0);
>> >>> +
>> >>> +       ret = do_readback(a, page_size, "base normal");
>> >>> +       if (ret)
>> >>> +               goto cleanup;
>> >>> +       b = mremap(a, page_size, page_size, MREMAP_MAYMOVE |
>> MREMAP_FIXED,
>> >>> +                  target);
>> >>> +
>> >>> +       if (b != MAP_FAILED) {
>> >>> +               do_readback(b, page_size, "remapped");
>> >>> +               a = b;
>> >>> +       } else
>> >>> +               tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED)
>> disallowed");
>> >>> +
>> >>> +cleanup:
>> >>> +       SAFE_MUNMAP(a, page_size);
>> >>> +       return ret;
>> >>> +}
>> >>>
>> >>
>> >> Those two functions do_readback() and do_remap() are
>> >> copy&past from hugemmap2[4|5].c, what about extracting
>> >> them into a common header file(tst_hugetlb.h or mem.h) for
>> >> easy reusing?
>> >>
>> > ok, I think, hugetlb.h/.c will be better place to keep them.
>> >
>> These two functions are very specific to tests (specially the do_remap).
>> Also, they use values that are defined only inside the test.
>> Though do_readback is more general which can be put in hugetlb.h/c.
>>
>> WDYT?
>>
>
> Ah yes, I didn't realize the difference.
> Or can we pass the specific arguments based on the variable part?
> e.g.
>
>     static int do_remap(int fd, size_t page_size; int prot, void *target);
>
This can be done this way, but What concerned me is mremap function
itself. it is defined in sys/mmap under _GNU_SOURCE. I am not sure
whether it will be ok to use _GNU_SOURCE specific function in
lib/hugetlb.c/h file.

please confirm if it is ok to define _GNU_SOURCE in hugetlb.c/h.
>
> -- 
> Regards,
> Li Wang
>
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
