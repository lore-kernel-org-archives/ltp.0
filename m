Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47402CD98C6
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 05:35:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22F6D3E2AA3
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 07:35:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBD343C54DA
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 07:35:29 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8259310005E9
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 07:35:29 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so10950044c88.0
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 22:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781156128; x=1781760928; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mUqL3JSCzdqxQdI7qYVtXKj/zsz06vCgXMnlA+u8L8=;
 b=IFe3rgKLu0bcviazPPPRTaZFluK3ZpmOIh20Y0fT8LcoOmaNTf797F3BcqkoZf/Zjo
 9CyU+ZOht6Ut0tCv8J0/VYS6pp8Pl3T4eGXnSV85ZAKu3gsYXKzh3JQAyuIPdGaJKVud
 yMOA1qRhw8AJ5/YNu9DEVAh1XQ+cp8sdNDbLKkAn/LvGzX9LTpd8znj4cuUKUSO24BAv
 TlJGc8SQ2c/WwYXbeBUobDt6PgWDU995kuSt/FBR7kkjmHPB9qfjr/lZhbeRcVts5xi6
 iPZCZ9ERaXquI3KvProBT8ci7nCATMxBRgnaVxy9SL1YrWRIxbdgAm8RVofVI3TMSLja
 zwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156128; x=1781760928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1mUqL3JSCzdqxQdI7qYVtXKj/zsz06vCgXMnlA+u8L8=;
 b=N8Ol8BUNbQswtDwLQApGKkGDO7gLdmUg8g36eKJVgrPgX0LECr7pzjExjWY8qeSbG+
 oMViCknh5ssGrXX5FWl/d6Ly42vvsIypBnWZTbkO7K6McpwSRfRWlNa20kmkMK7U+79x
 Am5J+nF7JU1Bi/kAQCeajTx9aj7SazErb1T1PuRU5a0ruEWKqjIoiTNZs7OnxRAfn+49
 J5hKRxJ67ZFCGJSe1utsLAwmcTpVo1qyp6pISTNHzhA61me5Gr4XC4dDAOfX83IXJb+h
 pDCG5NRB+1+G1kBeWyfZBx3z504+IEVafYTIX7VbAabJ3Qmep3916kWiqYordFgoYrQf
 pUdg==
X-Gm-Message-State: AOJu0Yw8/i/o6qqgc2ssgym7gmfLgYN8jRYzZwSaf1HhZSgInM/S60va
 4Ee8y9PT0DmRxrNG1a1PDN2sEQDYv34h83VxARpZqob4kRmAfTMNF/NT
X-Gm-Gg: Acq92OFcwqiomwLoBipKXs2FaNTM5oo93AM8MPIOBwakjaKiNAWZmWJr0T/org+CG3z
 fu0QehHwVbkQKm7x6ZrfawNr5brCl94iGlgYtj2tb2uKcAswzhuZG1msTQE96UB4jQRCBoESN01
 MpHFKrc379Fa/Giu5bpse6JTD4eNBI1dSR1IZnlcw6nZj6CjFPD2orO7bRIx3fk8zhuUkibKS5/
 +eRa9tEhgBGdD5a/fCeQrp9zyYYg83tl7K/SD06bgQVFP+DT0IsdK72eORl9GFCbGJqDVaG40OB
 eX6sW8WfRA722/bjSBiSud5zqwm6dmu6/YTlPjcDnyEFa4IC2qDhHRK69X7MbtgWKZaMiIyLt6v
 q5DdSPBancTdtiDKXXvO750qxIN7yO17fbnzfxpWpfXzWFFf86cd38PhywA4OsZD5z82ORsOCGx
 CoSn6Vx3XcmYdxTfzIlabKt9iuidnaN21tf2OaNyO76tWfX7Gh1kG95yNmi02gvhuius32geCmq
 EBJK2TcPPnlyY4eObGOa6Gwf9yFBWTkILBxZ49NL64DCkB12gY9
X-Received: by 2002:a05:7022:518:b0:137:c0a7:8cf7 with SMTP id
 a92af1059eb24-138422ef87bmr900232c88.27.1781156127681; 
 Wed, 10 Jun 2026 22:35:27 -0700 (PDT)
Received: from
 runnervm1li68.si5vesnirltutgysy1tpxjbuwf.dx.internal.cloudapp.net
 ([172.184.220.154]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13843025028sm806061c88.11.2026.06.10.22.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:35:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 11 Jun 2026 05:35:25 +0000
Message-ID: <20260611053525.4091-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611030858.4109-1-wegao@suse.com>
References: <20260611030858.4109-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: Convert to new API
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

Hi Wei,

On Thu, Jun 11, 2026, Wei Gao wrote:
> mmapstress06: Convert to new API

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
