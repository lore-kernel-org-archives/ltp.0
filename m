Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C89E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 15:35:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06C453EFB9B
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 16:35:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E7C63E652E
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 16:34:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0BCEC1027F90
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 16:34:52 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVDsa6S023925;
 Tue, 31 Dec 2024 15:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=i1cBYH
 5xlzEU5fJYZjpYPeKUOmLzPrw9bC4DSmBNu5Y=; b=tI7XEuviwOnpXZvyig3Wjd
 nSop4kLWCkpaL2/FGUuAOsvNSxUMMmPeZYvV6x4+bvr1QBJlBJpjsdk+KY+I0j4c
 cLN/B+3VLSZ3GIrKhydQWcHqrZtjbRF0p+yYy/IldwxCuT8v2f+GevHV6vQFhmBO
 Vm5IPPPIPpjSS5qICijXN0/uj5A99koVpihexsjlgIwCZmONhdSxIkv6w2BNjJaF
 8GlMQAAU2iHKSAYwXH3nbvGVlmg06jMb3lzsDP3aj/Ppo6IA/gAyrgQF6W52JPnN
 iCzEAzq+FDSdSjIohLVqNjaN/x0nyFLcE0n+OcsRjuOdVqM1x0EDIklHpkVuJvGw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43v5nhakpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 15:34:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVE54Yu014564;
 Tue, 31 Dec 2024 15:34:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43tunsjt5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 15:34:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BVFYmhx11207314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Dec 2024 15:34:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF7BC5803F;
 Tue, 31 Dec 2024 15:34:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A3EB5804E;
 Tue, 31 Dec 2024 15:34:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.178.58]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Dec 2024 15:34:48 +0000 (GMT)
Message-ID: <f0746bfae90306d45079f6f3e2f7a1d55e0ad79f.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Dec 2024 10:34:47 -0500
In-Reply-To: <20241231122340.GE36475@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-7-pvorel@suse.cz>
 <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
 <20241231122340.GE36475@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p5OyB5HshQHggiaviKsaYSibU-35jlHe
X-Proofpoint-GUID: p5OyB5HshQHggiaviKsaYSibU-35jlHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310131
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/8] IMA: Add example policy for
 ima_violations.sh
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

On Tue, 2024-12-31 at 13:23 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > Hi Petr,
> 
> > On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >  .../integrity/ima/datafiles/ima_violations/violations.policy     | 1 +
> > >  1 file changed, 1 insertion(+)
> > >  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> 
> > > diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> > > new file mode 100644
> > > index 0000000000..5734c7617f
> > > --- /dev/null
> > > +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> > > @@ -0,0 +1 @@
> > > +func=FILE_CHECK
> 
> > "[PATCH v2 1/8] IMA: Add TCB policy as an example for ima_measurements.sh"
> > contains two rules to measure files opened by root on file open.
> 
> > measure func=FILE_CHECK mask=^MAY_READ euid=0
> > measure func=FILE_CHECK mask=^MAY_READ uid=0
> 
> > If the 'tcb' or equivalent policy is loaded, there is no need to load another
> > policy rule. 
> 
> I guess I'll move check for builtin policy loaded via kernel command line
> parameter also to ima_setup.sh to avoid loading example policy when there is a
> required builtin policy loaded.
> 

Between the builtin and arch specific policies, most of the rules are already
defined.  The exception is measuring the boot command line.  Perhaps we should
update the arch specific policy to include it with the other kexec rules.

The arch specific policy may include the rule that requires the IMA policy to be
signed.

> I also wonder what is a common approach - don't
> try to load custom example policy when there is builtin policy loaded?

How about first checking if the rule exists when there is a builtin or
equivalent custom policy loaded, before loading the example test policy?

> 
> My goal was to allow more broad IMA testing based on different setup:

Very good.
> 
> * running tests with ima_policy=tcb builtin policy (current approach). Many
> tests will be skipped due missing required policy content.

Ok.  Remember even with "ima_policy=tcb" specified on the boot command line, the
results will differ depending on whether the arch specific policy is loaded.

> * running tests without any builtin policy + load a custom policy + reboot via
> LTP_IMA_LOAD_POLICY=1 (this patchset), but this should be probably be done only
> if required (or even none) builtin policy is loaded.

Good.  The first patch introduces the equivalent custom policy to
"ima_policy=tcb".  By "load a custom policy" are you referring to this policy or
a specific policy test rule?

> * Ideally not require CONFIG_IMA_READ_POLICY=y as some distros does not have it
> (but then it is hard to detect whether failures are real bugs or just false
> positives due not having a proper policy). Maybe convert TBROK/TFAIL to TCONF if
> policy content is required but cannot be read due CONFIG_IMA_READ_POLICY (and
> custom policy with proper content was not loaded).

Probably the latter option of converting from TBROK/TFAIL to TCONF is
preferable.  Why fail a test without knowing it will fail.

> But you may have an idea what is more useful (brings more test coverage).

There are two main problems:
- Not being able to read the policy.
- Only being able to load a signed policy.

I think between your above ordering and a new test to see if the policy needs to
be signed, it's the best we can do for now.

As mentioned in my 2/8 response, a new package containing pre-defined custom
policies that are signed by the distro would resolve the latter problem.


Thanks,

Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
