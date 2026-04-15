Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A5BF41992
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 11:47:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70E113E5BAC
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 13:47:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2ED83E2952
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 13:47:10 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6E7CA10009AF
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 13:47:10 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50d75bfb259so44209441cf.1
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776253629; x=1776858429; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKXWGNN8YKBTR3ERF/l4+zxy8Mfh0uuavuZ1r4ShbbA=;
 b=ZciZiwFy8Q84k6ye5tvyqVuaC+LZAC6olXv2SO1ZKW3SLevpsVqcFTJr4RrgoV1kOt
 GF0oUGBJkoxnKBcW4xNsRjA3yDJpNotTAT5+nvol2J2OBkKQEB1FgSCyiPdNTwqFHcet
 N7oIynsPjTiXUFbgKrD9jJFPLbzBXroP/WfcSGFKk92ugWeJcUemH4a2ptdD9QFl7kfG
 F+osNSzKSkRfEZYw6WMDzBkVklWMV0ZS8qa42R9LCHac1DSwein9Po8t4FUHU/IdeDEW
 gioi/LhGzlqebAw2GfOhhFQzyWngeDhq6ZdiMcFzlc/iUttAM5qMM3NuYzLWxp8a9awf
 8lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776253629; x=1776858429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKXWGNN8YKBTR3ERF/l4+zxy8Mfh0uuavuZ1r4ShbbA=;
 b=ScUpZyW02ET9jZr5X+94iBZiZYYQ41YM6R5xRWMU7HYAWjTgJkIKmcEMmhbi9cXkAj
 9+alV4TktGmQRNECipSQ31a+scWFZf5buZ+JHG/FQtPJKBeTwiivVjidBOl50GGkx4fV
 MzUJU2gVLZwb2B4Vw9h9egyJ4ccYYc035xTJqBX2eacJDIT3LxRwrTTWt67y0ZqkvrrT
 5bI9QCLOT6aNmBwDDgiSk5L7UbN6LNXS4WnMPkMGi+hlhhs5F2/tD15IoT3og8wOVjMX
 tjWcVk692qFj+TH1fd10C/vRRDoPtvnQ/sJ+1hCRGHq0afnBp/w3KByRNSwVOj6e7cFV
 cZdA==
X-Gm-Message-State: AOJu0YyoPxK8IpI3YFRjNkpp+WpTD/t5vd3jX7kNDS+ILzfTJUb2jdWq
 3ZXjP7YdxzWAx9ymu7P78n8xwY3fVrAVK0knxY/b+lqNnNQQlgNruX6m
X-Gm-Gg: AeBDietXOGzGg41NqbTEcpbkW1U0sJPbcQRNxzDVxGsXiUzJxezlBmxM1CcISGP5nbQ
 Znr3a6kbN45Px/vQehfvSB/ugSKpIWm187Izb7PMWHWjITiYBFIg22TOXBVlI4Ti9MXWN3W7dN/
 EKKbhImT/i3r9pj6Gz4rQ/ogWkj1AixVOKkEfPhHRhZXjI7NNs05Kq3lnn0K+x6o2bXXC+DbL02
 hAHg/lDYRx6ggXXyVKC0sRQW+dJGby+AdwdXISB+obQhZ1d1VkNoGy+YuG71ouSxB0H+mS7YL+l
 D+gV3+N9SKjmLF9fMiiCwiG0yuOc4g1sgGyG6L0Q/u6lFXAiyqRKOkPqQ1exUIUqdwDH82uEayT
 anS9uENfftXQN8Bj2RyJoB2ySgGgGcVyqLiEM4qkm7KsMfr8ErOhosPWSrcK9olxQMq89YPaSgK
 Qa8nV/VdexFDe9oQYZ/1ZooLqCjJq4lievPNyZKzb62Lx/YpAayXlt9IhStjhtc5YhNyMqNTVnQ
 hoJ70Q1Rlj4WsHyipm5csWQdf3xts060VHtntGh
X-Received: by 2002:ac8:6f13:0:b0:50d:a8f5:1c02 with SMTP id
 d75a77b69052e-50dd5b93b7bmr299466261cf.41.1776253629168; 
 Wed, 15 Apr 2026 04:47:09 -0700 (PDT)
Received: from
 runnervm35a4x.lq13sqfczlte5m0m5mu4ko3ipb.cx.internal.cloudapp.net
 ([135.119.237.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e1adc1029sm12454131cf.9.2026.04.15.04.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:47:08 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Wed, 15 Apr 2026 11:47:08 +0000
Message-ID: <20260415114708.3888-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329113252.204926-1-pavrampu@linux.ibm.com>
References: <20260329113252.204926-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Fix memcontrol02 test failure on powerpc.
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

Hi Pavithra,

On Sun, 29 Mar 2026 17:02:52 +0530, Pavithra wrote:
> Fix memcontrol02 test failure on powerpc.

> Signed-off-by: Pavithra <pavrampu@linux.ibm.com>

The patch is fixing a test regression so it needs a Fixes: tag pointing
to the commit that introduced the 50 MB allocation values. Please add it
at the end of the commit message body, before the Signed-off-by line.

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
