Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A60EF34C64
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 15:54:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1C923E4B38
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 17:54:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 108153E1DD5
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:51:53 +0200 (CEST)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9497560082B
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:51:53 +0200 (CEST)
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso3903062a34.0
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776095512; x=1776700312; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPVBnOciOymkt8TTTofjGGh4d7P4/7BB+m7V+e04UhQ=;
 b=c6F8JZavC7iw/+hFBW6xHS+k75m8LSGEy2dTyuHk5QfuKiGZsT0asq9t+MIOpmqVCO
 V4KA5zYZizS8GhThE8GesJJBxF7Va1CCTICKW2MFxc+LKG02x9qr8mQoJDkjP7Oi32R0
 H+P7YeMjpIskvk3RsbETtcTR6JjIIRXKc8RZRIDzgO8zVOAkZNtX/RPfcV2DfXuagXzO
 cawP6fxTllq4vbvW6c65nLXpKh/YFOtZWvn32vvlwkp8evSD7rYJrju3FLZeGvS+DK84
 kkxBAPcRMeYxgelvcdmIZaSXWKeECpsiVpK4enBkTUn7GXtG1RfI/R94mlOnD7sxumiQ
 hlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776095512; x=1776700312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPVBnOciOymkt8TTTofjGGh4d7P4/7BB+m7V+e04UhQ=;
 b=qGfWsauDupMHYRW9Grz1aI4ujRXda888VdGk/ZIIcEdW9Lp6XwbsmyCiXn9Z77+Hkk
 KB3cNWKpXItC1rd4tGveI9LLKCakQNHl1SLTuuiaWmFp+Sbxaz2m1j2RRW6VQmnqxnK1
 HhhkJo9tsB6iqkZ7CO7NFMCaXyMkkfUJ2VvbdU0f9zc/6aqudh9xaISbQeo7kobjwjQU
 mQLXpyEV7sLgF2mTgJkxb7DSltQGw0eIP31EhkmY5KX+vzHHwdYteQ/JAY4pse/H5l8J
 YtOzHwYAGQW0rpQmBsBMyoroLwfDT5uziUEXXK7DPVXmj75OkjzE6X7XFnL3GJFKlGEQ
 wMvw==
X-Gm-Message-State: AOJu0YwRqJto41rM1+EBryMhn7+vgofMWUkIm3hvcLVRlUSa11aMWiHd
 9YOlFWGQLyGJ7ylY+/lDSl+IlUuEgFJ26Pxi5RQtb1zQer4v9AAo5uP1EArgHds7Hb1c+qwmsl0
 =
X-Gm-Gg: AeBDievMu81IMLOWj0f5bvM9gACzlY6kciJvN6gsRYZaHyrGE77AEjDWrR5y+XdmKtu
 0cQijsntcDtLO/5quxllb5Lso2/V4qdx3MkCZZwrYZ2naI94+KPt1ekPT5aNuzMvWNodLTi3ZCL
 def7LrfgejG5RaM4f9bb+liYFiwrcTUm1rwU/VuYAQgTarhb87U1HGTP8KJIzhQLcciOZJA984x
 4SY0x9SLgV2o89uI7vjjN+v6qvqHsvs2/YNvFFBk9PtTJkk6amQ39lgyIWecUMHlJUMhPDuzOG+
 utM3Ca2WZB6/osQ5DSawUqQRPgnPH2777S+/BNg7zBtrBB+bKNIrE6q0pwmrQpQtFL3Rv3xDi6J
 8Fa/Lmu4Iu7kYhGF6zhzukcrHeW2Ew5gTljoT2Gxe5Cw3MC3M94RrAc/YnmdFyI67tN31mf1ooN
 aUY/BpUONe9yY7F+rdHsFC/bBg8Ed7aclk3nxh4y/Q2yIQ2zxfkVUq4krC4lzQGU6ceLcQ5FJgV
 E1eEWWr7tQuB9NQd5fo/UOl3h6+Rd2PBFA=
X-Received: by 2002:a05:7022:ec07:b0:11a:4016:44a5 with SMTP id
 a92af1059eb24-12c34efc9d9mr8007675c88.24.1776092211144; 
 Mon, 13 Apr 2026 07:56:51 -0700 (PDT)
Received: from
 runnervm35a4x.yizgoo0wxrde1freo0ereqkpvd.dx.internal.cloudapp.net
 ([52.238.26.248]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c347fa2c9sm14053711c88.15.2026.04.13.07.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:56:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Mon, 13 Apr 2026 14:56:49 +0000
Message-ID: <20260413145649.4050-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413134029.43754-1-mmenashe@redhat.com>
References: <20260413134029.43754-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 13 Apr 2026 17:54:23 +0200
Subject: Re: [LTP] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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

Hi Michael,

our agent completed the review of the patch.

On Mon, 13 Apr 2026, Michael Menasherov via ltp wrote:
> [PATCH] futex: Add error coverage tests for wait, wake and cmp_requeue

[...]

> futex_cmp_requeue03 verifies EFAULT is returned when uaddr or
> uaddr2 points to unmapped memory, and EACCES or EFAULT when uaddr
> points to memory without read permission (PROT_NONE). The EACCES
> behavior was introduced in kernel 5.9.

The commit message is missing the Signed-off-by tag. Please add:

  Signed-off-by: Michael Menasherov <your@email.com>

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
