Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36D8E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 12:26:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A1B73E890D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 13:26:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB9383E88F8
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:26:40 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE92463281E
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:26:38 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBB5ihV008120;
 Wed, 11 Dec 2024 12:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=98ILy9
 FXd3s+YnzM+DjxOSnqwZtrFBOsdam8JBqVAsE=; b=LTs51K+Shqf084UQG1lr8D
 zFhZw0FRr1nI3fS2maNDWy1YfVma068yudfi0SJQfItrAk20Bo95Xu8yvWwWU0Hw
 VhOooNMeqxh2uM+fK0cIbG9As9XJVTYuoxNflniLFgF+IZjGkjDBidtzLg1Lhr5R
 TCW9eedNvCj5NoLBU7u80+lF5bI2k8N7IpN7+213M+Hld34vkLBakqrG9aT00SNW
 SRhXrOWydsQ782mJXIpC2V1DsJeT1O7NZzsVkLDN36IKa5/tK3j8TspLiBLCDEBP
 s1/koERYYci2joZgCNFcbwWgoqkhK/iP3CN93AyMSr4mqY+XcfMMqbuQJvjZKHag
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8w6g5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 12:26:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBRGI6017376;
 Wed, 11 Dec 2024 12:26:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1s0x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 12:26:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BBCQYbo23790194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2024 12:26:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C05AD58053;
 Wed, 11 Dec 2024 12:26:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D1C658059;
 Wed, 11 Dec 2024 12:26:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.71.1]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2024 12:26:34 +0000 (GMT)
Message-ID: <007bb56c0ed893e6b53d31efee1276e7bb91a557.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Wed, 11 Dec 2024 07:26:33 -0500
In-Reply-To: <20241126173830.98960-2-pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-2-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dTMCDa90AAR0I-w2CcqThRvscFCvOcc3
X-Proofpoint-ORIG-GUID: dTMCDa90AAR0I-w2CcqThRvscFCvOcc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110087
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ima: Add TCB policy as an example
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

On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Except for the "dont_measure <tmpfs>" rule, the "dont_measure" rules are for
pseudo filesystems.  Including a "dont_measure <tmpfs>" policy rule was suppose
to be limited to the initramfs, and then replaced with an IMA custom policy. I
would either re-order the rules so that the "dont_measure" rules are only before
the two "func=FILE_CHECK" rules or perhaps remove the "dont_measure <tmpfs>"
policy rule.  The kernel builtin "tcb" policy should be updated as described
below.

> ---
>  .../ima/datafiles/ima_measurements/tcb.policy | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> 
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> new file mode 100644
> index 0000000000..280e6af87c
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> @@ -0,0 +1,20 @@
> +dont_measure fsmagic=0x9fa0
> +dont_measure fsmagic=0x62656572
> +dont_measure fsmagic=0x64626720
> +dont_measure fsmagic=0x1021994
> +dont_measure fsmagic=0x1cd1
> +dont_measure fsmagic=0x42494e4d
> +dont_measure fsmagic=0x73636673
> +dont_measure fsmagic=0xf97cff8c
> +dont_measure fsmagic=0x43415d53
> +dont_measure fsmagic=0x27e0eb
> +dont_measure fsmagic=0x63677270
> +dont_measure fsmagic=0x6e736673
> +dont_measure fsmagic=0xde5e81e4

Limit the affect of "dont_measure" rules to just the "func=FILE_CHECK" rules, by
moving them to before the "func=FILE_CHECK" rules.

> +measure func=MMAP_CHECK mask=MAY_EXEC
> +measure func=BPRM_CHECK mask=MAY_EXEC
> +measure func=FILE_CHECK mask=^MAY_READ euid=0
> +measure func=FILE_CHECK mask=^MAY_READ uid=0

Move above two "func=FILE_CHECK" rules to the end.

> +measure func=MODULE_CHECK
> +measure func=FIRMWARE_CHECK
> +measure func=POLICY_CHECK

thanks,

Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
