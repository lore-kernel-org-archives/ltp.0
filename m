Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48933CA9EBE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:35:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2A683E2E2F
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:35:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EC963E26CD
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:35:09 +0200 (CEST)
Received: from mail-dl2-x04.google.com (mail-dl2-x04.google.com
 [IPv6:2607:f8b0:4864:38::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E06286002DA
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:35:08 +0200 (CEST)
Received: by mail-dl2-x04.google.com with SMTP id
 a92af1059eb24-144fff5061dso245510c88.0
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791624907; x=1792229707; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p6P+HHZ1+EJaNjtQuyxgbnxmKohnBc6kt/gGTOMAXdU=;
 b=SSAXsTYgrIYfcJvcKtx4TFCFswEHqa7O9snhUd7hGRan6EpufPxGio5QvTtAunaqkg
 Jtqa3U762KmPj7vMqxAedNB+U7qeGq/rkGn/7h/A5IiSuTxstN8drBAs3fkzf5TTWxg8
 XDBX+wNgocjCO0tOsD/b3T8gr5lEwyDIrQHRZjWBxDs9c86axaqREfi+ak9xW0lVswuM
 esnRO+NrrXUzN/ARaJ1ZDIMJ1QUKSSc6n8vHE08KgmziD2MYHzWXoZ766PV8XazV/ypA
 84VXtMIl91FAIrNjqMdbEII2DuxDHeb5KFMdj0HGukOqfhHv3H6FxGA4hKZ9Lyi6EHNV
 YXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791624907; x=1792229707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p6P+HHZ1+EJaNjtQuyxgbnxmKohnBc6kt/gGTOMAXdU=;
 b=CEdu/sGASh5bQS07FaHruyQ+fFkuDsn/t6jNen+ZY2dAFBdUxDjhGK1Xs977Skyo6j
 5HNISVlmRffMyeJF93nQ6XiXsxgNjpO+SzeJ4DNx+eBOpmsFIpxpdk5W0D3zrSZ/Vlvd
 H4gvdbmCECE6K+wSMzDkiewjSpS5An/STQGxpgNq+zQTbda8VuSKwunpCKLBhKLbEIBp
 NRtovC/NQ61OpeLxRmFQotOz7zyvvPCP/HXsFxsShuClGw9Gd/pyLltVbvw1Mx3TPQiH
 15c+YXb1LdcD9+nRKwgx5uj+jZkzMRQHFqRPrQoW8qSDWIJL6QXdTjL6HeN3nYnbuE8C
 RtGw==
X-Gm-Message-State: AFq9FYJUi7zAGkizjU+BlrlRmOkUlF7Iopg0oxa0mOrzzMXHTPk8Xa/+
 ajLtkMsE1kpDBOIyS2DDslLzivqtPYIZoHBed7d50F8fENnb1V/EN6ou
X-Gm-Gg: AYBFou0IwDUk2YjJfiTDh0Q7S0/nvZNaFdXiDxARk3qvx2+C8vSyMKXOeCXkDFN+BlS
 1xFCK8b1qrwIJ32NRvn5q8IyCwZk41OOVvjeIDh9f4F61KpiiVLdFQR330LVwk8kAqnYXUKftdQ
 Z92CtYpSKGhlQaS1DGpS/txKQEX+fAjCjwGSskGb3EQZEBrBA7gLLXb0Sxb1WflXMnsBftGZPuF
 B5dA6bEp5LyTvsjlm2wl4jx+yAvTKVciyZg/TjlaKqdSONvnJf+M22udrH0NfqFO7Ni2dYKmPt5
 rhb+k0GzsfLzgWCHL3cfqL0gyINiTjRFU+VTsG26d888jVTWT1kKoxSrQGmIdstJDf/oOWONef4
 NRzbFm/UOAwVH0Pz07eScZVSj6+WULzWygnEoSYIShb5RxuTHHhlwZb7TxIgzg/Tor4q1NwCMx9
 1UZjsLjub0xl0II1gTPIVynux4Rzdbfn9mHIVxykAyMK0O409lilk0X45FmEnn62FgH1Z5uP4eS
 EIEt+9y3o289gk3/e3bN8xKQeXkYNc9p7qKbxyOMjhpO8yR03f1lFUebIV/id0aJ6bW2lKy0hxm
 OMAIbxyIRz29r2hdGsd1Uwj7
X-Received: by 2002:a05:701b:2608:b0:143:298e:45a1 with SMTP id
 a92af1059eb24-16a612bc05cmr5980345c88.40.1791624907094; 
 Sat, 10 Oct 2026 02:35:07 -0700 (PDT)
Received: from
 runnervmmprz5.oxntq2pneleudbr4ohwvsaqdeg.dx.internal.cloudapp.net
 ([172.184.214.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca329d9sm14793361eec.5.2026.10.10.02.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 02:35:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: dm.chestnykh@gmail.com
Date: Sat, 10 Oct 2026 09:35:05 +0000
Message-ID: <20261010093505.9326-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010064240.2467-1-dm.chestnykh@gmail.com>
References: <20261010064240.2467-1-dm.chestnykh@gmail.com>
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

> diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
> +	if (gs == 0) {
> +		unsigned long long test_gs = 0xabababab;

Medium: Both exercised GS bases fit in 32 bits when the initial base is
zero, so an ARCH_GET_GS implementation that drops the upper 32 bits still
passes. Include a valid base above UINT32_MAX, such as 0x1ababababULL, to
exercise the documented 64-bit result.

> +		set_gs(orig_gs);

Medium: The restoration syscall's return value is discarded. Injecting
EPERM here leaves GS nonzero, but -i 3 exits successfully with seven
passes and silently skips the set/read case in subsequent iterations.
Use TST_EXP_PASS_SILENT(set_gs(orig_gs)) and abort with TBROK on failure.

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
