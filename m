Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5906109316E
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 05:07:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2648A3E4EE8
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 06:07:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F6E63D0E54
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 06:06:52 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 53539602263
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 06:06:51 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JFnGRA2232234; Fri, 20 Mar 2026 05:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5EYM/c
 5b/5v3BgUvYoddMZjEAB2KPvuKAL9riJsS0Tk=; b=f42lgNJa7FABYn/BbpOvwM
 rnitx0YM21wuP7DmUJDs8uHMmEBe5rb8RCWWcdSWzxw6v7QQUNzsUCa5lSGq4se2
 vRWH74P77sARtkwcdIeJPhA1KqLJcHb2cAXnPDXn1pd7/4cyJOf+NgWi78jdPeAO
 ro7M7NarY55LY5Aw0uF6cAP1eW9lrpiMfd2Dg0llQqCQ+S/L9a+LZeTgUtvyM7Si
 2Byfxz5T91X221Y1UqLbTCMazR5oA3Q5yJD/R66p+28ziGFr5gk9LC+kfhroCuBn
 +MaXARp2zgeQBL3nXCBA3M60jANR+mYWXILA+BwpPhJVi/V/Zu1lc1eRLlL2hwtQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfvb8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 05:06:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62K3XZoS014032;
 Fri, 20 Mar 2026 05:06:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcydjws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 05:06:47 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62K56lwr7209782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 05:06:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBA8558147;
 Fri, 20 Mar 2026 05:06:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13AB458145;
 Fri, 20 Mar 2026 05:06:46 +0000 (GMT)
Received: from [9.43.122.180] (unknown [9.43.122.180])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2026 05:06:45 +0000 (GMT)
Message-ID: <269640c4-177c-4e47-889f-2405c53b4fd7@linux.ibm.com>
Date: Fri, 20 Mar 2026 10:36:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260318110328.52031-1-sachinp@linux.ibm.com>
 <20260318110328.52031-2-sachinp@linux.ibm.com> <abwpJ3bR2lwM6Ru3@yuki.lan>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <abwpJ3bR2lwM6Ru3@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mKOTSI5iODQ_pIat1HxcdtZRTAqY11_0
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bcd5e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=lp0cJ3u-F6ibWuxK_iQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAzMiBTYWx0ZWRfXxG0tetzh91bT
 aOtzgfpjt3arC9WesTHr0qVqXrP05hBm/deQppA124GkQAGqnGjvC0KSKcyPwbDfuSkfwKxGSJR
 pbm/zRyZPnev2+gN2YKkcrtUXptdrlzjvvpDbT6ihBIECFlrvH7xuzwKLRYpL82pUcyKJZaa4V+
 95CKLTYkuebzzHkeI5r7nTuoTLLwskNYxOwxxGQ/SLSsG/O+IuV0nmcYOmrrn+7hTedx2jooA/5
 pmKBaoZz5UDmo0NWBcsv1s71dkbPitJu/aODpY8mLckUuVGazx4MtyTF5LVoviCQNXSZ12+99Ub
 6RlfthG8Zv4gAAcxyq/Ktom3DZY3r+3i+oNmrnv1br6Tu+RREUtVEk+dkQstT5QeK7Lzrym4++h
 PdeCogC6IIeJvcjPFbSU8Xc6j5ONBxTRn9w1sNC5xDhtz49MvilbDSS/y3yDnG6aTic+y3npeQS
 3tjOKpy8SgCIFVZ/eeA==
X-Proofpoint-GUID: mKOTSI5iODQ_pIat1HxcdtZRTAqY11_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200032
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] [PATCH 1/2] io_uring: Test IORING READ and WRITE
 operations
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



On 19/03/26 10:19 pm, Cyril Hrubis wrote:
> Hi!
>>   # Tests below may cause kernel memory leak
>>   perf_event_open03 perf_event_open03
>> diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
>> index 749db17db..9382ae413 100644
>> --- a/testcases/kernel/syscalls/io_uring/.gitignore
>> +++ b/testcases/kernel/syscalls/io_uring/.gitignore
>> @@ -1,2 +1,3 @@
>>   /io_uring01
>>   /io_uring02
>> +/io_uring03
>> diff --git a/testcases/kernel/syscalls/io_uring/io_uring03.c b/testcases/kernel/syscalls/io_uring/io_uring03.c
>> new file mode 100644
>> index 000000000..53d4feae5
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/io_uring/io_uring03.c
>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2026 IBM
>> + * Author: Sachin Sant <sachinp@linux.ibm.com>
>> + *
>> + * Test IORING_OP_READ and IORING_OP_WRITE operations.
>> + *
>> + * This test validates basic read and write operations using io_uring.
>> + * It tests:
>> + * 1. IORING_OP_WRITE - Writing data to a file
>> + * 2. IORING_OP_READ - Reading data from a file
>> + * 3. Data integrity verification
>> + */
> The second half of the comment should be doc comment (starts with /*\)
> so that it's picked up by the documentation parser and exported into the
> online documentation.
Ah yes, will modify.
>> +#include "io_uring_common.h"
>> +
>> +#define TEST_FILE "io_uring_test_file"
>> +#define QUEUE_DEPTH 2
>> +#define BLOCK_SZ 4096
>> +
>> +static char write_buf[BLOCK_SZ];
>> +static char read_buf[BLOCK_SZ];
>> +static struct io_uring_submit s;
>> +static sigset_t sig;
>> +
>> +static void test_write_read(void)
>> +{
>> +	int fd;
>> +	size_t i;
>> +
>> +	/* Prepare write buffer with pattern */
> There a lot of comments like this that are commenting the
> obvious. Comments that comment obvious does not add any value and
> shouldn't be added.
Will revisit the code.
>> +	for (i = 0; i < BLOCK_SZ; i++)
>> +		write_buf[i] = 'A' + (i % 26);
> This should be done only once in the test setup.
Will address this in v2.
>> +	/* Open file for writing */
>> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
>> +
>> +	/* Test IORING_OP_WRITE */
>> +	tst_res(TINFO, "Testing IORING_OP_WRITE");
>> +	io_uring_submit_sqe(&s, fd, IORING_OP_WRITE, write_buf, BLOCK_SZ, 0);
>
>
>> +	if (io_uring_wait_cqe(&s, BLOCK_SZ, IORING_OP_WRITE, &sig) == 0)
>> +		tst_res(TPASS, "IORING_OP_WRITE completed successfully");
>> +
>> +	/* Sync to ensure data is written */
>> +	SAFE_FSYNC(fd);
>> +
>> +	/* Test IORING_OP_READ */
>> +	tst_res(TINFO, "Testing IORING_OP_READ");
>> +	memset(read_buf, 0, BLOCK_SZ);
>> +	io_uring_submit_sqe(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0);
>> +
>> +	if (io_uring_wait_cqe(&s, BLOCK_SZ, IORING_OP_READ, &sig) == 0)
>> +		tst_res(TPASS, "IORING_OP_READ completed successfully");
>> +
>> +	/* Verify data integrity */
>> +	if (memcmp(write_buf, read_buf, BLOCK_SZ) == 0) {
>> +		tst_res(TPASS, "Data integrity verified");
>> +	} else {
>> +		tst_res(TFAIL, "Data mismatch after read");
>> +		for (i = 0; i < BLOCK_SZ && i < 64; i++) {
>> +			if (write_buf[i] != read_buf[i]) {
>> +				tst_res(TINFO, "First mismatch at offset %zu: "
>> +					"wrote 0x%02x, read 0x%02x",
>> +					i, write_buf[i], read_buf[i]);
>> +				break;
>> +			}
>> +		}
>> +	}
> This should really be put into a function and used in both test cases.
Will address it.
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static void test_partial_io(void)
>> +{
>> +	int fd;
>> +	size_t half = BLOCK_SZ / 2;
>> +	size_t i;
>> +
>> +	tst_res(TINFO, "Testing partial I/O operations");
>> +
>> +	/* Prepare buffer */
>> +	for (i = 0; i < BLOCK_SZ; i++)
>> +		write_buf[i] = 'a' + (i % 26);
>> +
>> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
>> +
>> +	/* Write first half */
>> +	io_uring_submit_sqe(&s, fd, IORING_OP_WRITE, write_buf, half, 0);
>> +	if (io_uring_wait_cqe(&s, half, IORING_OP_WRITE, &sig) == 0)
>> +		tst_res(TPASS, "Partial write (first half) succeeded");
>> +
>> +	/* Write second half */
>> +	io_uring_submit_sqe(&s, fd, IORING_OP_WRITE, write_buf + half,
>> +			    half, half);
>> +	if (io_uring_wait_cqe(&s, half, IORING_OP_WRITE, &sig) == 0)
>> +		tst_res(TPASS, "Partial write (second half) succeeded");
>> +
>> +	SAFE_FSYNC(fd);
>> +
>> +	/* Read back in one operation */
>> +	memset(read_buf, 0, BLOCK_SZ);
>> +	io_uring_submit_sqe(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0);
>> +	if (io_uring_wait_cqe(&s, BLOCK_SZ, IORING_OP_READ, &sig) == 0)
>> +		tst_res(TPASS, "Full read after partial writes succeeded");
>> +
>> +	/* Verify */
>> +	if (memcmp(write_buf, read_buf, BLOCK_SZ) == 0)
>> +		tst_res(TPASS, "Partial I/O data integrity verified");
>> +	else
>> +		tst_res(TFAIL, "Partial I/O data mismatch");
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	io_uring_setup_queue(&s, QUEUE_DEPTH);
>> +	test_write_read();
>> +	test_partial_io();
>> +	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	io_uring_setup_supported_by_kernel();
>> +	sigemptyset(&sig);
>> +	memset(&s, 0, sizeof(s));
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.needs_tmpdir = 1,
>> +	.save_restore = (const struct tst_path_val[]) {
>> +		{"/proc/sys/kernel/io_uring_disabled", "0",
>> +			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
>> +		{}
>> +	},
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "5d17b4a4b48c"},
> This commit does not appear to exist in linux kernel git tree.
I will double check on this. Thanks for the review.
>
>> +		{"linux-git", "2b188cc1bb85"},
> And this is a commit that added io_uring. Commit hashes in tests are
> used only for cases where the test is a regression test for some bug and
> point to a commit that fixed the problem.
Understood. Based on the review, I will then remove this code since this is
a new testcase to improve coverage and not a regression test.
>
>> +		{}
>> +	}
>> +};
>> diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
> Since you are pulling the common code into header it would be nice to
> convert the io_uring01.c so that it uses the common header as well.
>
Will address this in V2.

Thanks again for the review.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
