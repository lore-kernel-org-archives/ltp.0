Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB73CE8537A
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 16:36:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 462B33E4E53
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 18:36:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 775453E133C
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 18:35:51 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8E0191401202
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 18:35:49 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6339o1K11535595; Fri, 3 Apr 2026 16:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=DKdtlhjTrp+zQioLv
 RYlmfcV7FXjlzOp87WUxfPE+PQ=; b=UKsNOxFa8RZUdNI56zGSGy/SbMO+LvS+0
 Iu3Fc3gH3Z6rRZeVJfzpwgCGaPaUJQVzGHTZyE+mnk5PxaK6+56YFIJ2TLZflD9K
 Wgq1iIhAfcuFpY68DerFqsx62ClXpZDxQEnCHXfmguGzKMkSJgogQOP353lhqLXV
 CRJs4sf26xvG0YMUDPIUasIbg65d3mV/j9IBxYG77eOLZoKAs/LKB6Q++DFEuD1m
 ekb6Fg6EhLTUVxUeYQvmqClNe1Oto7GoIcRCuP+UVIT7geLvAmyf0Vhh1dxd23pN
 xoCAQnyTlGMVRTC8h/ubfFP0UQ17XzgNbAL9DiVxJaxyYE/oFp6zw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3hfma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Apr 2026 16:35:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633Ch173021722;
 Fri, 3 Apr 2026 16:35:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasxw77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Apr 2026 16:35:46 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 633GZic47209936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Apr 2026 16:35:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B11EA58055;
 Fri,  3 Apr 2026 16:35:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C51B5804B;
 Fri,  3 Apr 2026 16:35:44 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Apr 2026 16:35:44 +0000 (GMT)
From: Soma Das <somadas1@linux.ibm.com>
To: liwang@redhat.com
Date: Fri,  3 Apr 2026 16:59:47 +0000
Message-Id: <20260403165947.9094-1-somadas1@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ac8cNRNYBVHWi0o9@redhat.com>
References: <ac8cNRNYBVHWi0o9@redhat.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tEuKYzt5oyts2vdjWFJ5KHyIwx9kBwS3
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cfec63 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=ArsMc-J5l3kcVpZNYO4A:9
X-Proofpoint-ORIG-GUID: tEuKYzt5oyts2vdjWFJ5KHyIwx9kBwS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE0NSBTYWx0ZWRfX5CZqhfm8pRzk
 bcrKzkaKqixeF7mxS44L/Ov25ji0g5kaNHPwYYH+Z8NjP6R9R4PJEjTVYtjFjjLJM1USzyECm1c
 2z3p+CGO/WpTTcYHoDjI/GvCEtefm5bcAHsW0VRAObEzJetWhkUBtOjVKv2YePzSKTSfHiLZtYO
 rAnj+BsAwigtOGp86/17R9VTClBPf+hcRrIpzNf686KepFb/w9a2Pz2myg8FSstj0RJJfyctM+k
 BdKiYBv7PzPte+q8qVWJ+2xsfsXlO/znsJ20gmgafYWGQm39tz6mGf6CBdmNC8hzxhgGAiKXfKK
 2Q6izcmmW1zZxo9FvouTMInv+l7akEov3/1L3joUM/HlzmRWD3i0Tfdl/jZD/rSCGEQjrWEkK5G
 veaEtUlA0DVquTCQGaHEIePPG/QcCF7SLTB2Sw0jG50T8NoFGnQU1VlTUcOpeIO/cjUcg3gL58J
 yFyF8FJeKyrB9dn0WzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030145
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] zram: skip exfat on systems with large page size
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
Cc: somadas1@linux.ibm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Apr 03, 2026 at 09:47:33AM +0800, Li Wang wrote:
> Or, can we specify the sector size with 'mkfs.$fs -c $page_size'
> when detecting a large pagesize system?

Thanks for the review.

Using mkfs.exfat -c $page_size would technically work, but I avoided
it because:

1. zram01 tests zram behaviour, not filesystem configuration -- using
   a non-default cluster size feels out of scope.
2. The cluster size must be valid for the disk size (only 25MB here),
   so large cluster sizes could hit additional constraints.

Skipping with TCONF honestly reflects that default exfat tooling does
not support this hardware configuration, which is useful signal.

Happy to send a v2 with the -c approach if you prefer.

Thanks,
Soma

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
