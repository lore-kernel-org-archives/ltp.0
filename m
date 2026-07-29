Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A963FC53219
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 17:56:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DC8C3E728F
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 19:56:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D74053E29BF
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 19:55:46 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7BB3F1400C6D
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 19:55:44 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TFIBav284430; Wed, 29 Jul 2026 17:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kIgaKQ
 XWcfZ1D1aZocHiBrx509/dikRRbzOYAOfrhbE=; b=Idaann5ri4NaO6/wNv0QcE
 osJtrSz0lNcItot81oQs0RWyA1dY2zFv4tM+wnOrwUnvzE8LDHGIN+5Kw3JOmrWo
 CW6iZOj5BdNeSkvEdzo5yKunSgQY+1OOvjes7D1gjX+KlRipCPjUrTpsO8aYV+js
 KpfjIQee44CWftE0zBQpSZvNMdBHvIfprxrkHp4FU4cjhcVsCC3fUF8fFjAaGwsd
 zXqy3dVLCPmJLELiOlgwNxzO+RV+BJHB/mMxuAJD40+wqZJXXGLXz8pSqAOLEXGC
 b4aymbVVChjUqgmf7nrL/HBOqhEPvo8S8WsEGrgcG/icsViFeqPJtfHT2N9jD9Hg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nu5yu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 17:55:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66THfGIL018395;
 Wed, 29 Jul 2026 17:55:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7thw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 17:55:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66THtfxK28181246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2026 17:55:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB9955805C;
 Wed, 29 Jul 2026 17:55:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41E765805A;
 Wed, 29 Jul 2026 17:55:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.31.108.66]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jul 2026 17:55:41 +0000 (GMT)
Message-ID: <7279643f66b2ea6d6888716f7923363c2f59b6eb.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linuxtestproject.agent@gmail.com
In-Reply-To: <20260728133556.GA1128467@pevik>
References: <20260728114224.1055009-1-pvorel@suse.cz>
 <20260728125815.4069-1-linuxtestproject.agent@gmail.com>
 <20260728133556.GA1128467@pevik>
Date: Wed, 29 Jul 2026 13:55:40 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzNyBTYWx0ZWRfX1JWC+f1yRS/K
 e/RraXScbo/8eqY3cHd/+9LPk6NYGNVC6dvcT7D/6i9XvCn0nqyYWKa4lE8PEK/JqqNN7BFgm4Z
 nGHSurv4nQa2D59z5Nw0XihoQgtDj6w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzNyBTYWx0ZWRfXwnYpvRmynRFo
 VMvpazXguNLpRkU1Zur+17Rifg71xHDowK2c+smDvj1UeayNL+xuZnZSDrU00R1tVBoI7KzcMgk
 w56ZqkxKUyUGto3VXik6wLrnbIJx39IJmu1uUq7AolyTpvW4RXmM5xEZTFdsYbMVUzn596Zy+J9
 KkUzaEmyjDNvUqfjDMosFo6MKCB33tL7yJ7GQyRZSA0Frv8ZlaIlWQ3WfStbSVwPMsDdHEn09wh
 U+UFvsDof3lBundbsbltaBTTNzRq1vQdr5e8tKi9q7i4GkRnSoPtoC0fLaC6vboPY9wL4HwSHOE
 jhXqcV8h57q4c9jqOCrkIPbQwAnMhmRGg8lBF/t4KsgCKos519ezjBkXvZeYseaszBlRGUxNRoa
 JLE898CeTXf9y3zBpImWbgK4pbdQFMV3enKNiKfmgD41Q2oR2UZ504ImfiQWUXBBzt8+MWHcX9W
 jtKQ+U5QKAxWWHBjhJg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a3e9e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=kLBT1emeShgpeJOJY6cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZdORQgrXuODFcVdXcn7RObsXSYd0nsIL
X-Proofpoint-ORIG-GUID: hnKvgR72_XESAT5vhuFJavPE0cXgvmfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290137
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 2026-07-28 at 15:35 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> once you have time, I'd appreciate your comments. Thanks!
> 
> > Hi Petr,
> 
> > On Tue, Jul 28, 2026 at 01:42:24PM +0200, Petr Vorel wrote:
> > > ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
> 
> > > -	# workaround for kernels < v4.18 without fix
> > > +
> > > +	# Workaround for kernels < v4.18 without fix
> > >  	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> > > -	echo "" 2> log > $IMA_POLICY
> > > -	grep -q "Device or resource busy" log && return 1
> > > +	# Require >= 4.5 to write multiple times via CONFIG_IMA_WRITE_POLICY
> > > +	# 38d859f991f3 ("IMA: policy can now be updated multiple times")
> 
> > Is CONFIG_IMA_WRITE_POLICY really the reason for the 4.5 boundary here?

Yes

> 
> > On >= 4.5 ima_release_policy() runs ima_check_policy(), which returns
> > -EINVAL when ima_temp_rules is empty. The empty write therefore sets
> > valid_policy = 0, ima_delete_rules() is called and IMA_FS_BUSY is
> > cleared, so the probe stays non-destructive even when
> > CONFIG_IMA_WRITE_POLICY=n.
> 
> Well, CONFIG_IMA_WRITE_POLICY did not exist in kernel < 4.5 (not sure if that's
> obvious from the comment I added).

Perhaps prefix the commit message with something like:

IMA allows the builtin policy to be replaced with a custom policy just once. 
Support for appending additional policy rules to the custom policy
(CONFIG_IMA_WRITE_POLICY) was subsequently added in linux 4.5. Refer to commit 
38d859f991f3 ("IMA: policy can now be updated multiple times").

> 
> > What makes < 4.5 different is the absence of ima_check_policy(): there
> Yes, that's true that ima_check_policy() was added in v4.5.

Agreed.

> > the empty write is committed and securityfs_remove() drops the policy
> > file. Would it be clearer to state that, and to keep the v4.18
> > permission workaround in a separate paragraph, since the two comments
> > describe unrelated things?
> 
> > > +	if tst_kvcmp -ge 4.5; then
> > > +		echo "" 2> log > $IMA_POLICY
> > > +		grep -q "Device or resource busy" log && return 1
> > > +	fi
> > >  	return 0
> 
> > With this, require_policy_writable() no longer TCONFs on < 4.5, so
> > ima_policy.sh test2 ("verify that policy file is not opened concurrently
> > and able to loaded multiple times") now runs there.
> 
> Hm, maybe test2() does not really makes sense to run on < v4.5. But test1()
> certainly does. And echo "" > $IMA_POLICY really disables policy in v4.4,
> likely due one of these from v4.5-rc1:
> * 38d859f991f3 ("IMA: policy can now be updated multiple times")
> * 0112721df4ed ("IMA: policy can be updated zero times")
> @Mimi WDYT?

Writing an invalid policy resulted in never being able to transition from a
builtin policy to a custom policy, similar to writing an empty policy. Commit
0112721df4ed ("IMA: policy can be updated zero times") addressed the invalid
policy case.

> 
> > On those kernels one loader gets -EBUSY at open, the other succeeds and
> > the policy file is then removed on release. That hits
> 
> > 	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
> > 		tst_res TPASS "policy was loaded just by one process and able to loaded multiple times"
> 
> > so the test reports that the policy can be loaded multiple times while
> > only the concurrency half of the assertion was exercised, and loading
> > twice is not possible before 4.5.
> That sounds correct and should be fixed.

Correct, IMA originally permitted transitioning from a builtin policy to a
custom policy.  Support for extending the custom IMA policy was added in 4.5.

Mimi

> 
> > Should test2 report TCONF (or split the two assertions) when
> > CONFIG_IMA_WRITE_POLICY is not available?
> With requiring test2 to be run on kernel >= v4.5 (I'll add it to v2) everything
> should work even with this patch (unmodified behavior on >= v4.5, avoid write
> policy on < 4.5 when doing the check for ima_policy.sh test1 and for other IMA
> tests).
> 
> > Verdict - Needs revision
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
