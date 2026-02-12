Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52144EB48F0
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 09:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770889978; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=tBT8Iy+WtNz6dH7UT/sf1bznBm0HDFbj5MgQb39p+vo=;
 b=F29ZqAiCu3gUU8OUtsz2tatO+EVEnUzvO0UlEBTxdhilkFDdnAZ/J8SdjCSqNGguwwLJ6
 GWxoUmSAIYUjNEnacGYuMZqQGbkBGSMVAixKkRF66CYzpn/mKFKh3lvB0oTCTO6nj+MffIT
 G6/NrRJdRTpR8hoKd4hbEWG0Id6kxOE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 922023CE9C1
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 10:52:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 272043CE9C1
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 10:52:34 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7BC9E6008C3
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 10:52:33 +0100 (CET)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A13773FB67
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770889952;
 bh=3Ub2tpRFSKIPilcfuJkFmB8H1huXuLHkLeHwhF0w7pM=;
 h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To;
 b=YwoqhkoxkVq/jX4dRiclwM0CPtnL62QHuqRUqhyC7SU2ZRpMbK/NMJYqUlPi4YB9b
 xOvO6YfvIRMu9bb2IhNFmfO9hALeVepp2+VkAT+jlvsXcI1KpKzGlFklktr3o3e7G5
 1RSF4In1UTJcNwdBdnhZhAt1oqCft9jZRWrONLlYIRODPhFu+fFvIRV6YXvcqAG6Rz
 qzjdeBBFFeuMWZkMjJj4VJmFyqpYUJTJ4BIdXQtVjHI5MB7fDDlleglmxFEd7THo4B
 +b3J4DTMCm7cY2GlpiycDfWy3evRWQsHhiM0q5FvTbtMIB4JbUUpXHQuQ1RWQWIXDc
 bAYqOH3cXWu3woxeqHEhCptFwNnQxf3FTbssDYxD6ZS0k7ZJhBzGZyruZFQXJMPfn+
 JZYcSnnxSi2Eiw+ZfXxse4rZ4IxJ5z//L96uk04i7Vde9ZVBf7c2P2TDL3dTG7tvZy
 owb0ViDMu19eME0TkPfYEAiQJT0TpGcVOTPeVf4lVubqKjN1lBV7VwWVJlHxV6KlMU
 TdxbKKMp6An5vJN1vDDZATz9kbvkDcJIxQ4UvDBxlTkVqchaMIGmKjS8TZPLg5OX0y
 zgCnJhyA8yPB52Ta2mJeuJecbZSeVKrm2yv9wm3LqmRve+6pyASyZVFVi7VMHDCGZf
 vsXHdaKneabxijrWEkJFxvjY=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aaeafeadbcso48144145ad.1
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 01:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770889951; x=1771494751;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Ub2tpRFSKIPilcfuJkFmB8H1huXuLHkLeHwhF0w7pM=;
 b=uwD2MzVwzB0JedHUklv+KLI4LcbUUAeumQd4uz52rKFrQSf8Qt1VRZnhMukUcgcUOe
 v4fD1ieZb9J90fQxP0rRLD+UCp2bcZwvOUkXLoDJFDiCuaPJPc+fkCkk/C8vo923gB1H
 x4ToptdIX1BJgHpj9Q3I66YPoZbnv/VvWCHT5efrxIZrY6vHWHqoTNwo7IdhyZ/xfKm5
 hA8t+u43gde6uGhQcwub51GMp5wl49vNlgPCZ0gx5BmQcdt+kainF8y1MKMlEZxpf3lW
 s6unF8nL14hbXj35Me+63FWnvo8/3CGzUvst3CixGRyYse9jGG6iJ78GyNYL1aMZtWIE
 unfg==
X-Gm-Message-State: AOJu0YzGTgVZH3eGyUg4q58Z+pO2fHAMt8Evxf7ZUkTPYqwUDoq+crfK
 0qYGFJBcllDV8VLMRlUzZTxayC8cNfwYf39ZcaJKV0Tg1uJqKtMgIttONFtnEVZ3fFjH8NNh71k
 J7uBNfTn8Kyoc6GuFT513KYmzjQhZRLnrKm/0dCcS/+TCvm++yc5vgDaw5yslU6U+/ObE
X-Gm-Gg: AZuq6aKgxFKJxJqN0ayWfXMsrh/llx6dX2f6OfZ3emdt5105chDDikVLlHDfBw9YArl
 w0P9HaNFZUQND47fXmmNdJEGwp7BBDfQoA5toKIGXXQv/GQPNMb6iwyIyXe4tUVS5XzwmYYknUl
 3G+39vDBxzHHYPceQu2hO9JHZz/mIm5YYKHxI8bY3iv7E2u02m2kdiG5/ouJIDKBSQXeRD5Xtkb
 gA76aFQLQF+EYe7+mrL/Fo7hQUkRL0cPDVjvKwzDGsOK3RSP4XGr/pgWT4dUb9PTNDLNDopUtIk
 BoUiDkTX+x55s03AJLyIi8QJJKf5sRfhkVkkTjvqYd4vLslB7AxMvNh5U1mz9pw40GTKIQZs+Yd
 KmzeJepu7hrE80RoWPBMT8oQJOv6Agg==
X-Received: by 2002:a17:902:c401:b0:2ab:230d:2d96 with SMTP id
 d9443c01a7336-2ab3987a015mr23149355ad.11.1770889951003; 
 Thu, 12 Feb 2026 01:52:31 -0800 (PST)
X-Received: by 2002:a17:902:c401:b0:2ab:230d:2d96 with SMTP id
 d9443c01a7336-2ab3987a015mr23149165ad.11.1770889950623; 
 Thu, 12 Feb 2026 01:52:30 -0800 (PST)
Received: from [10.0.0.86] ([123.208.221.96]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab298483f7sm45004635ad.16.2026.02.12.01.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 01:52:30 -0800 (PST)
Message-ID: <8becde91-d8ae-42c4-9c66-fcd022d3b8ca@canonical.com>
Date: Thu, 12 Feb 2026 20:52:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260207145942.299366-1-changwei.zou@canonical.com>
 <20260209075146.GA450151@pevik>
 <46bdaf39-4d82-4b33-94c6-0ef8525ffaf1@canonical.com>
 <20260209114700.GA488389@pevik>
 <9ca90f43-f8c9-4f7d-ae7c-5ea9653c7742@canonical.com>
 <20260212080909.GA134796@pevik>
Content-Language: en-US
In-Reply-To: <20260212080909.GA134796@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lapi/tls: reserve pre-TCB space to avoid
 undefined behavior in clone10.c
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
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKSSBjb3VsZG7igJl0IGFncmVlIG1vcmU6IExUUCBpcyBub3QgZ2xpYmMtc3BlY2lm
aWMuCuKAnE9uIHRoZSBzeXN0ZW0gSSBhbSBldmFsdWF0aW5nLCBMVFAgdXNlcyBnbGliY+KAnSB3
b3VsZCBiZSBhIG1vcmUgcHJlY2lzZSAKd2F5IGZvciBtZSB0byBwdXQgaXQuCknigJl2ZSBsZWFy
bmVkIGEgZ3JlYXQgZGVhbCBmcm9tIHJlYWRpbmcgTFRQ4oCZcyBzb3VyY2UgY29kZSBhbmQgdHJ1
bHkgCmVuam95ZWQgdGhlIGV4cGVyaWVuY2UuClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRoZSBp
bmZvcm1hdGlvbi4KS2luZCByZWdhcmRzLApDaGFuZ3dlaQoKCk9uIDIvMTIvMjYgMTk6MDksIFBl
dHIgVm9yZWwgd3JvdGU6Cj4gSXQncyBwcm9iYWJseSBub3QgcmVsZXZhbnQgaGVyZSAoaXQncyBt
b3JlIGFib3V0Cj4ga2VybmVsIGFyY2ggaW1wbGVtZW50YXRpb25zIHRoYW4gYWJvdXQgbGliYyks
IGJ1dCBqdXN0IHNhZmVyIHRvIG1lbnRpb24gTFRQIGlzCj4gbm90IGdsaWJjIHNwZWNpZmljLgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
