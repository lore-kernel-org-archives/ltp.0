Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D07F419BB
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 13:57:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69D143E5B6D
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 15:57:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73B473D0284
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 15:56:47 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C122C1A008A2
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 15:56:45 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F5Kb2d1859874; Wed, 15 Apr 2026 13:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GSFVtq
 d5OFAXJw1h6gyxSH1IEdf0nm7BNR2mtlYIEGE=; b=FmLulThs3TR7S07kyyvQcn
 QwnvMaFO0cVkmM4Gl4z+mbqjkK6OD1Lz4yrqTvncNpGFbWhUm3X8eDI6ujUkpP7l
 JUMK/VnBC9wVbJlIki/NSgEdL7RSTfNvBygHAIzwq+LlrGIkGbSGpRq60TCXT5Kk
 PAf+L9je/Cfhoo9pvpR+rbv/Posw5ZsnCxUeLEtwIHLV+FzGkWTD/aWDZkd3lnWs
 sSvbhOkzjO7ARjdq1g2zeqtkbmTbItHrkvHQwnGQ7M8co7RVv2WKwyq6L4xB+6qh
 LfPUCE1s01GcmR98CLl2emRd5FY+RAAOWtDuZPzY6U2yTSkng0iRpnLlkRj8GKQA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pfw5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 13:56:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FDfI2H025621;
 Wed, 15 Apr 2026 13:56:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujp9bj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 13:56:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63FDuhBE30737108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Apr 2026 13:56:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F39D45804B;
 Wed, 15 Apr 2026 13:56:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB00158063;
 Wed, 15 Apr 2026 13:56:41 +0000 (GMT)
Received: from [9.43.127.43] (unknown [9.43.127.43])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Apr 2026 13:56:41 +0000 (GMT)
Message-ID: <e4a4196d-03da-45a9-add8-4cf70286898d@linux.ibm.com>
Date: Wed, 15 Apr 2026 19:26:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260324052241.21455-1-sachinp@linux.ibm.com>
 <20260324052241.21455-3-sachinp@linux.ibm.com> <ad9hdOxg9CYxgNBb@yuki.lan>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <ad9hdOxg9CYxgNBb@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EWSPHUCaWaA9KFqVQ4xRkHvfWXQrL5fu
X-Proofpoint-ORIG-GUID: EWSPHUCaWaA9KFqVQ4xRkHvfWXQrL5fu
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69df991c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=-EJYuLv8UT8iYrDxEbUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyOCBTYWx0ZWRfXyi+xuEObbZQb
 P9RUkytGg2LyHC9oO5iYKE5sZYgH36rJiVgoIkz0Fn53UXdeKLAkUclu1F8cZPFtfj4XxBPL/X+
 06j7beS71coY/MYny/ItpyqRRApU8XtjgwWZBY1PxrWeWY8cFNSVXnB+5T0Eu8gF9o+wRHCkK1A
 Fd7nc/nFvvECnTIuYdXvqZwgU+44Jx71MheE467ZblJI0K0HYxeLCNKUGpbK/9947RbtZRYlxn9
 ajDFJ3+CQIP4OHRUWjLCYLYXMJKB+lgBZuwoRlUJbWFZJyrefvLbTt+5Jj99ffMjGh0Ow9aXY8Q
 NUh0ebiHtfWmFGKF5LK3qsponXnPaS/evt5SEY/raVIpp6PsbOFiej9AW5nie4TYigRpyK1+7M5
 XeLcb5onxizNA4ba4a6Xq9Mcl/Ws1aTKn0yOhjvDdt8YhgPJV4+xLXFgwkLDMlbX/19Xe3nE7FV
 bQjuNtdMIChZUNW69/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150128
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] io_uring: Test READV and WRITEV operations
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

>> +static void prepare_read_buffers(void)
>> +{
>> +	size_t i;
>> +
>> +	for (i = 0; i < NUM_VECS; i++)
>> +		memset(read_iovs[i].iov_base, 0, read_iovs[i].iov_len);
>> +}
>> +
>> +static void clear_iovec_buffers(struct iovec *iovs, int nvecs)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < nvecs; i++)
>> +		memset(iovs[i].iov_base, 0, iovs[i].iov_len);
>> +}
> These two functions are nearly identical, we really need only one
> function to clear the buffers.
>
Indeed. Good catch. Will merge them.

>> +static void test_varying_sizes(void)
>> +{
>> +	int fd;
>> +	int expected_size = VAR_BUF1_SIZE + VAR_BUF2_SIZE + VAR_BUF3_SIZE;
>> +
>> +	tst_res(TINFO, "Testing vectors with varying sizes including zero-length buffer");
>> +
>> +	io_uring_init_buffer_pattern(var_write_iovs[0].iov_base, VAR_BUF1_SIZE, 'X');
>> +	io_uring_init_buffer_pattern(var_write_iovs[2].iov_base, VAR_BUF2_SIZE, 'Y');
>> +	io_uring_init_buffer_pattern(var_write_iovs[3].iov_base, VAR_BUF3_SIZE, 'Z');
> Can we handle this with the prepare_write_buffers() as well?
These two functions implement different logic. prepare_write_buffers() 
create a rotating
pattern unique to each vector while io_uring_init_buffer_pattern() fills 
a buffer with
a single repeating character.

But I see your point. I will merge these two as well.

Thank You for the detailed review.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
