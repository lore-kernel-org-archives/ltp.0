Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238A1C54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 09:46:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06BFF3E49EE
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 11:46:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0F343E1565
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 11:45:47 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3D7B160086A
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 11:45:47 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-51c8dd6cd77so3336691cf.1
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785491146; x=1786095946; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1u13VjC3Xuc7Ozzz2bUSn0us2KFsCGTMdtKlzxCLHOE=;
 b=lA0sSY8DWvKda8h1TAEoY4bZlGqDA0xXHp+aZUdml1FRDz27FjIrlpJv9W7XiBmQTG
 OxW01sC4jjnwDGryw47G7ThYo3liAHHg1FQ+wN0XQ8uInt9/6csAaoySUbfLYPObMtpc
 BowmZrXm5tRj1tom7DsrGTzSQ+qdlT8fEXKizg7jk5K5WwS7T6QGWSohk3JBtCU3lV9L
 ucE7X3fnvL3LtHl92nBqJJ59nwz/f743rRhAf6S/Z+czbpRY9m6Jp+aByI2oJjKbCR3g
 irkT+N3XChVrUxv2ceTjDlueAIr5NDZLycVr6fRFD19riMFSYxtv+zNlnspFHYDniBGJ
 teiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785491146; x=1786095946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1u13VjC3Xuc7Ozzz2bUSn0us2KFsCGTMdtKlzxCLHOE=;
 b=p//qMwnenv3EuHRCfrJLMSm9Nr6oaS8Q4EIb3VdE3CQTRcLF/NTc2+rOFX5j7tsYT6
 z01ufrQkeFZIjDWaocmXLdH+eBgH31wYQW4Spa+1mTYKZzrZ+5XT8NXfv8gLLwO6Spbj
 HolYoiEffSuh8FXQPBQlmwxCaUdwb1XdxMSBuoZ/bRqifYcjlNY0hbbaIOfN+0e0L93z
 Qt6OAREfmlKXn4yl6m/+hrh7UEQDoGVbE2jNlQAXNUNAC06GMo3bSTD9R88P5bhz5hWA
 FjFZymDnNmEevhdXefruWImDV7hXXeZamUwXfWMNEd7J16xfSKMYBqOKtnFgYkOgcNz8
 Bz6g==
X-Gm-Message-State: AOJu0YxhbOtUeh2gp/p8zVUtqHcjb6HJy9zlSXusURta3WjZY0bpHZkW
 U8l109+ZJqGuRwpob+Q5ygsDMd7aI1oQbXQgl4K4qSwDmQLiAB4orT4w
X-Gm-Gg: AR+sD127ijez1YXt1yBVl7u5iu0hbFjedGmqgVxhV+zkY7KqjUGi9tZq02upi/7aQY1
 jCe++qM/LeROmPcutfBXlbJdjS1gluNKNUBxjoZwGaz0Orx+NGHVnjgEeBo4GzlFSw5SmnyXjvC
 X4uGliUbwqQ+mylPzYcq/mcHw4bysqXQpi+CZ43XwRoIY/EZAllmbg4MayiRqhE12ADRoB/MKaB
 qYC4Gu0DN35RFZSTpoq9QPytIyqnZXi515upQ/N5SQrUWTC8oIPpCeMwge1/I1cDzjmCCoE/Ynt
 aynDK65QjLRXOFJw4k9G4fVI9uGIEOdljz34E3dXoDzCoXPZVfMVhJ4nSKlL7jItOlyxKvt0he+
 1tg7fTnUtQ+8TTvbu4ViKWfXfyx0xpDGHv1uEeVN1HcF2gVb8EuwhTNbDSLh/3Tc9qByix7VU+I
 Y09gNWRJ8q+/has4oVHieCBUKTPPpAOUO7qE2Yk+r4L4UwMFvWuyJudBf1mzmFm/hTD4eiEnE35
 E/G1UoJpG1+FuMq6GakpvlVhs0UU4p9f0KyKW/IpnvvKOyywkuLwIEMjyrwmTKA6SrildZ147A=
X-Received: by 2002:ac8:584a:0:b0:51c:1590:8e13 with SMTP id
 d75a77b69052e-52b4af4ff39mr16578111cf.4.1785491145947; 
 Fri, 31 Jul 2026 02:45:45 -0700 (PDT)
Received: from
 runnervmvrwv9.n00m555wnkxuzl5dvgxei0gxwa.bx.internal.cloudapp.net
 ([20.55.46.173]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52b4ec01d54sm4532381cf.31.2026.07.31.02.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 02:45:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri, 31 Jul 2026 09:45:44 +0000
Message-ID: <20260731094544.3905-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731071545.1334046-1-wakel@google.com>
References: <20260731071545.1334046-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clock_gettime03: Extend tolerance on slow kernel configs
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

Hi Wake,

On Fri, 31 Jul 2026, Wake Liu wrote:
> clock_gettime03: Extend tolerance on slow kernel configs

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
