Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CA8C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 07:23:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 051D23CE103
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 08:23:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79E0C3CB948
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 08:23:18 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A336D1400BE6
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 08:23:17 +0100 (CET)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so4118112a12.0
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 23:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706599397; x=1707204197; darn=lists.linux.it;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tzvdPgvt5+7oQC8//UTqp7pRz++rztY2vF1W4o1jwgs=;
 b=gaj3tbLkdOTfF2u+270ZPNuFBpJAEYEPXqSklm1hKzUhao/H8Hyy9RulvyfCEaoGfX
 KuP8WvpVhCBeWnUlb2x3LYOvQBVpm77Ho7dy1wJMXr1v7wnfzN/uQplKh9XyopDclf7k
 1Xe8N60vv9MB32VrvYs/CQ4t2gbMQiAIAUxZ10+Yibe0HyPA2z+nJWe5U5xMC1qP+UpC
 jwjYPIHwFCrsqCbiVtNQMpd1PgHowkqzK56hPjM8eFiZ4Wxai7iJ3k8wuuFcn7hHrgY8
 VxZXalFRvQdeU+Bh4ssMp9PB09oZsYBvS9YH2kQX12frRRDnFH+H/jt8sQPGyPaeaHeU
 qgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706599397; x=1707204197;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tzvdPgvt5+7oQC8//UTqp7pRz++rztY2vF1W4o1jwgs=;
 b=duQf+r/Byk0cug9oe4h52OrHUrS97rV1QcJP8ionWEKb9RdV/JlhzEiC/fqP+77hs1
 JJSN3aRyDAIP/w3lRuYyYvq79IHtdCy5HmnRs+1/8TDUAR8vaev/98t7ojAnpVoW4WfE
 3da3Ei3UogaiNr42/LKwZv7Y60GKov+Ca1VCGT+TpEhlRdv4A/woVH7vdhhu/6JbhArm
 RMjSa9N/jZ2dUdoKkdlQCW+vP9XY09+7Ti993DFuBhk+WTNqbwjudx29WKTh+DcBwmGK
 yR1JqiM5Z+Q2gvCBlPruQjJTjgxmEixlvS36G+U3uCQVCqL3IuEG7hr9wS3bCeBUmBh1
 khvg==
X-Gm-Message-State: AOJu0YxwC5btRky8+FLYG4tndVvsiBCQH0u5AM4iodf2l+h1ONDeQl0Y
 iA57lUdLBYF8eJWZ+UOEOLNNadgOSOC6EhqpUCNE+OmJRO8W8Fm6F6pDrXOBB2TYCZyOLrsQfiC
 5NfZEmIz1N05BbmPs02+9xY0MhTLfFWo=
X-Google-Smtp-Source: AGHT+IFiPwmVO4ZREQw1oQct/8vPkimzakkQ+NVj289BZqfvhifQUGZoHGpZ1e+Z3vH6Ogom8EzWT6pCvYCtGq1g+cM=
X-Received: by 2002:a05:6402:3594:b0:55d:2ecf:eb1b with SMTP id
 y20-20020a056402359400b0055d2ecfeb1bmr6023890edc.1.1706599396692; Mon, 29 Jan
 2024 23:23:16 -0800 (PST)
MIME-Version: 1.0
From: Anil kumar Julakal <julakalanilkumar@gmail.com>
Date: Tue, 30 Jan 2024 12:53:03 +0530
Message-ID: <CA+QiLSHC64=ZA0dpeM1AsMWAY6TQ5BHHb0JHchV_4K+_oCHdeg@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] cve 2015 3290 broken
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

Hi,

I am running ltp test cases on the android x86_64 platform with Kernel
v5.15.106. CVE-2015-3290 is failing with Timeout for both 32bit and 64bit.
Following is the error I see,



*pid: 8962, tid: 8964, name: cve-2015-3290 >>> cve-2015-3290 <<<
uid: 0
signal 5 (SIGTRAP), code 128 (SI_KERNEL), fault addr 0x0000000000000000
rax 0000000000000001 rbx 0000000000000010 rcx 0000000000000049 rdx
0000000000000000
r8 0000000000000000 r9 0000000000000000 r10 0000000000000000 r11
0000000000000246
r12 0000000000000007 r13 0000000000000010 r14 0000737216a3f000 r15
00007372164b4000
rdi 0000000000000026 rsi 0000000000000033
rbp 0000000000000800 rsp 0000737217227bf0 rip 000064711cc81b7b*

Can you please help me on this issue?

Thanks & Regards,

Anil Kumar Julakal

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
