Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D920CA5FA1
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 23:52:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D768B3E596C
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 01:51:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDC863C9F01
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 01:51:42 +0200 (CEST)
Received: from mail-dy2-x0b.google.com (mail-dy2-x0b.google.com
 [IPv6:2607:f8b0:4864:36::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D6E410009F6
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 01:51:42 +0200 (CEST)
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-34b2df0dd39so133311eec.0
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790639501; x=1791244301; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ky6vo+MMcE1Opl38EdAepWUTxjqY9TplOxaqMI3ZIpA=;
 b=syokANya7IpV7SSRAoMc/PCRTLnrGiFyzsYerX1KpeHuCLVGMExOw1qZNa0jKalyTt
 gvOB3bkQF6FOD9Zwzqm5DTOLlaIfWg/TpEddegUtUExD5B5XNP1c8/H7mxF1Ns507ItX
 3NQEaPp75pP5zfxbe916qq2ioZROB4b2r6HxOZ/lReklWpZ8IJuzyYimbo6hbumAbGSJ
 /h/j5vcELHqt8U6Qsv4x64OBZb+WL3DeWeUy3rMRZN0OSjkCAkKQ+rsGvtv6t4+4n2JI
 5qdUfAaw9S5J+7hv0g6oljQxhuyQs74cyGWSzWf8r6t+/x0EsTrWxt24A+T0Ny1gsaZN
 un1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790639501; x=1791244301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ky6vo+MMcE1Opl38EdAepWUTxjqY9TplOxaqMI3ZIpA=;
 b=HhZrR/08/TpW5jIV7O+2V5dHzXCy1LplPG8dRUtM8NdiYE+dRw447xUJfH7cq734NN
 JImFPhk5gCB4shS4I6OjmBJ2TQuzkhQRHF0BRSn49XK6wK86qJw5GKaVZs5eKercbHhf
 h7yyqmS7YvOlfQZ8WiRcq5ALLhRgUNbGVfvwJV1nqUflpMLS1+EKneeK1MZsAX0Kfhnd
 rm32fLMvKHzS9Z9aSWmXoksNxEPG5QFRRXfDoQW42vPn48qsaHei2+5iZdgDNYoD+vXw
 DyDA73K2Eg2SLO/Yp4p9ycWRhJSlt2eBeXezSrVnNN2jPfGBdo1ybLXxeijwuHLUSQF3
 fm5A==
X-Gm-Message-State: AFq9FYIOOHNc0+PfxeARAvYB2H6DlaUq8ajHT9kd5T7zlKL+RPKWOrG6
 m5CCnImkh+pJ2XvypRepitczsRGAWFRD5wck69zqN/mBXmlQ1nnrl9Ee8tR7OA+K
X-Gm-Gg: AYBFou0k+HxA/iwEh7cPk5vL/MhgMzayJ4ngY1HYONkudXpWOzHrAAzvNOfTxoVFTr1
 ho3g6RylwbW+ktkrb/EKkGiZuHB5FZoirR1HpiE3nbP7A/sJTykjqg6qevdt4LoUdtN0QXki1qS
 A3ifNngfkLSfG5ymx075bZ8jbZsRDvGto1+plaoOy0EjOo6g25ehy8hjIZk8HXuI3g9yvpMk7yz
 KNhJVzksVLU1ZOjEJqyIQzQFM7RBKUAaKy404mUwFrLbPmdDsp+Sr8VcoIarGBTtBdLZoA1hB/w
 Enz6C42WrDdL/u3jcaiMlD1nAIJ/jG2DNw6IBH3JdLdiddMed+gYIs9Ocr88h6E4XTvWX91A0hz
 l7BN5+AbGNuq3Rfayy1WzUHzdqVojYOPcElQ8g6uBdKUTpNlLpcL43jw4T+lkyk5nbm3auCk516
 eLwW6ytLPiqCePprXVDqwtPAnC3+ul4/EER/PThH5svcHnWQ2TCyeIZs9kkRQ0IryunwYnxKgty
 mQFgd79P5f1eIC16KJSQaIUGdREuUcUvxg3Q1yDZjWNbDaqVKAsaRm8SB1HuVTDbmUzDg648Pvz
 PWS47nz47WQ63Q==
X-Received: by 2002:a05:7301:712:b0:32d:205e:31b1 with SMTP id
 5a478bee46e88-342705b8903mr10944629eec.3.1790639500631; 
 Mon, 28 Sep 2026 16:51:40 -0700 (PDT)
Received: from
 runnervmtr4k5.4sxkbaxg4qtuzo33vupisx1tnc.dx.internal.cloudapp.net
 ([172.185.150.248]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34b2b8a57casm668132eec.7.2026.09.28.16.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 16:51:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 28 Sep 2026 23:51:38 +0000
Message-ID: <20260928235138.7953-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928212713.2832800-1-anders.roxell@linaro.org>
References: <20260928212713.2832800-1-anders.roxell@linaro.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_clone: Fix child detection on sparc
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

Hi Anders,

On Mon Sep 28 23:27:13 2026 +0200, Anders Roxell <anders.roxell@linaro.org> wrote:
> tst_clone: Fix child detection on sparc

> +#ifdef __sparc__
> +	pid_t parent_pid = getpid();
> +#endif

Use tst_getpid() instead of getpid(). glibc versions prior to 2.25 cache
getpid(), which returns a stale PID if tst_clone() is called from a child
process created by a direct clone syscall.

> +out:
> +#ifdef __sparc__
> +	if (getpid() != parent_pid)
> +		pid = 0;
> +#endif

Calling getpid() in the child returns the cached parent PID on glibc < 2.25
because the raw clone syscall bypasses glibc, causing child detection to fail.
Use if (pid == parent_pid) pid = 0; instead, or use tst_getpid().

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
