Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E4FCC6B27
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:08:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B33B13E2B0A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:07:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 170583E2AFC
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:07:44 +0200 (CEST)
Received: from mail-qv2-x07.google.com (mail-qv2-x07.google.com
 [IPv6:2607:f8b0:4864:33::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5B3160065D
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:07:43 +0200 (CEST)
Received: by mail-qv2-x07.google.com with SMTP id
 6a1803df08f44-91b8216ae32so18776086d6.1
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791965262; x=1792570062; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h1dR2IdyfsJAHq1e6eqVvPgtRGqUL36wyDQrYss2F2A=;
 b=qM4eRYOioQw38ln75k3x88rbhvHpSdOT3UysSdExT8Bnbr12CL0DXJNI0XWjCQpQ89
 CQlGfitm/4fyGuF6xOHn9P3WObzrD6oOL8OY80nPRCM2fFh8QUxDzJARWaA61mp9gKOu
 nUpVGNbkZd+CYG8OBlL8aVn1o8z7oy35TAI+BoCjUTO9k1D34b/FwIaPyo0laixZaZaE
 Zw3P9nD9lOd8gLldGMRSVl6DsjagZDvC66SgMdof6XPhNa/oIaJIQUUxACIGWzMIiqqA
 /gKUjorFpHv2BxW6iHGW9Xak88QR8KX2mP0TH2Zbqx2RcyeLvSltUtS9WQB77RzRt9Gl
 4xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791965262; x=1792570062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h1dR2IdyfsJAHq1e6eqVvPgtRGqUL36wyDQrYss2F2A=;
 b=jF8W8IJqQC/iMw302l4mxIEFPE/ceKpdnFPaa2ucvQ4np7LeKnNYm6mnN/OyLObHHI
 4wKMR7RmczeX64Ml4Cbq/ABQxZHUS52VoDBI2r3qymTFdshnyppigKEV7r7qpaakkWKI
 zVYZiHPlA98myjGzyutipUFKFzIsS9XzOn/r5NjkFPFn79pt1IYKgXFpWlnb0w/gOS3R
 7wby/Y6iaiZP1n8kBpk/MkQwgGb57pSBvIzZDvYH73BVlUqjPMlxF/wUqhfP7v6BgLTi
 DnczwTJfHCplkUDdSxY+Mo/C0sIh+/9yi8LgcqXU20yjw4oKR5KXJ3UV+/uImijsJqDG
 ICnw==
X-Gm-Message-State: AFq9FYJbnMYI6FGXDY6yavkyWjqALUtpZ0UC2V7UCytEhygdolM0PXfm
 voPxf9vmeZaUlh5uJKzy0fYhzV8OdkxjMjYKal0RFvHamNHEEIkc+pxt0nqGvXFL
X-Gm-Gg: AYBFou3AvTl/CzXOaK3AiDgY0AVmbxHfucEm7Nv5tH/q0MSrlLMy60OvYTXKu7TybQa
 lw2WWoMSHfPUHkKu1S9MjNzrl2bl3RWEqk9QHLXW/X0RgRIYnXPvwKCkvCYCdCIaGRTLJV9KjXF
 khhPYxTVom3kqEiKUrBcfoojUTHMuvecQPJa9Ev1/XU/0c0Ffgld1zylwNJsELYH1fvECkzv+4y
 f+v1tKqhUYABRjXBqHy+RyhXTF7D9pSW7PazfioR7FEzykOEpx1/dQMwUcMITbT1fyANeSKAQXj
 RQsLjEX2DDWcYJdTH0tNKq3tQ3jchWyQr8lOFvCx91r/9QJ5AiOYjfGUR6QxISraDsMZl5g5NnH
 nfK4JrCXnypQ0SL9T5XTqMxPs9lEmjn7p694iwInszrFVtGfPpQlKoHrsNFO0k0gO1u37nXqe9H
 9dvJ0ELe1b0KCHfW77U/IS+OLqj3BSR3A5bLy/gXM5Mk0s/FLW94e89bZsC6jIUhORCOX0XVU1q
 N5VOoG+kkNfHJrm6kBYqEsShc55o6WaCxjynKboAgurqsbnV0ifHeLV7UUm+rWRqQ1lP+gWT4f1
 cuP8mkX4UcDu
X-Received: by 2002:a05:6820:55ca:20b0:6f4:fb85:5e39 with SMTP id
 006d021491bc7-6f4fb94a77cmr4751620eaf.29.1791963434883; 
 Wed, 14 Oct 2026 00:37:14 -0700 (PDT)
Received: from
 runnervmmprz5.0y4ggixqpiae5jt5tzqp2bomxe.ex.internal.cloudapp.net
 ([135.232.232.65]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ef023a1c1dsm13667927eaf.10.2026.10.14.00.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:37:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Darren Chang <chihsheng@google.com>
Date: Wed, 14 Oct 2026 07:37:13 +0000
Message-ID: <20261014073713.9269-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014060212.1081388-1-chihsheng@google.com>
References: <20261014060212.1081388-1-chihsheng@google.com>
MIME-Version: 1.0
Subject: Re: [LTP] process_vm_writev02: Fix stack overflow with large buffer
 size
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

On Wed, 14 Oct 2026, Darren Chang wrote:
> process_vm_writev02: Fix stack overflow with large buffer size

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
