Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17262C61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 17:36:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAF563C719D
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 19:36:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F18CC3C2CE3
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:36:17 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 55EA0200978
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:36:17 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2d6efd73032so7638825ad.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787679376; x=1788284176; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QCLX+b0971/S/5wAkSrz2+opJvTJsIPoHE4YBTNEz5U=;
 b=I9pgzoZsmuqL5miglMPqN6WCBKuCq/lgwtLq1MSCbGlAFcFg3ZqjIDW6yKFcsh+pKk
 nvsBUGkWoV5BJ6cO32N9aaHSUPcmKYkIL1gL2LRvAQ1fGx4hnAeuvBdDVseHpuokrAyV
 QZhssNeNP5AC5UTC55UDXnxi2bwOMjr4yCLu/ZK8oyR7lDQsaPVMFQOh5Q0gxeom1URG
 Fyyh4Dy9ZVnZGXgi5RujVWwVb5e8ndBgtNPlndzKRW1PnaZaQUDDZozK4Lej9urYAKnV
 Xb7ED5Qkb+9sY33+fU/eoCoNHcbuSvFPCB2ssr5nAAW7OL1zOsnGT+GBBJSwUZsLhecA
 6BhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787679376; x=1788284176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QCLX+b0971/S/5wAkSrz2+opJvTJsIPoHE4YBTNEz5U=;
 b=XPT7J68vt1iZ+TF7D7FEMgaFuSvzmWw5iDczrNRYkdgQSvxUpWhhb783ATdPVgHJPZ
 GNHb6tv3qNTXXpBAPi4EmjicfA6QbqoGenpupj2JKLMB+yrw+pkLzE/EtfIQLxwVzQHK
 PN/w8zY3gzRkcLXNx0Eb89xWBEz8745+DSav7lPZA7YGgs8099hAt5c5w3pDFY21zY2B
 gpAlqDxUr42Dd/yKrrRXDpZRrCCYR7FRMsKJuiMgcfGLjfW1udqfKg0VdpoTyPOMsTi2
 HOkmgkiyzj9E+fibWqL86PBWmaFapaFVHO5CyeIvb8YcGQ2ntvq3RnFFZMrWSnUjP/Ht
 vlVw==
X-Gm-Message-State: AFuF++lsg9RS54ubXsk1zmamWqBq2+F79FBHA6xUz5fej4KdRyEWt7Hd
 /vEx8umT1xGNyvgtOQRbXo2+zkzxSqnmB9KIBYIPNk+7KZzQunxneeRk
X-Gm-Gg: AR+sD13gC0IBEhFGivPX/tVkICm2MDR5mTAfUbDovqIkMlLolejxlDo6kl3cDgAyEjU
 +FIsIgTHyBbWIWfThhKap/4Rqv+L21pMwBB+HXLsFmFyeDUw1L144fjoiVZg14XKhEtWDTOTGjI
 UeRq8xatMchY0BS6BiEI2URMqFFWXGrpb5abQicnmkWvCuS9h+LfHGTAQJyKXAC139hjMO8yBOW
 8/0ngdOfLgpY5aQDw1pyAgK9fTdAE0PsU5EPxEDy2gxqeFY/tWILAL1iYA9m9PCfNH5v45E7QqL
 CfesvEeNDTUfeaKaZiQjOxkmU0SpTnxHlMPphvKnE08DHlA8eFRnhljh+VZUfthPiX0Ku8AVKi5
 PcfksAo7WWQHNz5dOi0LxvC7a2n55WoVn/BCxQAF458XOS4ozPd+TftvMEOQXeeEVRp3wb8TYtm
 dnREl40Za7KheamZ3xvyaWv+hXVm9WhM2jz6ERnbOLivtVCRyRzuqUIumTIANF+gUtRz6EH5+tR
 hlqbHjJGLBxtu39QzHeAYMo6reOkGff8+N38wxbTrxkG6CQbaAWezgfQS6Y2q+vuN3v8GN/4rE=
X-Received: by 2002:a17:90b:2245:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-39645acceabmr10789898a91.15.1787679375599; 
 Tue, 25 Aug 2026 10:36:15 -0700 (PDT)
Received: from
 runnervm76f27.0dag1445wiqurpv2peo3esqijf.dx.internal.cloudapp.net
 ([52.159.227.6]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8f47d8csm747875c88.8.2026.08.25.10.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:36:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 25 Aug 2026 17:36:13 +0000
Message-ID: <20260825173613.8867-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825171405.123011-1-avinesh.kumar@suse.com>
References: <20260825171405.123011-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] uevent02: Make wait_for_uevents() order-independent
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

Hi Avinesh,

On Tue, 25 Aug 2026, Avinesh Kumar wrote:
> uevent02: Make wait_for_uevents() order-independent

> +		for (i = 0; i < cnt; i++) {
> +			if (!pending[i])
> +				continue;
> +
> +			if (uevent_match(buf, len, pending[i])) {
> +				tst_res(TPASS, "Got expected UEVENT");
> +				pending[i] = NULL;
> +				remaining--;
> +				break;
>  			}
>  		}

Could this preserve ordering between dependent lifecycle phases?

The callers put add and remove events for the same objects in one array.
Matching every pending entry means that a remove received before its add is
accepted, causing the test to pass despite an invalid lifecycle order. The
kernel change only requires the interface and queue add events to be
order-independent.

Could each independent group be matched without order while retaining the
ordering between the add and remove phases?

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
