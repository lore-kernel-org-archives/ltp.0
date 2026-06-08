Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340E9CD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89FBB3E5F89
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 13:27:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3CB83C19F0
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 13:27:20 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1830F200D04
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 13:27:19 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6588w5o13370905; Mon, 8 Jun 2026 11:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=n6EvNV
 TaHTgTPwxMu7BEgWgfUkV3tfNerM4YN4xQ6+4=; b=Xv5j7Rjc8cwTvayTLsBMlx
 kQ+/XlR+J1jIVDUM2oW+xh5LDt5QLTc9X9QFYWGrTTx3kEan64UfWuztpBzBQyJ3
 JTzuHyBAOzyZ6AmVt7WUY/mS3zn99ZY+02SudreH9OFyMgfk/PhCCgklwq4lfzVl
 byTYzZELMEIsBYdS3XIvQx7xyIkH4SnuadtasqiBAKNmclNTnNpEQnFh7F2s4Nz3
 mcmfX2se9TUcjeBNS1GQkUeVEDFohynJHg3ClarAKoBWeyRcdS+ceDr6cqHlKCrE
 WxDE0k4TNJr20qs1/oItBtpu7ty4kKAFDO8quEHxkZ5TvLEWwwZnA5G09AB67vWw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydxys8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 11:27:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658BJvMQ005562;
 Mon, 8 Jun 2026 11:27:17 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vw5cj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 11:27:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658BRG2852298064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 11:27:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A5085805D;
 Mon,  8 Jun 2026 11:27:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 618CC58057;
 Mon,  8 Jun 2026 11:27:15 +0000 (GMT)
Received: from [9.43.109.84] (unknown [9.43.109.84])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 11:27:15 +0000 (GMT)
Message-ID: <84984062-a7fb-4cb3-b036-510c6cf4ca25@linux.ibm.com>
Date: Mon, 8 Jun 2026 16:57:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sebastian Chlad <sebastianchlad@gmail.com>,
 Sebastian Chlad <sebastian.chlad@suse.com>
References: <20260507073417.64123-1-sachinp@linux.ibm.com>
 <51507e20-d908-4213-967e-df74bacd87fa@linux.ibm.com>
 <CAJCsO8fQOQfa08bN92zkbqhU_B0B0Ojx2xRm0+TA6jP6WSkZ5g@mail.gmail.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <CAJCsO8fQOQfa08bN92zkbqhU_B0B0Ojx2xRm0+TA6jP6WSkZ5g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwNCBTYWx0ZWRfX7/am6BCgVETt
 q36pnSiTbm6Bd8gsX4Uq6xrJLrWYHJ9bWUyu8D0jK1IChCNnz/qVK6HEN+JgNHgisXbiS2/JBIW
 IN99LBroa/KcdKXo/9A6qRqhu+6rYC6k11DNV46tUmi6FqqmHn9XAq4hSyqfBr8GNcd6wkU1Ti5
 iT7YSP2mpL9ZHC5js43co43BbN2bseyIh0p/dPz9WphKQCeS5kxkrARneUp4lDp7sTEU4QnGc1r
 BSoJKvCIXRQyy/ReXxx8mx3AijKOlDFtPHtdKCRD1o6T2ZFp/zX6VMilbYmxddL6UqhoyZ0Aed8
 66BSCac/fUEA+gxrm2zI1xo/xU56u3Bon0ihOkp0l1Bm7f0WxXHvxVDfoSdiqjOwpH9pOG/byl0
 UYHL3ZCyVqKO06IXhXMx503+CSibcnOrWlq8vz2oeWBNbQKGhTQuKdVkbzHqDb7i0nHv0leahDZ
 BS0ZFTYVpFDu7dsPukg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a26a716 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=xvEzGbcZP-CkC8YoyhYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NkhFcqjODyjAOOcRHQhJsm4W5gp0dxXM
X-Proofpoint-ORIG-GUID: Wf5Cprs2mS5HomsWJsTk4hoPwgLIZajT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080104
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/4] io_uring: Add io_uring04 test for vectored
 I/O operations
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


Hi Sebastian
> I see some fundamental problems here which admittedly started before this
> series. I believe these need to be fixed before we apply more tests on top
> of it.
>
> In io_uring_submit_sqe() and io_uring_submit_sqe_vec(), opcode is passed as
> user_data:
> io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)buf,
>                               len, offset, opcode);
>
> user_data is supposed to be a unique per-request identifier for correlating
> CQEs back to their SQEs. Using opcode there is meaningless as a tag.
>
> The existing tests happen to pass because io_uring_do_io_op() and
> io_uring_do_vec_io_op() always submit exactly one SQE and immediately
> block waiting for its CQE, so correlation is never actually needed.
> However, any test with multiple in-flight SQEs of the same opcode would
> pass;
> the user_data check in io_uring_wait-cqe() would match regardless of which
> CQE corresponds to which request.
>
> Please hold off on applying this series until the underlying issue is
> fixed. I will send a patch to correct the user_data handling.
You're right.

In io_uring_submit_sqe() and io_uring_submit_sqe_vec(), we currently 
pass the
opcode as user_data through io_uring_submit_sqe_internal().
As you pointed out, that is not a meaningful per-request identifier and it
breaks CQE-to-SQE correlation once there is more than one in-flight request
with the same opcode.

> I also think io_uring_do_io_op() and io_uring_do_vec_io_op() should not
> tightly couple SQE submission with waiting for a CQE.
> Keeping them as a single helper makes the tests effectively synchronous and
> does not model real io_uring usage.
> It would be cleaner to have separate helpers for submitting SQEs and
> waiting/reaping CQEs, and let each test handle CQE validation and
> result reporting in its own body.
> Having basic smoke tests, sending single SQE and checking CQE makes sense
> in LTP, but I doubt we shall have this as a helper.

The existing helpers
io_uring_do_io_op() and io_uring_do_vec_io_op() hide this because they
submit a single SQE and immediately wait for a single CQE, so the tests
are effectively synchronous. That makes the current code work for simple
smoke coverage, but it is not a good base for adding more
io_uring tests.

I agree that we should fix this first before applying more tests on top.

The right direction seems to be:

- stop using opcode as user_data
- make user_data a caller-provided per-request tag/context
- separate SQE submission from CQE waiting/reaping
- let each test validate CQEs and report results explicitly as needed

I'll wait for your patch and rework the helpers/tests on top of that 
approach.
> Thanks and let me know if I misunderstand something here. It's the first
> time I look at this code really.
> Sebastian
>

Nope, you are spot-on with the analysis. Let me know if I can help in 
any way.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
