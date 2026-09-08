Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF12C79F82
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 10:43:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DCAC3E4E3F
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 12:43:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40F3A3E1895
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 12:42:58 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 610B160065B
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 12:42:58 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 af79cd13be357-930f7b1eb68so313745685a.0
 for <ltp@lists.linux.it>; Tue, 08 Sep 2026 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788864177; x=1789468977; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6L0+OHXB+R3qKP6TtcZEtQcCpBGCDd32x9GlezkC3CA=;
 b=EmOdPf807IaHF/zURompP3qx1NhSGwzlKr1/vtQ04/2L09V29HjM8GEjRPi7LoFgGM
 VbFtmmkT9obiLAeySnjtHlWg/0/CsecRktQBhQ1lfDWveauOna0FYFovodijgIsUiFOd
 5dW31w5EXQX8gPsykw6r5/Fr8a6vHrEPeisSdYuIZaVuRcwICr7//hFXE1IO/CmnA8f5
 HLTZgJLGEeh3vfHWcIo9j8grSHfRR11OwymayEkNa1sZviEoP02yMQTOL8GrcNroLgtV
 KY/RiqWVe+qOCZSJrhhyaoR/ahXAK5wlbrW0Y0f8sJoV7iQUFU7yAuYbyU+61cefZUr5
 Zv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788864177; x=1789468977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6L0+OHXB+R3qKP6TtcZEtQcCpBGCDd32x9GlezkC3CA=;
 b=Y2BjpR63fJd2BxO0hfH7fmzaRYX7oSUlb3sZguBJ4JgnA2tL9BX3garC3QjlGLAeS2
 U6T3crdqhE/kgmC2wb1gjGdMluf7Feq0CizEEY1x9Q8kHzH6s5UWF2gxqc6KS947uOW3
 qfRrOkDWMDYFoOsRO4Rx+MWAgY5wFknpPxcXmkgW0aQ5FBUfctxS6x7QQo2d1YSLHHhA
 32hpPSl87aszdzy3zxo5uUyuK3dNl8YahMatMdBivVYkNWRVcPEvbLYmQlzsXuieLWP3
 tx33ON4HKiOJoGEl+sey+Itz6FUiISPEtH4XEfE3bO2HkRhSE+yGF4UZn8Y40Q0yQfG3
 60nQ==
X-Gm-Message-State: AFuF++nTuKCm+4WdtjF/Pkn/+Z7hEPzfnLxqgoUfQSgrei9CoYps+aVW
 yT89b5XOFCuYYrrWKGs26sKrjZonvYQlMZUYoiUrPxZ3UeA1KISwIeFm
X-Gm-Gg: AYBFou1lWZEjTQbZLAq9S8tU7E+wbxknR49B5FG0RFq1b7Qft4661y9hKHBgZhkSFRB
 fxZNQIoB6m1MmS+l72AsChTPJW/4F+1fyGUQ9QdbmpB3Uj+N/kU5Ki7jVPWs32CQ+q6wFsRu4nS
 SGNktEtxEwIWi5DW8/Rg7C3iTFjtgLNUxFr+xVgySaE8TFb6cXeG1HoVZ/6ReRfjpelNFMqHHuf
 H+D3pvc2pF4CFVXnczKECXx4Rbd3xUuxHTokMLGX+wXUmaSBQ/EPnSyOBvN608S84obRGePvrLR
 mbT9bIAQERmVpBQWWo7b7ZXhSapCGXPoMA8gxo5rBZf9L+nkzRDRE3aEQ7U0RxvWgZSS1P1XCeW
 RJX69Gf4wuN9jlagd3ReAsrERYgxFPTRt5MXJ2Ivhm15DJgx6h79lZju2d6kDg3Ygi8SsuS+aNb
 mI0CV7INvMqND8wIorIYBcpWlEJvwrA3opvKisVz7x5wumsB1wdikXzdskcZR9iPG+qfk33UvOi
 fPleaf2Xh3ASbybU0f3HTyYoUdpDKq9cDvSnqaqlfZY3K8mKhgeRfi/Itf9YChhgI4J0OSOgqaN
 VQ==
X-Received: by 2002:a05:620a:bd3:b0:939:3f4f:324d with SMTP id
 af79cd13be357-939c2fe61a1mr192823585a.43.1788864177152; 
 Tue, 08 Sep 2026 03:42:57 -0700 (PDT)
Received: from
 runnervmejwal.jes55jykdhaenadivdr5v5tmaf.ex.internal.cloudapp.net
 ([64.236.176.232]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb678b8sm1128080485a.30.2026.09.08.03.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 03:42:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Tue,  8 Sep 2026 10:42:55 +0000
Message-ID: <20260908104255.8624-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908092248.15774-1-mmenashe@redhat.com>
References: <20260908092248.15774-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] read_all: Fix buffer too small for long paths
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

On Tue Sep 8 12:22:48 2026 +0300, Michael Menasherov via ltp wrote:
> read_all: Fix buffer too small for long paths

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
