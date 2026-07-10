Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0291C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 17:59:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9373E5D2E
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 19:59:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7C003E2C59
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 19:59:03 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC874600BA9
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 19:59:00 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AHIYjI1863383; Fri, 10 Jul 2026 17:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=dY09R7hzjct7fEPZT0KmSrSW95/Tnc
 2dFOtOREJhRgI=; b=QM99HGwTpt8YQNcrZJgdi8TOUCMOr7OEUMtuhcT04NUiY+
 muvJYbggEITz6OLD1uYOKlNY9IN5/W5m+pPh7LKUf+1SFHSDKda6awDoA503/NBs
 73Oj0+tsBUExzmMnAFpAQv3+3mO+QfgBvX22vzvEioDgDgNgonw05IT4+yR2Y03L
 7XchXZyPBVz27/yh0Q5Nzl7E3c7A14P/B9PD1XJaabc1/CYWazpF8+ac0Y2n1Vgf
 8K0AXHBxt3aQ+9k3tzLr0cnA4EqL85CuxwqETo0UR2aHfR8Xb7m/KABEC+ghrY+O
 JWYKz2lMT6ofIKSBDSoKySi84J/VqUAtMzs4RCuQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknyakk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 17:58:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AHndMv020262;
 Fri, 10 Jul 2026 17:58:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkk672-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 17:58:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66AHwudf50790854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 17:58:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E1DA20043;
 Fri, 10 Jul 2026 17:58:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4B4F20040;
 Fri, 10 Jul 2026 17:58:55 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.87.140.3]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Jul 2026 17:58:55 +0000 (GMT)
Date: Fri, 10 Jul 2026 19:58:54 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <alEy3nC7daReO293@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260709102837.54583-1-japo@linux.ibm.com> <alDlHzYiak61OLRZ@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alDlHzYiak61OLRZ@rei>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a5132e2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=YJIrWB2r75PW0QrGtXgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: bwJLpWbWM45lyyHFU4kIPWdQOqtZ1sFo
X-Proofpoint-ORIG-GUID: bwJLpWbWM45lyyHFU4kIPWdQOqtZ1sFo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE3OCBTYWx0ZWRfX/4MJ7i0sf2xK
 uuhFKqWbP1NAjeSrxtYauFSECTSQUj7GSn1gYe3gWyrVbbHrX+7ZNP3C+DZVgns7a2NKp92+Dyo
 1jUoi4/49UUjTiuySF54qS9ua3lMEBY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE3OCBTYWx0ZWRfX0ugZOJwJHvYj
 zOo8TbPoLTk7Sz666oNGi3HTDQb8mrJM/YsiQdYOMlCq/ds+yQeabuKICy0sfPyruPLo/YDKHfw
 jxBwHe2W3joU3lLu1paf82LUF6Twf96NlxvlR5NxS9alDQLDtZXHCnm1cLtX+K/28JJIkSwdH75
 DEKlULkeNA/oYEznFwtiUxCc6DYT9vg6Ht8XHtVnhFKfv0+ANOGB4/xZibBms1wM+05vpgqyjdc
 gSOQswGmotaqZE+0zJR1/Gp1Zmb5YqeMYVGawvcxvPtasxaLuLFCcKPeBSIFsazMxePgpM3637g
 bTFMAcT8rLu3azfUXUgOICFX07z0jkYmGbbG6MTTqTaw/9lTv/I4p29NXd4zmhecPCioXJx5DlU
 D9hscurxgkmLPmyWPakeiWKqEzICDpXD4NvoPSn0RhT+X45cHH31Udyo7HNuVC9mD2QttoHEPN+
 njXgYZ/qL8HrLYdqjtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100178
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] kill11: Skip pipe-based core dumps per
 signal
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

On Fri, Jul 10, 2026 at 02:27:11PM +0200, Cyril Hrubis wrote:
> Hi!
> Alternative we may change the core pattern for the duration of the test.
> Does this patch fixes the issue for you?
>
> diff --git a/testcases/kernel/syscalls/kill/kill11.c b/testcases/kernel/syscalls/kill/kill11.c
> index 3cf62feae..191587368 100644
> --- a/testcases/kernel/syscalls/kill/kill11.c
> +++ b/testcases/kernel/syscalls/kill/kill11.c
> @@ -126,7 +126,12 @@ static void setup(void)
>  static struct tst_test test = {
>         .needs_tmpdir = 1,
>         .forks_child = 1,
> +       .needs_root = 1,
>         .setup = setup,
>         .tcnt = ARRAY_SIZE(tcases),
>         .test = verify_kill,
> +       .save_restore = (const struct tst_path_val[]) {
> +               {PATH_KERN_CORE_PATTERN, "core", TST_SR_TBROK},
> +               {}
> +       }
>  };
>
>
> --
> Cyril Hrubis
> chrubis@suse.cz
Hi Cyril,

yes, this patch fixes the issue completely for me.

I tested it on both x86_64 and s390 with different configurations and could no longer reproduce the failures.

Using a non-pipe core_pattern during the test is a good solution for my setup.

Regards,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
