Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C68C2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720809702; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5/WHgMPeNhfBFyKdBhPVY+k68K1W4o8j7UiRrsW3pVg=;
 b=FAdBF9j2Z9kdMN0NOpfZ/Xm8mdx0zD3TdaaB2uaHv3oIO/F0MtujD8an6fEJ+DWOckCA7
 rP46YkQxJYNoMTtZ8EFplsTdj9kbn6OLyi4z3Iq+og9BuqGxE/prWR9GmX3jHdN6wk9778X
 NZcR+ciUwPKEJ6JnriYAtxqg1jmUxt0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6BFF3D19BA
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 20:41:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01A703D199B
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 20:41:20 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 44039600F81
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 20:41:20 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58ce966a1d3so1571a12.1
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720809680; x=1721414480; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mh5dZEgwkrXwum+I5gal7+BLOWEIWV9G1ODsEarv8aM=;
 b=njouwT1s4diC3OkMoTU+OW7A540OX1Uxi/5c/wiHy7Rl6v8B03asCebGLIokNUllyr
 akOJp9l5UWWWcVpgDGDky1DKQ+s0YtZNfvfEQkMYJ4cgN3p8qJFqIReAkqrjGg3Qf749
 PHzdzN668W3iHTbfTE3OGtaF8zwOHP8qxK3r4VzIpjI8njsk9TPpLrbs4LtQG0nceRs/
 rlFehQsy8uGWdhyD1QauGcQNUAZrGutjKpHInL9DxM7LcIHgAb5Kgbd2BFyKazVrWJu3
 BCR7ge1f+0KHCDpnFn/H8+dw+KQj7Vmw9DCrxspekIUooIVazb3mOZN2GuzFXZfq00AS
 afWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720809680; x=1721414480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mh5dZEgwkrXwum+I5gal7+BLOWEIWV9G1ODsEarv8aM=;
 b=VTCtJZRUX6WEeNJyMs/B96k686KSdbyyhyqh7NCbBYjBbXRh/RG9W0bpQ4MqSIMiAR
 YhVFpAiGMVePMNqUp3xpbkZ7C6ZkDi+Gvt2s+vFWFm4u4OiqddK0ZolTA00yS/TtufHj
 5oA3khVwrVM3tXLa6buRY15AzmoetbZZV2kBzANmwLeB8bBR2iGTyckMxFVUVq6UoWtH
 Hisl460f7bBwBzO2+VggQvIhhaqLc8U6iCDK3jfQqsLr1s0cAg4Q4TLAG5+83R6A5S3+
 r6KvTE/AtoTDkXsecvccZvF5ePqB1A24+SxFBRukrV3A2MGcQmf2Rx8eg1XdnM3PrlC5
 1jdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPclXeqpa4jm0FE5+tamypNAob+xEROoviCC26bke4HJVx9sz+lbCKqXO67pEtPiw0qjuwMqgR2Io8bs4FhYgJFcQ=
X-Gm-Message-State: AOJu0Yzq0hsrjYN05VhWqF7QixDUfGbG/Z1NELxTCbAcXsmbPy45lKsu
 5cV5EFKd6QzjPMdXfzSLUrPaXGXGi7s6us56vR8tmnXjXiWVbwu0CKjU6U8d6xeLNsfF2WZiRnW
 qDH6FEwRNRs0rA/+Yla8d/CGkJxRAQTdHSi5P
X-Google-Smtp-Source: AGHT+IEr+E8CO4Ic3/PxEqhMayZoYEWqDQfLicqHYJttz+JFlv4LXzJzkwGFaxumrrvZwKUTHMovQh7Rc6Pelg1wa50=
X-Received: by 2002:a50:8acd:0:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-59acfaffd57mr15345a12.3.1720809679302; Fri, 12 Jul 2024
 11:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20240621110924.GA672386@pevik>
 <OS3PR01MB6391B5AD36997AB801C0E06A92D02@OS3PR01MB6391.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB6391B5AD36997AB801C0E06A92D02@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Date: Fri, 12 Jul 2024 11:40:52 -0700
Message-ID: <CAG4es9U42+AvgM2upLfuKjKzBySZ3y9kLRkGr=sngYw_uBBMNg@mail.gmail.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTm9idWhpcm8sCgpPbiBGcmksIEp1biAyOCwgMjAyNCBhdCAxOjQw4oCvQU0gPG5vYnVoaXJv
MS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPiB3cm90ZToKPgo+IEhpIFBldHIsCj4KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5j
ej4KPiA+IFNlbnQ6IEZyaWRheSwgSnVuZSAyMSwgMjAyNCA4OjA5IFBNCj4gPiBUbzogaXdhbWF0
c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4vv
vK/vvLPvvLQpCj4gPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+Cj4gPiBDYzog
bHRwQGxpc3RzLmxpbnV4Lml0OyBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiA+IFN1
YmplY3Q6IFJlOiBbTFRQXSBbUEFUQ0hdIGxpYjogdHN0X2ZkOiBBZGQga2VybmVsIHZlcnNpb24g
Y2hlY2sgdG8KPiA+IG1lbWZkX3NlY3JldAo+ID4KPiA+IEhpIE5vYnVoaXJvLAo+ID4KPiA+ID4g
bWVtZmRfc2VjcmV0IGlzIGEgc3lzY2FsbCBhZGRlZCBzaW5jZSA1LjE0LiBPbiBlYXJsaWVyIGtl
cm5lbHMsIHRlc3RzCj4gPiA+IHN1Y2ggYXMgYWNjZXB0MDMsIHJlYWRhaGVhZDAxIGFuZCBzcGxp
Y2UwNyB0aGF0IHVzZSBtZW1mZF9zZWNyZXQgZmFpbC4KPiA+ID4gVGhpcyBhZGRzIGEga2VybmVs
IHZlcnNpb24gY2hlY2sgdG8gdGhlIHRzdF9mZCBsaWJyYXJ5IHdoZW4gcnVubmluZwo+ID4gPiB0
ZXN0cyB1c2luZyBtZW1mZF9zZWNyZXQuCj4gPgo+ID4gQ3lyaWwncyBzdWdnZXN0aW9uIHRvIGFk
ZCBmYWxsYmFjayBkZWZpbml0aW9ucyBzb3VuZHMgdG8gbWUgYXMgYSBnb29kIGlkZWE6Cj4gPgo+
ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwL1puVkNjVTZqT1U5OERZZWtAeXVraS8KPiA+
Cj4gPiAgICAgICBJIGd1ZXNzIHRoYXQgdGhlIGJlc3QgZml4IGlzIHRvIGFkZCBmYWxsYmFjayBk
ZWZpbml0aW9ucyBmb3IKPiA+ICAgICAgIG1lbWZkX3NlY3JldCBpbnRvIGluY2x1ZGUvbGFwaS9z
eXNjYWxscy8qLmluIGZpbGVzLiBUaGF0IHdheSB3ZQo+ID4gc2hvdWxkCj4gPiAgICAgICBnZXQg
LTEgYW5kIEVJTlZBTCBwcm9wZXJseSBldmVuIHdoZW4ga2VybmVsIGRvZXMgbm90IHN1cHBvcnQg
dGhlCj4gPiAgICAgICBzeXNjYWxsLgo+ID4KPiA+IENvdWxkIHlvdSBwbGVhc2UgdHJ5IHRoYXQg
Zmlyc3Q/Cj4KPiBPSywgSSB3aWxsIGNyZWF0ZSBhIHYyIHBhdGNoIGJhc2VkIG9uIHRoYXQgc3Vn
Z2VzdGlvbi4KCkEgdmVuZG9yIG9uIGFybTMyIHJhbiBpbnRvIHRoaXMgaXNzdWVJIGFuZCBJIGRp
ZG4ndCBzZWUgYSB2MiBzdWJtaXR0ZWQKeWV0LCBzbyBJIHNlbnQgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbHRwLzIwMjQwNzExMDA0MjIwLjEzMzgwODYtMi1lZGxpYXdAZ29vZ2xlLmNvbS8Kd2hp
Y2ggaXMgd29ya2luZyBmb3IgbWU7IGRvIHlvdSBtaW5kIHRlc3RpbmcgaXQ/LgoKPgo+ID4KPiA+
IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKPgo+IEJlc3QgcmVnYXJkcywKPiAgIE5vYnVoaXJvCj4K
Pgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCgpUaGFua3MsCkVkd2FyZAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
