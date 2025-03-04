Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E93BC021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 13:06:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56B043C7B04
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 14:06:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47A2E3C7B04
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:06:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 481391423DD5
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:06:10 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249qUk4018564;
 Tue, 4 Mar 2025 13:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5NhgvE
 mB//JwLWrL4p9NVehytXsQmTIfoqR3DznckAw=; b=BKw/QOzlCIUUbi/j7Z5X7L
 p8kjlE35oZ/jBgpLkHkkU1GAgAMAsfH1UHGktnsD2eqteNjIlE/PJLnDcPHpjcoj
 H/2TF52BdvXC+1j7sVBJfVQWcTiJvv7r75/HsKmDGHPwOxbSKIvNF5gF6Gbk/+Wo
 rI2Zy4qxuH+emtWj2F8r5XMWlX5milKNOD43nP2BNOpYQhJ89yS5nyGNlHOMPdDt
 hGkzhKYBzlJDD617h/F3KxLqnQ3vGDRybGl5OkkV5u/y7tTsIhRz5mGod0hr/gwO
 l0fQ2P5bWPLZFrVkckDYSNWzCbj8fuVv3aIpkeg8ftvQ+w12zE4vLmZV98HK6z9w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmyky3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 13:06:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524AkFkb032216;
 Tue, 4 Mar 2025 13:06:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjswpck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 13:06:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 524D67o420906696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Mar 2025 13:06:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D51C58059;
 Tue,  4 Mar 2025 13:06:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACFCA58043;
 Tue,  4 Mar 2025 13:06:06 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.57.16]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Mar 2025 13:06:06 +0000 (GMT)
Message-ID: <30769565910b3198fa8d714b5edb25419fcb1457.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 04 Mar 2025 08:06:06 -0500
In-Reply-To: <20250304125749.GA81126@pevik>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
 <20250304125749.GA81126@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _8Zetb3FGGs-Lk1GJLKif6CTulfkSx2O
X-Proofpoint-GUID: _8Zetb3FGGs-Lk1GJLKif6CTulfkSx2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=954
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040106
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] ima_violations.sh: force $LOG ToMToU
 violation earlier
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 2025-03-04 at 13:57 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > Violation tests are dependent on searching the $LOG file, which may
> > itself result in a ToMToU violation.  Preempt getting an additional
> > violation during the tests by forcing the $LOG ToMToU violation
> > earlier.
> 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  testcases/kernel/security/integrity/ima/tests/ima_violations.sh | 1 +
> >  1 file changed, 1 insertion(+)
> 
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > index 37d8d473c..22863fb72 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > @@ -30,6 +30,7 @@ setup()
> >  	if [ ! -e "$LOG" ]; then
> >  		tst_brk TCONF "log file not found, install auditd"
> >  	fi
> > +	exec 3< $LOG || tst_brk TBROK "failed to read log file"
> >  	tst_res TINFO "using log $LOG"
> 
> If you don't mind, I would reverse the order to get info about which log is
> used:
> 
> 	tst_res TINFO "using log $LOG"
> 	exec 3< $LOG || tst_brk TBROK "failed to read log file"

Oh, I see what you mean.  All of the TINFO come first and then an error, if
there is one.  That's fine.

> 
> Or, if it's needed to for some reason to run it before (no idea why, but I might
> miss something), I would merge it as:
> 
> 	exec 3< $LOG || tst_brk TBROK "failed to read $LOG"
> 	tst_res TINFO "using log $LOG"
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

thanks,

Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
