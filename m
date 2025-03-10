Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC2CC282DE
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 15:33:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41E203CA25F
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 16:33:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1607B3CA0F3
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 16:33:38 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BF21C60094B
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 16:33:37 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AE36uZ027805;
 Mon, 10 Mar 2025 15:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=omQjwO
 UOQ1zyN/xVouOTv/yvneXmz5VRfViFYgsL/rk=; b=ioAw/PLUJD7Ka5E4k0IILP
 A5e5dPJW0yZzk/j+q0VFrx+mImpZqrVNa/zJJJ2HjNysfz3mUeEr7zRTLL32u6MS
 HaPRKhibLWHkSxROzfRQ3waT30YwbvXdU1so8Et/QFDQh/e4+CSZAd4Mkm9DI0bR
 BbkPEJxeSQz7w/jPp8f8tVMkwaCzXvH33X+JPlMQjY7Nm5Or9ha7VFIW0VFJnPXe
 wDnn/84ctWcO748dE7xyIxb8buA5OzViCRKCDoVmTOhSalmX7nqdzuZL2Ew+JO0Y
 zdKpDEQ3WJ9GDLROMl6Cjv5t7jjNlaKW45T64iLkeul9I+llIY/UBrgiJUi9Z0Tw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp0h4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:33:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AEI0f8022203;
 Mon, 10 Mar 2025 15:33:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45917n79je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:33:34 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AFXX8p17629696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 15:33:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F9F758068;
 Mon, 10 Mar 2025 15:33:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FA1558067;
 Mon, 10 Mar 2025 15:33:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.67.195]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Mar 2025 15:33:32 +0000 (GMT)
Message-ID: <88e87da5b2d5d731e6ad4e2b4043d39e4221684d.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Mon, 10 Mar 2025 11:33:32 -0400
In-Reply-To: <20250307102429.GA272497@pevik>
References: <20250114113239.611278-1-pvorel@suse.cz>
 <20250307102429.GA272497@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0LHyb4Y1XXaj8hRMkk3VFVz1HqhdZcR3
X-Proofpoint-ORIG-GUID: 0LHyb4Y1XXaj8hRMkk3VFVz1HqhdZcR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011
 mlxlogscore=805 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100121
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] IMA: Remove evm_overlay.sh
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
Cc: Ignaz Forster <iforster@suse.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 2025-03-07 at 11:24 +0100, Petr Vorel wrote:
> Hi Mimi, Ignaz,
> 
> > Proof of concept, it was never fixed in the kernel.
> > Instead we should have some basic EVM tests.
> 
> gently ping. Is evm_overlay.sh test useful for you?
> Otherwise I'll delete it.

Requiring the "ima_policy=appraise_tcb" default policy to run the tests limits
its usefulness.  Perhaps REQUIRED_POLICY_CONTENT could be defined.  I'll let you
know. For now, please don't remove the test.

thanks,

Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
