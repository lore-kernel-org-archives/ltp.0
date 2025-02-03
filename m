Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BD9C02196
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 16:31:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A53283C8F86
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 17:31:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8987D3C65AE
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 17:31:40 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8EE131BBC81F
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 17:31:38 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137WuCZ014569;
 Mon, 3 Feb 2025 16:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=U+2+3C
 YO4cJ9IUa+j/NrGC7uuUK+CXz36ht8K6d8ygg=; b=RTWYSVidEFFG6/79GLIa8E
 vXwTG+S3RdZLUDo7otR+xudxYIB+LSw3yKva4Jn+tSpYgH/3y1mOjKzwLDZO+NTM
 TDsb/qKLSlaEXrv6gTERixK6ovmgwaylVs2HdF/eg878sBD0mqIHDupg3hd1ZQFG
 y39sDoZHwhoPJF2iE5DmqM1ERo7qhEPk+aYOzYohsYLOtVtmaibzl+CvxhhOXeIp
 MFU6rpFiq59OhVCMrGtVSzB+H0T3DRIkH0pjE9azl0ZfBw/RKO2OuR5cBpVs8glW
 TrXwM+iKrUluVI4Ww6wPeR+eBLhwOVsGgMJA8KMkoITbAr+KHiyXkfrJkFvSu7uQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jsgnjffh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 16:31:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513Cv66W005254;
 Mon, 3 Feb 2025 16:31:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jq050-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 16:31:36 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 513GVZHw22544778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Feb 2025 16:31:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF3745805E;
 Mon,  3 Feb 2025 16:31:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 697A25805A;
 Mon,  3 Feb 2025 16:31:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.83.5]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Feb 2025 16:31:35 +0000 (GMT)
Message-ID: <44b924ca0fde4c916eba8a98551e44a65072d2e2.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Mon, 03 Feb 2025 11:31:35 -0500
In-Reply-To: <20250114112915.610297-9-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-9-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6J2nfkXEeQv3qrNB3ZDUHerzpdJ-vZXi
X-Proofpoint-ORIG-GUID: 6J2nfkXEeQv3qrNB3ZDUHerzpdJ-vZXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030120
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 08/10] ima_setup.sh: Allow to load predefined
 policy
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
> if available. This should be used only if tooling running LTP tests
> allows to reboot afterwards because policy may be writable only once,
> e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
> other.
> 
> Loading may fail due various reasons (e.g. previously mentioned missing
> CONFIG_IMA_WRITE_POLICY=y and policy already loaded or when secure boot is
> enabled and the kernel is configured with CONFIG_IMA_ARCH_POLICY enabled, an
> appraise func=POLICY_CHECK appraise_type=imasig rule is loaded, requiring the
> IMA policy itself to be signed).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Looks good.  Thanks, Petr.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
