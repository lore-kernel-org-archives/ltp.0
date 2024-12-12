Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5B8E77182
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 14:30:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8657F3E9935
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 15:30:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C24843E1529
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 15:30:10 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0D0B9143DF2B
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 15:30:09 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC73Sh6005494;
 Thu, 12 Dec 2024 14:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=veTZQe
 DJ0GD1LXtOGAdZJOldYsKDzUhG628MUhkI/T8=; b=KdfQluCMktqVRBR6jEElqf
 1eGvU9GlMz59dLUMyPRYGnmxmfrIT9RYY9A2H6ecel7goU/51ITjiU3d7oNpCYch
 lyYbxhvm6Lg2e21pqEw5odehXMmFsdDMoBKyC8A01FUo4FUQolAkOlXhYnGF/d8M
 /qIIFWps6b/X3g6kO6ahfk8SWr9yN7dzkJ7Iz6TxUQmQIzjBs7ZlCJJEWMLBlkxz
 cA0TG0G79amSnYZb1fRHrgef/x2Tx9nakm5ekinWiyBYZm+jxWKVhJW/i9VM1CVp
 TNiq/T4JnREj5E+WqD2pbgSgK4fUkG5SlTJCvhMIkSFncCOQcELgPRjS0jPyey3g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqkw9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2024 14:30:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCD2lp0016910;
 Thu, 12 Dec 2024 14:29:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yh3j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2024 14:29:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BCETxte22741746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 14:29:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0562058054;
 Thu, 12 Dec 2024 14:29:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B64C5803F;
 Thu, 12 Dec 2024 14:29:58 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.69.6]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2024 14:29:58 +0000 (GMT)
Message-ID: <3da6e0fade05a3087848bc86a55d771901dbf701.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Dec 2024 09:29:57 -0500
In-Reply-To: <20241211194836.GE443680@pevik>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-3-pvorel@suse.cz>
 <710315f59b9378d76d226e209fee698f6bc11c06.camel@linux.ibm.com>
 <20241211194836.GE443680@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 62OGfyyTt3VXsO3FZuZP8LzSiIEc_plY
X-Proofpoint-GUID: 62OGfyyTt3VXsO3FZuZP8LzSiIEc_plY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120104
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
 Roberto Sassu <roberto.sassu@huaweicloud.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 2024-12-11 at 20:48 +0100, Petr Vorel wrote:
> Hi Mimi, all,
> 
> > On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> > > environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
> > > if available. This should be used only if tooling running LTP tests
> > > allows to reboot afterwards (because policy may be writable only once,
> > > e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
> > > other).
> 
> > Thanks, Petr.  Allowing the policy to be updated only if permitted is a good
> > idea.  Even with the LTP_IMA_LOAD_POLICY=1 environment variable, the policy
> > might not be loaded.  For example, when secure boot is enabled and the kernel is
> > configured with CONFIG_IMA_ARCH_POLICY enabled, an "appraise func=POLICY_CHECK
> > appraise_type=imasig" rule is loaded, requiring the IMA policy itself to be
> > signed.
> 
> Yes, it's an attempt, which can fail for various reasons. I'll add this example
> of failure to load the policy to the commit message and to the docs.
> 
> I'd like to detect if policy got updated to avoid wasting time with SUT reboot
> when policy was not updated. But this probably will not be always possible
> (e.g. (CONFIG_IMA_READ_POLICY not set).

Why do you actually need to be able to read the policy, after updating it?
Either the policy update succeeded or failed.  For example in the signed policy
case, writing a valid policy rule via 'cat' on a system requiring the policy to
be signed always fails.

> 
> > On failure to load a policy, the ima_conditionals.sh and ima_policy.sh tests say
> > "TINFO: SELinux enabled in enforcing mode, this may affect test results".  We
> > should stop blaming SELinux. :)
> 
> This info was added for LTP shell tests, which got often affected by
> SELinux/Apparmor. Because IMA is written in LTP shell API it gets this.
> Error message is printed on TBROK, TFAIL, TWARN. Is this the only part where you
> would like to avoid the message? Or do you want to remove SELinux/Apparmor
> warning from all IMA tests?

You have a better feel than me as to whether SELinux/Apparmor could interfere
with these tests.  Unless we have some reason to blame SELinux/Apparmor, I would
remove it.

Mimi 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
