Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82077C4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 02:47:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FAB33CAEAD
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 04:47:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 277973C075E
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 04:47:15 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B0AE8601115
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 04:47:13 +0200 (CEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C2gBWB022762;
 Wed, 12 Oct 2022 02:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WxB/Y1Lrqgnu40ZfjQ0+EPIGchSJl+Y84dVKmh4BeIc=;
 b=KrcYWNq/+YgvzT9ptcjXG0ogjj2DA0To1mFWuwO2uLFd1yRFR3LSVrj0w2Jk4fMmr9cA
 E+hHJ5jeN/kk9siFYmcfkHx5fn9rLHWlgLTEcuLo9dGdYP0YMQNKslNummpFTNLCj1Z/
 rWX6q9kzB/zAZ4XGzRm7sZ2W0uHN1v4kaJLpBQlvmLFXoBDnfqVToZzTt9XNw2UjT2hM
 DuxrmHH37693CCcx1z1tJQKN2kfkWFB/QpB2dZ9ldqWP+qWq6eC2BYapmDqq4r+fHf0+
 huC3ydIQdmjvjn9WtCmiPX3po2Wt82zyPGrjgNXwOl+oIF6ti9CxRiIRgzC3apKSYn1S 6Q== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5n180366-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Oct 2022 02:47:11 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29C2Z4nr012798;
 Wed, 12 Oct 2022 02:47:10 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 3k30ua4csn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Oct 2022 02:47:10 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29C2lCFk2556428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Oct 2022 02:47:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4336E5805A;
 Wed, 12 Oct 2022 02:47:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFE6358051;
 Wed, 12 Oct 2022 02:47:08 +0000 (GMT)
Received: from sig-9-77-135-142.ibm.com (unknown [9.77.135.142])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Oct 2022 02:47:08 +0000 (GMT)
Message-ID: <a7b9b60182d13d92d6e0c5d2c588644027c72b41.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Oct 2022 22:47:08 -0400
In-Reply-To: <Y0QFSiMTx3XlvAHJ@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
 <Yz+4xepB6HlyFSNJ@pevik>
 <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
 <Y0QFSiMTx3XlvAHJ@pevik>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nKxHn0LhUFfIO60nL2WYQ40_jRbv3ryy
X-Proofpoint-ORIG-GUID: nKxHn0LhUFfIO60nL2WYQ40_jRbv3ryy
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_01,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120016
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

On Mon, 2022-10-10 at 13:43 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> FYI I have problems with ima_violations.sh, when run whole runtest/ima:
> 
> tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
> ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.Og149san78/mntpoint
> ima_violations 1 TINFO: timeout per run is 0h 5m 0s
> ima_violations 1 TINFO: IMA kernel config:
> ima_violations 1 TINFO: CONFIG_IMA=y
> ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=y
> ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
> ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=y
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=y
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
> ima_violations 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> ima_violations 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
> ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y

> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-
> 5.19.12-1-default root=UUID=6de93d21-b5ed-4aa4-a9e4-00a7ab77c6d9
> splash=silent video=1024x768 plymouth.ignore-serial-consoles
> console=ttyS0 console=tty kernel.softlockup_panic=1
> resume=/dev/disk/by-uuid/570474ff-969e-41e6-883e-ecff2fd15015
> security=apparmor mitigations=auto ignore_loglevel lsm=integrity
> ima_policy=tcb

I would use either use the original "security=" or the new "lsm=" boot
command line option.

> ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> ima_violations 1 TINFO: LTP IMA policy rules based on fsuuid=7ab2cd65-3060-4dbc-b786-72703604a33e
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TFAIL: open_writers violation not added
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TFAIL: ToMToU violation not added
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TFAIL: open_writers violation not added
> ima_mmap.c:41: TPASS: test completed
> 
> My fix [1] does not help. Problems are with my changes or just with your
> original patch. Continue debugging.
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20221010085944.26814-1-pvorel@suse.cz/

Only the ima_conditionals.sh and ima_policy.sh tests define policy
rules based on fsuuid.  The other tests are still based on the builtin
"ima_policy=tcb" rules.

Without seeing the output of "cat /sys/kernel/security/ima/policy" it's
hard to understand what's causing these errors.

thanks,

Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
