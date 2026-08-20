Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B325DC5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:49:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48CB63CDA31
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:49:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DAA33CE321
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:47:03 +0200 (CEST)
Received: from mail-oi2-x0a.google.com (mail-oi2-x0a.google.com
 [IPv6:2607:f8b0:4864:32::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 864E410005A1
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:47:03 +0200 (CEST)
Received: by mail-oi2-x0a.google.com with SMTP id
 46e09a7af769-7e9fe57f70eso212020a34.0
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787212022; x=1787816822; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fg0SdrBdoqha2REXKaQc6Mb3VkPDPuMHYb7lCtYTt8w=;
 b=Khr+W+jYPQyNIwD/NLN6KBrPPFJ/llxj6VmTFM/hmRl+L+ctQECZ0ox+VvH4MQyRSX
 m0TBWB22pIJEzCsu8DcPX20HpLJzN4OWu/NiQRRjyzBkBBPQ2IuGhl/Wl9A1UozIBmNK
 YvU7/8zcE3DfTOXEouy+ddQ1sxjjZhtwncg+IOkJ6q5MAL8PtpiBRGWLwBIqU3mgoml1
 bVuL724zH9vM/VeBIIU6M6Ti5fuW9YUPepzcBZJBkspDSpKTV5mzK3RQBwKUkHaXBg8u
 UoEW/t7oFBdONXx9czi5ux63PsHJBkfhx/yW6hnnp0ooqoTF664q70aub9xdV8VRNL9g
 DLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787212022; x=1787816822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fg0SdrBdoqha2REXKaQc6Mb3VkPDPuMHYb7lCtYTt8w=;
 b=FbSOTNJwTvUkzfbh8u97z4l3F7gD+6xRkUubOT0kLwBvv7CY6mS0cYFazPHh1FPmXW
 jsjVtuezl95hdJalQcIVssD0XVKDrlcwKDhtQthUocWxc9N1MNzH6EWMm4vR8GMUBDh0
 B2wka9WnBxhAjXoowgwYdzhNaDT0gxNMgwyl+leg7cAXq6Evculafi2dlaxlRpjpSJ9r
 Y0QBZeJ6sf7aJW1YT4BSxP1NMK3LlApzbOLyi0iwjsEQsVABOMeXHsZc/dRyZ/DNC1Vd
 GN0V/EQ3ls36ICeZ7ebDXQ7PFWAz5TsKdJ18WSGwZWQHTX3WRCvdiyhRt3ifPSZNHZpY
 8WJw==
X-Gm-Message-State: AOJu0Yw6dRHdBwMNx2I1pARLbbN2T3vt+Da0EB1BNu5wBOPsDqiu5hLM
 3W5qzE8YYxUwc/jv3AufhBEnosxRHqdx3DQ4ktXOI8/fE2nr+E0jwh7n
X-Gm-Gg: AR+sD10qag4J4TRp9DK4XZXUJILNt10gGisSC85s/fn5Sw/N+yA0tYnxPpcYSo+x7rX
 JjgPDE3aVfF8KshR6oUAf3gu/V+yLf3uyvrm+Y3MoW3gcPsA+HBAFha1LKvBdQLLSYhI1ESZ5Xv
 RgxjDcl6sRSJGIKxgk5cnEQ+/Lb70WjRq1O56KHoOJRzjPLQn1RoUzEygoYRlrrk4L8g48EYm9w
 I5em/VuhNhJWI8JYWUBtcg//JDs8Gs2PZZ5S6CTzBBqCS25gtY1+FB9oj2vyyNP/+O7LCg58R+g
 eS4wsYi5cajC2gOeQny2cVPJPo7hoJpj3cFPD7tdfyTapWWRgx7fcxrjrBzGmnSJcCC/J3hmoRP
 pTm+xavZxr9ej28jHrrK7ibFqjGxKgfqQh6+ljfxja66G9lZWsithXeYlcymhLLGpiH2WR7NA62
 JpcK8SKgx2DfFzUWC97I4d4FQ9/ULEx3g5uazFebXIskl7i9kHh4YXIWEQlocTfh9OnOgAPjBV3
 kQwbKZUUIt/JQfXHWudVlMyAUbhzZxCLX3vBHWpFBf4AfbE10xR8LKigTRA5BGrLy58nudZp6FR
 5S0=
X-Received: by 2002:a05:6820:1c91:b0:6aa:e854:d05d with SMTP id
 006d021491bc7-6b13c2d60ebmr7548385eaf.3.1787212021820; 
 Thu, 20 Aug 2026 00:47:01 -0700 (PDT)
Received: from
 runnervmzvulz.puiydixaqiwudic4nrs54mqeod.gx.internal.cloudapp.net
 ([172.212.167.166]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb1fsm4709371eaf.11.2026.08.20.00.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:47:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Thu, 20 Aug 2026 07:47:00 +0000
Message-ID: <20260820074700.4031-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820072133.2036117-1-cyyang772@andestech.com>
References: <20260820072133.2036117-1-cyyang772@andestech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: test: check systemd in tst_virt_hyperv() as
 tst_test.sh
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

On Aug 20, 2026, Victor Cheng-Yen Yang wrote:
> lib: test: check systemd in tst_virt_hyperv() as tst_test.sh

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
