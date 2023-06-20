Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B25EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 18:53:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F16E3CE0FF
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 20:53:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE3263C6335
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 20:53:12 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DAF4E600283
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 20:53:11 +0200 (CEST)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b586e564fcso1766328a34.1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687287190; x=1689879190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GK9r4oApFvoOkU2vxHnCywaPPqjpIR7pmqSTunIX3rU=;
 b=yLAFLT/ZnId4JD4nAc1qW1cGmbYuzkXOg4W1GAlZbLrpQaFPAmwOtNjAl0PAtbYc6c
 enxPRnHlCmhPq4EwXk1JKa4a6omyvMVznuJc3xgaCBa0AZh/eD0H9h/cwmzyM12ThJeE
 3JjkEUzIhNt4vqiAfvUVSTlVo9Rx3dXTQojR54FMrpJOnB/T0mIvsEh19Mst45qQC9/g
 HE5IoTxmRjqGvrMq1u0S3wX7fsREbqSu17Eo3Glu4RdxplwxQcK+Fl2Z3lc1yFtluzf5
 33iA0RGLZ1wr+/M8vzmcIAw4g4YWYAU1BMBCFXK0YStPPuiW2BNoKwTSWj4q9fXpxdZc
 5+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687287190; x=1689879190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GK9r4oApFvoOkU2vxHnCywaPPqjpIR7pmqSTunIX3rU=;
 b=cA+yAEXhb81+VU3jxp1f2K45enif4rxBJqmzLOFwLAlM/daaBtpelHkz+mkCZo/G7z
 Idi0gs1qbsckgRVs7VynIyVk8kKorwpErJo8KwcGBrGGHk1FJ0rIWdK1nTB0aRDTMkg7
 IHtwvXfxXJL+Tom3LU6h6Um2WtSmP/Jg7KU/WrLFN2CB4swuLHTbfrllcXt3jZPpwlQ1
 YHpi5fzDXFN+TFoKazljVK627Aqq1gWckO8uEzg5TKFmpXOVuKFWDbTVVeWHvuBtd/b7
 RPIQQB7QWaFdsYYx0mGcIkcinzBxU27zTqpjzJ8EoCFc9rIlj+NvY54VG21kS2Jd1uTl
 ahTA==
X-Gm-Message-State: AC+VfDzCgrFxnaJ1AVQiJ2NrFwKLk5j6t2MrJgzfWTg80ZIU1mVgaWud
 b5gH8OlZSRR/iJWKt3TPCTmExVvLsydqcCjD125AtQ==
X-Google-Smtp-Source: ACHHUZ5MlSK427v7hc8HmtqCVOC7xQX8FE5+662DL6Ui76xZ8tTjI4cz4jmqbCrPAtX7ol+7yaTTJRROMmGQt5EtojE=
X-Received: by 2002:a05:6358:416:b0:12e:f325:e08 with SMTP id
 22-20020a056358041600b0012ef3250e08mr6049072rwd.1.1687287190203; Tue, 20 Jun
 2023 11:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230608005315.3703446-1-dlemoal@kernel.org>
 <20230608005315.3703446-2-dlemoal@kernel.org>
 <20230620101429.GC275381@pevik>
In-Reply-To: <20230620101429.GC275381@pevik>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Jun 2023 20:52:58 +0200
Message-ID: <CACRpkda0ngTip0af=9bJzDWErR+urCgWn7EwLX+yri8PLhsOVw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] ioprio: use ioprio.h kernel header if it
 exists
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMjAsIDIwMjMgYXQgMTI6MTTigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IElmIEknbSBjb3JyZWN0LCB0aGUgb25seSBjaGFuZ2UgaW4gdjIgaXMg
YWRkZWQgTGludXMgV2FsbGVpaidzIFJCVC4KPiBuaXQ6IGl0J2QgYmUgYmV0dGVyIGlmIGhlIHNl
bnQgaXQgaGltc2VsZi4KClJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlq
QGxpbmFyby5vcmc+CgpZb3VycywKTGludXMgV2FsbGVpagoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
