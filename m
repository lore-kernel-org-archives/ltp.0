Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0876C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 04:13:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CD6E3E754C
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:13:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3954D3DC3E9
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 06:13:40 +0200 (CEST)
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A99D960066F
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 06:13:39 +0200 (CEST)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-38f25802c19so664756a91.1
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 21:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786594418; x=1787199218; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kKybxL8+Xj4bCqkHWuCr600okdkmfnU1D64fGz8bqNE=;
 b=Jt4ae95B4hTXmhQ7sbyDm/jqv/jOYGXOVv1Cb4Fj4dXB8sYYPHfFIzCujOnAcysQJk
 Y35KoRMr1C48sA9mMtvFT+aQ/XMUP0R919e8/rTlmmZEyNiR1RzbGcx4WNsYi2hf3lGI
 mmD6sBiM6RPjgVZkT4vF+kEO2cDgXvYYBpUc/1gYONyIwwqvi4ntfyERmubiblJl9fQT
 L9qi0241YsFEN/1ajaBzbN7ZWX8TF60tK5FKjdYQYXlbrndAr5D6LBhAUPO1emrDvrnS
 clf0z8izaNSnW3BZWQJjm2AmHZRvAb10C5xdHANcVYCqPn+ryn4cxFYpgdcaPQUPNCTP
 Bk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786594418; x=1787199218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kKybxL8+Xj4bCqkHWuCr600okdkmfnU1D64fGz8bqNE=;
 b=ou6bGEmPkpF+AQHscIcvdEsrxxgZT5VRh3yQjcZVEnS9hl0W2kJnFMNq0bYkI8jt++
 y6jcxJYCXbTfm0Pt20xUv/wmme7VvRQVwfgNUfmuMM0cW/nHoR5tZuGTgrS33tkUkA38
 dhT3n5q4Ouk6EjzZiDm/8v81KtfMMEG/Qkj0TC+k1sA3+0crASAJwIxhMKGvYZOauldS
 0prC2v8mPQDOaadWdWc21Y06LEolIObSVJoObw1V2J7z5ry0VKgtdBpVGJjC0h9KE/N6
 goAVT2bZ56Xt3tRCkx8h0/vSOUDVXs0d87ahdQ3mv7BJ0BQfN96NEigQYRKsa8A3eO25
 BH5A==
X-Gm-Message-State: AOJu0Yx5Q2yS6bYcSV/+ftuI21tfiNJ8EUQCdITnBpz7gF2ac7z2wJFg
 T2+Qc/9/pK7i4gCDjpWbeI11pj6hQWvW2K2fhEFQqjlBdLMBI1+KCsdw
X-Gm-Gg: AR+sD121/Mmju8cNobxytVThtwWt1Yint6a2g4jApseWW/+rzz47nQVTDRP2l4LYwie
 ucCydu5KmEPMOOBhdDUGan8gjXnOcVqJ/+npKkv3jCz6QTpzjKpIs5/AF8KB9PYrH1oyo/b+FLC
 bhCm88STiCJT199xcV+8XnwlYYJrCKj2rbJJ7/Iknwdz1YWSIqUDRukUySVzRJcufVU/gYeMy03
 yQP52sFrBVtWG/fZ9Xvf2zfnraK2DvivPx+gKIBtwelnsM51pXekGfzubbmfpLVWeKCvd8rv/ME
 Mq7MySmgoxTQPuLkxfdjpgIWLnW5zY+GzwBxioCSTC5W1vF8Qq5f3H3J3KRVeVjYBRW9rLcEAoW
 y8KN5prkIZ4kpzgq6/H0hESm8FzPxQ+ui6z678D1s2dsP2HmVA17zEomIAxHkLfakpnaTXlcmiB
 OPo4uhIoGaKnzqJQ6/vkQNHKAQsypCaYpzWPj6BlcUVZDhwRzYR9ZL7GRco1RTTKoE3uBml5MOa
 cAjnB3J3n6s+5KHe8vKLGzYuN3AlM2LXjCck8WSy8vc/tEzzevSqBuFbFfLqAullryceod/yhIB
 IRyU
X-Received: by 2002:a17:90b:5910:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-3931e31d0c1mr3695484a91.20.1786594417897; 
 Wed, 12 Aug 2026 21:13:37 -0700 (PDT)
Received: from
 runnervmvrwv9.jrxjczydboau5pwkoq3th3lkvc.phxx.internal.cloudapp.net
 ([172.182.192.146]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412d8bcfbasm3852771c88.4.2026.08.12.21.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 21:13:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Thu, 13 Aug 2026 04:13:36 +0000
Message-ID: <20260813041336.4258-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813023216.79848-1-li.wang@linux.dev>
References: <20260813023216.79848-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscall: set FORK in tst_sig for some old tests
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

Hi Li,

On Aug 13, 2026, Li Wang wrote:
> syscall: set FORK in tst_sig for some old tests

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
