Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC454C021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 21:33:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A78313CA05A
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 22:33:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D899F3C9D69
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 22:33:15 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 23107200BD4
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 22:33:14 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524KaT99008926;
 Tue, 4 Mar 2025 21:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IXDOt4
 dGMOUZ2E0gjatLE5EUFdlEMv/9mYYSZO4nvko=; b=HCArbirEC4VDWz/iAnbUF/
 XzvO6VEn12hseWchJaKDfCvzYFdTCXwK0W0sfx/OKH/cGBLLPxlxYYLgEFIV9TGJ
 P3KK9vVSv9eBgPxtentk1BYApbPP5tBsPTzlhriefZ7TvrpA7gUbGRtIbQIRKpVn
 ulg9r4zj/eiyA7eY8T9tWAvvqRuM1lgQcUM93qTbovXO5pOA4+eHEtBIvfFS6n3P
 4wE8CGlAuBTVqWS50hGoljGLYOxF3e+qK7c2JoJXH/Ljl6K6xboJ4cl75bK9PQ5y
 z4bA5lZw1o7TE/TK/pI/4BOCLw1bFjgKY7dUTiI3+Vhx2FT63kzmBkypfs0zR4eQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568pp869g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 21:33:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524Ilsrg020841;
 Tue, 4 Mar 2025 21:33:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnfhv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 21:33:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 524LXBBi27787824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Mar 2025 21:33:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E25858067;
 Tue,  4 Mar 2025 21:33:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61A4358068;
 Tue,  4 Mar 2025 21:33:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.31.103.152]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Mar 2025 21:33:11 +0000 (GMT)
Message-ID: <a0da3808cec92300c67489539fbee3cbfd2fb4e5.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 04 Mar 2025 16:33:11 -0500
In-Reply-To: <20250304174342.GA97130@pevik>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
 <20250304115331.524842-2-zohar@linux.ibm.com>
 <20250304133101.GC81126@pevik>
 <678478de87319625e591e8e956a57b31c700bbd2.camel@linux.ibm.com>
 <54cf5311ec5e0debd6dfd63669e8d01883c0ba23.camel@linux.ibm.com>
 <20250304174342.GA97130@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4sbaRRjd-5lJge1lM-hzGxWKfY1NwILp
X-Proofpoint-ORIG-GUID: 4sbaRRjd-5lJge1lM-hzGxWKfY1NwILp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=941
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040173
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] ima_violations.sh: Update validate() to
 support multiple violations
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

On Tue, 2025-03-04 at 18:43 +0100, Petr Vorel wrote:
> > On Tue, 2025-03-04 at 09:44 -0500, Mimi Zohar wrote:
> > > On Tue, 2025-03-04 at 14:31 +0100, Petr Vorel wrote:
> > > > Hi Mimi,
> 
> > > > > Add support for the number of expected violations.  Include the
> > > > > expected number of violations in the output.
> 
> > > > Unfortunately this works only on fixed kernel (e.g. the one with v1 of your
> > > > "ima: limit both open-writers and ToMToU violations" kernel patchset [1]
> > > > (I haven't built v2 [2], but it's really just
> > > > s/IMA_LIMIT_VIOLATIONS/IMA_EMITTED_OPENWRITERS/ => it will work)
> 
> > > > Testing on any other kernel it fails on first testing after reboot:
> 
> > > Hi Petr,
> 
> > > I only tested by specifying the "ima_policy=tcb" on the boot command line.  This
> > > failure happens when loading the test specific policy rules.  If setup() is
> > > called before loading the test specific policy rules, forcing the $LOG file
> > > violation at setup() would be too early.
> 
> > Sorry, that doesn't seem to be the case.
> 
> > With the changes to validate(), even the original tests will only work on a new
> > kernel.  I'll rework the patch set, so at least the original tests will continue
> > to work.
> 
> +1, thank you!

Hi Petr,

Since the original three tests don't provide the expected number of violations,
the following should work for them.  The new tests will fail without the kernel
patch.  The assumption is that LTP can handle some of the tests, not all of
them, succeeding.  On a new kernel, all of the tests should succeed.  Tested
only with bash.

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 2fbffc5da..0395f8d0a 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -87,12 +87,13 @@ validate()
        local max_attempt=3
        local count2 i num_violations_new
 
-       [ -z "$expected_violations" ] && expected_violations=1
-
        for i in $(seq 1 $max_attempt); do
                read num_violations_new < $IMA_VIOLATIONS
                count2="$(get_count $search)"
-               if [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
+               if [ -z "$expected_violations" ] && \
+                  [ $(($num_violations_new - $num_violations)) -gt 0 ] || \
+                  [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
+                       [ -z "$expected_violations" ] && expected_violations=1
                        if [ $count2 -gt $count ]; then
                                tst_res TPASS "$expected_violations $search violation(s) added"
                                return

thanks,

Mimi



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
