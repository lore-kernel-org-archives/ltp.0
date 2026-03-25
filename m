Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E28109C02F
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:10:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDCE63E3000
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 16:10:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42EE63E1F8F
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:10:40 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D62C1001131
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:10:38 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PEiJmu3111761; Wed, 25 Mar 2026 15:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=SjYJuc2A7IzAkC6ODkLX0x2hzt56R6
 diG5UOX6+9pnY=; b=fyMcKkUk4p1gFkZdiNXD1U1vot6hbv738sZFKuZ0cq48sC
 Oxl6Wsf/9TTDsitc+jSQ3I4gfIWNPwm+I51/kVDu8AAa+2ZiF/takxUPX71o3XN+
 ew2FK6Bw1yt1SlB/s8JKVg+O0XFlkAgjucR/qQEFD2GMQD1zW1jfIXIXdvRv9iW1
 x1NhviMz0tWvRp8zc60exZstg5f+wJbl4H8iD8GOVrGUuPG8B/eE+PqCeU/4L42U
 zNSeEZaBsAsgeYs5ZR/wv/mLHAzxXwqNDFSJ07Nogh2uw/WVBF69rDsSsCALE2Xw
 SEjaZUDCy/tI3HRamml/BsI6Wvn5SJBs9MHEy2yw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumr941-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 15:10:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PEnswo006009;
 Wed, 25 Mar 2026 15:10:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yq4h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 15:10:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62PFAYdc41615840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 15:10:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 573B72004F;
 Wed, 25 Mar 2026 15:10:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED1062004D;
 Wed, 25 Mar 2026 15:10:33 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.44.112])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2026 15:10:33 +0000 (GMT)
Date: Wed, 25 Mar 2026 16:10:32 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <acP66MTKk3LzceQD@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260325-compile_flags_gitignore-v2-1-87b8bdabd676@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325-compile_flags_gitignore-v2-1-87b8bdabd676@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0CEpUxc9yazBxpd-delYIChKNvKA7rpK
X-Proofpoint-ORIG-GUID: 0CEpUxc9yazBxpd-delYIChKNvKA7rpK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEwNiBTYWx0ZWRfX+56LF/PaRj/q
 8PpxlDYaKjydKyeKMsgbHuSAy9JM8s8L6HAkZNDxLlpYGkHGLIrIIDQTXKt2/1Jn09uWlWcvBb6
 cpnBWvBAGcGflwlvyBSnj2kW657/NKKFjZdjDAjbGXqlE/LCjU1gBzFTRiW7Fcxgz2op+q5ZmPO
 JqcryhziZy7mmHHAHsU14WyYj+FHakLobMWSGA90o5IQeNaxlI/GpD0Tg/twUyw3l9T/osVTrIf
 CsoO0UqoZsy/5IQWqtr3QnmJGbgbQHvNcdt5WgpRJ46enKhtaYcf1p1sUM6250OjhOrYR+XjapV
 QZDYzR72qSoRuUPl6HeEwvfg6aAs0M8QG2y2eoEuzGghRUzTRo5ugchZlHaV/7BUS9CRREpSOAf
 18KQHhIst4agbMD8tzeyMpIzCCSQH65gQ+ngVbrVsDETXOHj96udf5HxCLay5Zx80i2UZpqgqtz
 6HbResmWnSbui6FABng==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c3faed cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=0Ni6rV8TAAAA:8 a=PpTQVM3mCUC9IMbezycA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=MEv8DOuCJPEGjlO0Qob3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250106
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add cglangd specific files to gitignore
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

On Wed, Mar 25, 2026 at 11:51:45AM +0100, Andrea Cervesato wrote:
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
> Changes in v2:
> - add compile_commands.json
> - Link to v1: https://lore.kernel.org/r/20260325-compile_flags_gitignore-v1-1-b0de37eeacc8@suse.com
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 24f4a4ea834e0b919e640e879fe5e5b5d7aec466..139ecded5fa0a47a12b97eac6ebf432cbe5e5c11 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -60,3 +60,5 @@ patches/
>  logfile.*
>
>  /utils/benchmark/ebizzy-0.3/ebizzy
> +/compile_flags.txt
> +/compile_commands.json
Hi Andrea,

thanks for spinning v2 so quickly!

Small nit: with the leading '/', /compile_commands.json only matches in the
repository root. However compile_commands.json is often generated in
build/subdirectories (depending on where the build is run). If the goal is to
prevent accidental inclusion anywhere, the pattern should be unanchored, e.g.:

  compile_commands.json

(or equivalently **/compile_commands.json).

I can reproduce this by generating it from a subdir (e.g. via bear), which
produces ./compile_commands.json there.

	bear -- make

Thanks,
Jan
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

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
