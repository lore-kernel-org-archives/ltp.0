Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA4AC4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 23:29:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 260E13CBCC0
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 00:29:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84FE63CAFC9
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 00:29:23 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5282E1000458
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 00:29:20 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BFMs7TM029716; Thu, 15 Dec 2022 23:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=HQ9VRuA/PehoWPnLs+fdCYprs+J8PXwHwu7xXkD3Snw=;
 b=s1WKd4WoIRruZ96jLuonyDN1cM646b0i6zJEui0sAfQO9L/8ZxYmhR3toyPgzqFEgfLy
 tgk/R0wVkyQAh9fr8gJMQb3zffNv94YGTF1UgaE3MfFGw7U7semXv54uWj1pgDTB0Rhb
 DBOFwYybGRwjOxhSAr4Qc9RXMjbSUe6RBhjOxz2+UjRspifcZwPC8nyVXHOSngzQZyTo
 W8ey7bw797sU6d3hM4y5JuR+UfFJV6sTC2sJ89+iWdvbxX9xk+44sNy29Gq9HEtck3dq
 YrWvl5M9w/KbIMQ2ugV4S/rwtKRhkes4CCkm1SyE7xM8WHQmgKm+SQ84UguVei3oMNV3 JA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgcsk0pjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Dec 2022 23:29:19 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFMGVua024172;
 Thu, 15 Dec 2022 23:29:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
 by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3meypkeakf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Dec 2022 23:29:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BFNTHv22622050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Dec 2022 23:29:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21F4A5803F;
 Thu, 15 Dec 2022 23:29:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA25F5805A;
 Thu, 15 Dec 2022 23:29:16 +0000 (GMT)
Received: from sig-9-65-242-118.ibm.com (unknown [9.65.242.118])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 Dec 2022 23:29:16 +0000 (GMT)
Message-ID: <d7f4edfe75498d5d80bc55f2bb118fea34d9ad08.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Dec 2022 18:29:16 -0500
In-Reply-To: <Y5tp0K5QIZ74bnw7@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
 <Yz+4xepB6HlyFSNJ@pevik>
 <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
 <Y0QFSiMTx3XlvAHJ@pevik>
 <a7b9b60182d13d92d6e0c5d2c588644027c72b41.camel@linux.ibm.com>
 <Y5tp0K5QIZ74bnw7@pevik>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YXoQpKknlhRjn_lzFRd3aDL7tNosAeDZ
X-Proofpoint-ORIG-GUID: YXoQpKknlhRjn_lzFRd3aDL7tNosAeDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150192
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/ima: limit the scope of the LTP policy
 rules based on the UUID
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 2022-12-15 at 19:39 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> I'm sorry, it took me long time to look into the issue.
> 
> > Only the ima_conditionals.sh and ima_policy.sh tests define policy
> > rules based on fsuuid.  The other tests are still based on the builtin
> > "ima_policy=tcb" rules.
> Yes.

< trimmed >

> 4) running ima_violations.sh after ima_policy.sh no longer works, because
> there is nothing new in /var/log/audit/audit.log. I don't know why, but
> ima_violations.sh requires either the default ima_policy=tcb policy or policy
> created by ima_policy.sh *without* fsuuid.

Violations occur when a file in policy is already opened for read and
is being opened for write, or the reverse.  After the builtin policy is
replaced with the custom policy based on the UUID, running the
violation test fails because the UUID is reset by the call to
ima_setup().  So the file being opened doesn't match any policy rule.

> FYI below is content of /var/log/audit/audit.log.
> 
> Also looking at things twice, fsuuid does not help testing much.
> Because main blocker for testing is not the scope of the policy, but write once
> policy - CONFIG_IMA_WRITE_POLICY not being set on distro kernels thus repeated
> write of the policy will need reboot.

Oh, I didn't realize this.  Fedora (and RHEL) enable
CONFIG_IMA_WRITE_POLICY.

> Rebooting actually might be possible sooner or later with new runltp-ng from
> Andrea [1] (the feature is not here yet, but will be sooner or later). runltp-ng
> is close to upstream, there was first attempt [2].

Let's try to avoid this solution as much as possible.

> Other option would be to prepare policy which would be suitable for all tests,
> with help of fsuuid.

Ok, I'll look into this.

> But that has drawback:
> Currently we use LTP API to mount directories on loop device after test has started.
> These devices are temporary, e.g.
> /tmp/LTP_ima_violations.pEvyfJO7Af/mntpoint/test.txt will be unmounted and
> deleted after each test run. But for fsuuid we'd need to first permanently
> mount the devices to get their UUID. Therefore there would have to be some
> special setup script needed to be run for all tests. This has proven to be
> problematic in the past. I'd have to extend the API to create something permanent.

Instead of ima_setup() setting the UUID to a new different value, if
additional rules cannot be written (require_policy_writable) the UUID
could be set to the existing policy rules UUID.

Thanks,

Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
