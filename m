Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40EEC88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 17:42:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75AF93E9489
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 19:42:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CE1C3E920B
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 19:42:13 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AA2851000237
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 19:42:12 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 d75a77b69052e-530e0062c97so2256841cf.1
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789148531; x=1789753331; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=edKrU1dNClNd4yg7va7ABgRzSnwrXMGyQ+6gYJrhDDA=;
 b=qA3e2JwXtHDmNu5JftTyZnStuvJq2+i8EeT8HCLY4t5exYA9MaNLJbncTyF3XEAV4t
 /IQeVfN58scKcKz4+bsk6NDUkOr5Ir2O110a3RAMSHp4ZzD2qUFnkKJyE4Ph586RxnuN
 CTl9DViaotF5QgxaBVdx4VbzmU+NRGdlpcpkv4djwKRTmEV7DAA3rcgArfHvy7zJKlqW
 6u4+pPI7oDwmaXWyZNs5+aqUb0qTGgsmr4uiRfjLzQhiva7ckwzsQDChQr0I/WJWWxIN
 AyxdCqqNqQettrg2fFJAz2dV5YVmxjm1WptmKqRkIEdwiCn69hfKgFFskMBZk3evBdEb
 uG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789148531; x=1789753331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=edKrU1dNClNd4yg7va7ABgRzSnwrXMGyQ+6gYJrhDDA=;
 b=Gl9Gb9zWcUM9dIwaGuuLaRlYerng6fX/0CiTaVqZKNpXAMuLhGaj7AC5cGBnVNgGnq
 ZXnZ4uZCzlwMyqOPpqd9GJYE9fqHXv/PLTB0u5kNl4uHJXJA3zR/qeh6HQ0mj0G0Z9JH
 /mkdHhBQFRy3fnBWpRrZMqYG5OUE4TnOrm8/5ggt6K6UxH/zWxyb7+8rXJ2sJSef4jAn
 JMfLgkgWotF8W2m5pP2x2wOA0q9feVanxiP/n1E5PpP0cogVvuCOq1S5lm/fbPs+gTFc
 E12adWzenzq9VkVdWoQ3LhKLVFXucIgHXuiwzCEAcBrMtcR4f8PRkS4XGfW9U7mXJ0RI
 eVsw==
X-Gm-Message-State: AFuF++k8sr1GxS9fHsdZGbNU0VW8VVw3+SKRUW8SA47Iv9iMHjUIWzj7
 Kpc0VKZCrtfEx5rxtVxnAVZ0ZPckdRlbu5GaCai9792p3UUMC1HSt39e
X-Gm-Gg: AYBFou11MIL6sI74Ln3tMTuRpQwy4s+RNcPQuXu1WfB+8jTW1oXaVNl/HbEO58rOJk8
 69qltTWNlqSptGaULOxw5fuY/EhLYPcWXwAzmTH97/73bDf6lf6GvB5HIZR5mwfbw0iXiAqRzkp
 GjD2ZpeO4fb18vjaeHUHf60Kjx+wjfoieOf9rELI+aTqZJgNBEdN40QlmG9AW9Gxsp6uuQvw8mn
 7EZ5dM5f+38ekHZ+cy14pqXmn7zYazSOeqXllOxx86j2u/4S0IBeqQd9veDpxuMK/H3YtQ11SLu
 jphTyFWg9Z1+wHVCbOmGyZab9bGOGFG9bDbuZ2xg0BMCJj2T32tFsbNrCEX5Pwn612yV+SbNfvW
 x70EKhfmCc83KcyP3+ljeds79hu3+U0rbVQ7CuFA1W2Gp2YpS7lmujSRx+WD0sNP+FMtgjZ+Mib
 hcgrJx6IMoFJpLo+r4UAGqbLrzLPJyxDpnxslIPVe8MUlIOUBNZ3CTJi68RqFeH2Eht3EqzKM5P
 c17+NhptZ4UEqAWBWqwuQ0e3GKP8MetsH5nnZBWesvR8ctkhdELTtJQvcJMQ1VnJNxnXS1nfFnf
 iHKd9ZmxOmWFAnhAiBLhGtI=
X-Received: by 2002:a05:622a:351:b0:51e:e5a2:ac82 with SMTP id
 d75a77b69052e-530c85cdd26mr86612561cf.23.1789148531245; 
 Fri, 11 Sep 2026 10:42:11 -0700 (PDT)
Received: from
 runnervmlun5p.uija1hs0nz2uxaixrrhkeiq2kh.bx.internal.cloudapp.net
 ([172.190.102.83]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530dfa7e000sm8706461cf.21.2026.09.11.10.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 10:42:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 17:42:10 +0000
Message-ID: <20260911174210.11289-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-mmap_32bit_coverage-v3-1-b0608349556d@suse.com>
References: <20260911-mmap_32bit_coverage-v3-1-b0608349556d@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/mmap: add MAP_32BIT fallback
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

On Fri Sep 11 17:29:53 2026 +0200, Andrea Cervesato wrote:
> lapi/mmap: add MAP_32BIT fallback

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
