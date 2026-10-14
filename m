Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE07CC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791965810; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=89cDejn+sss2+5/wT3qL/KJ2fCW/97PKWmHTbuusgT4=;
 b=dYT0DV1EE7ckjhvOka1oplg+HweMmelOsLoluwERUbGkyipQzi501v8NuM32jW0L53lsB
 fGntgA6RkXLpYn5wZiQWjD0HfqKCBiq2M9f7zF/ddnKwLxjPyjrxp7UjRYckSyMn4pRnTeu
 86JIokikkXJ4icp1Pd/UGqut6VGzFrs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6267D3E559C
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:16:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B89093E2AFC
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:16:30 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 03AE0600651
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:16:29 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2acc1e170cso643932166b.1
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791965789; x=1792570589; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qqGEG2G08rDX+mEGOkjDBemkmhuFzJed13QwYleMORs=;
 b=A2GNTEEFSx1HTRKUh6nK7KiSb8wDDSWqKswoYntafl9LsN9v1U4NyV2KFMUXPpdtDC
 /0MLvoAnFXk65aEg/jhweL58PHJSErQhw92adhoIM/oXS0mYkva+QdRYvzjvVndnjYeW
 mm5L3JUB4yljnsXACbH4vcXxMS52bkVAGchmhpuOtYZUShq62kvoKkoB2N+KnAYHz2Vk
 4vIeHmRgGtiMZ+B89njMvJImlCO3VUFvakQ8rK2UTVCV9ISFeLI/oDDYGTbrAOjyu46M
 SAfe0g00VjFoHUtKDVcEiC+kPN4gAjstbdb0PpgJc3S2ETIPwCDUwU/K81J3VVHeYYV+
 ksFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791965789; x=1792570589;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qqGEG2G08rDX+mEGOkjDBemkmhuFzJed13QwYleMORs=;
 b=0YQQ+NXkqY4U6xF2H4W/gr6bXpa+HQBDeUhDSY1qZvUW0OhBXn6tEWymVWmL734AJp
 Iu1bIIA2fqIRjfdqlmAUjGB1Wg/aRjPWK4axRxp5eOKMWFxMSmZcwXd3QcCuvVMNwkmp
 +xT0m0W1yw478lzEFhFx/ZRleVInCq0qvsW9vcAcTvQPyO/jN6dYAZjDU7Cug2ofoAH7
 vHJmX4qtv/1otQm8I/4W+gkl2mjocmCCZIo8V7lT/uaaXKGvLs1UcewHNmPNO7mFqU5v
 /ZMi5ww70JN0BIuR+5EiWf8vuRF9ci1K1rg40fLjC+9OH/V0J4N468vgNuROctPQemcw
 B9xw==
X-Gm-Message-State: AFq9FYKzpqPk6ZeebAAc3aj40l3elW1XcUSR1kTVdbC6YL/RjVxlexh0
 AwNFgSXSt+579L8KXkw0XTJU2t248WW1fjdBQ6Fx9lhwOHVJrc7kTwFf1ccrt08DodiHcI8Ghmp
 Nj8xqYE14Jg==
X-Gm-Gg: AYBFou3lcuk65VZlvspsk4s3oaioLVXVhTtFxJOHFy/9E6TfPF+95QIaqCV86sUjp+o
 +LtcKpkxQ0MPaI3Qho7UrCF6aHzyotpVcEDpEVAKDl2dlE3nZN8o0qdCfXngyGeVWfAjwIOishu
 XMuGbTpPLNi9GEfzq9b2ao3eDS/dh9a2mWqXM+hHLfM2G8kxizxlksFqxDiFljs/1H8RJaidFCt
 oliVhdz+U1X5Igtcm3ksooOqHSxN875klz1cWHMaanYoU65i4qMG2znnWR1KmYXRVkz8DsCyH9F
 u7NeQshlDjNtd4w+zESYtn1iA9VAcV251VyIO3bmTiCAC5B/qfIkgesquuD7G50quceoVzoiwE2
 UErm7+xTkNs9r9aJfAF2a4eNxZIHsCdrh5APCDGUd6PdLWNVwt3zO9ox63qfzzlNG6yOQIBWpva
 gP2v3+2rGfw8Em0O2nX1GV/WEERTEUqScLglpUNWKWRQhNZN3c5Xg2lKXfRwqQnM9I6aGhuz+vE
 KpWHSrPdJhY7GmftaxAo6Epm4IKvZyDW223shgKpzrAJfl+xqZtWAziblqHB+zCWZOAe5nX6oXq
 7w==
X-Received: by 2002:a05:600c:64c7:b0:49f:ff32:803c with SMTP id
 5b1f17b1804b1-4a18e49c536mr284637345e9.16.1791963802919; 
 Wed, 14 Oct 2026 00:43:22 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f249692sm413777345e9.3.2026.10.14.00.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:43:22 -0700 (PDT)
Message-ID: <zEv6AUi5JUa4zZxBhpChWHtlkQSFX3ZQ9BPa@localhost.localdomain>
To: "Florian Schmaus" <florian.schmaus@codasip.com>
In-Reply-To: <20261014071734.450957-1-florian.schmaus@codasip.com>
Date: Wed, 14 Oct 2026 07:43:22 +0000
Subject: Re: [LTP] [PATCH] keyctl05: Use DNS_LOOKUP_GOOD to avoid
 false-negatives due to EKEYEXPIRED
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

Hi Florian,


> In keyctl05, test_update_nonupdatable() verifies that
> keyctl(KEYCTL_UPDATE) fails with EOPNOTSUPP on key types without an
> ->update() method (such as 'dns_resolver').
> 
> Commit 4e9400050683 ("keyctl05: Improve the dns_res_payload for boundary
> testing") changed the dns_res_payload to a 6-byte V1 server-list header:
>     { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00 }
> 
> Byte 4 represents the lookup status (enum dns_lookup_status). Setting it
> to 0x00 (DNS_LOOKUP_NOT_DONE) causes the kernel's dns_resolver_preparse()
> (net/dns_resolver/dns_key.c) to treat it as a failed lookup:
>     if ((v1->status != DNS_LOOKUP_GOOD &&
>          v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
>         if (prep->expiry == TIME64_MAX)
>             prep->expiry = ktime_get_real_seconds() + 1;
>     }
> 
> This sets an aggressive 1-second expiration on the key. On slower
> environments, such as QEMU, more than 1 second may elapse between
> add_key() and keyctl(KEYCTL_UPDATE), causing the update call in
> test_update_nonupdatable() to fail with EKEYEXPIRED (127) rather than
> EOPNOTSUPP:
>     keyctl05.c:143: TFAIL: updating 'dns_resolver' key unexpectedly failed: EKEYEXPIRED (127)
> 
> Set status (byte 4) in dns_res_payload to 0x01 (DNS_LOOKUP_GOOD) so
> that the kernel does not set a 1-second negative expiry, while still
> retaining the 6-byte boundary payload check for commit acc657692aed.

Good catch. I'm wondering if it makes sense to use KEYCTL_SET_TIMEOUT in
this case, but I guess we can rely on the test timeout in this case.

did you explore this option already?

Otherwise LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
