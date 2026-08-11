Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E62C5CFCF
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786438441; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=4eVlAjsLjXpHMO8DvT6xpHbG0DGNRITeNV33jehACJ0=;
 b=ReWToTPpdo8IhlzqTAMyPNHLgGVlKwqP+wkh5FZhc59rXjF1FcaoxG/H/izg1K4HmRElf
 p+ukEmwvzgJR5dgWUtB7NGfcnXIDcePczWZZP15AWpoZ+HCuUOxG2t6Mg32zZ9608z3tRah
 d4MTYKKsRXTKE15lOL+3rRPYRU/w5Do=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 431D83CB850
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:54:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F24A3CB850
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:53:42 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2C036003A3
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:53:41 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so2323565f8f.2
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786438421; x=1787043221; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MqadhdDYL/2RyT7hpiwDmXIudjVvSSnD7BpdNgPxgL8=;
 b=aBLFz+lZaDFP6hgKtCNw0FFvouknmX8329eVH7zP99yks4lORAadKrxIGceVx+N6DO
 HTw2TJp0IZ1wSY+QipKGvMERiZDFRDNslrFXRi4zdqECROPmoLP2IvaY0fJl2gtJYuIV
 SZVZDihU9OaJDF2eeLT3ZBLQxoqdCey+4QJYC08Mm8oidYsE++yGPJwfgdV9PZ3mhpWF
 Oujz0KECW1bUtyGyLMnw8xo7gqdiPefBijKrnGS6Lxf0hkHyokQMG0UFX259G3640hsi
 NqSOJi6t/E6c1T4wJklcNB/9KeKnibNoAqDs8XYUon3Q8czVtVungGQClGP39Xhn6i43
 v1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786438421; x=1787043221;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MqadhdDYL/2RyT7hpiwDmXIudjVvSSnD7BpdNgPxgL8=;
 b=P3rzuD5wkZAGGFlYqkwmGnyR5ORvj05LCuHAchhI4Fftd1nlRwTLSTcnWMYoLP3qU8
 2foJTsKp0SQQEWj+dZ4tHGEPCQKAoQZo/F0Ent2qqAb4eLD+1lOVZjbGjeQJHAp/r4IW
 stgan4uv5lZA3MTLRtwI+TeuFIoy88mjAVINuZzoaVIjvkiAHMTkWAOmEARGLh0PhURw
 wgzw0aK3R6eInEIuHMINnxKAC2P2Fl6iYyc5dXkD3Pm3Motebf4raL39pLb0sSZ+dc+8
 YrSMzOuRON0sQ1JgGvDDEAGptDVcGxom6ySjI08vZkCnr5WMKguYiYGHklYO1Pe+8RcN
 xUxw==
X-Gm-Message-State: AOJu0YwFD/sMo1+ITO4ZtNBWhk301nxdXWLj1KryXri/yiv66dntu+un
 Q/5benuHaCcBxdwjQziHhiyN/mXuCE8TX3F92q1Jarblth6miCDGJVSEmERSWSLSH8c=
X-Gm-Gg: AR+sD10u1eqRss1YYKbVoZLgWSEVOMCCfl5CEFZ7vOMKgZJyj5PVl8XdSG24HTw0lp8
 ESPlD4AxDn2RC8PEbiVDM8OezIrVrnF0+v9fCTcCnJz8hEtTupktychkra8G4Q+81ZOg9D4QGyI
 vhtm0YWHyYn/qtXdLOUD7HvCFa6FoNKAtVwA6tW3KGJat+sFqdXJ7fBwFM/iLsORRXQE8fr5PG6
 fwv82DAVu08plRlFwdL5RD/vlxLFiwAs4CVZeIYcuDHTnYHIzkioUlWXjp+qcPqf+TEtr5Y1qxW
 SXaowYNTNF0aFJbuyinyhTD1ftHLZTZfZL11Vn1VydjY8hKX9+w2Yuv86E++9UYo+12cEA0z3Jh
 x1+C+Q3J1IMYfFWhdkzgSiPOiFPFJHcUxpxjwi/JOaF0IPJ8scA3iLGTWwD2Lg2FVjHgoobwkUp
 4mn/00N4FKRGDBxl9cpbmfST1y2Qi6pMpnpkqLD0Z+Wqt/yP/MP0YEkc4YSZlsgQR2xnWzlA==
X-Received: by 2002:a05:600c:5247:b0:499:5e50:5be9 with SMTP id
 5b1f17b1804b1-49978e1a8b9mr22592715e9.16.1786438420981; 
 Tue, 11 Aug 2026 01:53:40 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49974146b83sm50419405e9.11.2026.08.11.01.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:53:40 -0700 (PDT)
Message-ID: <6a7ae314.87c5160c.188a1a.140c@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260811084943.GA1676037@pevik>
Date: Tue, 11 Aug 2026 08:53:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 7/7] lib: Add 2 basic tests for .min_kver &&
 .max_kver
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

> Although this is an interesting idea, I'm not sure if I find time for it. Feel
> free to further improve it. For me is in the end trying to fix fanotify20 :).

ok feel free to merge for now.

Andrea
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
