Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90DBCD4840
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 12:44:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ADF03CB9F7
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 14:44:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7125F3C041A
 for <ltp@lists.linux.it>; Mon, 11 May 2026 14:44:18 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B206160042C
 for <ltp@lists.linux.it>; Mon, 11 May 2026 14:44:17 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BAEMOS4020088; Mon, 11 May 2026 12:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YO7Zy1
 yravIXI04FVwMuXL9fLglGhHzVHODVUkoKcI0=; b=Fj2vuRCiUGHOD+r1LeFKqK
 KfhYmJLyhdPccRMkOsIRHyoqaXTY4ue7oAzw6cu9h465qam9BFztubAGieHkhMQK
 EZ/gMbaH4c4clZefMj7XgcSJ5tGU5Zl7494DpNx0jGNS5esUALqYJOQ7kFaJgTQc
 JQg0b0SVscfSOL9eavwcQjkiObiwFfHXcTJ8L8Sdu+uVFppw49ROsat7fEKwH2Pt
 ZresJacOOBTuqOG2x/2RxYdxkq753kMWBKyPqs+iwKWKzSurWbXNZaqXYHKnoH7a
 gB0uilXB4l+igrsQsSxkbygyUWexbmHx9xSYa4OS/9z3hBr4VnvMQIL5YDJ8GpBg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdqt68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 12:44:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BCdTpE008788;
 Mon, 11 May 2026 12:44:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hxy50rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 12:44:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BCiET431916762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 12:44:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A62A5805C;
 Mon, 11 May 2026 12:44:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FE565805A;
 Mon, 11 May 2026 12:44:13 +0000 (GMT)
Received: from [9.43.107.54] (unknown [9.43.107.54])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 12:44:13 +0000 (GMT)
Message-ID: <dc4311f6-014b-4fe1-b7ee-5e3399d0a0e5@linux.ibm.com>
Date: Mon, 11 May 2026 18:14:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20260511070852.90379-1-pvorel@suse.cz>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20260511070852.90379-1-pvorel@suse.cz>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a01cf1f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=8r2qhXULAAAA:8
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=NiYv6D_-EqcXDy79cBkA:9 a=QEXdDO2ut3YA:10 a=8gvLZcY7Nlvl4CGD_6nf:22
X-Proofpoint-GUID: wkaqDshaLloODKSA2RN-B7vd7ntkOuMw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0MCBTYWx0ZWRfXxukzQNrqd8J8
 HZpVWT+dZEtVjY7Qk/jzVT0O9oABD5bSlzILsW0u5Pkrrd7x6Ui4xvGqiv3YDXHQ/maYLe3IuXP
 ICnN47S9VTB4PEx+BGlyR4alcGEv1e+/tu+zM/ZuE5iRaLqPTTQqxhkj3RPmpVljmMk9W8fk3jm
 y7irH6tjD7bAdzrmRFdE/N7Ntbyei/Oadn4ODwxLFjGoBCcXN6KIRV9MpFPoMy1/bhW+nQDO2cE
 PKUmZz+jf3mASXYVi3kWqcRY2F1aNQbI3LryY2qBvcXvu8CxFpTuyon9hAdo81W05O9EY7BjOpY
 rrbyl1XaGNpoy64IdxKIaifFv8nC6S15s8mVdSpq90hjtWQDDfXuwdK1sJECIUvaXjrliB73mj1
 Iy9sDnZfSYmlEqGuFxgSYlcxZALuyrH2aTPO5HARVLVMTngqVac1kpPqYScd3Xu8YFQKHrSxp68
 usXJQdwBf5C1PZpVASg==
X-Proofpoint-ORIG-GUID: wkaqDshaLloODKSA2RN-B7vd7ntkOuMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110140
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/cve_catalog: Link CVE to www.cve.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 11/05/26 12:38 pm, Petr Vorel wrote:
> Although test_catalog page links to www.cve.org, it's more convenient for
> readers to have that link also on page dedicated to CVEs.
>
> While at it, change warning to note (it's really an info, nothing to
> warn about).
>
> Follow-up: 79396c7b71 ("doc: Add CVE catalog to documentation")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Sachin Sant <sachinp@linux.ibm.com>

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
