Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F839CDB470
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 17:56:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 867E33E695B
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 19:56:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99C9B3E2CA7
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 19:56:36 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C1A22002AF
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 19:56:36 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30c52cc5285so117941eec.1
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782237394; x=1782842194; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gg/jy+AoUOXbV2TzBvc3h0hAtmiGpP9bkSwslCV84KQ=;
 b=qylNk/azIt4EmP5i2bxIMIVnVYObTLBLsLBf4yj2d01QFs+QlXekGBkC0poUwUjems
 eAfzfMoU/pu1MasHu6qgzSJlru6aXmIY1TPOzkb2DYsWxaEmL/44SwrJg5Hi9/mqVLTj
 OqDLoFgsBSa6Rg6l7Am9+Z9grwLmW0uwIOhr37qlqn1P6e/0RKNeydv4ZU+8kgxpGg8Y
 YcJEh/dayPq9ZyZZSHke1FgLrefP4MpV5/9iYTIxsir4P5QLJ7jCo4UBi23AADoAEVw1
 4f5Wi8YYFVttqFamUUWnJT8QfdSFl6VLoGY1Kr50+qDEvAIowXkY88cPoWbdqntgDzCV
 5F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782237394; x=1782842194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gg/jy+AoUOXbV2TzBvc3h0hAtmiGpP9bkSwslCV84KQ=;
 b=PTgDsE5y57l899OF/a2Y9sLzEScnbutMy9UjzKIExScy7A8nx8Q/VrPGjauqX65mz0
 A/KWJuIdeGq2JH9+8u6hP5KuCF73qx4iT+koS9jizPC4AsY4Acyk6KEzcYaQ1htQu6FN
 ZRmflvMEyxSFU4GY4fyPw/5HHrsCCkx74B2mW5mENQfrP6nhp9m8PtacKZUt1ARg4Zxd
 QwCLnpkUalMm3ztGjC1UQ5UwdcLZQJNLHGG0tA7Lk2RWqaG/RpDOQtXC7zSt/GuTofM9
 DJmlzOx/ntqDKkavozRbKxvj13IEmHWFOc4TXcUdEjBRUXCe/nQP/QXDZIHUFsI5t9JV
 0vpw==
X-Gm-Message-State: AOJu0Yy/48+K4Dok3YvyS7c0sEAxI5YvXR06KbO5Nl/Tn/TwAF3QBCSJ
 8N59xXElEjqmADYzFTZdKUe9dduyuVu3xiGSG06ZCVOkGH+8+cnMDLBCw9fadjFBpSg=
X-Gm-Gg: AfdE7cmX7qzNvO922VwA6LDhq+VAqGoNI+u8teLWqRZ5LMQz25uobFUyAs/rWbcqvgx
 BTezFiLBEyTV/EDcpFcGZ9a+Dpuh6axS9Y8HGqWwrbsAzHUGjSBwoca4gzsYaaGMgmh3BVdcnOr
 6ImnyFAwZDONbU2RVz2ZgwFuiJLiBATyOaSErjdmFk3+EGxjdVRx06zAzuwTuIjFT16CcU5J2fD
 X+9aCmCEgF1ieFqvRHcTzZYmKEwqotC21O2Ub6qz8+5+NeSUTIHuoQK4PsWxyOmoZRrmIvthQSl
 D+TPLSqUSoICiOx+eE3V8U3dv/7fCbW1ttzCU15smTXWnBU9bOzEU2AQSdSZD+9fVpo5rXDrH7+
 xQ4JGSoixUj7xz8/lIf34aQoGFgeLcuFyoxHe1TYu5iQUmEh2Aw8uQslB/WXwHTF5+PcppSwz57
 G+cPSnxuZDX7UnkWGZu7GZ0yGM7COTMUoMOetFx3/AdxJAywCRg5E5g75PIw1FkvtIfPv3KiYKT
 YJgNIQsVpuBd+XwWrdc06Ut71fX2/7IRRV1cL4=
X-Received: by 2002:a05:7300:ac82:b0:2d9:a799:3c4f with SMTP id
 5a478bee46e88-30c69324e5bmr56143eec.24.1782237394269; 
 Tue, 23 Jun 2026 10:56:34 -0700 (PDT)
Received: from
 runnervm7b5n9.h0zle2lkrq1evn1mioojdfzlua.dx.internal.cloudapp.net
 ([52.234.45.177]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba1c376sm19411832eec.3.2026.06.23.10.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 10:56:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 23 Jun 2026 17:56:32 +0000
Message-ID: <20260623175632.3882-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623163144.83028-1-avinesh.kumar@suse.com>
References: <20260623163144.83028-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sendfile09: skip on native 32-bit kernels
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

On Tue, 23 Jun 2026, Avinesh Kumar wrote:
> sendfile09: skip on native 32-bit kernels

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
