Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E9DCD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:22:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3A673E5BE2
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 15:22:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CDE03E6CD1
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:21:57 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C8446002FB
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:21:57 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-13817614cd3so7047508c88.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781529715; x=1782134515; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uThMgYkU4CdK7aukQzJucZ1s0nVyvPh2Dl19cGXLlZQ=;
 b=kNDNtUpyjkXSzsPGhmXjGXQCGSNmAtaiOOmoVgM3E3Aw39dmYVK04npZwYUR4+rpRN
 KOd2KffDP2YSWhNqUUa2JrzWPkTyF1ScjXpGxBWkQsqrjthmV5IZaETToMmOMo3Hg5j7
 m1V+O9H56jqH80dRl2qDYKQh0LtMjKLB095cNijRzt1UYtNf23lG9yMUEVNU7ukKsVxH
 1terYHakYfI8dCGWdImm4JTo4dPJjbYs1MpcFJPZ5yvH5iMiBtVMXQnIv6QT02x4IsfO
 MeRh9TG8lITw0hmN4TWKT5hoyxuzBfWuHny4j4J36lJNvkVNwCnQKG5rjQkVZ0+ADN1w
 /fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781529715; x=1782134515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uThMgYkU4CdK7aukQzJucZ1s0nVyvPh2Dl19cGXLlZQ=;
 b=jkNCXL5dyMRJR5UW2pxcN6IWRI124S1p+6eYWC/cGTVoC6ZyyUwK6Ow+gUEIXAOXpV
 QQoAOPDJvBgIHr6Cy/KJk6vbFWtUPW9HaeVTQEIGlOoMaEIP1qA+j2sng/Z793sRQuF0
 8H0Hq2xeVJZCbNrFO1JuocRN1W4TeVs51sj5ufY1PpFv4k6JFa3grcqZ1bEcqjWvwL6N
 ZFvqYCgwMtCYgNWco152RwUd3F82qP1P2LvGZl8GhXfLaLFBpTN4xANIcDs13qfgrKlW
 vW1YCxp2uPoEc3H3dYRZniORmv4PVEwQSLirg6hV2WmPwqEJzCxY+fKEvjUrAur9G4L0
 42UA==
X-Gm-Message-State: AOJu0YyHUBK8Xc1rI8ZVGL4omc2sNKoivHgm62WjK2nTpmuXOn3dS65n
 DnStxuYubwdlWNtdpJYm/l0s8tXZDiFkthKgVdBGw7U3o4YbDPCbqToE
X-Gm-Gg: Acq92OEPUmWiQtvO12x5LWh+JZ+3fXbSN5XvSYPNiukJyGnBGr1kJ4oNq645DIQmbN0
 7TTm7r4rXJY+UitoqJvq5fmytxClla2EiSFmgc0FdIFaLELxTFa7M3bsFWxXc83vYhRnW6cAEdK
 7/jrO3YZg6QSIK6BT9ItIvERWn8cVL5Efr/MPVGROJcXVM96zRYQLHIXzCVvwplfTmn+zI0atmF
 CRKkC5sW5CleFq5/1wXtzbioDlsVTfcLqTJekfe2uC3WvI3oGwWjMUUAr+0BjD2PO3nNdKIUgzh
 4I4PEILGPy+yvxpRGKmIgqGYbO34H7qvbY1TUiFficLsk8t3/wAMb0rJFznUr9yxlLf+C4WcDBy
 qu8dCaU75/T7hsSbAErPxOjhnhts72OWh6lWl2Y9KGcpsMvWGsGdSF23pvEZHdzd/OSbwmqR7TZ
 t9cgxcoLKEn1co/LnVzok7Q5k+r0VmasJ4lwQL+9ObgJBRqPUXvSrMiibx9a744gzKlFdrmcoLm
 fHkBcTd7PVZK/nuhvloSrgSCFGZsIiDQwMy/LZL
X-Received: by 2002:a05:7300:3b2b:b0:304:e2a5:689a with SMTP id
 5a478bee46e88-3093ec3e358mr6205004eec.21.1781529715218; 
 Mon, 15 Jun 2026 06:21:55 -0700 (PDT)
Received: from
 runnervm1li68.ixwszk334gquvkza1ve3oo5und.yx.internal.cloudapp.net
 ([172.215.209.70]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e91f878sm14663246eec.17.2026.06.15.06.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 06:21:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jun 2026 13:21:53 +0000
Message-ID: <20260615132153.4097-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615-fw_load-v7-1-d51e607f16bd@suse.com>
References: <20260615-fw_load-v7-1-d51e607f16bd@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fw_load: Modernize ltp_fw_load kernel module
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

Hi Andrea,

On Mon, 15 Jun 2026 14:12:45 +0200, Andrea Cervesato wrote:
> fw_load: Modernize ltp_fw_load kernel module

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
