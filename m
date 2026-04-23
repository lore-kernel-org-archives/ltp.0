Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47C7F99360
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 09:37:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A7E43E5376
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 11:37:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5ECF3E20E6
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:36:54 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 35D99600784
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:36:54 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12c8f9846c8so5645380c88.0
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 02:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776937012; x=1777541812; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnKqlguuFdNkTyCKqOftY1sBiNhKW6D7q91apBPNAYc=;
 b=fY10TcmRaLq5MqkkyPVNJj3G86tEqiTWE/CyA5CrsyaAOMorOBS5Q0jkzDMBWQsCZf
 xZ/4m033jObx25zIziQ/wLPCHySt2lnOusPxIvpZRDG1VTlA26kPOONenTgqL4ZRatd8
 sGdGU6DN/AxnS2mD0qokAJmv2X4xZzjN+73ov4wWnvmyX9helbLgzZNKRtNub7h/bLSS
 BpMFKu2Gw/0ILaZaiDaHMNdJRZ2ZKTdUM0eHPUjwZVfD/GCaaAsPWxq8ZfoxyP2qnXts
 fHw631ZOX9goKKurJ9gWPAU6Ghn6IZDCB6cPQm8vyzUOvICvaFc50MPw0mk2KHMVZ8SF
 D+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776937012; x=1777541812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FnKqlguuFdNkTyCKqOftY1sBiNhKW6D7q91apBPNAYc=;
 b=WLRzzbvWJmumMvBzjjrIs27NaMdueUGVI98MMtWNIEsBO2lYWztD1J0dfXK5bZQl4E
 bXMfQHMXUGngfhmJk0vp+K72Thv1OGRb6R6xTJ1jNJH7xBEzOrHai98BOMpAAJuilMOe
 KIOw7ltwwrhox6vfa0pkE0voi1kV1uo2Nk0hm0Km3TQyPaQkSg5M+kOgzTcY9Kf0xyg1
 k13aWZ8Wnp2l44M4FLV3/fK7jOPt28Klf7vKnP8MmSXzBYC97UzLR95Q5O5GDijlC3rn
 eDyGAWYag0/Gx1OAAfUr1RuKVH2sYfzP58Ml51WQ34xhAbe3B5Or4DW1MXPidYaFnmOg
 MRUg==
X-Gm-Message-State: AOJu0Ywjz8SufrtVqa/1OjEVNUN8Zlhw9JviJFDNVOSyUd0llCZ5AoBr
 J+VE8aqNzu3vJGGCXDJQaUCiDaJ6ql5qtU+SJbbjGu2wSbGt1zUmCMJS
X-Gm-Gg: AeBDiet9bJhikEttPyGYeArusr1zBaiG6XhYd9wsYJELY/m+wUeso95w1H9Bj7mMEBT
 gmYtsrGy1NTcGuLZg5PpHEn4EGkkA6Dm6t2847TmqaQRl6xoVaUcsEbNZi65TwqXq4PcJRITOdr
 MFmI2bYEz0zDHQrFuTBbpEvymo81hyogLhKLfjj0naaWE0edeWlowgQhG34YDdkZ+59Kr/FAWAT
 uYLPu5JjwfC6BPKQVg+RivKal+lysDdT0JifsBZaymMO9f3yUVtAQeC4wGUeEa8BHnvjSEP5nnc
 5B6y8UEpx22FD+dLPWPxwivm9XPlIZFH388iPoZ625qwqadI2je0ue/2qP8WgO4vM3SnZmcC9tl
 oPI3hGr3jOW4u6CQSHxzBre4sLyv0CDYp37iawHN6fUd9FweXvWXBuU8HbF+3moP+ZR8dEnomeH
 KdZG9baCH1tykx44H5lrUifUZFLwu6ylqzx5eXxzCBzvyt2PXADjrfgvKsUag0fqw+78N9ABKsc
 mFNArZzOs89SOpnT+wWay2/xgZiGj7jVXOWvBYuHiArsUew7g==
X-Received: by 2002:a05:7022:6627:b0:12c:8b9:7200 with SMTP id
 a92af1059eb24-12c73f95211mr14101022c88.17.1776937012315; 
 Thu, 23 Apr 2026 02:36:52 -0700 (PDT)
Received: from
 runnervm04xxt.cddunxfqncwu5ncfdzyn0hhfze.dx.internal.cloudapp.net
 ([52.159.244.87]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a20b9csm27469100c88.12.2026.04.23.02.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 02:36:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Apr 2026 09:36:50 +0000
Message-ID: <20260423093650.4027-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423084123.657690-2-pvorel@suse.cz>
References: <20260423084123.657690-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Ignore empty LTP_ENABLE_DEBUG
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

Hi Petr,

--- [PATCH 5/6] ---

On 2026-04-23, Petr Vorel wrote:
> lib: Merge functionality of LTP_QUIET into LTP_REPRODUCIBLE_OUTPUT

> +     - When set to ``1`` or ``y`` uppress printing TCONF, TINFO and TDEBUG

s/uppress/suppress/

(The typo is carried into patch 6/6 as well.)

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
