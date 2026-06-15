Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAEECD98CF
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 18:32:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBBFE3E5C70
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 20:32:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C8903E168E
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:32:00 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A2FB0600475
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:31:59 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-5175eab3a93so29897611cf.2
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781548318; x=1782153118; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/oGCIr1QfmAVTk7W41Hvs0p8Ly/UFkp1VfCDbTir+g=;
 b=APUTed8nU8qAhDweI3f4EuOdyp8yjoyqkZ33z9q20SKuskA0Z9ydIHxxBLcMcak2mo
 8muezvhX4SccgTy0maPAf0vJ9cJnzAp93died52qsD9rLbeY4yC7ROkV1WweVyJXOZS9
 VV/PqJFnR9MOgskh8xQ2QlN8Ik81Dm/LELV4kJk1PtoJWXKp2SXLUsV6Cvtj2Nzg9HEB
 HTo7v3JBkHhRt7TjyskTlh59005Llp/Ybi3z8FKRt1h9T0PrmWy7XD5XepDndROtcK1e
 kIhs9GJEjO3QvTM99CK72UN5Qi/vHSbp3exuYAaaH7+C95ryyxg3A4SSoUS9WAAnqWln
 +YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781548318; x=1782153118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x/oGCIr1QfmAVTk7W41Hvs0p8Ly/UFkp1VfCDbTir+g=;
 b=VAVt8/pL5EXttAsYN5JlDh3QDHLCjACRsYp2cm9rP+mOAH7fWAYlbvQTfnJA8AYeiK
 hIDqaCYVKpW9J/g4cLZRSoBC4VcerLJkC/gUHE4GhPQA3dSzTFZLFWowW0mitgr0LP9P
 1WCzytHWW+ndWrgEMiIX/Ly4dQei50Xc43HP/wAkkbv5KiJ0YQTNUfVjJDtSr/NukWok
 +eXtKmCSmQgVLkjU+14131NVbrPbExFIgGOH2fcXqfLrEXIaDG72dd9kukanM7BFe/hV
 SPs+rhgzssZ73evI4OuvdPKhyYxhHpGc0Z+3vi08VjJXSlHA56uw/vLZk9lxIsvAm0sA
 mb9g==
X-Gm-Message-State: AOJu0YxVW8PpRJtcfEFhT2MD7fVDp1AqAX6c2hZ0KtnFehBN12nG1Ew+
 eU3R+/nVoZxeLu3k1H2qTRMEubvObG6CpJDJJHlPXxq1Yn+dvppZqwFOY0BQ0oA+
X-Gm-Gg: Acq92OGgrs+keMIv97+CHHmPj1rSj/TR0s0NOhrqD7ZjXCPBdTYqeQ3GkdWqeILAoPy
 tY99VZOxSC9gUJMJzFX8/xbw9ycpN14TZo71k6E8uwd4OpMs0PWA03dVnevYFNlJbIH5VUag06k
 /qs3xvOytcShOex4YlLqq9hcwth8izM86ZVFJMRRW0ztxeOTIQt7QVrN8v8JCu257MuUm6f1PO1
 JmoaGT/Jq8atOtEwH0iMlORX+MGg+M7fwGnFBSyzZFtwBsnrQmmt2gQNTpqug2sO5XLbsKsxuoG
 IP6/2ofMmeubyjj3R5mMWvb9kQFXqrH6lK8+QTbcst7RXq2Gpqixo3c+CPkIQgiy82iaWZVp51j
 wVaEZrCOGx59HbOcdADSvNfVOQegZX+hX9Dn17MYIHYg1G0j37Es3nEDREkqLO8fNJIns0WRP5j
 CarJEFUva1GEb/mTDJ4XmWYYvkKb/Bvif9oQjBZUtPC+rV8ATlO6t+PwPK2tCEGa60uSUaA5qR0
 fYC1eBivIVVsfrbCY1IAyCgAXXhg7kDj12uzrAMDw==
X-Received: by 2002:a05:622a:1e92:b0:517:85b3:9467 with SMTP id
 d75a77b69052e-51953356422mr194026301cf.2.1781548318274; 
 Mon, 15 Jun 2026 11:31:58 -0700 (PDT)
Received: from
 runnervm1li68.kdo4uim0ecfu3i2wm31vtr4tyc.bx.internal.cloudapp.net
 ([172.203.196.178]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a061028sm1197281785a.42.2026.06.15.11.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:31:57 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: AnonymeMeow <anonymemeow@gmail.com>
Date: Mon, 15 Jun 2026 18:31:56 +0000
Message-ID: <20260615183156.4038-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615180629.7148-2-anonymemeow@gmail.com>
References: <20260615180629.7148-2-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify20: Allow FAN_REPORT_PIDFD with FAN_REPORT_TID on
 v7.2+
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

Hi AnonymeMeow,

On 2026-06-16, AnonymeMeow wrote:
> fanotify20: Allow FAN_REPORT_PIDFD with FAN_REPORT_TID on v7.2+

--- [PATCH 1/5] ---

> fanotify20: Allow FAN_REPORT_PIDFD with FAN_REPORT_TID on v7.2+

> + * FAN_REPORT_PIDFD combined with FAN_REPORT_TID is supported since v7.2-rc1.

The latest stable kernel release is v7.1, so v7.2 has not been
released yet. Per LTP convention, tests for features not yet in a
mainline kernel release need the [STAGING] subject prefix.

Since the patch adjusts test expectations for the unreleased v7.2
feature, the subject should be prefixed with [STAGING].

--- [PATCH 4/5] ---

> fanotify21: Add test variants for FAN_REPORT_TID

Same staging concern here. The new test variants exercise
FAN_REPORT_PIDFD combined with FAN_REPORT_TID, which is a v7.2-rc1
feature. This commit should also carry the [STAGING] prefix until
v7.2 is released.

--- [PATCH 5/5] ---

> fanotify21: Add FAN_REPORT_TID pidfd coverage

Same as above: the thread-based pidfd verification is for the
unreleased v7.2 FAN_REPORT_TID support and needs [STAGING].

Verdict - Needs revision

Pre-existing issues (not introduced by this series):

- fanotify20.c: `static int fd;` is not initialized to -1, and the
  validity checks use `if (fd > 0)` instead of `if (fd != -1)`.

- fanotify21.c: `static int fanotify_fd;` is not initialized to -1,
  and the cleanup check uses `if (fanotify_fd >= 0)` instead of
  `if (fanotify_fd != -1)`.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
