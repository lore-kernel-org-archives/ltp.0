Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAFFC2A09B
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 18:49:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58AA23E586E
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 20:49:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DAF33CFA2B
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 20:49:13 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3225B2003B5
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 20:49:12 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677Imon92187755; Fri, 7 Aug 2026 18:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uL9Sbq
 o344dX4Hx33UITUq52ZG7x9ZSWpCr08dldau4=; b=ooonFvIxX/49Eg7NFWw8lo
 WVf2y9f6T6ljFgFInynq9wDHZK9p2qLXLjwUsNTAQ7O3Ur/imZmP+QR0e3aPiHyE
 oIL3Ul+6hwsClqkpZz/dqujxYYl7HfwV3BA4YjKSwTLNLpneX73vojOr1KJ81Ry+
 OTzIBZ1G9XYiylPdLP6Dn8D1Kk508dXSw+7JsjPDrGbPGChKP4iPDJyYLnPgWL2u
 7+xbG2CdeQSN66Q9nNH9XEPkWtPcziDTVOst1czhUKRGZDfCN7fXLyF+ALiaZenY
 bA5VAr0Ovx367UiZ8WcL+1uwpuLh2fxhzX90LnIQRAqADpJRJRFKmqqHGWZxFqXQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02d87s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 18:49:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677IfHWX001236;
 Fri, 7 Aug 2026 18:49:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwh1wx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 18:49:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 677In9xI17629844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Aug 2026 18:49:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE4635805D;
 Fri,  7 Aug 2026 18:49:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E9A658055;
 Fri,  7 Aug 2026 18:49:09 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.26.181]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Aug 2026 18:49:09 +0000 (GMT)
Message-ID: <1ffedf290548a2fbfb1670ad53ec5d57e0f27178.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
In-Reply-To: <20260803131942.GB246496@pevik>
References: <20260728114224.1055009-1-pvorel@suse.cz>
 <20260728125815.4069-1-linuxtestproject.agent@gmail.com>
 <20260728133556.GA1128467@pevik>
 <7279643f66b2ea6d6888716f7923363c2f59b6eb.camel@linux.ibm.com>
 <20260803131942.GB246496@pevik>
Date: Fri, 07 Aug 2026 14:49:09 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a7628a7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=aCwNQFKuUpxus5D-iSYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0NyBTYWx0ZWRfX7FoRUk2mstIh
 Iw5m/oQNxd0XPRyHELIe+31cQq9ciQPOYvUCbLc9fkg+P+9D2PDlvfnyx8u28r/sj5UrMaN0RHi
 cgRiAQcvZgkgt/a0MFnSm/ep0uLQK3fJd178NYDICbBWmp2TbeMCVziEpc7ZVTKnQiZIPYT8e0I
 kbXD5DP3KyXI44kljXnh/IyMp1pmkV0UXdm4qPlzbJFN7vOROVGyHScB0UKPx0poKAuaQlh+rVO
 VB5SZ17pBTvq8Nd7mf9PKpiC+LLL9d2lwR+PUxD4Jc3dsXqhFSrIFxVPLqb5MYBL/eGUjlEuRD5
 TI0Ohxnk1p6cKyuYpGkBp9Idma/p3zp13S86gKJd0+M1pZmSjPJFKGoIDa2qvXHGFnZ3XuN+23C
 3J2pKJ9+M1EL+6CMD7A4FD6UkNVYItCF2cNX//zR7GQxgtPQtKRp0Hm/FAHFvNUvto/zaEfz+L7
 ij4zQZTO7MZ9sNAgk5w==
X-Proofpoint-ORIG-GUID: 7DXgU4h-pFHlQ9xKPbPjVJCvP4pn9xcY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0NyBTYWx0ZWRfX96WnsJ7iP6uS
 XwJFUBqpQ93WYW+chmTqAS9AY3uqbn4amTMPeWa0DFPr/zrztWOuyhbmJy1qCWdBAYDfDJ4U6Ch
 akFJGeCzgnjblXq1O8o4rqgt6kDNw2I=
X-Proofpoint-GUID: 38RT8zg4nJohzV9gIKgG-073rTgYngCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070147
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, 

On Mon, 2026-08-03 at 15:19 +0200, Petr Vorel wrote:

[...] 

> Do you agree that test2 in ima_policy.sh should be skipped on kernel < 4.5? If
> you consider useful running the test also on these old kernels I could just
> correct the commit message for older kernel or simply ignore that fact (just add
> a comment to the test that it's irrelevant for < 4.5. (I know 4.4 is not
> supported any more, in fact it's just for SLES and possibly other LTS distros
> still supporting this old kernel, but I still appreciate your opinion.

Test 2 says, ""verify that policy file is not opened concurrently and able to
loaded multiple times". Prior to 4.5, a policy cannot be loaded multiple times.
I agree ima_policy.sh: test2 should be skipped on kernels prior to 4.5.

> 
> 
> > > > Should test2 report TCONF (or split the two assertions) when
> > > > CONFIG_IMA_WRITE_POLICY is not available?
> 
> FYI we could sooner or later start using kernel config (e.g. look into
> CONFIG_IMA_WRITE_POLICY and CONFIG_IMA_READ_POLICY as many LTP tests and now
> even LTP library require kernel config (we resisted long time add kernel config
> as a hard dependency, but finally Cyril added support in 2018).

Nice!

> 
> But more important for me would be to migrate LTP IMA tests to shell loader [1]
> or even rewrite to C API. We have deprecated tst_test.sh API some time ago.

Oh!  Sure, sounds good.

thanks,

Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
