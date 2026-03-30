Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9228FF4957
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 07:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774855427; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Trx826YUlEA+jMmILdKDhbhsoDeJGWd1o68/rRaSO7M=;
 b=c9VjTZqwPDllqtJVuxAy4iNrsPc4PcYUxKr8+t4FuByjGgy4jKXktXS5UsRIA3ITs9LzC
 hHepHwi5XRZzeFTS5uU5QtPDN55j7Cr+bDaRsPpEaH+Sotvq7YKLGQVRPTgbcwTpZZY3T9E
 C084LXLTF+iNO9K0+TSJx8Kqh793f4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52D883E2AEA
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 09:23:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CB993C8235
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:23:25 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F8801000254
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:23:25 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486fb112c09so40202865e9.1
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774855404; x=1775460204; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hmwIfuIusgaPJQCTWI9f3SfeyojU1GIBRXkaJuN4pfk=;
 b=DyuWS8prPacfdzMGbS/Xqkb/ZtDhWUAYZzJvRj9/UORTXfUtirtI16u+j7O9/UgcNS
 e9Tqh3zFV9F97Kj11kfj9qdrD9cZy2eouvpsVLn9/gYK9mrcrnYnfSiKg6hVczCnzltr
 nWEc2OnXtl25WPsTv/8JSqqsaZQ8VZeLRKLxRxFirX2IRy0/GustCwtn9mss7I5ZxgD0
 uWMVHeTOU7Oa2rtBbtWMiSrr1MbZ94Vi2qCUOsat3wq87G5Z7Enkz9XHWhyu2sYJrkV9
 IPhN31VK4lbEkqGQFZzcX8jAldUPutv1r2pV3jgcKthElZEfjIxzBlfLfbba0nWrpru2
 p+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774855404; x=1775460204;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmwIfuIusgaPJQCTWI9f3SfeyojU1GIBRXkaJuN4pfk=;
 b=hRfjCO3WJ7YLBOLQ6Q+qVE16STq5pZzqC8PKV6ErjPgnxBmL2MuCPrxNpgBKOERzMT
 NwOSGdeC1xL9SL4hSa7rJbPRjqY51Kjoz1KUj3Z8ESEJM+fKgZT6y7RcrcnMhMn/6Von
 ODPl/OElel9awNoi2oYk+QyL8eZJ15KFbOa4ckM90UGx+cM1hUxM2ddZNyBCTAIQHkNX
 2XrN3r8dxpYw1jgF7uTW6rB+XxD/EIoHr0l/nUBPDuI3Txmh6KT7i+LNxAm2qhWOWRKE
 S+Ge7CuQsmQwLaeF/2sOIguK2/12gFBB6dlwe8VokxZVexz5h1ezSaQhtzJseCFJdQab
 nMHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1TVq5nlOskPI+47/Y/q07vVCcRsYFdvLxeKlCffvd5zSGJufza3gj2K4UAFoi6nAi3Ic=@lists.linux.it
X-Gm-Message-State: AOJu0YyTyn3n6eoWEahd2KLISG1Odz+fWbkRAh2+CsKjzzhS0JFLEvxo
 eKzYv/PG6NAWRASQkgr89XDO+pIlnR0CbMYd15IYkk5s+JxxPZqobndLShw6eJLOGjw=
X-Gm-Gg: ATEYQzw71p3VKQVFwbNEkTJtrMfpHHQMUoyQycTYbTeqf8Om5a9Y6BXiUv3ZZ8nDQvn
 XhEQ4RFqoWIISxNrs4Ps/W3+2eXoBzdaEftAqqtsqCrqS3hOAQ9HgiDaKAAHHl1KpI8MSCmrmjY
 WR/nRRXTglP+lbyq+3DZun9UYJnYxYISkq/bZ4slkvPhfN+ntWN/K5mKCbzq6CeShqSYTs/MeQf
 CojV2XR7g5chuFJHgLlnMnAwf9Y3Dx05Nl9MEpVoH/cg79t6bK+qokNqJglAslRowSomQqUef3/
 jpm2p4xTujkuD5nG0rTdo8Hx1lRtsG/A8IvDHzaqiUqYPhdKb799+7y9gsyw/OHQFHZGSZdIl2X
 ym+SHvniz40DEQaNJI+PIUspoluaTjmnWcX9D4pNKha7sCNQtA8dtdgjQhYL8JjtDnV8FtulleF
 rNvlPReWg/D4lT+ND8E6/NUIEQqw1Q3Ove2t8mqKNmLUs1A9JND37UN4nl6Jj8sJLXnoFUow8Sb
 okGdccNZjKqyj756QOhE2vwTgwsATlWDYU=
X-Received: by 2002:a05:600c:16ca:b0:485:3ae8:2231 with SMTP id
 5b1f17b1804b1-48731faed9cmr73675925e9.30.1774855404445; 
 Mon, 30 Mar 2026 00:23:24 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487270f1943sm93076975e9.7.2026.03.30.00.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 00:23:24 -0700 (PDT)
Message-ID: <69ca24ec.050a0220.1c41d8.a7e9@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260327152952.GB1092845@pevik>
Date: Mon, 30 Mar 2026 07:23:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test
 Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Would it work if kirk has it's own .editorconfig? I mean, it should have anyway,
> but if it will be applied on it as a submodule.

There's no need, everything is handled by `ruff` that is auto-formatting
and cleaning up python code. Its configuration is in `pyproject.toml` and
it's de-facto standard for python development nowadays.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
