Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B07C5DF85
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7122B3CF487
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 18:50:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE1B13C5A12
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 18:49:56 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B3AEF1400B94
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 18:49:55 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KGVijs1192734
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ilZXkK
 0MYNjwpk9XqV7ONqNw1Z0tZLs58noNO+bqd0w=; b=IsjYmGQ/pF4RpEm+lMSQJh
 cfolHzDY/k0OjQ/so5DinqeFhs0BkREc0Yv2EAlrhLyFSspqO/ZKmsiSOdzn6vr7
 wXclJqeSiv/+Zu2OKnQxDqUzvd7kdmyQvgjZApKYszmVfjpV5SEFU7QZ6JgPppzj
 J0QUNlmsIK5RZ3epKursHUqz/8aKCi/SpfGOmnd0T/IU3RFihseq54jjJAEL2QuM
 n8NBTuKOQM9+pjJDL+aKHVaOccvFi6ifF7aJdOfirNxweL+86iJ68DcQ6ZYGkWAa
 PpgKbJYYyD9wQDIb1hFWBND2t+dv/3FRpD074RHCMA8Yn1iLL+qodPzgqatyk5kg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0bq73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 16:49:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KGfODs013420;
 Thu, 20 Aug 2026 16:49:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekfnyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 16:49:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KGnpUq34145012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 16:49:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAFC85805A;
 Thu, 20 Aug 2026 16:49:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18DE758051;
 Thu, 20 Aug 2026 16:49:50 +0000 (GMT)
Received: from [9.43.90.108] (unknown [9.43.90.108])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 16:49:49 +0000 (GMT)
Message-ID: <b73168f8-beff-4185-b3f2-91c3fbdb7981@linux.ibm.com>
Date: Thu, 20 Aug 2026 22:19:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxtestproject.agent@gmail.com
References: <20260820042516.46631-1-samir@linux.ibm.com>
 <20260820103328.8356-1-linuxtestproject.agent@gmail.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260820103328.8356-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VAw6MU9WCQL7eoHGh-Np9jOzAPoLJYAD
X-Proofpoint-GUID: QU2DnFVKYGGOt6mMRlVuMIps9dWxdaTu
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a873031 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=e1jxkg9pX5HLVYnBzN4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyNSBTYWx0ZWRfX7SyZZczi+maa
 IUYHXi8RCjOE/xH8bG/dgQX7Z/NjtS1Q4nBYFt2OuzT+Ulc5FGQ7nSbTyPKMSpwBRpFcsu5xFKs
 dU92ONfXE8cLdNCNsbZxjiiarGGhgP0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNSBTYWx0ZWRfX9OKNkYsycYi3
 OyxDz/XlhgSg0Gw2KLiDSjUAQe6hReCIoJsfkJ6wT9KYq5TBbx5jW6PIJdZ55ewAJ4X2+tAriuD
 pQJXyh9lKEd9CmNcylEggMPpsSV+pycTce/TO9+TRW0BX6fwyowDWKGWHxRkwjqg+dceLzO1So3
 RY7oIeYiDw4x72r/3zDLqd4AGGI+rwzw9fWE84WBxlqQqgfCpfUF0rKLqzBDVlQaQjBOns+myuS
 z74xt/2FHVHH/jlLzAd8/R+W450MCAi4egVlFu+cBQeU8mWlLXhiYC/w/8o8XRkZm1zWEihWQsm
 8osbEmAbCTu9sy9cJrecwO8HdZZ9II8WA5Dj3Gh7PLeIZkSy4Z3tCEoGavmHBUn3ZpOHUhIYkMb
 ah8+629hf+R1B6vUvE09/kBcZo9iIVqvAXTaBsFUdZDcwyghx57a/M8SYyqomS7Bh8OTpayELOo
 48Ixn5wnPLP3UFaKq8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200125
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugeshmat: Add hugeshmat06 migrated from
 libhugetlbfs shm-perms
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


On 20/08/26 4:03 pm, linuxtestproject.agent@gmail.com wrote:
> Hi Samir,
>
> On Aug 20, 2026, Samir Mulani wrote:
>> hugetlb/hugeshmat: Add hugeshmat06 migrated from libhugetlbfs shm-perms
>> 			hugetlb_after = get_proc_hugetlb_kb(getpid());
>> 			if (hugetlb_after != 0) {
>> 				tst_res(TFAIL,
>> 					"Child %d: HugetlbPages after detach is %ld kB (expected 0), reservation accounting leak",
> Could this use an oracle tied to reservation state instead? In Linux 7.2,
> HugetlbPages reports mm->hugetlb_usage, which is incremented when a huge
> page is mapped and decremented when it is unmapped. The original regression
> leaked hstate->resv_huge_pages, so HugetlbPages can return to zero after
> shmdt() while that reservation remains leaked.
>
> The original test exposed this by making enough read-only attachments to
> exhaust the pool. Here, an eventual shmat() failure would also be handled by
> SAFE_SHMAT() as TBROK rather than reported as a failure of the operation
> under test. Could the original reservation-leak oracle be retained and the
> regression reported as TFAIL?

Agreed. HugetlbPages tracks the hugepage mappings associated with the
process and can return to zero after shmdt() while the underlying
resv_huge_pages reservation remains leaked.

I have retained the original reservation-exhaustion behavior and handle
the relevant shmat() failure explicitly as TFAIL instead of using
SAFE_SHMAT(), which would report it as TBROK.

Updated in v5.
>
>> #define SEGMENT_KEY	(0x82ba15ff)
>> 	shmid = SAFE_SHMGET(SEGMENT_KEY, segment_size,
>> 			    IPC_CREAT | SHM_HUGETLB | 0640);
> Could this segment use IPC_PRIVATE? IPC_CREAT without IPC_EXCL returns an
> accessible pre-existing segment for this key when it is large enough.
> setup() would then overwrite that segment, and cleanup() would remove
> another process's IPC object with IPC_RMID.

Agreed. Replaced SEGMENT_KEY with IPC_PRIVATE. The children inherit
global_shmid directly, so a fixed key is not required. The unused
SEGMENT_KEY definition has also been removed.
>
>> /*\
>>   * [Description]
> Could the deprecated [Description] header be dropped?
Agreed. Removed the deprecated [Description] tag while retaining the
test description, consistent with the convention used by other tests
in this area.
>> static struct tst_test test = {
>> 	.needs_root	 = 1,
> Could the high-level description explain why root is required, namely that
> the framework modifies the system huge-page pool to reserve pages?
I checked the other tests in the hugeshmat and hugefork directories
and none of them document needs_root in the description block. It is
a well understood LTP framework convention so I am keeping it as is.
>> +/hugetlb/hugeshmat/hugeshmat06
> Could this entry be placed in
> testcases/kernel/mem/hugetlb/hugeshmat/.gitignore instead? New test binaries
> belong in the .gitignore in their own directory.
There is no per-directory .gitignore under
testcases/kernel/mem/hugetlb/hugeshmat/. The existing hugeshmat01
through hugeshmat05 binary entries are maintained in
testcases/kernel/mem/.gitignore. I have kept the hugeshmat06 entry
there to remain consistent with the existing hugeshmat tests.
>
> Verdict - Needs revision
>
> ---
> Note:
>
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
>
> Regards,
> LTP AI Reviewer
>
Regards,
Samir

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
