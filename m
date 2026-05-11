Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94BCCD37AC
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 07:42:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 610EA3C72BE
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 09:42:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B43B73C31FF
 for <ltp@lists.linux.it>; Mon, 11 May 2026 09:42:39 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 39E1B6005CD
 for <ltp@lists.linux.it>; Mon, 11 May 2026 09:42:39 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50fb18c55beso42322201cf.2
 for <ltp@lists.linux.it>; Mon, 11 May 2026 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778485358; x=1779090158; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxHlYupIT9GnFmu3bmLDFI8WhjjmtvnVPb3x8J1grPY=;
 b=eWRUNqQPLlqaHoiGft6cEIrUy9mJmivD64r5XnVremnzd2fw9XSQUZ9nFetq3Q/Tgz
 +pkH5jJfp4CfgTZTmyOxa5navLNEpgBp91Z+z3EK/pZcT+8HoMgvGgaxvlqyPrb9igWA
 /vCiSMZK5JZltGWYYSddRpYrkFaeUe3HxrKX2u1lfq2YmMzZ5NAH1YN+I98PHQxOUNr8
 FQ7N3zw6nd3BjO9XTdDbHC2qoJcVrby+QVy/pvANnd+v3vCmF6mFf0Vfk7nmo4ckrjjd
 9lnyPalxVM8OtjMzAHk6hL5V3C0JrOIlYTmg/gS+ty+1ENRk8nfl1tK6hhcv+UE1znA7
 k/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778485358; x=1779090158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DxHlYupIT9GnFmu3bmLDFI8WhjjmtvnVPb3x8J1grPY=;
 b=QsKEk4okbO46z23/tGVykWNcuFyojRcxvmpdifis93R2Sv4qb3pTxQq203sRA/HJRY
 CFUCnR0aIsnqwmdcPTUg5gNKo2n6XACMFE7HrOeiYn9lh/FiyIiiEv2X6ZL1bBcl9Mtn
 9hJiWDngj33skc3PCUOp12aAdUWshq+AhrhnT52EGDrp6KvvUtDsLieA7VO7PwgQqt2J
 iT2pRAXlGCFMyQpMdTnTtQR4NQ9wn8j00jdGyNBt8iwjGu8HpEPfCcXcwZqhu7y+EzSf
 EnSaFa3OGjsw4waXrIJf0zx9XHp3Mu7AEhEh1hraKy9LX3fgcw8jVN3PpAY8ccYr4g81
 Zpbw==
X-Gm-Message-State: AOJu0YxKUIeQHG30pu+AVwCEn9/q7u3LpXRO2N7MhGHH3wS4pc8t3GEz
 AqYoPTqU5igUFOh23HS1wYkTwfI8rEk5ogX0Oq9xEN93STVRXnYt23tv
X-Gm-Gg: Acq92OFhWd0nox8qs9y6KoW+P0KZnHhayp1E8Or5XKA8+qTXU2+ekry3/OFL6FRLiuN
 QxdfMSBiQuYFww5UnSUjw87GoLAVAKDcJWUBJN6Y9ezniWaBNNy6EWzCWUkuc6Nq4HWwHbbrskn
 RWOlbLVVxyMD/o6sVyUS251djM/Z7bUQOReUsqRD8LSRCUN4GiQfYg1vi3jtpeR7Sls6INy2kmJ
 Mo9mn0LjAzOQhdgwx//49LVxNE7acvM5FAXPVsJ87aZQ4KMRYC8AZswZYLxllW67X/TNDVL8X8R
 lCSjlsGsDf0lDcV/jdE/8nH8ySGkJ75on1XXXpP+vJJYT3kOLxEH69AvtGG3e09sQ7Taf//bccH
 ncTeJMx/0SGKWo9MSAUqe2vhPrNZPeAPITAUl+169UVSYWm7K6UrhmtaOb2Mfzpr/bsVuVzTJvh
 KP4QKlAAp+gTP/V0i5tYivbrM3qJ0IRXRscKZXn0+0gFzWKEm+1XaH2W1EtLXAlTecab9+mMS18
 JfzHYyWprBmljwOAeyatkEjPC3DDNdYKkFXqBk4o8s1YB5AkcI=
X-Received: by 2002:a05:622a:598a:b0:50f:c2ba:e922 with SMTP id
 d75a77b69052e-51461e35664mr341282011cf.14.1778485357942; 
 Mon, 11 May 2026 00:42:37 -0700 (PDT)
Received: from
 runnervmeorf1.net0ibprzlqujb4ppu2xd1znfd.ex.internal.cloudapp.net
 ([64.236.177.102]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e68a963sm83330061cf.13.2026.05.11.00.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 00:42:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 11 May 2026 07:42:36 +0000
Message-ID: <20260511074236.3866-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511070852.90379-1-pvorel@suse.cz>
References: <20260511070852.90379-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc/cve_catalog: Link CVE to www.cve.org
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Mon, 11 May 2026 09:08:52 +0200, Petr Vorel wrote:
> doc/cve_catalog: Link CVE to www.cve.org

> +cve_url = "https://www.cve.org/CVERecord?id="
> [...]
> -        "CVE": "https://www.cve.org/CVERecord?id=CVE-",
> +        "CVE": cve_url + 'CVE-',
> [...]
> +        cve_link = f'`{cve_id} <{cve_url}{cve_id}>`_'
> +
>          text.extend([
> -            f'   * - {cve_id}',
> +            f'   * - {cve_link}',

Looks good.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25656919931

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
