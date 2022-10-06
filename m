Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA5EC433FE
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 22:55:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 278383CAE22
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 00:55:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C8D73CAA2E
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 00:55:34 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 138771400B9A
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 00:55:32 +0200 (CEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296LOAAQ023176;
 Thu, 6 Oct 2022 22:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wDYiZQ4yrqcAudBPKPdBrHP2SXQAIaHtYfpI4VK3jmU=;
 b=KjFPjZF6vXxkli55DQAuxGGsEKZf5wn8hsIvnDEleVAI+CyAzTc1tX2r9od30L03QVW6
 5N62DGtiKSLA7j7NK9Y9H2JRFZWBBG72opKifQlAmltm/AtYOmqaQWMYfwVdsx2K+gje
 JGdJkVIvv7rdcUmPuXtwg++BLNJoxkjbe4m3gIYkJwMiEGUGWVST2OxNVP1O+85/RoNJ
 boStruj+rabbSDEVB5hFmZbFxT6yjVDvig5FYlKja/BvD5VzuDZo0/CUM4mOHOtPbVf+
 3l0yyRLf88+J7AppLEHzMV46l4xJyqkFp7DhYFOqQrVz+j0cMADd3TjBfXwV80gFjAS0 Lw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k26wct23n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Oct 2022 22:55:30 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296MnwE3003951;
 Thu, 6 Oct 2022 22:55:29 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma03dal.us.ibm.com with ESMTP id 3jxd6aejg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Oct 2022 22:55:29 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 296MtTrD62259698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Oct 2022 22:55:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4011C58067;
 Thu,  6 Oct 2022 22:55:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 031D858056;
 Thu,  6 Oct 2022 22:55:28 +0000 (GMT)
Received: from sig-9-77-159-79.ibm.com (unknown [9.77.159.79])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Oct 2022 22:55:27 +0000 (GMT)
Message-ID: <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 06 Oct 2022 18:55:27 -0400
In-Reply-To: <Yz9CW5vXCuztOTOl@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J842yUQD5Ooj3SJG8gV3DbnSpbnWDdmo
X-Proofpoint-ORIG-GUID: J842yUQD5Ooj3SJG8gV3DbnSpbnWDdmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=879 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060133
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

Hi Petr,

On Thu, 2022-10-06 at 23:02 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> > The LTP policy rules either replace or extend the global IMA policy. As a
> > result, the ordering of the LTP IMA tests is important and affects the
> > ability of re-running the tests.  For example, ima_conditionals.sh
> > defines a rule to measure user files, while ima_measuremnets.sh verifies
> > not measuring user files.  Not limiting the LTP IMA policy scope could
> > also affect the running system.
> 
> > To allow the LTP tests to be re-run without rebooting the system, limit the
> > scope of the LTP policy rules to the loopback mounted filesystem based on
> > the UUID.
> Thanks a lot for this, that'll be a great simplification for IMA testing.

By limiting the scope of the IMA policy rules, not everything would
have to be signed on the file system, which brings us one step closer
to defining LTP appraise policy rules.

> I'll have a deeper look tomorrow, but what we need is to ima_setup.sh is to
> always have loopback device. ATM it's just only if TMPDIR is tmpfs.
> See patch below (untested, I'll test it tomorrow).

Agreed.   Seems to be working.  :)

> 
> Also is the kernel code path very different to use UUID from the current code?

The code path is the same - either the policy rule matches or it
doesn't.  Previously, however, the test files being measured could have
been located on any filesystem.  With this change, the test files now
have to be on the UUID filesystem.

> If yes, we might want also to keep the old behavior enabled with some environment
> variable (the default would be to use UUID). Or not worth of keeping it?

Instead of keeping the old behavior, how about defining additional file
tests that do not match the new UUID policy rule?   These files will
not be measured.

> I'd also wish to have simple C implementation instead requesting blkid
> (although util-linux is very common, it's an extra dependency).
> I might write simple C code which finds which UUID in /dev/disk/by-uuid/ is for
> loop device should be pretty simple code. But for now it's ok to use blkid,
> although it should be added into TST_NEEDS_CMDS.

Sure.  I posted this patch more as a proof of concept than anything
else.

> ...
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> > index 0d50db906..d5c5f3ebe 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> > @@ -28,7 +28,7 @@ verify_measurement()
> >  	ROD rm -f $test_file
> 
> >  	tst_res TINFO "verify measuring user files when requested via $request"
> > -	ROD echo "measure $request=$value" \> $IMA_POLICY
> > +	ROD echo "measure $FSUUID $request=$value" \> $IMA_POLICY
> >  	ROD echo "$(cat /proc/uptime) $request test" \> $test_file
> 
> >  	case "$request" in
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > index af1fb0028..95e7331a4 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > @@ -27,7 +27,12 @@ load_policy()
> >  	exec 2>/dev/null 4>$IMA_POLICY
> >  	[ $? -eq 0 ] || exit 1
> 
> > -	cat $1 >&4 2> /dev/null
> > +	if [ -n "$FSUUID" ]; then
> Interesting, would it be correct if there is no UUID with my changes below (i.e.
> always use the loop device)? Actually, do we also want to have way to disable
> loop device (obviously only on TMPDIR not being tmpfs).

If/when using a non loopback device, there should at least be a major
warning that the global policy has been modified.

> > +		sed "s/measure /measure $FSUUID /" $1 >&4 2> /dev/null
> > +	else
> > +		cat $1 >&4 2> /dev/null
> > +	fi
> > +
> >  	ret=$?
> >  	exec 4>&-
> 
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > index df3fc5603..016a68cb2 100644
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -178,6 +178,10 @@ ima_setup()
> >  	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
> >  		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
> >  		cd "$TST_MNTPOINT"
> > +
> > +		loopdev=$(mount | grep $TST_MNTPOINT | cut -f1 -d' ')
> We have $TST_DEVICE for this.
> 
> > +		FSUUID="fsuuid=$(blkid | grep $loopdev | cut -f2 -d'"')"
> > +		tst_res TINFO "LTP IMA policy rules based on $FSUUID"
> >  	fi
> 
> >  	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
> 
> Proposed (not yet tested) changes.
> 

Thanks, the proposed changes seem to be working.

thanks,

Mimi

> 
> diff --git testcases/kernel/security/integrity/ima/tests/ima_setup.sh testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 016a68cb2..dd88fbc71 100644
> --- testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -11,9 +11,7 @@ TST_CLEANUP_CALLER="$TST_CLEANUP"
>  TST_CLEANUP="ima_cleanup"
>  TST_NEEDS_ROOT=1
>  TST_MOUNT_DEVICE=1
> -
> -# TST_MOUNT_DEVICE can be unset, therefore specify explicitly
> -TST_NEEDS_TMPDIR=1
> +TST_NEEDS_CMDS="$TST_NEEDS_CMDS blkid"
>  
>  SYSFS="/sys"
>  UMOUNT=
> @@ -179,8 +177,7 @@ ima_setup()
>  		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
>  		cd "$TST_MNTPOINT"
>  
> -		loopdev=$(mount | grep $TST_MNTPOINT | cut -f1 -d' ')
> -		FSUUID="fsuuid=$(blkid | grep $loopdev | cut -f2 -d'"')"
> +		FSUUID="fsuuid=$(blkid | grep $TST_DEVICE | cut -f2 -d'"')"
>  		tst_res TINFO "LTP IMA policy rules based on $FSUUID"
>  	fi
>  
> @@ -339,10 +336,4 @@ require_evmctl()
>  	fi
>  }
>  
> -# loop device is needed to use only for tmpfs
> -TMPDIR="${TMPDIR:-/tmp}"
> -if tst_supported_fs -d $TMPDIR -s "tmpfs"; then
> -	unset TST_MOUNT_DEVICE
> -fi
> -
>  . tst_test.sh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
