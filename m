Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76653C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 13:53:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E2923E5C66
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:53:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6001A3CD4AD
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:53:25 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F3E2C1400DC4
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:53:24 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8fd49c74519so3967086d6.0
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783605204; x=1784210004; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/8BMnH71qSYKYQJhJNMscoudOpDRiRXMKe86ZBPWd8A=;
 b=ZoMnZBMq1JAxjzX+N4DCa6HfQBA82XlOkucTZSJtI+DMAR+/cTpKxK3TzD5hqvxX9e
 WRiI3hbbAaunGoS2+J0eYsmBECZoZSgW4yDJIeOIo5F6DYTJuLpxr8wEocqrq4VxmhxC
 +o/zDeh+CNUAsboVxA1QHFVYX9By1rxYqWcOPVSlr9MAMAXCtH1IcCfzCTVfqPBiTUQV
 KiJKi4+ctO4Z5+IG9W9l63EKOX7Ss2QQPsZ6Ot5kfHsA1r4/gW836NaD3CSduUUbckhz
 IliI57aLeSI/+cKqmCZK8rozJZuDFTlbfZHwCFdNCkCaX2TbkJzsZqdHVpRKqYnvO3QA
 einQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783605204; x=1784210004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/8BMnH71qSYKYQJhJNMscoudOpDRiRXMKe86ZBPWd8A=;
 b=X5SKOouXDrcUj+JPi8Rpe5pCZefFyxonqQtS0jNjpXy94maXvRpK0ihDFIc8kgOibM
 8i3QThiV5coazqC4l+vTf5joPbFResTVgXZt5u09uUQpX1sMlpOaURy4BtDPjbfTde0s
 0QZXGFP7Uaji7Rw7P3lgvftlyKu9zHa5SzLnVNj87gDH0gBLaN5uNP7OOQf8Xde4eQIv
 McGrKhnV7IYnTzY9iI/o9vjvnHUWC32kW8PiKoAGYxrgyOeHU0VmbRwAs/cHbIOz4KxL
 cwjgoLdO86fFf3d4/9/+Zn8DJHOsF7xZMpPe1kHwN8ZsxbWS/k5+mMAGeJkKRbo/PN1t
 +xGA==
X-Gm-Message-State: AOJu0YyDgIUBcXB2J/E9X8Mit3U2VS5kZ6jZBD+tXMLLOF+khwEuFkNU
 idwSJUBgxecsGprX9WPi+D5LZdVYcWHZZcyY/bU5gMX7MZZHBII/yCCz
X-Gm-Gg: AfdE7cnKZGmhHTBQrOTUoq6XunHWBwrtgNsviMWGczSkuue7cNl8mvDNliLIfSgauNd
 E6aKwoyYLhdMF7Hm6WO9xyPQjjSfN569hPsP1e5LLQzUxqAZg2ZL837zr+x8HdPeSY2LSidqUiv
 CKdoXa340HwIUhI0eEGznB30GRcMzyvxkvyJHiiGJyQaCtakXpU2DqFVBxCGKKSxlqktMvdReub
 eEWoivFzWie9Rz+UeISIHPlPxD2IfwsFH+9Piz+ukJX1ISQ/IeYXMG2Bm/mXtNSG14CeOoYwscu
 uohNUPnyH3z4ukZYS8gUCnQdVItfeHBjPoeHEvOkDugbdMt+LFiQmRu9Szw+hRrZPHffTqQZ7rN
 j1NsE9HHboEjopUkyDIC6GVNg+tKvQ9IEz7CtzHJVXaZkEJnTajnKSBRED9MF9AxeaOQkdKlAQY
 qAbiLWkfmQ5zp9cwlFENSM+M8N2sOpHNKbFTouBQDgaEckPUGjM7xqf4VPDExDJFEDhg35WGywU
 yzJBUGkyanUO7BLlDZVQ0gQY7liSA==
X-Received: by 2002:ad4:5c8a:0:b0:8cc:2a92:48e4 with SMTP id
 6a1803df08f44-8fec217b8bfmr81323326d6.32.1783605203676; 
 Thu, 09 Jul 2026 06:53:23 -0700 (PDT)
Received: from
 runnervmkkn4f.4qvv0lt3cckengxra1ydaipxhh.ex.internal.cloudapp.net
 ([64.236.200.229]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd57baf98sm18279886d6.17.2026.07.09.06.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:53:23 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Thu,  9 Jul 2026 13:53:22 +0000
Message-ID: <20260709135322.3977-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709102837.54583-1-japo@linux.ibm.com>
References: <20260709102837.54583-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] kill11: Skip pipe-based core dumps per signal
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

Hi Jan,

On Thu, 09 Jul 2026 12:28:37 +0200, Jan Polensky wrote:
> kill11: Skip pipe-based core dumps per signal

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
