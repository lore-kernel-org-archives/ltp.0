Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBABCCFA13
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777544395; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=efIqYTXDviYgXN0XJPVvGwPcZYnN7bu6W1Occ+Y0DeYydvyvzJJtYElLz/YpSnb9m/FUd
 klVUeqKL2fL0By1KHKdFfb/ChYNKi3ClLqB5/eUwKf6zRNXU7J4XEPslgi9sFJ9AcNVydC1
 RWPBhrgYo7anOjOWRUYh3U7AW7SEqqs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1A5A3E65AA
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 12:19:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0843C3E180A
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:19:32 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A1821A0088C
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:19:32 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so7267845e9.2
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777544372; x=1778149172; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=IVrj9m2taxhFZNfpFRENATg0zsEBLrDq3UrRQaWAq33Do18UJNME3GNYu15uq92o7+
 nT/kHldQaiD66ffoGd/oiEBsYjeQyxy+ivLrMDwfxqN3DAWSwkzD3CEOzfB1vDJaEjtk
 Fj7p6kaeL2MOpk4PbfSbgwq5/47boMKoWM4NVt9ge3R5s0naywSJkUv92fJkY3PA6LI9
 wfwIU7d55MvjDaHlz8l2ojAF6coReQ/mD96pTTbf5YB0nB9IpdWSO6gK1AzH8df0AmIB
 UQQaTZzgjcfBV1+eMtTLtJQyfX8IJzPtpc93Y2KvygDih7LyWHqtIIO2iH4oVPi+Xga+
 LMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777544372; x=1778149172;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=T7jVWKSIKlg+lQx6rXjjXj0WgpNK/60064uXAT+6gH2NgkVDLVx2jxH6DJXQZwDcRX
 cufo7YVAINUNNP+rURPN+NELcQ5NHM/dAQWJAslPdPZqnM+w4e5HKi7zIxlpOgA/1Cn1
 xchRIZtOqxMyLRXyTeV0UM+/TytBAlOGAeux6jjDF89H2goBz1/roTL5q0dt3FGhgyoL
 6QTOrCpAN/6aFVxIrrIbFtXs7vD7c4QSyrbAgJHQi2vCUidbwv/PGf7v2biyEOUyDgFY
 2CrRclOPTJ0Ie6sWeb9ksU1btruJ0P1+v4XL0p51o4kKXZq+8YEDeV/qRzTV4WUkKdBL
 SdpA==
X-Gm-Message-State: AOJu0YwPyvIkXmSrcZs9vTMk0WyD65+8ISfTcn0ilANhxx+EJ06kADGE
 pcLxKKLheNZiLjkk0EHGmLkBhSYPpKuxnqlJ6D+TVKWq7OgoiiMWj5mqP7UIrRL/8R9UwJ6DiAC
 Ck/REKk/SjQ==
X-Gm-Gg: AeBDieu5pCRO70+lE1hB8POcASSt2AqPTpy4XQVMt1GOrUA82jPzxmTb/arXCcU2f4d
 oZYf4ylxIuuhz1Iq64BSKX6EXfnojXzPpaYTmJsKSvkiLKD6QBdXA5ItjKVC95QOFsFnGH6BMEK
 J0vcaBcfkomciZu3uwx6IvSzd8wMJHo6cvRbvDsP1bfyoFr8tmlj9n76xnBFGKrpzUUlzd4XTk4
 x0qYGr5fZFLI52nZxnwowzCTSnCe1zpRrhDR6D2GP4/e1YQCrrg4W6T0A/BiPy4EU/V+J/KE+kk
 zrhDhsuBvCHxVQD8PYyxy1h8C5OuSs7qHuYNUtW7UZtGKowCh06a9CPFsjMhweZzZ/1rjGOsAeB
 0nyy8CUj11WMM04HNgATiOtQ1Tmf62TOUjNvUe400Jr7Y6zw8fybO68w8soinhHkR/p49W1n+YH
 79Nrz8MMmEvpxjqonPenXDmSq8bDbrXHmusyvSUiLRlCVUI7QkPB6DvArhAzNiPJJiEOIg+s51L
 TMpVXAjNE7yFVaxHagAnofbjmaXrtCqHbUdQhmyHqvpfyT+x56royC3T9svY8ph4r8vU9V0WycU
 8SI/LKfILBZrUfIFtnJ0u4g=
X-Received: by 2002:a05:600c:a315:b0:488:9e54:94c0 with SMTP id
 5b1f17b1804b1-48a83d6ec9emr31010035e9.8.1777544371566; 
 Thu, 30 Apr 2026 03:19:31 -0700 (PDT)
Received: from p200300ef2f4fc9007395fc0cb1d2b23f.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm57041195e9.12.2026.04.30.03.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:19:31 -0700 (PDT)
Message-ID: <69f32cb3.050a0220.147ea.d7bf@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260430091956.10915-1-chrubis@suse.cz>
Date: Thu, 30 Apr 2026 10:19:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_test: tst_reinit() abort when already
 initialized
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
