Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EE3E77180
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 12:19:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A943F3E890A
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 13:19:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FE583E7D06
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:18:51 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85820618611
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:18:50 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBIBUa008973;
 Wed, 11 Dec 2024 12:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ORAUV+
 JiO6RE+BZek7JQsl/5yygpu1rmOlNgFc7NFoo=; b=eAURM691ksD9FmDiCL5iOs
 RXIQ11PAeO6sceHnstS7ZlykOjCVr/vvff1bUoMCsrrzcME7GfZfXQRR8HDKJZsC
 rnK4gb4n/lY6MTUEWuODXlAi1AUbnne7jIPN+yESicjlLztQaBQVpKLxbgHSIqsu
 omk95sgyyfasw6zHi4pVL0PzNikwgyLNIyn9YBNEfs1nJSKUOnhssQelEku1wl9l
 x4S8ljsTzEytK0+shkCeLacfJmWNA8CoRiyvAYlStX7umolzD33Hf+hEm2iuDzzu
 Y+11oidvW45uZs2us9prWz8iTxdmgsrAJRAUmGcn1wcTIvgAk0LHpOXQ+mwdk9lA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjm2j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 12:18:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB9Y5vV000572;
 Wed, 11 Dec 2024 12:18:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn9b0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 12:18:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BBCIdMw13304384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2024 12:18:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63B2C58052;
 Wed, 11 Dec 2024 12:18:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E232158045;
 Wed, 11 Dec 2024 12:18:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.71.1]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2024 12:18:38 +0000 (GMT)
Message-ID: <710315f59b9378d76d226e209fee698f6bc11c06.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Wed, 11 Dec 2024 07:18:38 -0500
In-Reply-To: <20241126173830.98960-3-pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-3-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BfxQ6LX7SjTRq5f7ERZGtQXgi71bvrMj
X-Proofpoint-ORIG-GUID: BfxQ6LX7SjTRq5f7ERZGtQXgi71bvrMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110087
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] ima_setup.sh: Allow to load predefined policy
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
Cc: linux-integrity@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
> if available. This should be used only if tooling running LTP tests
> allows to reboot afterwards (because policy may be writable only once,
> e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
> other).

Thanks, Petr.  Allowing the policy to be updated only if permitted is a good
idea.  Even with the LTP_IMA_LOAD_POLICY=1 environment variable, the policy
might not be loaded.  For example, when secure boot is enabled and the kernel is
configured with CONFIG_IMA_ARCH_POLICY enabled, an "appraise func=POLICY_CHECK
appraise_type=imasig" rule is loaded, requiring the IMA policy itself to be
signed.

On failure to load a policy, the ima_conditionals.sh and ima_policy.sh tests say
"TINFO: SELinux enabled in enforcing mode, this may affect test results".  We
should stop blaming SELinux. :)

thanks,

Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
