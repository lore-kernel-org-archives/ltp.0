Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96A0CD5BC0
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 05:31:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 361AE3C72D9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 07:31:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C05873C684F
 for <ltp@lists.linux.it>; Mon, 25 May 2026 07:30:45 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0CA0E10006AE
 for <ltp@lists.linux.it>; Mon, 25 May 2026 07:30:44 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P5GHYn3804509; Mon, 25 May 2026 05:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gQzCvX
 tvr9iwgWOT+nSBiCUHYgOekePhFEtVAu0tYRg=; b=mHpp40tZHfA5vNJJSe1ldB
 ZXSu2tgdXsh8C+i8bUqhe6wBfoqUWyfusomZnDnEkHgYw1jBG0zxKIL/Fou8PHQR
 BUiz6TH0c58I3fseHsudHt+vkDy5x5klsRWAo8za/nQHbDPzgr+/cd2fKUYeXnrN
 oRuYji0MT6CJEdD00aSuiF58oBBFjLEr9kT/0yvjY5JXB9ab3UFwQguSjtIzxEXy
 mD11GjxXX+ch7Pbi/VFb4wMiJUwAqBmTMR+FAeL9+yweDd4jv0kioUa90y42frf7
 /Z0rqGg596IZKNgFGdgWV6Fz6iNv7K4fEKamfIxUidF9twAy/kN058zW5tIex6pA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qbp8qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2026 05:30:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64P5OBGJ032740;
 Mon, 25 May 2026 05:30:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebpxvuyu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2026 05:30:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64P5Ue8627656928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 May 2026 05:30:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BD1358043;
 Mon, 25 May 2026 05:30:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7300C5805D;
 Mon, 25 May 2026 05:30:38 +0000 (GMT)
Received: from [9.124.216.140] (unknown [9.124.216.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 May 2026 05:30:38 +0000 (GMT)
Message-ID: <bf329b6c-1acb-4168-82f8-a1c3de600dc9@linux.ibm.com>
Date: Mon, 25 May 2026 11:00:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Wagner <dwagner@suse.de>, Sebastian Chlad <sebastianchlad@gmail.com>
References: <20260428075302.7320ef7e3@imap1.dmz-prg2.suse.org>
 <20260501151420.1042995-1-priyama2@linux.ibm.com>
 <CAJCsO8epT++TaOs7=NAy+jC4pQDN9tA-1n_tFy233sHKkJ697w@mail.gmail.com>
 <3191ffc7-8ff7-4b14-8bb0-934853e6d2ea@suse.de>
Content-Language: en-US
From: priyama2 <priyama2@linux.ibm.com>
In-Reply-To: <3191ffc7-8ff7-4b14-8bb0-934853e6d2ea@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA0OCBTYWx0ZWRfX1WoRvgjFEvxQ
 Lo0DQ8jUAevuhiDz+4k83oBdXzCCbJJF7EhEVz7d1uVJpFbeMV56VsMN61RZhcQCmlsC8E6E7kX
 us+Bb2oMER7q3PjTWHsIq8jWdoXKJLkzgwccYWOWwF6jmC1gpgwEQwqJItP1lw7RTXHO1uEWlM7
 x7oF5tWXySnaJnhl//hfZrqRIsl57sWKmVQ3XZ/HGh6HhdrQbAkLFTIlSl91ONX23pnCHBrRGz2
 bDMnKsAILlxVZuT719IKke+E1Zj9mGr1BpP34P4c9W24IqiXNxCPxJtr5ffgNZlR7gdWZn2D+Q+
 6OBTmMMHmM20Hw81C7mlWu7CbajRQj+M3Q2bZAIDeNl/pue4shJAc9tTOTy2RzGLbZ9iv+9jWh8
 FCsnOxoE3sH1qHoC1TwzabeWntHmONb8S9R6gbgv9jOxt3lHODZs7+nGsdtuwTdA59vJQeONJLv
 nFtDlNsQFH1/aaejP2A==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a13de82 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=8FyS-pScxX4m2_D4Cw8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: w3YMpNvKdKQND_cLqVpKoVkNuh1BpWg_
X-Proofpoint-GUID: MArnSyHM5vwy0VBAJb21Un3yJif25yTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250048
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] testcases/kernel/device-drivers/nvme: Add NVMe
 device discovery test
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
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, daniel.wagner@suse.com,
 ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sebastian,

Thank you for raising this important question. After reviewing blktests' 
coverage, I see the concern about duplication.

*Proposed LTP NVMe Test Suite - System Integration Focus:*

Rather than duplicating blktests' comprehensive NVMe protocol testing, I 
propose LTP focus on system-level integration and kernel API validation. 
Here's an overview of the planned test suite:

*1. nvme01 - Device Discovery & System Integration (Current Patch)*

  * Basic device enumeration through /sys and /dev interfaces
  * Driver binding verification
  * *LTP-specific angle*: Validates kernel's sysfs/devfs integration,
    not NVMe protocol

*2. nvme02 - File System Operations (Planned)*

  * Standard POSIX I/O operations (open, read, write, close, fsync)
  * O_DIRECT, O_SYNC flag behavior
  * mmap() operations on NVMe-backed files
  * File locking (flock, fcntl) with NVMe storage
  * *Differentiation*: Tests syscall interface, not NVMe commands

*3. nvme03 - Process & Thread Safety (Planned)*

  * Concurrent access from multiple processes
  * fork() with open NVMe file descriptors
  * Thread-safe I/O operations
  * Signal handling during NVMe I/O
  * *Differentiation*: Multi-process integration, not device-level testing

*4. nvme04 - Resource Management & Limits (Planned)*

  * Cgroup I/O throttling with NVMe devices
  * ulimit enforcement (RLIMIT_FSIZE, RLIMIT_NOFILE)
  * Disk quota behavior on NVMe filesystems
  * Memory pressure scenarios
  * *Differentiation*: Kernel resource management integration

*Key Differentiators from blktests:*

Aspect 	blktests 	LTP (Proposed)
*Focus* 	NVMe protocol & features 	System call & kernel API
*Scope* 	Block layer specifics 	Multi-subsystem integration
*Interface* 	NVMe commands, ioctl 	POSIX syscalls (read/write/open)
*Duration* 	Comprehensive (longer) 	Smoke tests (<5 min total)
*Use Case* 	NVMe validation 	System regression detection

*Concrete Examples of LTP-Specific Value:*

 1. *System Integration*: Does|fsync()|properly flush NVMe write cache
    through the kernel's VFS layer?
 2. *Process Safety*: Can a child process inherit and use parent's NVMe
    file descriptor after|fork()|?
 3. *Resource Limits*: Does cgroup I/O throttling correctly limit NVMe
    bandwidth?
 4. *Platform Coverage*: Does NVMe work in PowerPC LPAR, s390x LPAR, ARM
    virtualization?
 5. *Container Integration*: Are NVMe devices properly accessible in
    containerized environments?

*Positioning:*

  * *blktests*: "Does NVMe hardware/protocol work correctly?"
  * *LTP*: "Does the kernel's NVMe integration work with the rest of the
    system?"

*Current Status & Next Steps:*

The current nvme01 patch is admittedly basic. I'm happy to:

 1. *Withdraw*if LTP prefers no NVMe coverage
 2. *Refocus*nvme01 on system integration (e.g., test sysfs attribute
    access patterns)
 3. *Proceed*with the differentiated test suite outlined above
 4. *Collaborate*with blktests maintainers to ensure no overlap

Please let know which direction would the LTP community prefer?

Best regards, priyama2


On 05/05/26 2:15 pm, Daniel Wagner wrote:
> Hi Priyama,
>
> Sorry for top-posting, but I have a broader question here.
>
> First of all, thanks for working on this and for looking into NVMe 
> coverage.
>
> Before going further, could you please explain the intended 
> LTP-specific value of
> this test? blktests already has a dedicated NVMe test group with much 
> broader
> coverage, including controller/namespace discovery, NVMe commands, 
> fabrics, etc.:
>
> https://github.com/linux-blktests/blktests/tree/master/tests/nvme 
> <https://github.com/linux-blktests/blktests/tree/master/tests/nvme>
>
> So I think we should be careful not to duplicate coverage unless there 
> is a clear
> reason for having a small LTP-level smoke test as well. Maybe your 
> intention is
> different? Could you please clarify?
>
> Cheers,
> Sebastian 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
