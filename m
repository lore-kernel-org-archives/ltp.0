Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C087C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 14:50:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABBF03D0AAF
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:50:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DA803D0A65
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:50:16 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF16E100C6FF
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:50:15 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6ef8e62935so5785666b.3
 for <ltp@lists.linux.it>; Fri, 07 Jun 2024 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1717771815; x=1718376615;
 darn=lists.linux.it; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6AkPN3HtbH5VoQtNE976r9uVTaOsLIWThCJIfiVI/0c=;
 b=KSwY8Nt+5oC2aISVn5GY5M6/V1RhCv+/A9woY99VDElAXY5xic8/6LV7CwvBgi4ppy
 KsCpB9+fTWu3P5OMCeJ8tIBy3HjPUUneaPgcXUI4aZGJDetePqS1U64EfqbgtXwcBOEv
 qBCP0MvU86M7WzmxUgHDesBf8YdGpVr7uI7/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717771815; x=1718376615;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6AkPN3HtbH5VoQtNE976r9uVTaOsLIWThCJIfiVI/0c=;
 b=sBrcpfq6j+D+nHjVhLZpSgmc8jdYzxwgv2MGxSMfaqIw9Og0K29uHE6TozMIZ8mawC
 qExaVaXPRco2NFNyKYWh7q9EnlHmES+CF1oWKVnWfHKO/N3/eT4nBgjdey3dgixtLlJy
 ZG6PN3gknxsQB921NCXyqBQBhBbLeTcJ1gQv65MuZU24kpywMeF8pl2ouJRyFJ8x1KH6
 8yVoXxaWw4BT+Xkv6B3Cn6TyZ2wQFtz5F5lf3c2sa8YVdCNbF5Q3kM79U0zwrVssm2Gh
 uWuO+L3C5cZFRCqOC9Z5VPeZvanZvoC4QXC7x1ZVXwZ81/zL+OG7wrnYzdgTvb1yKzGN
 NLqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVIWOA14mxRGy+xz4ANbKjYwvMamE23DEkc3aQ+AXqu2+iA2as4uX3jXsonyXl0aX7pjfejqr1UMzINq7VGzQGhCI=
X-Gm-Message-State: AOJu0Yw2k594NR+i3pbujSwCPujaNWU9oWFiYj6dLxVeuTO8GewEIAIN
 J+PSuOeUBcOyYfI3aSSvZs6RBIo0BAsXu4/WJr8eR8AqnZ2cb2+MiQNcSySB+B0=
X-Google-Smtp-Source: AGHT+IE/snOR0V+JXzgpFOMMcPUHRd21MNLIVQEubekOcjoLUXpD7I/f53NMp6DptPzyz/zwX8+8iw==
X-Received: by 2002:a17:906:250b:b0:a68:fd49:ab9e with SMTP id
 a640c23a62f3a-a6cd76a9327mr222079866b.36.1717771815307; 
 Fri, 07 Jun 2024 07:50:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:910f:5798:f456:d86d?
 ([2001:8b0:aba:5f3c:910f:5798:f456:d86d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581cc2sm256204166b.45.2024.06.07.07.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 07:50:14 -0700 (PDT)
Message-ID: <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: pvorel@suse.cz, ltp@lists.linux.it
Date: Fri, 07 Jun 2024 15:50:14 +0100
In-Reply-To: <20240607142423.116285-2-pvorel@suse.cz>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCAyMDI0LTA2LTA3IGF0IDE2OjI0ICswMjAwLCBQZXRyIFZvcmVsIHZpYQpsaXN0cy55
b2N0b3Byb2plY3Qub3JnIHdyb3RlOgo+IGtpcmsgaXMgbm90IHBlcmZlY3QgYnV0IGFscmVhZHkg
bXVjaCBiZXR0ZXIgdGhhbiBvbGQgcnVubHRwIHNjcmlwdC4KPiBMZXQncyBkZXByZWNhdGUgcnVu
bHRwIGFuZCBwcm9wYWdhdGUga2lyay4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4KPiAtLS0KPiDCoHJ1bmx0cCB8IDEzICsrKysrKysrKysrKysKPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspCgpJJ2Qgbm90ZSB0aGF0IFlvY3RvIFByb2pl
Y3QncyBDSSBpcyBzdGlsbCB1c2luZyBydW5sdHAgYW5kIHdlIGhhdmUgbm8KcmVjaXBlIGZvciBr
aXJrLCBvciBhbnkgZXhwZXJpZW5jZSBvZiB1c2luZyBpdC4gVGhpcyBkb2VzIHRoZXJlZm9yZQp3
b3JyeSBtZSBhIGxpdHRsZSBiaXQsIHRoZXJlIGFwcGVhcnMgdG8gYmUgYSBsb3Qgb2YgY29tcGxl
eGl0eSBpbiBraXJrCndlIGRvbid0IG5lZWQuCgpDaGVlcnMsCgpSaWNoYXJkCgoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
