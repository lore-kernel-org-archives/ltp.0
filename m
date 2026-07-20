Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D387FC44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 13:11:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9C933E5C6E
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B484F3E2C0A
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 15:11:21 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 697EB1000224
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 15:11:21 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8fda6ac0586so55791316d6.1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784553080; x=1785157880; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8iSHwolCXBl5840nVeG5UA81KlILhoqtT1BTze3ShQg=;
 b=fOwAe8ywFvn6ym6LH7YLw4tTtNdYYUiM23vDz0ogu2PlwjH5zyuIFTOKSrCJ1tVCfX
 Ka0CEDn7vYwIMakfqjXdOFaKkavINB+5I4yqDPHBfIsU90/Ibs954N2clgO7Cwi7ibsz
 vZ4RJGQGQJPjoI8ns25jA0NO0a7fSU1jXbcAcRKvrYZQP1HN0YhYU0tS8tLvbdSYDbhx
 t4vaLBVIUxphjRBU1aVgEoQLrezfwZ1JjXaRSixbqQjl668VhcblJGWDyI8/lmnKAlXh
 Qud4F/dJcQFlzDuv69rsyxSErqHRfC9TNtAm9UCGz4+3IIRdRYHqvL7XNDz0BKYQNAit
 j+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553080; x=1785157880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8iSHwolCXBl5840nVeG5UA81KlILhoqtT1BTze3ShQg=;
 b=al0UGOT4DkhUQawGrLbogRZCGyMiTgLc8sIK9+U2BJ8KVxkOARQbR9BMuXMFVLCnNo
 zt2EMY3GAx4gN/I9QzpukANHACIU6w5O+nm6Lmnd6Hxai5/XE2Jmg9rX1Ybk49Y53GVs
 e/Ysi8Q6sFO3xOSfVr870BIbwtoHamMkKgwXFndddBSowUdRWCo5VZnkyW2jTHeqQgjP
 ynkSzZoJ7fLKQV0TsSXfsCPGDS8gsw3m4vYCBMFMBDls5pSIq8dgfzHpvw8Qh5GGLCaV
 mK8YAZsSFwAVYdhcvwR4SYA480F9O8+oiFe5F5/ZZYxmQjD8+0sokCOwuvlcpAiQEg2v
 E6ig==
X-Gm-Message-State: AOJu0YyYbgDhNl305va6yHqJClWCCNHODWuBcaBYNEPRy7E1S+kqyRf8
 jmE57iT+MhX2ZepEMtLiPrsCEG3BfgVNpM7JwihJohkJo25KQr+gHs+P
X-Gm-Gg: AR+sD11RWDXDI7GDfxXBqPWc3a+H7+dStRAg5xWw8afB10R2mJQQ8SiBD6IEujWT3JD
 s57/F1CMgrbT+SiRp85sjRQCmnSag9OHSV9iQZDCl8xp5VSbg3fbcF6NTCvFjzQ0NbUm7JZMql8
 qqx4pgvZlm/NPs79XlXR6NZlZzNchAOFkNKPnW5sm09UnmOUb/7D6bXRIVZLPTKVX6QKzKgA90x
 WU0dBViM3GSLgp6ysvNKCjx77EFqmlqxpCiVXNCe8f23d8f+m5Nhb0R33No6/ZaCPLN3ZV5hqY8
 rl9YAAs+Ptc/NmU99r96T+L+n1i3yc/QPvpwa/JKRvUjtkIjTyTLWJ/MFGS0U+36PAcEghlCzv8
 5NJL22pc3KZSBtWay5dQnfUx8Az+dxs+Uxg9B1KToet6a1P398big1pi8fQ19VntjcnU+JDA7w6
 INIMgZROTipSISA6eaTk4PvdEWbdbCC6nLka6cktWi+9fEjaD+3AUQn8FnVTgF7vylFeHsEikSB
 KWI07OheC6P4iwXAA==
X-Received: by 2002:a05:6214:ac3:b0:8cc:f074:95e with SMTP id
 6a1803df08f44-907783a568cmr155441556d6.30.1784553079981; 
 Mon, 20 Jul 2026 06:11:19 -0700 (PDT)
Received: from
 runnervm3jd5f.cpeozdby34eermus2ok2tu1gkh.bx.internal.cloudapp.net
 ([20.102.47.197]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9077853fce4sm91049446d6.9.2026.07.20.06.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:11:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon, 20 Jul 2026 13:11:18 +0000
Message-ID: <20260720131119.4130-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720122644.2153-1-wegao@suse.com>
References: <20260720122644.2153-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

Hi Wei,

On Mon, Jul 20 2026, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> + * [Algorithm]
> + *
> + * Case acquires three loop devices (dev0, dev1, dev2).
> + * It formats dev1 and dev2 as external journal devices using the
> + * "-O journal_dev" option and assigns them the same UUID.
> + *
> + * Then, it formats dev0 (the main filesystem) multiple times,
> + * first associating it with dev1, then dev2, and finally back to
> + * dev1 again as an external journal using the "-J device=" option.
> + *
> + * Next, it calls fsopen() and configures the filesystem using
> + * fsconfig(FSCONFIG_SET_STRING, "source", dev0) and
> + * fsconfig(FSCONFIG_SET_PATH, "journal_path", dev2) to dynamically
> + * alter the external journal device.
> + *
> + * After applying FSCONFIG_CMD_CREATE, it verifies using tune2fs
> + * if the external journal device of dev0 has been successfully
> + * and dynamically switched to dev2.

The [Algorithm] section must be a bulleted list using '-', not prose
paragraphs. See documentation.md Section 4.

Something like:

 * [Algorithm]
 *
 * - Acquire three loop devices (dev0 from framework, dev1, dev2).
 * - Format dev1 and dev2 as external journal devices with the same UUID
 *   ("-O journal_dev -U <uuid>").
 * - Format dev0 three times to cycle journal associations:
 *   dev1 -> dev2 -> dev1, so both journal superblocks are consistent.
 * - Open dev0 via fsopen(2) and set the source and journal_path using
 *   fsconfig(FSCONFIG_SET_STRING) and fsconfig(FSCONFIG_SET_PATH).
 * - Apply FSCONFIG_CMD_CREATE and verify with tune2fs that dev0's
 *   journal device is now dev2.

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
