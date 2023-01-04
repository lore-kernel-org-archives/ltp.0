Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE20BC4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 17:59:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DA4B3CCDE6
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 18:59:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D816E3CB66A
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 18:59:21 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 34CFD20074C
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 18:59:19 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304HFXoA031582; Wed, 4 Jan 2023 17:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=BlsX4nLV1lCNftvj6vkHD/Enq3lHtfb619ePz+e7kl4=;
 b=PITt0vV2+b80QVdIwNiM36v9Td9thfYbJ8Qvlu+EdtaG0KmcSHraI5UynIA901lBkryr
 ogdoK8Nxb+ZWmnJJc7E23DkwAtBF2u4Ih3F309Z0wkXYj6rj5Ed6PehZu+S1cnaZKw+H
 Cy6Q2JHJsHEgtGMfxWszvSyGHj9eGQ+sNqQuGV3nXWTcoI0njW6VBo0d2GUYz1xowUHw
 cFiaaZLiow0l/PKTkVw6C6EPtJajUgApiU2XSVs8LFvSs27qCgvNfBm2nmfZVeurig4v
 GwNkdhfLvXpJdCFw1IvSUFHrnuKjcfevMp4w88npCm6Ecv0I9G+zN25oQ28IILsqa5lU ug== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwdpvgx9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 17:59:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30486XiN001864;
 Wed, 4 Jan 2023 17:59:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfdp09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 17:59:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304HxA7643385110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 17:59:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D55220049;
 Wed,  4 Jan 2023 17:59:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7746220040;
 Wed,  4 Jan 2023 17:59:07 +0000 (GMT)
Received: from tarunpc (unknown [9.43.118.44])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  4 Jan 2023 17:59:07 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
In-Reply-To: <Y7Ryhx50EvHpbwI4@pevik>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-13-tsahu@linux.ibm.com> <Y7Ryhx50EvHpbwI4@pevik>
Date: Wed, 04 Jan 2023 23:29:03 +0530
Message-ID: <87wn6241w8.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r-sPzj52y7EMGh6JRZvRKswEIHXi8Xgv
X-Proofpoint-GUID: r-sPzj52y7EMGh6JRZvRKswEIHXi8Xgv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040146
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 12/13] Hugetlb: Migrating libhugetlbfs shm-fork
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

Petr Vorel <pvorel@suse.cz> writes:

Hi Petr,

Thanks for reviewing it.

> Hi,
>
>> Migrating the libhugetlbfs/testcases/shm-fork.c test
> NOTE: if you're talking about libhugetlbfs [1], the test path is
> tests/shm-fork.c (not testcases).
Ohh Right. Thanks for pointing this out.
I checked, I did the same in all the past testcases, will take
care of it.

>
>
>> Test Description: Test shared memory behavior when multiple threads are
>> Test shared memory behavior when multiple threads are attached
>> to a segment.  A segment is created and then children are
>> spawned which attach, write, read (verify), and detach from the
>> shared memory segment.


>> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
>> ---
>>  runtest/hugetlb                               |   1 +
>>  testcases/kernel/mem/.gitignore               |   1 +
>>  .../kernel/mem/hugetlb/hugefork/hugefork02.c  | 104 ++++++++++++++++++
>>  3 files changed, 106 insertions(+)
>>  create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
>
>> diff --git a/runtest/hugetlb b/runtest/hugetlb
>> index 33fd384b4..348a7dc5f 100644
>> --- a/runtest/hugetlb
>> +++ b/runtest/hugetlb
>> @@ -2,6 +2,7 @@ hugefallocate01 hugefallocate01
>>  hugefallocate02 hugefallocate02
>
>>  hugefork01 hugefork01
>> +hugefork02 hugefork02 -P 3 -s 5
>
> You're not define tst_option [2] (you don't even have any code which would hold
> these options), therefore passing any of these 2 options will quit the test:
> hugefork02: invalid option -- 'P'
>
> Please fix it in next version.
>
Fixed it in next revision.
please check here: https://lore.kernel.org/all/20230104122224.369467-1-tsahu@linux.ibm.com/
> Kind regards,
> Petr
>
> [1] https://github.com/libhugetlbfs/libhugetlbfs
> [2] https://github.com/linux-test-project/ltp/wiki/C-Test-API#15-test-specific-command-line-options
>
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
