Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985ECC5B568
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 04:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786335435; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+8yZdaF0OOnJTqS8Q++/+gsoAsHv4BjTVxg5sBnRb4Y=;
 b=ER3XExbU1r0XcVblQU/N4YTH0yFDSwz8qBUJM9nD4/ERkdJoHJCMIutcmKlHbxNTOrDKx
 PSX8wGdSvtlmEbxgW4sild8a4qiwc+MYPdkOu3oJ68kiIvoqweltzm19DvkywO7ajeHktPR
 wUuw/PMZ594hsRbFPTts0qDx7NCzU24=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C821E3CB3D1
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 06:17:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 945D53CB2DE
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 06:16:53 +0200 (CEST)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com
 [IPv6:2607:f8b0:4864:20::1045])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3448E1400178
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 06:16:53 +0200 (CEST)
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso2533933a91.3
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 21:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786335411; x=1786940211; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=flZsiv2Jxp3/cZlCgOHd7gwTQDDfsXjd63hBw7m3t/w=;
 b=o3LXpX6Bag0izIt4/H3VNl5IUTnde+E726CQuLImQvAvDly6a0d+OgJ6rW/z3gvKHO
 VvFKHhECQl953Id642L6Mu2MGldGwrRI5W5Rd5jJldGOpONwenQYkd7VNHurxmVY1Hhz
 Y2Q8zvZ/VMDwxGTc8C6KRtQyHuRZPp69VcMJg/xrF2pBMkuBzlNN67CsNP9880VwWObS
 XWIABAPlllta1f4FkKpIJvPQNQ/eJWOF72cetv5vWK7C0RaAhvfMFizhPqrnVpU2/+28
 ALC71YIbFka+jxvSTNI6Gvb+AqyYGdJPpfYjVZ5PdiyhDPoeGNyzu4Aeu6538DrVbgOS
 yvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786335411; x=1786940211;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=flZsiv2Jxp3/cZlCgOHd7gwTQDDfsXjd63hBw7m3t/w=;
 b=P1/5S9kbbqBUVsg/JVQwQqOl4tv3Az3gN4Yc6e+rNLYu2DLgZKYBmyoNGm28jtHCb9
 GzjL3fa9S/JjTCjZsZzegij2+AvrnvstwpF3Yji0qnjCAQ5Prw6dKqJUR/MP/kaQ/TLG
 iPAFVLE/TY0X639pntFy9NulZ6vj/R2QHKWzoM/5uuIyGtAkZH547mG8v0g47gfdCSOd
 xTDpYsbxLir8m2q374cs2JMHLIdMS77AZaKB6ObBmOXm5xaKzmlfNIiguRjir7TO24rv
 Q7iDz6UAWFRRLp0DY75mmzEsuJ5LLy5hVg1iaxcT+MLq0+WNBFYn/KhkFfQWk2Mw0KBr
 NmuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSTtwJxSIsRxgdsvnTNL+eJ00C9XZPO0jbdZTwLzojNoVkv+H9O34J0Y1A5CBOeQEVlLE=@lists.linux.it
X-Gm-Message-State: AOJu0Yx4yeEeGP8P/DpmCT4mfuYgHDQUkwyHbIs8XYz0OPaiPbaXmJ87
 9N9T1XQmqfp8A1Zf/u2hZ8rxWPfy/hfTtDdWWUe61CA8flm47kRgmjw4ZPZgzBMBBso/qRK3Yco
 jlQ==
X-Received: from pgng12.prod.google.com ([2002:a63:374c:0:b0:cbe:4e21:813e])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4309:b0:3c3:954d:278d
 with SMTP id adf61e73a8af0-3cb85df09e3mr42605556637.9.1786335411186; Sun, 09
 Aug 2026 21:16:51 -0700 (PDT)
Date: Mon, 10 Aug 2026 04:16:49 +0000
In-Reply-To: <anlLyuZW-8dHISLB@linux.dev>
Mime-Version: 1.0
References: <anlLyuZW-8dHISLB@linux.dev>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810041649.1714200-1-wakel@google.com>
To: Li Wang <li.wang@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Use backoff polling to wait for loop device nodes
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

Thanks for the review.

I agree that LTP_TIMEOUT_MUL=3000 is an extreme case and unlikely to happen in practice.

However, since we already sent v7 which fixes this overflow cleanly (using 'unsigned long long' in the macro to prevent the wrap-around), and the AI reviewer has already passed it (Verdict - Reviewed), I think it's worth having the more robust version in v7.

Please take a look at v7.

Thanks,
Wake

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
