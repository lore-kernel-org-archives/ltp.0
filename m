Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DE8D2FED7
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 18:25:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EBC53C9CAE
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 19:25:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EB4B3C1A27
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 19:24:53 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 33D6710009EC
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 19:24:52 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60RH0Prw021821;
 Tue, 27 Jan 2026 18:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DcRKyJ
 EM5s/6sS92kS1sOSlSlxzX2/oa/N7VkfXvO5E=; b=CQ9Skn2idhFbhtxYMmU73a
 1Uup+YksbNH4IUajf89smePsrydDMu3Tv35QJovlqg07dZxvVunjN586uwNfv9oE
 pUbmj/0feDB8rDxomBipoDGNhtJi4LKzuWjYGadwN2Wllh8KhHtpeJhBkPvEZAZC
 aCFI/HVGXD6ZrU8N59z4/f1mOwB+UKghhAEKm2h3mqIDTsrYr4avuh/0xMfHRZWs
 W/8/oK3zlvp8agfemICgERZGHyQu98dU5GQeDCDHJ47JJATbd6SdG3K9Cq+FZyo9
 UvKV3Bxy5pjkhIAcqp3shwqtyCv9QTHXOO7KMXtGEO5+duz3Mh5WStd7jUAHC7Gw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtf0qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 18:24:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RF0BtW018303;
 Tue, 27 Jan 2026 18:24:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41sjcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 18:24:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RIOnFA29032968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 18:24:49 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1585C58056;
 Tue, 27 Jan 2026 18:24:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F2235804E;
 Tue, 27 Jan 2026 18:24:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.189.79]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 18:24:48 +0000 (GMT)
Message-ID: <447d5d46a8ac3ed8a8283d87bd555459a2679495.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20260127131755.GA146899@pevik>
References: <20260121083343.127613-1-pvorel@suse.cz>
 <20260127131755.GA146899@pevik>
Date: Tue, 27 Jan 2026 13:24:48 -0500
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cksGe1t79QRuDBYy2o-fhV-qaI3MlbEP
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=697902f2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=_4C9gLwq-jLjF3gInBgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cksGe1t79QRuDBYy2o-fhV-qaI3MlbEP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0OSBTYWx0ZWRfX6mnWdqxDHPWl
 LB5YuWYr9sh5KKX0jxBywZK15f/upTW8xcDjn/yHZrLeNNLBAE0eODrTwrhR3UYIdbvnIw5gncX
 FzgzZl9rf52dPwFicqoFpL7GxTzKMF+GmjCA+dtkQUH0FH2ULYP1J0mpf8C3MojdBGxu34KC9an
 Fet1LR4cGG023gbCQMtCRAM9z08neWqa8igzxelJzmu7iSEh9V4w9XCtXzW3SmUATyvdcVdBUwS
 CL4G2k5Sgp5lP/YBpnCwYYIfI5T15Fl03qSCyoXQEipxbL5jA79JIL7hXUzKk5gzSdR1CZUtExa
 M8bbazj8DwPM4dbBZcTuht44IYUj/BSaZpl3msH54mgqZjvBuKVVFilHUKboHAfQ0YqY69Pfx54
 EfR3BM38BolsOyz1FG/QYqRcw/5jX32772EOY1k6YxsRK/2bYCV26aUnC2gLQKGnF/+WBKxY3pf
 DUqBZCM+L18vqhGL/HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270149
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima_setup.sh: Fix check of signed policy
 requirement
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

On Tue, 2026-01-27 at 14:17 +0100, Petr Vorel wrote:
> Hi Mimi, all,
> 
> > Kernel code in arch_get_ima_policy() depends also on
> > CONFIG_IMA_ARCH_POLICY added in v5.0:
> > d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86")
> 
> > Fixes: c38b528783 ("ima_{conditionals, policy}: Handle policy required to be signed")
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Mimi, all,
> 
> > FYI I'd like to merge it this week to get it into LTP release.
> 
> > Kind regards,
> > Petr
> 
> I dared to merge this to get it into upcoming LTP release (this/next week).

I'm so sorry for the delay.

Only if CONFIG_IMA_ARCH_POLICY IS configured, should check_need_signed_policy be
set to true and the test skipped.  However, I'm seeing:

tst_kconfig.c:531: TINFO: Constraint 'CONFIG_IMA_ARCH_POLICY' not satisfied!
tst_kconfig.c:477: TINFO: Variables:
tst_kconfig.c:495: TINFO:  CONFIG_IMA_ARCH_POLICY=n
ima_conditionals 1 TCONF: Aborting due to unsuitable kernel config, see above!

Instead it's requiring CONFIG_IMA_ARCH_POLICY to be enabled.

Mimi

> 
> >  testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > index 1bce78d425..df0b8d1532 100644
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -466,10 +466,11 @@ require_evmctl()
> >  }
> 
> >  # 56dc986a6b20b ("ima: require signed IMA policy when UEFI secure boot is enabled") # v6.5-rc4
> > +# d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86") # v5.0
> >  check_need_signed_policy()
> >  {
> >  	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs \
> > -		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY'
> > +		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,CONFIG_IMA_ARCH_POLICY'
> >  }
> 
> >  # loop device is needed to use only for tmpfs

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
