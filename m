Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6424C83F1A
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 10:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752488100; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=STFgRJNc52uWllGKFc6u0sV5BxJFLKC2u/YapFWxXSk=;
 b=hyVZkFTauPpGbxPIBdjharngrkGEmKjRWX0ic/PTnIkF9r83YZ+Atk+c8ssiGS0Niu2j+
 IjX4+D2ePhr2AnbgZ4z7Fty5sr39mm06BuNE69LCRVs1vOcRcfUWhC9125dhebUZVsBSUZu
 VyCud72QDa23qDaHXBJKeIHYIxK5d2s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BB763CB5A4
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 12:15:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CA023C0EF7
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 12:14:38 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 00CCA1400DE3
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 12:14:37 +0200 (CEST)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-45600581226so20068605e9.1
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752488077; x=1753092877; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ITB/P+N824LJT8yTqivp8/imiUoC4JSMbYhEM98Q0Bg=;
 b=eA17WMJME4weFPXgIb4N1fkaD8AUrpKZI7vDiExH9I5LHbEFMkXs8hAEI6YE+t50gA
 PM7oC2QIdLYWycUxQeRbrkOqk/4W1r5z5HXHN2LOKR/Vig9EMJ7I9ewFg4VUji93YQzn
 YRbr0BAW8kEQpBUs4lVE1JVPwqw5GtYej0eojRRvsV5kBWOsqKaEDb8lt2EOOM16QpNS
 GjDFfoqeWjxVY47v41Qo8dnqTJdzQU/Vs6vjsoos5k4Intkez24ASuOtUkhX+qJi+y0+
 QTTkTm6wq1wdUnuJkTzqeB7ALGtq+oveI/edl//d7AQTL1VdrHmw+eSNXhdsirjPTkxr
 B/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752488077; x=1753092877;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ITB/P+N824LJT8yTqivp8/imiUoC4JSMbYhEM98Q0Bg=;
 b=kz6hCsrM5RCEgNXDEWhxDM9VQIFqodHfDHvzGNNOhY6a2BEVhRLkiAk0yWY2fcgRPj
 C9Z7DdQ1i0w8FQtsnRq2XyN2QTWaGWsMUqtTdqhHV9Igv4Lk+dJ3bWBQZMnTFFA1c2WL
 VX7EDFrwzr47swNMUGxYsiEL/VGDMCJDGF0bsbogjuqwyDYOVGecwD4buGbv4BfR1gNE
 DvUcWcF5UQ/oa7AIMbvUdOYo0uzNvqCOigV3bCd5kzUX5n9b6sBkCMZFXSKeWnspdbCc
 BQV3XSc/cE8maDEN1AdXw+N6TRsTHYeRKxFiyiSyO4zSC7ZIA4UyffgWx9EJ6Aw1Sqpj
 fUsg==
X-Gm-Message-State: AOJu0YxxG+1LtM0ovWJN5JVhucz656iIYPVZQHEO2ef1O2lYHT3ji4Rf
 t0gNDMYDOmAiEJo3/KClX5E0n73wvK/gpmzk3RfgasMrnZmxBbQtOAhaolvYHMCZQK8=
X-Gm-Gg: ASbGnctueVVv5syQTML3YExUOWkDJwRPIPt/jJNtbowAb9o+8MO0/zX3BeOWcPX4xTW
 BzEcLs7o0YAc+NN2RduO3hCpENNKWd8BkY6u5SjkqQ/P0k834RXAaTU+2YrzgJqbRtkh/rNY2mL
 Da32CPRXP6z3QvQlXVNuWVuOEFfXbpgB0gBZYzwIrKSf0FI2Dj3oVsGhrenNdCL0n/vNl/adult
 BeFaqaIeOHsdXXNwAX2fpH4zE/Vwo8sdlAkugngKAK7fKyxuDMWNUCQv+Cx8v5wjJuDTT4XzOkd
 krmwjut2/k22YLbzU21/HH/tRw00U0XwGemz04xExpltttsyLL+QH1J3SRb70ircMxaXJNJq9bE
 oZUYZeXPXSszD4YNvHfD6Voh/8K+4mVQwGtYANV8/fn3X6nAv6+GANEhzUb+RSffkREN9slw6bj
 TagXrGEwQhTvJzskAvFrar1jSq0B6JuhHWog8CAjIQ/Y2epzw4RlXlBNhca7qlWA==
X-Google-Smtp-Source: AGHT+IF6AstJqFSHS7y0CVp58fTotegwctrcu3/zk5NB69hSLcRQ4TGQWQYu8PvS8YRioOswulztVg==
X-Received: by 2002:adf:b650:0:b0:3a4:d722:5278 with SMTP id
 ffacd0b85a97d-3b5f1895d50mr9006594f8f.39.1752488077266; 
 Mon, 14 Jul 2025 03:14:37 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c301a95ffsm12794445a91.40.2025.07.14.03.14.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 03:14:36 -0700 (PDT)
Message-ID: <b65060b7-b41e-4938-ae4b-342a748cb6e3@suse.com>
Date: Mon, 14 Jul 2025 12:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@redhat.com>
References: <20250708055950.m25zfqyfr4n4qkcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <c5247046-97ab-4d21-aacc-e4018ed4a366@suse.com>
 <20250713152142.2pe2sfgq4s2bd5xv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <6995b29c-54df-421c-a649-e4b9db119cfb@suse.com>
Content-Language: en-US
In-Reply-To: <6995b29c-54df-421c-a649-e4b9db119cfb@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Bug report] kirk can't run ltp's fs_readonly
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Feel free to test it now that this PR has been merged: 
https://github.com/linux-test-project/kirk/pull/62

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
