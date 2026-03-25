Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC71FEA808
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:40:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B7633E5529
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 11:40:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3AD43E2FEA
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 11:40:06 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E8FA200255
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 11:40:05 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P5d7cf3792418; Wed, 25 Mar 2026 10:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=OKEcSDRNK4Uc5Eanx6RObjZCi0jfAM
 ScS0Gi99P6R/U=; b=DJHeJko8H4cttqQHo4YmM28PkwkBZx1tSTGfDPuuIDjDes
 L3KlQCJULdi00nNDibQ75xqpU31u3tKejz6eiA/MWhyDThmbcrzMgVCMOVRs3/iZ
 780lqGLAux4agp8Q4XIL+5r05DvsxugUt0oeWeM1mx4n28Bjhy3NUxdwu3hcwbb0
 xfqPyUoSvnPLruuWiNqZqH/lLAHspWCo92OBTTuxrmGsjDzEIRjwuiRl4Xmw/6E/
 J1UhrGolBuEQtwDinnQ9MCeeX/vsRXtbjSUvw7Fh5w9pZ6IJrXa31wAkoxbdI8SY
 itTFYCCVgbUtC4JLTAGGvn9JSBe8nVu/H51VMShA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqg09v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 10:40:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P61SWc008749;
 Wed, 25 Mar 2026 10:40:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnp5ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 10:40:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62PAe0VV35520798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 10:40:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B0EA2004B;
 Wed, 25 Mar 2026 10:40:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1F5120040;
 Wed, 25 Mar 2026 10:39:59 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.44.112])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2026 10:39:59 +0000 (GMT)
Date: Wed, 25 Mar 2026 11:39:58 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <acO7fmOx60tVMfIL@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260325-compile_flags_gitignore-v1-1-b0de37eeacc8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325-compile_flags_gitignore-v1-1-b0de37eeacc8@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dJvGeb-2dbBilX4aRbLfMaat4J8wYuv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3MyBTYWx0ZWRfXyDSg4IFlMRG9
 5SDhv4cCPzXcVgah1ibJpMsqCafYLME0CCGywUiPGrFD9ijCdrd7RKLAhU+wjESrBIK85fOki1M
 rujTZBdQpo3sK9r/EjIvTdI/gL2OlrKTTSQzNXLXWDR7zmarcCe0GzfAi5YEqwtgdaClrm4rGun
 4c4zTQlWAZQ1qPKptY3BICmMz8UoxLsPW6XOUrlSMY7uBE1t5RWbahQ+HD5RW1gFKtEy46jlstf
 004Qbg/xHv4HtqdReYRPO4Bu9FwnuwHuNVfTfLP/IyTJEsM9yl/qdShUZ30y3N+iJMTC8DPx6UL
 U9UEZ/iiZ+NT9LQ8ddT6pQGLu87v3022oJkztwE3z8HxASTYzF9YaDfTfK8JOLcd+zCjtnXkEh7
 IdL4Z8h1EoZ5aWg1oocZA9krgM6ylOSwRWawmVnvvGoCBkGIt2rCZGjyTZLO0koJbli1vS6yLqG
 Q7GuI/hIM7ljpZVUBVA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c3bb83 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=0Ni6rV8TAAAA:8
 a=iox4zFpeAAAA:8 a=nixOok5L5LrsXmUUufoA:9 a=CjuIK1q_8ugA:10
 a=MEv8DOuCJPEGjlO0Qob3:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: dJvGeb-2dbBilX4aRbLfMaat4J8wYuv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250073
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add compile_flags.txt to gitignore file
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
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index 24f4a4ea834e0b919e640e879fe5e5b5d7aec466..6cd409489f266c4805dcf4633957892b10ea032a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -60,3 +60,4 @@ patches/
>  logfile.*
>
>  /utils/benchmark/ebizzy-0.3/ebizzy
> +/compile_flags.txt
Hi Andrea,

thanks for the patch!

One thought: `compile_commands.json` (the compilation database) is also
commonly generated locally (e.g. with bear, compiledb), and not
necessarily in the repository root (often in a build directory). Since
the intent here is to prevent accidental inclusion in patch series, would
it make sense to ignore that filename as well?

In `.gitignore` we could do this without anchoring to the repo root, e.g.:
  compile_commands.json

Thanks & best regards,
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
