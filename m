Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93355E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 16:02:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CADDD3EFBAD
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 17:02:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 530503EFB86
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 17:01:58 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD76A1BB8954
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 17:01:57 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVDsaCf023925;
 Tue, 31 Dec 2024 16:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TU8HT3
 TnCYL9X+3v8zjQpaKU1mxtq8vYakq654PhsK0=; b=lkxIBrgk0AhILLpL4W+ucj
 Dojo1lfbP4K7G7TOAPuQUewlM+nAzTXcJvSpadH8cmHre1Esdk4vFp43EsmE+rFz
 R5Jq+X+i635F2ghOOnCZc5IpGP3BcDGAfajAqDDAop3zaDyD00FcvoYpX1CmS+4d
 KeEm5bhsXDgnEA37OxsVUcsoicVBdSHuaiv0Eop1x7mzGq0RD+lXK+L0KIM0OlWu
 mXRyvzZdIGDg5v30UZzUmuOzMjT0suqBkf+P7Cr2GR9p9aStUuSET2/sIcNH8Zof
 W9DyGPsDFiV+uDpiZ7svV/vXrKw3nLsK5LZOPvCICpmrvwTOs317hBm5GArqew+w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43v5nhaprk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 16:01:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVFCrop010215;
 Tue, 31 Dec 2024 16:01:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tvnnaqkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 16:01:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BVG1rAR16319176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Dec 2024 16:01:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A5205806F;
 Tue, 31 Dec 2024 16:01:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F00D058066;
 Tue, 31 Dec 2024 16:01:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.178.58]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Dec 2024 16:01:52 +0000 (GMT)
Message-ID: <fa7b251e0b7966e9d32117996f4ae8390bc4f6cc.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Tue, 31 Dec 2024 11:01:52 -0500
In-Reply-To: <20241213222014.1580991-2-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-2-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2EeMxUkeY8pFf7_JC1UpSblQEpDVqzLe
X-Proofpoint-GUID: 2EeMxUkeY8pFf7_JC1UpSblQEpDVqzLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310135
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/8] IMA: Add TCB policy as an example for
 ima_measurements.sh
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

Hi Petr,

On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> Taken from IMA docs [1], removed dont_measure fsmagic=0x1021994 (tmpfs)
> as suggested by Mimi.
> 
> [1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

After thinking about it some more, anyone interested in constraining the
"measure func=FILE_CHECK" rules based on LSM labels to avoid integrity
violations would need to reboot the system anyway. [1]

For this reason, please include the new dont_measure tmpfs rule as proposed in
"[PATCH] ima: limit the builtin 'tcb' dont_measure tmpfs policy rule". [2]

[1] Integrity violations -
https://ima-doc.readthedocs.io/en/latest/event-log-format.html#template-data-hash

[2]
https://lore.kernel.org/linux-integrity/20241230142333.1309623-2-zohar@linux.ibm.com/

thanks,

Mimi

> ---
> I would like to check in ima_measurements.sh for this policy as an
> variant to ima_policy=tcb command line parameter. Do I need to check for
> all of these (suppose all are in ima_policy=tcb).
> 
>  .../ima/datafiles/ima_measurements/tcb.policy | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> 
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> new file mode 100644
> index 0000000000..1c919f7260
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> @@ -0,0 +1,19 @@
> +dont_measure fsmagic=0x9fa0
> +dont_measure fsmagic=0x62656572
> +dont_measure fsmagic=0x64626720
> +dont_measure fsmagic=0x1cd1
> +dont_measure fsmagic=0x42494e4d
> +dont_measure fsmagic=0x73636673
> +dont_measure fsmagic=0xf97cff8c
> +dont_measure fsmagic=0x43415d53
> +dont_measure fsmagic=0x27e0eb
> +dont_measure fsmagic=0x63677270
> +dont_measure fsmagic=0x6e736673
> +dont_measure fsmagic=0xde5e81e4
> +measure func=MMAP_CHECK mask=MAY_EXEC
> +measure func=BPRM_CHECK mask=MAY_EXEC
> +measure func=FILE_CHECK mask=^MAY_READ euid=0
> +measure func=FILE_CHECK mask=^MAY_READ uid=0
> +measure func=MODULE_CHECK
> +measure func=FIRMWARE_CHECK
> +measure func=POLICY_CHECK


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
