Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D61C5CFCF
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 01:18:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52DB83C5E1D
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 03:18:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 724B63C5E1D
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 03:18:29 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BAF20100092E
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 03:18:28 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DLWNRq3513180; Fri, 14 Aug 2026 01:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=msMSWS
 80t5bCMGLe66VYVo9N5HxWyHOKHuj0uosWnxE=; b=tdTWnA93h2Hsd6EvDn5Umg
 24es/WlZEpONzW7apMLJidE5bKUv5x0L0rbowCyrCK1RhnUsr9eL6m2dADsyQ8uu
 cHc99kK2Jvw41S6oCrPMAEc//3MDkfcGR4B1rEEengM7yTtnHT2eyfxWHbp5Gila
 M5sN7d1qh5mxsPUTr/A6NMmTlOs94wSeL1Oi99ZXNFVapvvRArmjIYJlDvaxEdin
 9DPKwiuivDhQlenqC9camG2kOQPyxh8iRumrEZSn7WEHjWp7BB3OmiJAF2xCIyTz
 GrZbZb9dz89UfsqpXYPV+3NyTPUxXsNUsV8DO7asHGPlSkLGTydr/jKg9HsUsSuQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma2q19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 01:18:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E1Bp4i025717;
 Fri, 14 Aug 2026 01:18:25 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hd97r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 01:18:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67E1IO6g51839450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Aug 2026 01:18:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFBAD5803F;
 Fri, 14 Aug 2026 01:18:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E01A5804E;
 Fri, 14 Aug 2026 01:18:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.7.32]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Aug 2026 01:18:24 +0000 (GMT)
Message-ID: <b901f8d94a9d6e3faf26a5e359ad8ec7e306c931.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20260813112524.1849695-1-pvorel@suse.cz>
References: <20260813112524.1849695-1-pvorel@suse.cz>
Date: Thu, 13 Aug 2026 21:18:23 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAwNiBTYWx0ZWRfXzMNJEb6T9r4V
 WoQKghGWxYMP1wPqsS/IDWjyWWgAAnlZ+LZ0XKreTpa3DyylvaMPYki2N5nLtqVfki9zqYp3E5Q
 i2/sNZroE9J28kBynSUX2ISAbj/UXmbR0EF5emy7GgHsB2EjfTjN8Xl/bkKuwDraQYt6SV/KRhe
 Jlx4fMjV+5tO3rebatdPp/Nddj5DXzitfYZT9ByLe72W7w9URHTjFU7DroW+IEZpryBr3e5dPK7
 FCDM6a0pyReb9yltCaERgtj1BlD1SAJ56UVl32dG63tgmuekvUXbhOEN1RgPb8qkmMSWxYxuQsf
 knttxGnuKiEXfhD/ye5IywVwC5J9mY/UiDLzwLdl70/dXBd1vMnxqG3LZVeCHbh6STA00MPFp4G
 pNE2VeOJ1HQrazjqB46AD7EwJDirv+dXt+uif7XqzlDYg2Bcz6DPlUsonYF9DQ0/8A39vwCYlN1
 NunXEIlI1YTcwVm5XGg==
X-Proofpoint-ORIG-GUID: 62GcnGBGorW-Cfw8cFhyK8oR-WQJ3dLC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAwNiBTYWx0ZWRfX1bcvoPBmQER6
 AbHiaAEA9V9g30/IWkf2BOJJy7OtDXThToix0x4Do6BtlXvp8RNgg+GedrRLYdLjPrvKQH3XdlC
 GuCTBxkBSY+zLuyrgqaQt9s78049gC8=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7e6ce2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=yF6fm7Vi_KPl3uAzEtQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 62GcnGBGorW-Cfw8cFhyK8oR-WQJ3dLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140006
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ima_setup.sh: Use tst_umount()
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

On Thu, 2026-08-13 at 13:25 +0200, Petr Vorel wrote:
> Use standard test mechanism to detect problems during umount() caused by
> GNOME's gvfsd-trash daemon. Although it will not solve the problem it at
> least warn tester.
> 
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

With this patch applied and after removing everything other than ima_violations
from /opt/ltp/runtest/ima, I'm still seeing:

ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_violations 1 TINFO: booted with IMA policy: tcb
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TPASS: 1 open_writers violation(s) added
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TPASS: 1 ToMToU violation(s) added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.1.5-
101.fc43.x86_64/build/.config'
ima_violations 3 TBROK: tst_checkpoint wait 10000 0 failed
umount: /tmp/LTP_ima_violations.1OEcI81NHB/mntpoint: target is busy.
ima_violations 3 TINFO: umount(/tmp/LTP_ima_violations.1OEcI81NHB/mntpoint)
failed, try 1 ...
ima_violations 3 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it
to speed up tests.
umount: /tmp/LTP_ima_violations.1OEcI81NHB/mntpoint: target is busy.
ima_violations 3 TINFO: umount(/tmp/LTP_ima_violations.1OEcI81NHB/mntpoint)
failed, try 2 ...

The message keeps repeating ...

Mimi


> ---
>  testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 19f00532b1..054ab28611 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -313,7 +313,7 @@ ima_cleanup()
>  	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
>  
>  	for dir in $UMOUNT; do
> -		umount $dir
> +		tst_umount $dir
>  	done
>  
>  	if [ "$IMA_POLICY_LOADED" = 1 ]; then

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
