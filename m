Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2EACA9EBE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 15:50:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC5553E2D90
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 17:50:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA1E53CD635
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 17:49:52 +0200 (CEST)
Received: from mail-dy2-x07.google.com (mail-dy2-x07.google.com
 [IPv6:2607:f8b0:4864:36::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A531600054
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 17:49:52 +0200 (CEST)
Received: by mail-dy2-x07.google.com with SMTP id
 5a478bee46e88-35148c9a73aso378311eec.0
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 08:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791647390; x=1792252190; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CUSYylSzNSLEv0WLMq8QVW4/tlfpR4KeFhPm5aGkbVY=;
 b=TpW5vwJC/ZQ2LaJTgXt5Q9bCjCTUfV1gg9MEAskbvfxc0EUsr9QYHLft9joGq88C/H
 9OOQcjcz5fEKkVA4AR88Nkw30VS04Fi6ctOa3F9JOG8BvCPEne4/Mgy0W6+wg+0hxhLC
 CwrwOSvgqW6io1Gw8URpHZiqJKl/Ij+MiCst+UC0rqE6+QAApS0JW8sN7mtbd1ZpJowd
 pQ6NJgKTWXjUc0fH+kqaDIR6Fzn5ROJKwV/g1xcyIri9D1Ao2DZBvlEQn4ArjWvhIRae
 3EgY0AmCgbqdLPagvNBOfF8sq6g4Z5KYg+/oSLTBQ3ZNtCzFH5SnIbDBnQPtf4H7YGKT
 V2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791647390; x=1792252190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CUSYylSzNSLEv0WLMq8QVW4/tlfpR4KeFhPm5aGkbVY=;
 b=z4f6/LU1g0uTRbGU/PHdYmozxLJ9BffyrU/vn9eVbSfXWaAwtt5AAM/6LTLj50SDXi
 jTWMwr9IndUiFnhZcbt2+EklT7kwSBpkeOqL+vgkzI52msJAewzfP1GxFdrfDSbp7SNy
 pCZ3TZ7DDGrcT54aUMT8PhTk0X71lMSi9A0UL7tpMFmhwcD3TidPpwel8Z/auyB9v0DX
 9BgH3U/9St5N5uZLl5+jd4A3wSJ7Adb0PtfsHHWqJOFlB4fjzIx+oGx/dOEYxw/LQkhJ
 4ig/JexbVkc0QheDhzdI5PjA8AIOYGWkSJmrtOXbh18kMmaJmabVWlk/2TGxSYZCIi5x
 jHrg==
X-Gm-Message-State: AFq9FYJ4ts+sCQe9DBI8Qs1SvP9AdoOpNvJNfe6I7B2M7MYK6qPggwYw
 rW5OJSZzYAKkUS19kmGpf+8SaxUN4rGNbqGM+sWQqf4sdNHtGqTLpLAc
X-Gm-Gg: AYBFou2/U1mzXW+OqUn+f9u65YigAX784knq0oCkGdxrhDJ0Ia+rfI7NE4S+vDWLHww
 A5ocif3CAHlnDhbCE1AIjHBmgElGkTD2jwsSCTl8MA3nSmcXXASBf9xSS7tsaKIYesCYGmfXfl5
 5L3yr8oLxFTJmm5QB7vKQDMlbS94tfve905A2gHsuN21LQHKnkAcAhU4bQWF0thpw/fYs+XB9Gs
 bf9MRTjs9u35CxL/zmRAZWi99+1Ap+Mxfurs+c3CtWwRnMP9JGwQV61kh8ApTxF1e2sIgL9WnWZ
 6YGN4DK7AzL8GWxylxqIweJo5AlAayPnEKneZnZjuJ8MBvgkMLr8PrQydiPw6RYeOIr5VBvSoLz
 iZZykx/sNCIFXN1F1PqBnw89CpnFTXSXt1ch/tx+bkGOpz+HhjunGXcOXcDcSZxjtxkGYFF9v+f
 NZdkAKZDbiZHKCGKndTRf3GMYBWRVwyQ+BXv9Fe7+rFhDHQVKN/KrHACjpbGfVrhwTU+9FtqYGm
 sglvmbIUoSKi3QtHXnB0IKuxPf+9qDWda+gXhjhMji/DKc37i/EMibDzFeryB0hoRyIpvpF3Krr
 6Bi9BdI5ew==
X-Received: by 2002:a05:7300:cf8a:b0:351:1ec9:aa4a with SMTP id
 5a478bee46e88-3537e063a23mr5888057eec.26.1791647390384; 
 Sat, 10 Oct 2026 08:49:50 -0700 (PDT)
Received: from
 runnervmmprz5.li2kd30fqcou3ceyvzdff3dzgg.yx.internal.cloudapp.net
 ([13.78.166.241]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d20dsm17977076eec.12.2026.10.10.08.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 08:49:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: dm.chestnykh@gmail.com
Date: Sat, 10 Oct 2026 15:49:48 +0000
Message-ID: <20261010154948.9272-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010094439.26053-1-dm.chestnykh@gmail.com>
References: <20261010094439.26053-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

On Sat, 10 Oct 2026, Dmitry Chestnykh wrote:
> arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests

> Signed-off-by: Dmitry Chestnykh <dm.chestnykh@gmail.com>

The commit body lacks a rationale. Explain the coverage gap and why
instruction reads are used as the independent oracle.

> #ifdef HAVE_GETAUXVAL
> # include <sys/auxv.h>
> #endif
>
> static void setup(void)
> {
> 	unsigned long long v = 0;
>
> #ifdef AT_HWCAP2
> 	v = getauxval(AT_HWCAP2);
> #endif
> 	tag = v & HWCAP2_FSGSBASE ? true : false;
> }

Without getauxval support, v stays zero and run() incorrectly reports
that the CPU/kernel does not support the instructions. Guard the entire
test with HAVE_GETAUXVAL and use TST_TEST_TCONF() to report missing libc
support, or provide an auxiliary-vector fallback.

> #define READ_FS_BASE() ({                              \
> 	unsigned long long __res_fs;                       \

> #define READ_GS_BASE() ({                              \
> 	unsigned long long __res_gs;                       \

These double-underscore names are reserved to the implementation.
Rename them to fs_base and gs_base.

> static struct tcase {
> 	unsigned int idx;
> 	void (*test_fn)(void);
> } tcases[] = {
> 	{0, test_fs},
> 	{1, test_gs}
> };

The table dispatches to separate per-case test functions rather than
parameterizing a common comparison. Use one comparison handler with
entries selecting the ARCH_GET operation and base reader; keep
GS-specific preparation in a helper and remove the unused idx member.

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
