Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF091F4613C
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 15:46:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DEAB3E5F11
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 16:46:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34C843E5575
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 16:46:26 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 317C5200B30
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 16:46:23 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NBDtZN3679602; Mon, 23 Mar 2026 15:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6ESUL/
 1YHauHbYzJEqjsVNo5PfKCeec0K2DeucuVLBw=; b=VR+2fHx6Tgnbfc8zKey0kW
 OAVTsCH/x+vJhHkzcmNoUzzzzeEQqEeiekB2zqCFw+rOcPBzq+CCF+2Km/EmjRpi
 J8/BO6UNGepT2u7iIpEvYr8KI+IBjcHhc/rkq/Y8sp9z4WwZjXta5taq7h1r83kD
 ZQlUn8AvMzxOtUkY1iaOtKnILYLxLspgk3kBSs1EOTFXmizv6RBjlCbNlSoElafO
 BacLHbg7eedLY1cQ2CEK6O4QNXBRkMA87cw1+pvDkMHeRGIdZS5tv2v37gvt30vy
 lzwLE1R0mBjQ4gpQ6HXwRIqa4WfhpGUMPiqqk/B7h6De934Z2L9Rt0MxSnfesGHA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxqk1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 15:46:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NBZOfu031631;
 Mon, 23 Mar 2026 15:46:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsp3ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 15:46:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62NFkKa127067070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 15:46:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FDD858043;
 Mon, 23 Mar 2026 15:46:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4041458053;
 Mon, 23 Mar 2026 15:46:19 +0000 (GMT)
Received: from [9.43.41.151] (unknown [9.43.41.151])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 15:46:18 +0000 (GMT)
Message-ID: <0f4b3126-fb50-4364-8ed6-346ab96c20e8@linux.ibm.com>
Date: Mon, 23 Mar 2026 21:16:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260320124742.75946-1-sachinp@linux.ibm.com>
 <20260320124742.75946-2-sachinp@linux.ibm.com> <acE2O3kN3OQWuEqR@yuki.lan>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <acE2O3kN3OQWuEqR@yuki.lan>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c1604d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=UXIAUNObAAAA:8
 a=Z1LUzX_1gg2MYUnCdPQA:9 a=QEXdDO2ut3YA:10 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfXyes2yOTsPvj3
 srACf5OymGuFIP7upNg4pqPYGK/Ynu9mAELC623qOmAlnHHwLuRjlnFpQiDv+6dm5NMthqIcQpo
 J7hia6n8Oca9vnFytRcQVNy86mqvyPtFmEHy9VHHWyAkNKX2Hwfkt8X1+Z5F4aY4aK0BYAJrlF6
 hqblgKdsunVq6pIOBeqsxzWK5RDiY1/GJ4gybk7AKbjZE6ou3vPB7XSdIwrAZqwINayCdQilzMS
 TrRYX2QOzP9gkec3sMyzH+O2LDvRcN8yBiQJeTEFinyBDoU39OCXLGC4a7ddVRg3+Tq//dZ6ng/
 C8lajs0Nnemhny3vSHkDhRQoj75IJciw7zuZtdEcyWYiiDf0iNca89xiPBDwafnw3UubbzLAcen
 ikltDXJ31dC0siZCxTu5mO0qj2r1QaYM5LUk/j93dm0fokXJJFko1USU6S7KOxyDPiQbOzNjiOo
 iXxw8J7B13jQZ+cnXkg==
X-Proofpoint-GUID: b27sBVRwaevplSM8OMk4J39A8g5Du3RL
X-Proofpoint-ORIG-GUID: b27sBVRwaevplSM8OMk4J39A8g5Du3RL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] io_uring: Test IORING READ and WRITE
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

>> +
>> +static char write_buf[BLOCK_SZ];
>> +static char read_buf[BLOCK_SZ];
> Can we please allocate these as a guarded buffers?
>
> https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#guarded-buffers
Sure, will modify accordingly.
>> +
>> +static void run(void)
>> +{
>> +	io_uring_setup_queue(&s, QUEUE_DEPTH);
>> +	test_write_read();
>> +	test_partial_io();
>> +	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
> I suppose that we need to setup and cleanup the queue only once in test
> setup() and cleanup() functions (when the test is executed with -i 2 on
> command line).
Good point. Will change it accordingly.

> +static inline void io_uring_do_io_op(struct io_uring_submit *s, int fd,
> +				     int op, void *buf, size_t len,
> +				     off_t offset, sigset_t *sig,
> +				     const char *msg)
> +{
> +	io_uring_submit_sqe(s, fd, op, buf, len, offset);
> +
> +	if (io_uring_wait_cqe(s, len, op, sig) == 0)
> +		tst_res(TPASS, "%s", msg);
>
> Rather than passing the description passed from the caller I would print
> the parameters passed to the function, something as:
>
> 		tst_res(TPASS, "OP=%2x fd=%i buf=%p len=%zu offset=%jd",
> 		        op, fd, buf, len, (intmax_t)offset);
>
> And we can add a function to map the OP to the enum name if we want to
> have fancy messages:
>
> static const char *ioring_op_name(int op)
> {
> 	switch (op) {
> 	case IORING_READ:
> 		return "IORING_READ";
> 	...
> 	defaut:
> 		return "UNKNOWN"
> }
Okay. Will include the changes in next version.

> Then we can print the OP as:
>
> tst_res(TPASS, "OP=%s (%2x) ...", ioring_op_name(op), op, ...);
>
> With this approach we will avoid copy&paste mistakes, it's way too easy
> for messages and parameters written manually to get out of sync.
>
> Also we should either propagate the failure to the test by returning
> non-zero from this function if waiting for completion failed (so that
> the test can abort) or call tst_brk(TBROK, ...) in the
> io_uring_wait_cqe() which will abort the test when something fails
> automatically.
Yes, will make the required changes to address this.

Thanks again for the review comments.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
