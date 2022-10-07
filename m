Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B9AC4332F
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 12:56:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A58B3CAE44
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 14:56:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39DF13CAC05
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 14:56:11 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 090A51A01941
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 14:56:09 +0200 (CEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297CXSva004012;
 Fri, 7 Oct 2022 12:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=l8+kClQJtiVn/mNi2rH/JUTSCUPrQeD5wpHg9kDapvc=;
 b=LzEhnJKzE2uBoKajIr6MRP6+PW9C31FnYTA1CPxaj5R73/ZziwafHvpNji5HmUxpdofe
 N8PlulEk/iVp2I7VIHANEXQID/ofiw1trNB/gQGMCsR93evQ1gjHWcGefOUcdevkbQFP
 hkh51Df4VE4m71zYzKnCXOhkfOEl+QYnvy+XBlInjKrEjsQlYgEIOOqhA4wwPjzDNPdx
 vjPoLv6e83wOGHigrZ5Uy9gmvWgA4EbhSF4/XSqe08IySAKv7si4SQSSXRCoe1BXAjZw
 qbdqxEjkk9+xnXQJiO8ItxtSLQ13Qoxbs9M+uu27TYWL6/cXlQCq+516s9cOTA8/mqmf Vw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k2m7m0qaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Oct 2022 12:56:08 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 297CpHSs030125;
 Fri, 7 Oct 2022 12:56:07 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03wdc.us.ibm.com with ESMTP id 3jxd6a0vsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Oct 2022 12:56:07 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 297Cu6FV18678316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Oct 2022 12:56:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C5145805B;
 Fri,  7 Oct 2022 12:56:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF72E58058;
 Fri,  7 Oct 2022 12:56:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown
 [9.160.33.126]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Oct 2022 12:56:05 +0000 (GMT)
Message-ID: <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 07 Oct 2022 08:56:05 -0400
In-Reply-To: <Yz+4xepB6HlyFSNJ@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
 <Yz+4xepB6HlyFSNJ@pevik>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kl34-ljEcVQx6UbQjZ_Cv5xZv9hNMrP-
X-Proofpoint-ORIG-GUID: kl34-ljEcVQx6UbQjZ_Cv5xZv9hNMrP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=604 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070075
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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

On Fri, 2022-10-07 at 07:27 +0200, Petr Vorel wrote:

> > > Also is the kernel code path very different to use UUID from the current code?
> 
> > The code path is the same - either the policy rule matches or it
> > doesn't.  Previously, however, the test files being measured could have
> > been located on any filesystem.  With this change, the test files now
> > have to be on the UUID filesystem.
> 
> Good to know. Also, we have new feature in shell API: $TST_ALL_FILESYSTEMS (it
> has been for long time for C API as .all_filesystems, which loops the test over
> various filesystems: ext2, ext3, ext4, xfs, btrfs, vfat, exfat, ntfs, tmpfs.
> Test therefore takes much longer, but it's worth for tests which can behave
> differently on various filesystems. I suppose IMA does not need it, right?

Nice!  IMA code paths are different on filesystems with/without
i_version support.   With the proposed i_version kernel
changes, ima_measurement.sh test2 is really important.

On filesystems without i_version support, after a file has been opened
for write, on fput IMA assumes the file has been modified.  On next
access, the file is re-verified/re-measured.

I'm not sure if ima_measurement.sh test2, which is limited to
filesystems with i_version support, should be extended or a new test
defined to detect whether a file is properly re-measured after it has
been modified on all filesystems, even those without i_version support.
 
> 
> > > If yes, we might want also to keep the old behavior enabled with some environment
> > > variable (the default would be to use UUID). Or not worth of keeping it?
> 
> > Instead of keeping the old behavior, how about defining additional file
> > tests that do not match the new UUID policy rule?   These files will
> > not be measured.
> Correct measurement outside of the loop device? I.e. something in $TST_TMPDIR?
> (i.e. /tmp/foo - test unique working directory, $TST_MNTPOINT is mounted on
> /tmp/foo/mntpoint, so that we still have working place outside mounted loop device).
> Do you mean trying to measure something what expects to fail?

Yes, there shouldn't be a new measurement.

> > > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > > > index af1fb0028..95e7331a4 100755
> > > > --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > > > @@ -27,7 +27,12 @@ load_policy()
> > > >  	exec 2>/dev/null 4>$IMA_POLICY
> > > >  	[ $? -eq 0 ] || exit 1
> 
> > > > -	cat $1 >&4 2> /dev/null
> > > > +	if [ -n "$FSUUID" ]; then
> > > Interesting, would it be correct if there is no UUID with my changes below (i.e.
> > > always use the loop device)? Actually, do we also want to have way to disable
> > > loop device (obviously only on TMPDIR not being tmpfs).
> 
> > If/when using a non loopback device, there should at least be a major
> > warning that the global policy has been modified.
> OK not quiting whole test with TBROK, but add TWARN (test continue, but later
> exits with non-zero).

Sounds good.

thanks,

Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
