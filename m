Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19A010A1E7B
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:12:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 492F53C9D72
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 12:12:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CD8E3C2C33
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 12:11:41 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DE6E4600A75
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 12:11:36 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62Q7F4HQ3275715; Thu, 26 Mar 2026 11:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=blotyEtEUPwnKkGKBqk7luGrelFkjP
 RL25bw7NMApq4=; b=cOYbDWQi8ioor1IFpq/DsdLorUHg79kkip/mBlRup5J6v4
 X4BbJqRz4cEmSlvHHIVtGMemZmOaZxHdru9kvcfPEoAXmfzMrgNh+7+Ay0JOK68y
 36/SxI01qqc29CPlXm3aXdchFOqPLPJjIqd/gfJ6fJEBc4ooMFQRNe8INmzF8xdR
 KJ4S28QQoIBvFeAZp4lT3vpsABtbHH4664sHOsvMmlMJLdany/qScxQ8PgOJW3Fd
 LwU9U1RpSVb/rhmds67RGNfdw8PMlkH6mf/iOeV9HJqN6/Q51sGVBXkyBdaLhUrH
 wG38NdeVJJRJf22hIjxIc7pvpz8+H2mEy5jmMz7g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqmwrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 11:11:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QB8Jtv031635;
 Thu, 26 Mar 2026 11:11:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt2sct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 11:11:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QBBWGw56885610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 11:11:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3308B20043;
 Thu, 26 Mar 2026 11:11:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E511520040;
 Thu, 26 Mar 2026 11:11:31 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.20.66]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 26 Mar 2026 11:11:31 +0000 (GMT)
Date: Thu, 26 Mar 2026 12:11:30 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <acUUYqtV-qIyj5lK@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260325-compile_flags_gitignore-v3-1-2ad84b58ea47@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325-compile_flags_gitignore-v3-1-2ad84b58ea47@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NQA-6JnWyFp9GSDA0892WLKJ1aawSeOX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA3NCBTYWx0ZWRfX+zupQ/F2bBYr
 LjmuiWkoiceMjM0BeK4DLeaEl8WsZAy48RLLSZ7o5AtA38csy6xLN23hfokEs5crj2U1XxPUgdq
 /os3WRkPpW+79dTHJh4AEyV+qgkC9ZLXM2eGQ3wsTiD46Zie1eUSUcYZRBcN55CFInBm4Kopep6
 FHXs7KwvseBIXL6gITTSLKySKbD+eaQWznghoB4EGqzioUJJ+KFdIb1AFNul2vL8gTZj41EBjkD
 m6AoXdUhg8dubTvrT9lvWEoqp5GrjW2PvXj9T+VeqECMLhMIo2AcbENt60d4fOGrCj0JsUE/aJT
 w4et01nW60W68yUwv5sAaSmlyMkJIw1cn4uyGWy4ebS5mo2DqtrDzVCpxNoTcp1fb0JYCR+6oBV
 aMU56jPbFcwsyfrXfEiZWcorjWVEq2tPTZNfz8PF5UraGpDVE+hoRSl3nF8J1GyuThMWJShlThv
 Hw/tewQES3PCR/w3PQQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c51466 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=0Ni6rV8TAAAA:8 a=VnNF1IyMAAAA:8 a=yxLsLHf_a6Yz9EDSCFkA:9
 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=MEv8DOuCJPEGjlO0Qob3:22
X-Proofpoint-GUID: NQA-6JnWyFp9GSDA0892WLKJ1aawSeOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260074
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add clangd specific files to gitignore
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 25, 2026 at 04:37:39PM +0100, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Add rule to ignore clangd LSP configuration from local repository.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Clangd is extensively used by IDEs and generic LSP wrappers to setup
> clangd configuration. This patch removes it from gitignore so we can
> safely avoid it gets into the patch-set when it's sent.
> ---
> Changes in v3:
> - make compile_commands.json and compile_flags.txt ignored everywhere
> - Link to v2: https://lore.kernel.org/r/20260325-compile_flags_gitignore-v2-1-87b8bdabd676@suse.com
>
> Changes in v2:
> - add compile_commands.json
> - Link to v1: https://lore.kernel.org/r/20260325-compile_flags_gitignore-v1-1-b0de37eeacc8@suse.com
> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 24f4a4ea834e0b919e640e879fe5e5b5d7aec466..3fdfeaba0333990c607e7847e4f997192d710394 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -60,3 +60,6 @@ patches/
>  logfile.*
>
>  /utils/benchmark/ebizzy-0.3/ebizzy
> +
> +compile_flags.txt
> +compile_commands.json
>
> ---
> base-commit: b874b6a264cf4f343c17d543ebe4ff91fbb89042
> change-id: 20260325-compile_flags_gitignore-c12d8f65ef2d
>
> Best regards,
> --
> Andrea Cervesato <andrea.cervesato@suse.com>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
Hi Andrea,

thank you for this patch.

Reviewed-by: Jan Polensky <japo@linux.ibm.com>

Best regards,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
