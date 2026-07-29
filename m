Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542EEC54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 13:52:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D2A83E4BAA
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 15:52:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B1663E1C4E
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 15:52:38 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CFB2814001FA
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 15:52:37 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TDHpbL017742; Wed, 29 Jul 2026 13:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EK8Ejc
 0UX0UM96czEtDStjhfrp+5jVJdUSq/N2OOyl8=; b=NWxrtBxieV2l9Qrunkg8lL
 qUQUk5PqNthyOhaVM49YhRLcpoTE/uKuTHiwqXWs58I5jpduE1qCazXiydl/OoSS
 1mlaoqmYZ4fJNdyDL/2R6XInVqoPbV1lfhwRx/4rW+3OmQH+mye+Y26N1RV5TLuW
 dENYFFCOr568yw/m0CdX4/W1a+MjUUPqAgGTFGhb+2/6BBVsM1R9kQaFYvNiBOgK
 wmGTBV1pbdggGuhrT5gaW4NZRQ+trxWmbAsSSFwDeVQN/bWMLNf5oIW1zDttvfdo
 eZhI7Xv678+uEUErohEKANceiAvcqscHINUXMAX/8F+44eYPWeikOXaI1zMfXXTg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyja6fu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 13:52:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TDQGCE025857;
 Wed, 29 Jul 2026 13:52:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgerdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 13:52:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66TDqYCO32309766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2026 13:52:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4886958056;
 Wed, 29 Jul 2026 13:52:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B76658060;
 Wed, 29 Jul 2026 13:52:33 +0000 (GMT)
Received: from [9.43.117.118] (unknown [9.43.117.118])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jul 2026 13:52:33 +0000 (GMT)
Message-ID: <28415772-b9ba-481f-8a17-ceb5ef58ac61@linux.ibm.com>
Date: Wed, 29 Jul 2026 19:22:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260616045414.9081-1-sachinp@linux.ibm.com>
 <20260616045414.9081-2-sachinp@linux.ibm.com> <amnxF9DZ5u2UYL95@yuki.lan>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <amnxF9DZ5u2UYL95@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX2YNk0BQBvQOj
 5DYWiwS+3w9ZspkU2ZM3wW681CgCEQ98GwU5lnCkmybKRVnqEruaOQnaqEgMz+0EAOSXNkvf7mn
 Bgh0UNmPMJ0f1LlPhQA+6QSdCiD2Wds=
X-Proofpoint-GUID: 1iB1IKXsLukMRfYQpre8PdPGVBVM0xh7
X-Proofpoint-ORIG-GUID: 1iB1IKXsLukMRfYQpre8PdPGVBVM0xh7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX7YMDny1msJUm
 qe5rTS5NC3je50lQH3jCiSUUBcvll3bDtdrxq5u2INkdbg1xdoK9QOzcamNx2jpTCl2L+/KxNAC
 4ie9pc1PYfPB62Q/iytwaHdgQw9dX7AY/4VPro1/Gd8Gh+s0MhzhP8zSD3TTSznf+4Prj0tIn8n
 BCTxhJ6GNUTJqdGtKusX6h2nEEiIw+X7AAL725JVeeYdTLZ4tdj8FMb2K8ygcWlCHX24Fepour0
 is2tC/J83PjTAJyi9Yo50cjX1aMPIvf9Fb7LbJfSv4mmjMLEgnkL3OK6WesXA2qqb3qz0uUJE/a
 kjWcAB/Tgc1PYIRgY+/ah0vFPi1uwFFbNcba/KIO65B8KLzGlLe22zqg4JiUX4QT1KfDWEuj2KQ
 5Evsdx+v+/MlQqrxHKBrI7vbiBS/xgvQUW4JQNOxrrQg/x4xh3ZpGFhI+CIp849n2uVbT0wBAVC
 orEHZQJCVp6GFzaZcjQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a05a3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=tsiYnCHysR4RgFDZqrwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290114
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 1/8] fs/acl: Add ACL_USER_OBJ permission test
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



On 29/07/26 5:54 pm, Cyril Hrubis wrote:
> Hi!
> I've cleaned up the patchset and pushed all the acl_* tests, thanks.
>
> We already have xattr tests in syscalls/{set,get}_xattr that cover basic
> xattr operations I haven't xattr_test01 for that reason. If coverage is
> lacking there the xattr tests should be put there.
Thank you.
> The main changes:
>
> Added SAFE_ACL_SET_FILE() since the code to handle EOPNOTSUPP was
> repeated in each test. I've also weeded out some of the cleanup, there
> is no point in unlinking files or freeing memory before we call
> tst_brk() since that will be handled by the test cleanup and OS process
> memory teardown.
>
> Also weeded out the file removal in various branches in the middle of
> the test and in the test setup(). Each test cleans up the files at the
> start of the test function. With that there is no point in doing the
> cleanup anywhere else but cleanup().
>

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
