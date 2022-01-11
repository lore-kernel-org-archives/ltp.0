Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60567C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 10:42:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B4C13C93CE
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 11:42:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E1BC3C90AA
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:42:04 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3411D200BB0
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:42:03 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id B50E89F75E;
 Tue, 11 Jan 2022 10:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1641897721; bh=u7Kb46G871Dw+D166tbNEbTkGImAG8hJeYHelmeNr3g=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=MfPG62/7q9aviUfg67tBGbbal08+YBRTSAZBZbHy6F1y0Oa/JQXgX7boVtFmIXVi8
 hvL4O5OAWtBLat0kt3qvnOUDAv61edQ18Q7v0ZYOJ4flXejTpaOv2umeumpbpuY2rW
 PwgW+89GMdEZ92mHSo1tiR9qpoKs49p/mj8MD/mA=
Message-ID: <7cf81226-52ca-5016-5041-ce12b93b534f@jv-coder.de>
Date: Tue, 11 Jan 2022 11:42:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
References: <YSz36VZ18+N4YsM/@yuki>
 <20210831091005.25361-1-rpalethorpe@suse.com>
 <20210831091005.25361-4-rpalethorpe@suse.com>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <20210831091005.25361-4-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] bpf_prog05: Drop CAP_BPF and check if ptr
 arithmetic is allowed
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,

Am 8/31/2021 um 11:10 AM schrieb Richard Palethorpe via ltp:
> On older kernels pointer arithmetic requires CAP_BPF. They also lack
> the ability to call BPF subprogs. This makes it difficult to exploit
> the div/mod behavior.
> 
> Older kernels leave div/mod by zero undefined. This causes the test to
> fail and backporting the new behavior is difficult. So when we find
> that pointer arithmetic is not possible without CAP_BPF we can return
> TCONF. Because in this case, we know the test will fail, the risk is
> limited and there is little that can be done about it.

What does older kernel mean here?

> +
> +	if (ret != -1)
> +		tst_brk(TBROK, "Invalid bpf() return value: %d", ret);
> +
> +	if (log[0] != 0)
> +		tst_brk(TCONF | TERRNO, "No pointer arithmetic:\n %s", log);
This check now fails for me with the following output, where the test 
was successful, before this patch. The kernel is a non-standard suse 
5.3.18 with realtime patches.

bpf_prog05.c:100: TCONF: No pointer arithmetic:
  0: (bf) r2 = r10
1: (b7) r3 = -1
2: (0f) r2 += r3
3: (72) *(u8 *)(r2 +0) = 0
4: (b7) r0 = 0
5: (95) exit

from 2 to 3 (speculative execution): R1=ctx(id=0,off=0,imm=0) R2_w=fp0 
R3_w=invP-1 R10=fp0
3: (72) *(u8 *)(r2 +0) = 0
invalid stack off=0 size=1
processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0 
peak_states 0 mark_read 0
: EACCES (13)


Is this too old? But then again, the test was successful before this 
patch and your commit message states, that it was not successful on 
"older kernels".

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
