Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA56C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 08:22:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50A4D3C98FD
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 10:22:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB7923C0E56
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 10:22:15 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A01192000A0
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 10:22:14 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-51c2149571dso29744921cf.3
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783326133; x=1783930933; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XPMgYShl20EKs1ZYQTWQVdTEwYjrHHFi2lLVinb5u5U=;
 b=WJzvk5PBhK1OSLuPcq2A4f/amnb/wdg6lMgs9XktbuZkAGi5fqBinbmsB8DRco2HkE
 e/w20XWOtr8bC1ABpSiL/bltrXgGz1/vLTH5/9xyROJfuSASZwQuEa0rwjArNmFJ3WRy
 7ZdzXGR8628+YmXnAhQ2GnB6AcipPcim+ZqDMlAcWkc7CSd2d+sVEymvnswB6T8PR+5P
 cfJT2I83gpk7W0+BeVTYs1E9DDMshn2IRm8OSv5pHj6oAZ4LDapyyZTsFQ4wShe89QHA
 kayPEArYZspL6DkHKlj66YNweae+rmg1HW5UPrDRNgy3vES1ceULYUZP8jxBy6EMg6Vv
 uyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783326133; x=1783930933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XPMgYShl20EKs1ZYQTWQVdTEwYjrHHFi2lLVinb5u5U=;
 b=iC22g2zELHFkoc0GzkTZkP43fw9kAAw/bQvyHkA0cr3jKIyzNVYNXvqlj3PKYED1YN
 Qhycg1y1H0m3jhlsYNcDq3I0nGmnbH28aHjJzuRtKCJLvQGuseGKYDIWHFVwgV3h/p6t
 wPu7a6dD4Q5YrZUTzQhlkhrQsBiQSikqDLT5ZBy7fg7lwh56cdCC5J4DpQhUN4TOpyuL
 iZ3ttE53F5PKl+rl7mZX6gDP6X6b17jTgGF7WUvoNp3qBIEt9eLm/wY4hctS1PHI56gc
 78VZSJV8tqJMFW6XtXSN+8bj2iM4grPWaijr0JLkvIUzgqtiRJDPdE3dATzHK8yY+9+W
 +fSA==
X-Gm-Message-State: AOJu0YyG9nMjqfcdtS8Fokr/K3G0CpyqTz70U2TbmhpYzJFGeEb/iMjY
 1W1oP5Qm6Y+jYtHmy9x41m/UH4+czJiJYJDXFyi+ELgcI2AQ+fmHFh3A
X-Gm-Gg: AfdE7cmn5UI67lppZyB1s8uWr5rr4AAMVTZFwyHr0s0xBGZlayftD//WuhU+c/dNkQo
 pjqxJW4P99Yff2Yc1fvND6uIaEFEU8OgjypUfKiEedOj/QT7vBB5Cgwg81k+YUtMXqLwlgrZFAe
 zii/gVUrQUSYl1bR3scaXJ/8rIJo4TKjFw8M5JqONkBaH3JGSxYCJQTJ8ddrnU+VGdtpNCfFFQH
 uvHLZSIycknqpJRj9QprR/Pei4K7VMcNe6f06Vh+HV59W4W0L6OC4qy2UPNJAfIGEtRKXTRwF4Z
 RLmO4WAQ8gmGj6jnGhdg3SmFb/igJFApJp+bJqhMqwgtgmc7nOEVP7e6ihbQy8HwHkZFXfYhKYz
 PEa2nF8/aaAWcRVVJpHbvyATZMxTcbZWn7IC9OXahHkSxUo+4yzMACQhy1oUxVUNUh/s8+wgL8O
 JidGRinecPOdKFjoJ38CiHGDu4yts6FGWSLmVqwpngLaebp2UE3OkiriG5bxQ2txEq8kUu1dGev
 tZpRpiPG4aF+3pF2kZiJnEMxL5+
X-Received: by 2002:a05:622a:1b2a:b0:517:85e1:388f with SMTP id
 d75a77b69052e-51c4c21a237mr138800411cf.30.1783326133376; 
 Mon, 06 Jul 2026 01:22:13 -0700 (PDT)
Received: from
 runnervmkkn4f.zrqr2oex231ezjigm0txkepa0a.cx.internal.cloudapp.net
 ([20.161.28.101]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4718141e6sm130507196d6.24.2026.07.06.01.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 01:22:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon,  6 Jul 2026 08:22:12 +0000
Message-ID: <20260706082212.4080-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706060244.23332-1-wegao@suse.com>
References: <20260706060244.23332-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] connect03: New test case for EPROTOTYPE and EACCES errors
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

On Mon, 06 Jul 2026 06:02:34 +0000, Wei Gao <wegao@suse.com> wrote:
> connect03: New test case for EPROTOTYPE and EACCES errors

> Add a new connect03 test case targeting AF_UNIX-specific connect(2)
> error paths, specifically EPROTOTYPE and EACCES.
>
> - EPROTOTYPE is verified by attempting to connect a UNIX domain SOCK_DGRAM
>   socket to a SOCK_STREAM listening server.
> - EACCES is verified by modifying permissions on the socket file to 0700,
>   spawning a child process, dropping privileges to the unprivileged "nobody"
>   user, and attempting to connect.

The body describes the mechanics of both test cases, but does not state
why this new test is needed -- what gap does it fill? Does connect01 or
connect02 already cover AF_UNIX-specific error paths?

Rule 2 in the LTP commit-message guidelines requires the body to state
the motivation or problem being solved, not just what was changed.
A sentence like "connect01/02 only cover generic socket error paths and
do not test AF_UNIX-specific errors" would satisfy this.

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
