Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5C1CA9EBB
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 22:24:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 850553EAC19
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 00:24:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F1C63E5C1D
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 00:23:55 +0200 (CEST)
Received: from mail-dy2-x08.google.com (mail-dy2-x08.google.com
 [IPv6:2607:f8b0:4864:36::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E21741A010B0
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 00:23:54 +0200 (CEST)
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-3538045633fso76510eec.0
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 15:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791584633; x=1792189433; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tZBb8QJ20kg8XS1i0HmJkhqs7HZMOHQwae3/T5FcPJs=;
 b=D076VlWru6kmG4vjF4FHqfQTUDEtHXMFFC/SV/dN9JVS1JUjpLz7bnR+IqyalhN7F8
 02D3zumnBfUja5KL6ziBQ4ZOdtNLzFEs1DRSgydSjaM3qmi7LglIdYs6gdiK33uKeE7D
 /Y/2ofRbD2suovgg06CJ/B4zsanep8TWPgK64IwOJcaT9wIjeJ7Q/Ln4Rgc+UAOF/qhZ
 IoZEZSY9U/3qOo/S1k0CeB3xiJBnauos9tnmgSAN6o6E/A76PK2GrgKOesmoduczbHtc
 MifkhOxc5JKovJTcYzEN236qZsPlrgqCliEMuzmezyYNE6FRJlkYmnJXfhkoWr4VzodF
 k20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791584633; x=1792189433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tZBb8QJ20kg8XS1i0HmJkhqs7HZMOHQwae3/T5FcPJs=;
 b=FEFL2dLI8DSoAH1H8m+dh7gVFhEBtLmFdFkSqwlyVIn7b7lHXFDk2Czzh8Wa0x+Nob
 3TSTTSGaXe/k8FR2H65xrugUVReq4yBWg/+SR9cvK/l39EOdDqe+VJbiefTUwlQBr0hB
 JVDa9bYQDyG4AgqPOWIp7qUMVvVKz6qdhKyv6Mw/2988MAeMRkshFiLgNuOAZH5Nu5GK
 fjrkjzNR9aobjj7RfoDhclLVuIc8+vHeWblOHbUFKe5D2NxqBcoJpt1qrI02exNTTl1d
 ugvMWhSlw7YNzmxMS+nA6ZtDwbzMedviLOkZghc823hsKod/rjpiLY2hF01s0hx2Gzc9
 +jSg==
X-Gm-Message-State: AFq9FYKSIKsmUPBTsL0CeE4NKM1mNRlSAstXmb2qoBQBBuP3aArJk1aW
 TSq30WuVlIIAGQu1kh0Veq13GPuZAYc6GcRJiA6XoqlSmwn/DzAjZCuU
X-Gm-Gg: AYBFou31QK1hc76iEv7Gm0gctEGCn5toBA0Ck5Tc2O9noolaPLdaW3IfkCvNNZg0/lq
 FZkbWIqlsgNPVJZXDxru2VUh2ltB3F3ljTANFHb8k2iSs1Ehduv4ru795EMCEQFtwgbRpB7B5F+
 fMyXkFTZhbYvjdUkG5a8D0XDypgH5LCzluwq9PHNH7zL/BaMBm9M8ZqZLx4oUsHBYo9BlrEROUU
 eAe2R0LRJjD1b76yoktBdfgtKjdtvIoS1nuRZ2vrVulE2C6JSV4MfBwQ2Jt0bb51n3bnTOYMQGa
 Lxf2mHjXaXj3AmR8vWDF8JMDfW8CAqA1Qq8qK3bg9PSXcVRKoKFdJIffdv5sLSjv3rUt/tF0qXZ
 MPRjcR+/HM2VR8UMwMN85sDPmsGlRWImOWT6fXzo+Qn0R+wzT/VZKnsZdhIv/nUpdI+mw0Jy3BX
 6bnDlJhX/mlbl1tHqb+he17n9fQVOMebjtc8sE2Y2RW+eJDsQwghyQXk2t2p4KyY0yUMYhqTvLH
 4/00fVe1rnNh1VLaCZzNVciWRullcONbPXD3rtIRJ1IL2iPrkRFs2btbf3zE62fKT60NC8nfc66
 +9gheZm60g==
X-Received: by 2002:a05:7300:ce94:b0:351:6b27:d67d with SMTP id
 5a478bee46e88-3537e04925fmr4220145eec.30.1791584632787; 
 Fri, 09 Oct 2026 15:23:52 -0700 (PDT)
Received: from
 runnervmmprz5.1qk5hrnmv30eljm3ic5sjdqocg.yx.internal.cloudapp.net
 ([20.51.57.115]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb1e02asm9516772eec.27.2026.10.09.15.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:23:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: dm.chestnykh@gmail.com
Date: Fri,  9 Oct 2026 22:23:51 +0000
Message-ID: <20261009222351.9135-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009183921.3408-1-dm.chestnykh@gmail.com>
References: <20261009183921.3408-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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

Hi Dmitry,

On Fri Oct 9 2026, Dmitry Chestnykh wrote:
> arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests

> diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
> +static int arch_prctl_get(int code, unsigned long *out)
> +{
> +	return tst_syscall(__NR_arch_prctl, code, out);
> +}

High severity: x32 also defines __x86_64__ and passes .supported_archs,
but its unsigned long is four bytes. The raw getters still write eight
bytes, overrunning fs_prctl and gs_prctl; glibc's x32 arch_prctl wrapper
uses a uint64_t temporary for this reason. Use uint64_t or unsigned long
long consistently for the output pointer, result buffers and bases read
by the instructions.

> +	if (gs == 0) {
> +		unsigned long test_gs = 0xabababab;
> +		TST_EXP_PASS_SILENT(set_gs(test_gs));
> +		if (TST_PASS) {
> +			TEST_GS_BASE();
> +		}
> +	}

Low severity: the checkpatch stage of make check-arch_prctl02 fails on
declaration spacing, single-statement braces, a trailing blank line and
bare unsigned declarations. Add blank lines after declarations, remove
the unnecessary braces/blank line, and spell the types unsigned int;
make ignores checker errors, so its zero exit status does not mean this
check passed.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
