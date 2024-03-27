Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B6AC54E67
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 10:05:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C1733C039E
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 11:05:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D6A53C0189
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 11:04:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=geetika@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E143614052E0
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 11:04:41 +0100 (CET)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R9M1WT005521; Wed, 27 Mar 2024 10:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=pp1; bh=Y2TfBd7NYu1XN2Zu5zCJxH/hCBMsDJg2QHN6eRrW1mo=;
 b=pvhugaTaDrXRk7n7BMoSAKGqf/VWX9sxqGO1umkxbNJfjlxMzfs4Lgfn6EVF3y3u3h6S
 jriKFokVhLryxMgkMj2t+k0vSEze3UwIhNLnCsUYGzx6m4n8Idfi07AbZOqoNIAHkqoY
 bT6fhNuQ6u/I5UezRYNvtqh+ldbeeghXqmbb/0W3C0Kw8t8cHOCAcBOu9FOIWO0BQZDT
 24rIrUqW1NY3agIAJJKdlWb1bPM0m2nm8Qa/yv2Fug87fgsaofv5VB2KZJWtbW9fcZtK
 5ygQSRLc5dqZbI3qcWOmhWTcIC3kIIhvAX5vP8ZScaaJxty6I4gs2wTMByT/mNLh2z61 lg== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4grug2xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 10:04:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R9Ch64003744; Wed, 27 Mar 2024 10:04:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2c42wbww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 10:04:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42RA4YOt26870122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 10:04:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79F7D201F9;
 Wed, 27 Mar 2024 10:04:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D65F1201FF;
 Wed, 27 Mar 2024 10:04:33 +0000 (GMT)
Received: from [9.43.51.185] (unknown [9.43.51.185])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Mar 2024 10:04:33 +0000 (GMT)
Message-ID: <8cdc9eba-d567-4f57-8731-bcf1497c3d1a@linux.ibm.com>
Date: Wed, 27 Mar 2024 15:34:32 +0530
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20231003133703.98552-1-geetika@linux.ibm.com>
 <20231128115041.GB369141@pevik>
Content-Language: en-US
From: Geetika M <geetika@linux.ibm.com>
In-Reply-To: <20231128115041.GB369141@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dw2PT63URG6bE_9Cn_SJ0MECXH_m9GFX
X-Proofpoint-ORIG-GUID: dw2PT63URG6bE_9Cn_SJ0MECXH_m9GFX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=947 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270068
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] [PATCH] Migrating the
 libhugetlbfs/testcases/straddle_4GB.c
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 28/11/23 5:20 pm, Petr Vorel wrote:
> Hi Geetika,
>
> Please have look at my comments at your previous patch [1] [2], these changes
> apply a lot for your patches as well.
>
> [1]https://lore.kernel.org/ltp/20231128111024.GA364870@pevik/
> [2]https://lore.kernel.org/ltp/20231128112254.GA367506@pevik/
>
Noted.
I will apply whatever changes are applicable to this testcase in the 
next version.

...
>> +
>> +/*\
>> + * [Description]
>> + * This test tries to allocate hugepages to cover a memory range
>> + * that straddles the 4GB boundary.
>> + * Scenario 1 : mmap without MAP_FIXED
>> + * Scenario 2 : mmap with MAP_FIXED
> This will be badly formatted (it will not be list, but inline).
>
> How about:
>
> /*\
>   * [Description]
>   *
>   * Test tries to allocate hugepages to cover a memory range that straddles the
>   * 4GB boundary, using mmap(2) with and without MAP_FIXED.
>   */
>> + */
>> +
>> +#define MAPS_BUF_SZ 4096
>> +#define FOURGB (1UL << 32)
>> +#define MNTPOINT "hugetlbfs/"
>> +#define HUGETLBFS_MAGIC	0x958458f6
> Could you please add this magic definition to include/tst_fs.h
> (as a separate patch), we store all magic there.
>
>> +#define _LARGEFILE64_SOURCE /* Need this for statfs64 */
> We would probably define it in Makefile
>
> hugemmap40: CFLAGS += -D_LARGEFILE64_SOURCE
Noted.
I will apply above changes with the next version.

...

> +
> +static void run_test(void)
> +{
> +	void *p;
> +
> +	/* We first try to get the mapping without MAP_FIXED */
> +	tst_res(TINFO, "Mapping without MAP_FIXED at %lx...", straddle_addr);
> +	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
> +			MAP_SHARED, fd, 0);
> +	if (p == (void *)straddle_addr) {
> +		/* These tests irrelevant if we didn't get the straddle address*/
> +		if (test_addr_huge(p) != 1) {
> +			tst_brk(TFAIL, "1st Mapped address is not hugepage");
> +			goto windup;
> +		}
> +		if (test_addr_huge(p + hpage_size) != 1) {
> +			tst_brk(TFAIL, "2nd Mapped address is not hugepage");
> +			goto windup;
> +		}
> +		memset(p, 0, hpage_size);
> +		memset(p + hpage_size, 0, hpage_size);
> +		tst_res(TPASS, "Mapping without MAP_FIXED at %lx... completed", straddle_addr);
> +	} else {
> +		tst_res(TINFO, "Got %p instead, never mind, let's move to mapping with MAP_FIXED\n", p);
> +		munmap(p, 2*hpage_size);
> +	}
> +	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
> Maybe use .tcnt = 2, in struct tst_test and separate these 2 cases into it's
> wonf functions?
>
> You would either use:
> static void run_test(unsigned int n)
>
> With that you would reduce code duplicity and make test function smaller.
>
> Also, sometimes we use test struct (pointer to the function and description, see
> e.g. testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c).
>
> ...

Can you suggest how we can handle the test exit upon failure inside one 
of test cases then?

Currently I am handling it by using label windup placed at the end of 
function.
In one of the other tests there was feedback to not use exit(0); then 
how can we exit
easily upon failure from one of the testcase?


Thanks & Regards,
Geetika

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
