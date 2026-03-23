Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3467EEC01A2
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 08:43:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C29213E2368
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 09:43:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE3953E1452
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 09:43:12 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D9E3F600A76
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 09:43:11 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MNvbVo1013982; Mon, 23 Mar 2026 08:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=s+vvxM
 keX23JBJ6eH6Qx0XpT4Q+OUKb5NgnrMZaNRBY=; b=L8DLQel31hJ6x/NpVps0ik
 v8DS9FzGdHanWtcIBYtnPECECV8koA8NbB9XMFlneoLYLwyBUGi73vDGwI3qQYGB
 SY2F4D1OJsJx772JNMAAEp3j+0ZHa76//2GASo7H4fC6ytO8GA1y6IoaEiffN7gv
 zOcTQtREh98H3PZ8CmmHWDHFf49WYfz2/sVQ9d0jcgiPUl/obdS7/Bu35o1GMEUT
 FQKBR8rd3dVPSt3Wl7gXYozzDmLhEb66SaPgK84VMhjxaeKB9Vv1U5wUk1z4eD/f
 ZLaJPKSwuKN6DgX5W+4JmfbGNehlP6gbmuWo+78tAd4SliwBcXA4wbnbXdr7q2Cw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq61t3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 08:43:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N7BTfo009126;
 Mon, 23 Mar 2026 08:43:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nncn6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 08:43:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62N8h6v641353592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 08:43:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50C4820043;
 Mon, 23 Mar 2026 08:43:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1E3E20040;
 Mon, 23 Mar 2026 08:43:05 +0000 (GMT)
Received: from [9.124.220.110] (unknown [9.124.220.110])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 08:43:05 +0000 (GMT)
Message-ID: <992deb3d-747b-4d9c-8f53-bee9cf5c6f01@linux.ibm.com>
Date: Mon, 23 Mar 2026 14:13:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260318082438.50245-1-disgoel@linux.ibm.com>
 <abwlWjOGbIUIZLbe@yuki.lan>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <abwlWjOGbIUIZLbe@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rc-BlW_bwj0RTPl8uCAMhQrki8BruNbm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA2MyBTYWx0ZWRfX/vlQR1GbHSh7
 dhisDaKzagI1PonBUi0H2yQx7S5Dq32hHKjM318IXfJUXmcFcD+1i1v4eIHQzz9Xo0siQGs7uzV
 mz6UZR6hJ3a/yHXRRtAgMGZ1JiPbfPKiGpEz1mHU78rZgxJCeEcTnYyEF2la3BNRa2U73+dphJ0
 2EiL78PznVdxPgaEpWxZLk1U92f0XPj+WmgF+lXH9aTpnPmupjDLuchvy04QtHij9zNj34kc/i/
 H5+QO1Xx+avTAcEHzC88GjsV/F1me2amdx/Z22yJG3zoibNj/b3d+BlbYqVsgcpB9/hiPUHGcdg
 e4hdlcYHVwgX1vPkrmpKEautor1A+sbjHXm3YehV7zmspuH7B3xhaec/wfzHiedO5UXNuKkj41L
 XSGdn5uLi8FdZAWnDYFJf0Lgl95dh0Rq6dTgiz7/MIIeoSyDANDfvbZ/9KuZKge2CAlUOm7kZWb
 VkXUqH5GYBSAjxb01uw==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c0fd1d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=v5NCU26o4an1ghq3bsQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rc-BlW_bwj0RTPl8uCAMhQrki8BruNbm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230063
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/ustat: Skip tests on Btrfs using TCONF
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

On 19/03/26 10:03 pm, Cyril Hrubis wrote:
> Hi!
>> The ustat(2) system call is known to fail with EINVAL on Btrfs because
>> it uses anonymous device IDs for subvolumes, which the legacy syscall
>> cannot resolve to a physical block device.
>>
>> Currently, this results in a TFAIL, which causes false negatives in
>> automated CI environments (e.g., SLES). This patch adds dynamic
>> filesystem detection in setup() and uses tst_brk(TCONF, ...) to
>> gracefully skip the test on Btrfs.
> 
> That's why the test has known-fail tag, but maybe it's time to accept
> that ustat() is broken on Btrfs and it's not going to get fixed.
> 
> However we do have .skip_filesystems in tst_test structure exactly for
> cases like that, so it should be used instead.
> 
Hi Cyril,

Thank you for the review.

I will refactor both ustat01 and ustat02 to use .skip_filesystems and 
send a v2.

-- 
Regards,
Disha


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
