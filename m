Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2926FCD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:08:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D58483E6169
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:08:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 310043E2630
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:07:57 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E546C200AF3
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:07:56 +0200 (CEST)
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-47c941f6bdcso2616785b6e.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778080075; x=1778684875; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKstfxyVNzjA2A0unyqpX6aTIc9N37Cr+CCt22DRNU8=;
 b=nhFlGPtaRJGCb71Wp6cjwI/nmJjXlYW7Gej3tmh8VoWgRzNcHPmbKst9IhjcoGE5vx
 XksihKAOzmD7bwy0Pj4loUcWZd9WSvIGe62FBZRnaKzh5IC1BdQip7megxmEblVlXh9U
 1c2AuGiYiNJSdQyIBdVHbuAKc4/QhJvv8afgxNRXymka4Iqry6KTjaVe5XOpsgR4TdZp
 id5Eo/cMo/nHpiG5H6ROemIP9SwFJaqdqGYKI0uvDJNijwBdOOqOkCJWHWR0Tcz4dWZ5
 HeB1cRO6pKUxBDuPeorf3INDYFJF1uwr/NJnk+x5PxSfXG+E/4yaPKVlSjtdNLtuQE2B
 iUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080075; x=1778684875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZKstfxyVNzjA2A0unyqpX6aTIc9N37Cr+CCt22DRNU8=;
 b=qECVWE+DoTXxgRSblqE0gH+Dg2kU5Flm9wF1FIjVKuUVJd9C3FQy8Ydfk2yE79hGov
 Gh6XrSNCd5tsCs5zDTCPti3PPYHUs1GdqTnSbhXRQc6lOQ++/aggRfNaD/5ruXZJT5+V
 yhBgwishjT+hrHaUqIlGE77qxywBjlz57v5PeM+7Pyth1NiYs6GrfY6KRZ7j2uFeB8rM
 nTprInKsLO6yqbpjTJnolwdVxueCrO8Hv+rFSZMc5Bi+eHhTfvSSMshMgQD1WoIsLcnU
 pwh4wk15A8/0vQSaNW9czhWAKnZeyunGOEmE1mVVLGLI0KColjTLPAR54pNOY/u+UZlx
 IrQA==
X-Gm-Message-State: AOJu0YwpNW3lPslL3LarLP2Ka11jw8kSrMmn3KyBWlOJT9onjwK0CqHl
 a7jmFSUmyNsStZjji8hg6c73JzOcIKfQiE+nDsi7ThOmMSckatjpIu54
X-Gm-Gg: AeBDiev636tduZx4onraEiDFH55jaNGSK2Lvz1OOoDheAJL5ZxH6L9n8NHrKAb61xid
 XtqUBi9HsvqkYQV2Y+U1O4PTsKPA0TUX/YTMy4FEx2jHhWvIhhQiRdAHUpY8cFN7pnDeyXqZAnt
 0Fmv/fn2tNLrzM/wOv1Fp0mDJZjla6u6LguF2gH6+HxqY2Hv5V8AA027iyvyCvMsTj2JVd7EfgI
 gAs0w67qxYvyobYT+LChJKvkTz6fh3jsrL8UJHyXoRSu9wNbifuJegiVDB05ACOVYhQ9NrGuDsk
 d43Xy9dSvTty4AXVbwkvN1tgDvXhzLZhXlmVzEF7bruRW/SX56LlFJwCtChkAz4IpqWAmGir9NL
 l+3SQ6t87W/OVehv8fxVNETP6VO6wAI6ePOJYtXtqKg9LpWmElmc2hg/CBsVzNIpFzd7yW+El/G
 5VDrmK/YUcv5fKR91IIJO4kVKVxCNWaHTVVxk7ByXkGWX/SSi9KlgfTaHuSdQYrVwvHWeGIBLAn
 YOdNoxyN+fq7Tnq43cM8hj9kZr47kw5Gewm+ZZmsJBjLOXcy+E3h2J0hlA=
X-Received: by 2002:a05:6808:1924:b0:45e:edbc:bbd2 with SMTP id
 5614622812f47-48042479bf5mr1994563b6e.22.1778080075323; 
 Wed, 06 May 2026 08:07:55 -0700 (PDT)
Received: from
 runnervmeorf1.hppsbykjavouxdtdb545iqfrfg.gx.internal.cloudapp.net
 ([52.176.37.71]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c763b2ef3sm10814792b6e.2.2026.05.06.08.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:07:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Darren Chang <chihsheng@google.com>
Date: Wed,  6 May 2026 15:07:53 +0000
Message-ID: <20260506150753.3949-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260502081446.10472-1-chihsheng@google.com>
References: <20260502081446.10472-1-chihsheng@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_virt: Add fallback KVM detection via virtio block
 devices
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

Hi Darren,

On 2026-05-02, Darren Chang wrote:
> tst_virt: Add fallback KVM detection via virtio block devices

> +       /* * Fallback check for KVM:
> +        * Android's ueventd creates block devices in /dev/block/
> +        * instead of the standard Linux /dev/, so we check both.
> +        */

Malformed comment block. The `/*` opener must be on its own line with no
text. Use:

	/*
	 * Fallback check for KVM:
	 * ...
	 */

> +       if (!found) {
> +               if (access("/dev/vda", F_OK) == 0 ||
> +                       access("/sys/block/vda", F_OK) == 0 ||
> +                       access("/dev/block/vda", F_OK) == 0) {
> +                       found = 1;
> +               }
> +       }

Virtio block devices are not KVM-exclusive. Hyper-V and VMware guests with
virtio drivers also expose /dev/vda, so this will produce false positives.
Either narrow the detection (e.g. check /sys/class/dmi/id/product_name for
QEMU/KVM) or explicitly document this as a best-effort heuristic.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: (not available)

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
