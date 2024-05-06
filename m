Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34C9C25B10
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 23:15:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 401F63CDB7F
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 01:15:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A8283C8658
 for <ltp@lists.linux.it>; Tue,  7 May 2024 01:15:27 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 441F51018996
 for <ltp@lists.linux.it>; Tue,  7 May 2024 01:15:27 +0200 (CEST)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-23f2996b634so1328429fac.0
 for <ltp@lists.linux.it>; Mon, 06 May 2024 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715037326; x=1715642126; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=evBoxV6sbKr3sOu/UV1Ii7VGEnBSL6pYl0yrTvbD8do=;
 b=jlmI22jvLn0F5ioCipRxuaralGZhIEQFHuhtsPKETypMJGriLPHqIUyn+D+7qqhXQl
 7U1fm5Ikp6O4tB6id5n67/t2Sy2+Cm2N84wvXpOMwXi2v+zsIzzPo9B1ysEyz4eYHYIL
 3wEYHeixTxd+cP/SNXtvMswY7nb9g04WoeYu5Ych1ZcisH9VO3+rfer25NvLtCZfxFmH
 ZypfWXp4nN2i8IRRcuPGHQzofj4o6ghKzAuvGgLG649+sNkepETmLMySQYQaIjltxwlw
 AfXzf74Lr0af3zH38U+x/xsu6FJYQtgCKBM40Tc1ZYpwsbPAfPa/4j+VrjEq2VbEs+m8
 e6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715037326; x=1715642126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=evBoxV6sbKr3sOu/UV1Ii7VGEnBSL6pYl0yrTvbD8do=;
 b=iftDQTFczrBxOitmP++kv1p57AvA+O8HemiOf/yEuwFw1n30OS6k8MDIlQz1pUr2FK
 Cp2YNJlxGIYPTnbbdNV2ZX8gEw+G3KBlx27Q5GHvqynTbwDlcIektEP05gSr/VYYy+xr
 EWm5mFEfH+ul6MLFXw7n55hEYvAeZl/NSgIpGH3ORN5siqF1pZMAB/cOieUs5pq433me
 m9Z4R0CmykjYgbb1AdD+ofjWMDD8foI/1oh8QKQayiyPLJK0xInKiSJC0vKgpVVMPd50
 Our74PIl5J4QaR+PWAfCpZGOEpumz7Fc6i1Ii1DN223/zCHLsWjkRNaMXdhHiCJoiJN/
 MfgQ==
X-Gm-Message-State: AOJu0YxJIFzTTPmqpnbx6jD08VHALoGeE42+hCLTMllJ3Jt9fdU8+nrA
 CmigFpLxCutcbpjmNvKoWp8Hrvq5GLB2j+MfA40Sus4W93FiX1JutuWsnkYLSpap8BgfdGsgn6i
 KaeaQI5tb+EqR5ItA0mZr1cB4cg2LTQIB
X-Google-Smtp-Source: AGHT+IF0gqmj2uqxvRFIVfqRjVJD2xhOsa9SglfL28tCVjv+0yKn92Mw31lIcOYKyKGye5l8itKWXoSOEXQYPe9CKCY=
X-Received: by 2002:a05:6871:a6a0:b0:22e:b3c6:96cf with SMTP id
 wh32-20020a056871a6a000b0022eb3c696cfmr14569010oab.49.1715037325605; Mon, 06
 May 2024 16:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240506190348.1448707-1-raj.khem@gmail.com>
 <20240506210010.GD38981@pevik>
In-Reply-To: <20240506210010.GD38981@pevik>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 6 May 2024 16:15:14 -0700
Message-ID: <CAMKF1sr_s8qnm3++7gea+UuShkB6KYQOz2t2ooCcbNaBjxv8vA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] sched_stress: Use time_t instead of long for type
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXkgNiwgMjAyNCBhdCAyOjAw4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBLaGVtLAo+Cj4gPiBUaGlzIGVuc3VyZXMgaXQgd29ya3MgYWNyb3Nz
IGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzCj4gPiBGaXhlcwo+Cj4gPiB8IHNjaGVkX2RyaXZlci5j
Ojc0NDo0MzogZXJyb3I6IHBhc3NpbmcgYXJndW1lbnQgMSBvZiAnY3RpbWUnIGZyb20KPiBpbmNv
bXBhdGlibGUgcG9pbnRlciB0eXBlIFstV2luY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQo+ID4g
fCAgIDc0NCB8ICAgICAgICAgcHJpbnRmKCJcbmVuZCB0aW1lID0gJXNcbiIsIGN0aW1lKCZlbmRf
dGltZSkpOwo+ID4gfCAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fgo+Cj4gPiBXaXRoIGdjYy0xNAo+Cj4gVGhpcyB3YXMgYWN0dWFsbHkg
cHJvYmxlbSBvbiBtdXNsLCByaWdodD8KCgpUaGlzIGlzIHdpdGggMzIgYml0IHg4NiB1c2luZyA2
NGJpdCB0aW1lX3IgdGhpcyB0aW1lIDopIHdlIGhhdmUgdW1wdGVlbgp3YXlzIHRvIGJ1aWxkIHN5
c3RlbXMgd2l0aCB5b2N0bwoKPgo+Cj4gQW55d2F5LCB0aGFua3MgZm9yIHRoZSBmaXgsIG1lcmdl
ZC4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
