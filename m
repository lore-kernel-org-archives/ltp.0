Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB968FA0C5E
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 09:24:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2747C3E5B6D
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 11:24:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28B2E3CDE01
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 11:24:31 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A7466200A1A
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 11:24:30 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-899a9f445cbso73374446d6.0
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776245069; x=1776849869; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=if/eKhva5jvU+sIx3G07ssnvbdbcn8CUDnfdi2On0vU=;
 b=a1za7ev2C630+rmdUTRbiyRcpd1S/jUqSFfWudUoEvfX9Z1oKp57gSmeaXxcJCEZ54
 xewT1tOh0pE9ZzyS0ORNxrr3Yo9sPQY1NUXYX2I2pmc5enkXgXdjMH5WpJS29u7G23p5
 i8S7JFmmS/T0XUP0ZyI+rIv0Txr1BN6QkhQR/hmRxHdkvMXtIAtBA7hOLKaSydBDPqaq
 liECBygI+F+O/1G1UfqXXLD5WPMn8Q1g90jgZD9BgwfIXfAX5rEfnEAuAlK+I+z8EVLZ
 KlgW02gfgq9YC36P8PUYDTUWRG7FC/suy1TbcU9eYTn5tBWSalv13f5Wjb37aWjtUHa3
 mXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776245069; x=1776849869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=if/eKhva5jvU+sIx3G07ssnvbdbcn8CUDnfdi2On0vU=;
 b=NzK8FoGzuJBZSJQ2Z8WUDFt96qaUxhLKkBwzjrMOm/2alMbVKLgWJ47Rk3yKssfPO1
 8lgVir+gK/zGtniZ4Q41Ja4UHBASR5IBo7gwsUAWpz4rcaj6AX2zx5qBSfnT5u/uU0zH
 lO7aEp3SQ227q+SCMTYFEB0B8oq5lOolRLqlVFNxVwN/yLpAIZSlvFfTwlpaZ0HZ5dvP
 b+qCx7xau7AcE5Ye5Pif2gqMojDI8/NI0yX/uCQvhMi4Kfe1kFpmKBATa38FWA8i6qkr
 IXZm6RdQHdW0d0D5hLxzbjoSxHitOKqHLMSpl+++dqNNMHCu40lqyP4OmK2NCBg8PQsl
 hf6w==
X-Gm-Message-State: AOJu0YxqYO3KqJpl6MqSuEwyPVRJbrcpcT8na5DXIcQpQn0eXwz9Pa0/
 6ba8HISGcJJzIW9LvqKCAdODK7uYA7Mxp8nwomBvKVLthvxdgCoSxBdo
X-Gm-Gg: AeBDievNqiDdCPR9z2ocYNFAnh24teQ7EUCX05X+vsMFH+9jNNp9AJ1XOioVD8Dp8f0
 MBp8YIR9bjI1nvbgqNnj3blqjcgVnKCqBLDAENh4GKyh+OHCxv4JYFYy6VvyAtsJvUmAteeV+xE
 fOELyCCjTPKL5f6WbbSRDFKqblbH0eOlqnRzO0fw1tCFFPf02HZBKT4QtJAzhYtVT295TsDj2bw
 GMgKyp/dkBAKFNH5jhL/6KubsXDDLDfJI8rSIL7v/0dPJhq15P2fhcpcODhqpLUvqqya5xAMK1k
 lb1KST//9FfTz1Ef39Ie+//PK9ULLAhwkUprm30f1uAVyM/WjKR0mxwvIu0ThJAGudpOAxwuTGM
 khmRbC5mgDFn03tYxHsk/ptKx8wgjb99Z+WF1t+OwkvbAYbXJIZtQ9UlaEQqZnXqwjptvIegyeq
 NYNcDjh1Qh/NMICu7a7c8yLKI3bh+Lqi5cMDT9Pm6Ea1+ojA7FN4OVj/9MoOVqiV5d793vPOp4K
 zEQNB3diPQgrWmPxLc8wr5MiKRxtNqFjOD+31fv0w==
X-Received: by 2002:a05:6214:3d0a:b0:89c:6a86:e632 with SMTP id
 6a1803df08f44-8ac861c1a0amr326172926d6.18.1776245069382; 
 Wed, 15 Apr 2026 02:24:29 -0700 (PDT)
Received: from
 runnervm35a4x.kdo4uim0ecfu3i2wm31vtr4tyc.bx.internal.cloudapp.net
 ([172.203.196.181]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6cb9ecc5sm7502906d6.23.2026.04.15.02.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 02:24:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Wed, 15 Apr 2026 09:24:28 +0000
Message-ID: <20260415092428.3884-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415080623.164440-1-rbranco@suse.de>
References: <20260415080623.164440-1-rbranco@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Use two-step handshake to probe features
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

On Wed, 15 Apr 2026 10:06:15 +0200, Ricardo Branco wrote:
> userfaultfd: Use two-step handshake to probe features

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=499941

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
