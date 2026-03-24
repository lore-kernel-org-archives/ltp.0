Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FA9F532D4
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 05:16:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B4803E6B83
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 06:16:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AC663C62D0
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:16:03 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 55AF41A00EF3
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:16:01 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NFFDLS662269; Tue, 24 Mar 2026 05:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1sflfk
 pz3n1+QuaQHsX6SnCQIVD0fw28XY2/kjWxeTc=; b=i+fIN8XGhR15nTK7FeK+Mq
 mOpBzw4iqErJIa3Hx54Nd/jVUXmn52Cs1jAVmCH7HnPB7sMDvXkOwQzTMfD0n1jj
 VacwQpoJ5RdiPXUKzVLVZzVnpJ91pWI0CorQM1r002CLNjaxm9OFIy4gB6tTRJLL
 hG9ZWmaPqRcHiw7QKxctBbZ/bAvg6SYy59OigYN4Rn3dfZ8LAVdBg0qPpOaJiHSp
 Bxi4Ht9poLZaOsFsDjvtdmh39Ec0aSggqzDXoHBkCTHvOjj7JQogoMY+iKVZRDTa
 YlCq/5nKyx/qjjL2AfuhKSt/BpPkT1uxUNloSr6U1quMzU/sOS1nmmk85MtsEb6A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuse93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 05:15:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O3HIrk008722;
 Tue, 24 Mar 2026 05:15:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nng9kc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 05:15:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62O5FwTf36569764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 05:15:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9A8858059;
 Tue, 24 Mar 2026 05:15:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC21958055;
 Tue, 24 Mar 2026 05:15:57 +0000 (GMT)
Received: from [9.43.76.226] (unknown [9.43.76.226])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 05:15:57 +0000 (GMT)
Message-ID: <3a221c0c-abe8-4483-bcbf-1fe0ebb5df8f@linux.ibm.com>
Date: Tue, 24 Mar 2026 10:45:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260320124742.75946-1-sachinp@linux.ibm.com>
 <20260320124742.75946-3-sachinp@linux.ibm.com> <acFo4gfmugdfiOwI@yuki.lan>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <acFo4gfmugdfiOwI@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NTqmk5NRfrjFTi9T0INvd11INOFqD7vD
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c21e0f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=wpqP7JLZNQ9YzKkI1QMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAzOCBTYWx0ZWRfXyz99pNs+XUeu
 lbtF0TAaOA7imUFndO20EtClPGoNzwJjuXbMn5SEBBAwu5W56ukrp1V/R1o+5zv4OXs+M+2M6pz
 0ju36DBX+6AGbx9vbgQ8n4814BZV7n/2wQhHm7jvn3TtbahsNgXWfcwGnitjCbMsd4Sxlun3b34
 sS4Lo5cDkRMCn0FnBn2NOY1Z7qGYqKdHYHsjxF6VEHoEyZ75bx2FIjRvkM/jAN0osu5bkWHwT+B
 q3ArnE31dVTix1J5UHucZH0ND5N2yHXSM7Kqe0irmSpt/qTrV47ZdQk3m7lVD97oGEZ5FAslsDq
 VWIbX5o6hygTQW0bv1jK4hVZMSNp3LDAaarqw6puOitf9Fv6HdPI5DqvtBxgHmXE4SRLuwhVGog
 /ixbTH0X1QaO6rFI8XZTrK6hdFkMLAEPI707C2K+Uw8XjFai3aLs5RQFAfLIHbU9yvJzzp2AsnF
 rWVVQFjnBOEZHqEPshA==
X-Proofpoint-GUID: NTqmk5NRfrjFTi9T0INvd11INOFqD7vD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240038
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] io_uring: Test READV and WRITEV operations
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



On 23/03/26 9:52 pm, Cyril Hrubis wrote:
> Hi!
>> +#define TEST_FILE "io_uring_test_file"
>> +#define QUEUE_DEPTH 2
>> +#define NUM_VECS 4
>> +#define VEC_SIZE 1024
>> +
>> +static char write_bufs[NUM_VECS][VEC_SIZE];
>> +static char read_bufs[NUM_VECS][VEC_SIZE];
>> +static struct iovec write_iovs[NUM_VECS];
>> +static struct iovec read_iovs[NUM_VECS];
> The guarded buffers can allocate iovec for you as well. Have a look at
> readv01.c test how to do that in the tst_test structure.
Thanks Cyril for the review comments. I have addressed them in v2.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
