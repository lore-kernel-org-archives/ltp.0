Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACCECA5FED
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 05:23:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA1593CD74C
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 07:23:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F8C43C9FD7
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 07:23:22 +0200 (CEST)
Received: from mail-dl2-x09.google.com (mail-dl2-x09.google.com
 [IPv6:2607:f8b0:4864:38::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 940E31A000F9
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 07:23:21 +0200 (CEST)
Received: by mail-dl2-x09.google.com with SMTP id
 a92af1059eb24-143255db95bso35757c88.0
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 22:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791264200; x=1791869000; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CDOmqK+xhMs/eUWisPHCwsRwKtmyXeJSM/ITQJufGXQ=;
 b=sSo6jM5QuSmEMVmH3R1Dvu2DL+rtYp08Tj9QBk0heHDy8FEpLQ2zlBmLkyTMuBL5og
 Fy/tgijLPWRaF6AZb6ivKELjapHwtbllUn7gkJ91R0JxwzV07G5HRNADEIrus00GNm4s
 Kj77c+gvp33mCpo1v6zmsGZtoq2Xw86EoyDMf0pkBkj/5MGEwFCqaJsDx/WQZjuff5dq
 5CEdQmazTiL+t0w/7FjTo8nUFseoSipwvgykv3o4Cs/kLX7RraYQQS8hAgwMcQfaClcg
 b/J/4yYAa8Kk1smX+2Uq3ZZAF7LVbL6Z3HD1gLbpFAeafq+Gpaxs0d/KrWxR+qY+YZwu
 mjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791264200; x=1791869000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CDOmqK+xhMs/eUWisPHCwsRwKtmyXeJSM/ITQJufGXQ=;
 b=byu/wO/ExaowDUpNYW/MRI1E4zJKUl6fiYk7Ksn8JzIdT1yHDmdO39++fuKtiN8uYW
 49dbx9N3H7ET8GXhnPE/UOIQ15d6paJ51MFVfaqB8oYp1tO3X3ZCKZ005N/myzz5cK76
 adZ4yzRTlJKtQvrJK1E24ZjZwT/ArNCG7q5FW2jsL5wViP+B9hu1/FP4HRvoGDSMfVsK
 HsxS1o7YiuMe3idP5JL1Lm5GmysmORP7S6OusIKJXaVlhNSpIx9Iz2z7ZLaZLsQL9j8P
 puJU/cvI6Aio2NourMBgpLk+aGSGY3sBdBqNuqBe5wZ/dinGFrF6+AcAYJZ58oJ76ght
 aDbQ==
X-Gm-Message-State: AFuF++m/0kB6XeSfxG3wAaAsv975XnDLS+WhFhfC5gYQnYdw2Js+Modn
 83LTu7TiBuMqNMa72LuueASqQXG3Gn3NEtyo6s+txYvDrYnLeo4zsM6d5TuaJSC2
X-Gm-Gg: AYBFou3Xvj7IxoWQ7NqA2ZZV/vS7UPM8RAXRegAlVj8xAU3UjJJtpV78Hu3FZCU0LpU
 Ku3eL//hgYjzEfBPIbfw/w+mhIZN9Fr2ryIeo/PPrwmCrgQ8t7IL4l+/Gsa05IXuurOWjC8J5w9
 CjCPq4T6x7CVcGkrlilR3VX7Gsr6Znly1NnuuvB01iqkonI2UPFjmTOGsHZ04oHf8+S19j9K9r/
 YCyttMsJOGM61DkhtP4Tc0q2r2Fi5YRcyVtnbmYORgto9IusuZqmfMrcF9bNOdSTqTselq0oWT6
 r9YCrNhounbeEcMHHU26WJSwQQpMFuPjT9XyZg3uSfuTVG0aTwae/sySvSjZMnkvlY1flSGvwcd
 r0nU8NAbQSt4WlzDHPtLJPLdFwqFk5qva573mG/mxhNtiPYljpQwhd//2a0OVInwMW7lMNHyixc
 gJqoIyWebJ7SJ1RxsyJ6Ve0fgRhldo164/enJMnBbSjPNnQnzXc0kIneB5uwpM1X5UQkhq0jGEp
 cr5V7XOI76QctzrAjiUQm+pbjT5qYYPQfYR9ZrBUiOQGgXuQwZIQkouoNRO5kVHu49xr6ltKrCt
 RKoVs98vSAo=
X-Received: by 2002:a05:701b:2618:b0:154:dc96:c1d8 with SMTP id
 a92af1059eb24-15ec01d320emr539217c88.2.1791264199508; 
 Mon, 05 Oct 2026 22:23:19 -0700 (PDT)
Received: from
 runnervm8df0l.sjon4tmsf2qexicyal4bq0hddh.dx.internal.cloudapp.net
 ([52.157.33.160]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d84523b6csm3534903c88.12.2026.10.05.22.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 22:23:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Tue,  6 Oct 2026 05:23:17 +0000
Message-ID: <20261006052317.12310-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006020331.3791608-2-cyyang772@andestech.com>
References: <20261006020331.3791608-2-cyyang772@andestech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Update call sites of SAFE_READ() to use the enum values
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

Hi Victor,

On 6 October 2026, Victor Cheng-Yen Yang wrote:
> Update call sites of SAFE_READ() to use the enum values

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
