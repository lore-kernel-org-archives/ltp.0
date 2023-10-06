Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2642E95A91
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 09:49:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CCAA3CB1D6
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 11:49:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A6823C4BC9
 for <ltp@lists.linux.it>; Fri,  6 Oct 2023 20:42:20 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4D3F920650A
 for <ltp@lists.linux.it>; Fri,  6 Oct 2023 20:42:20 +0200 (CEST)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-690bc3f82a7so2185024b3a.0
 for <ltp@lists.linux.it>; Fri, 06 Oct 2023 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696617738; x=1697222538; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUg2EZ7t6QbVRPnDWD48q594BNWRx78W4j0XN10BHAI=;
 b=w0fLYYJvZXgU61MtAIHcZaf23tLg+rW+3ag+B+TfRc+KaAxeWw8d48qrL1b6g+a7YH
 cYLJ5c9EFLlTQqrvBeUpiyoIl8FIcAfIveKbMKrLECWtOM1O0n9x8rhn3aKKHmWKozTX
 duaO8aNUvvSJrW6KAsO/4qFBcxR8M4PIGnPmy//aAPe8B9bRAWSB6BQApRDCu2YP4bhp
 Mi+yO6dcwqxp4Mn+I9yjS7E69vtzRYzhXzJLuboORsduVOm3Fo+FH83zxoAfvJvke61n
 faFQTdQesSbB9rjU8A+HqDNZhjNROgoJMqQ4+O9Goqpbvpqmx8pW4WE4PqLLlPaLvUHd
 /VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696617738; x=1697222538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUg2EZ7t6QbVRPnDWD48q594BNWRx78W4j0XN10BHAI=;
 b=u09vZVF+z+B4zEJVFjmMj09jePmXICey4zdfJOg9zmsR6TQrwUYHrQzzK4brNjdcLW
 F7k6LXp3Q6OiZnpi1JCdx78Q/38QWDJ0ayPWe06fxmx1NhbcJjLTDZl3oKUwpeK4OJ+b
 9RJVTZHr1hAfwT9K4Zf5shssoxM4tw6q1fF58Ht3Qj2ak4htVB/89o911uutC00VQOax
 lJ8tdls3fzZdxYzMPEQ+U3DnqLr4siA1tESspzB6Dx+ADLFKX0zVnRY3jjY/h7NDIZT0
 EmFwbNseFV65AA0aF3jj6B60LAdHshQ88IVjizEez16P7NqoFWIe7Fa/rjk/laBMhIve
 IfaA==
X-Gm-Message-State: AOJu0YwmIs/w1gB4Y+yANx+COdeBfKcKHBHSmvCjz6xtjVV9Gy1sa6Sm
 ksQI2SDGylCAF2E9nLEv71GhKHNzrTSf0+CK4dH17w==
X-Google-Smtp-Source: AGHT+IHUgHZyUTaGNx4dt+tc7IETfj4Jd3vKuta+Ow98vKSTFqxL8VKDeSZBqnX6bo8pJV9HXU1eh1GpPub4W8AU5JA=
X-Received: by 2002:aa7:88ce:0:b0:690:b8b1:7b9e with SMTP id
 k14-20020aa788ce000000b00690b8b17b9emr8463628pff.0.1696617738312; Fri, 06 Oct
 2023 11:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org>
 <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
In-Reply-To: <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Fri, 6 Oct 2023 12:42:04 -0600
Message-ID: <CAEUSe78O-Ho=22nTeioT4eqPRoDNfcWCpc=5O=B59eaMvOkzpg@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 09 Oct 2023 11:49:17 +0200
Subject: Re: [LTP] [PATCH 6.1 000/259] 6.1.56-rc1 review
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
Cc: lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 Olga Kornievskaia <kolga@netapp.com>, stable@vger.kernel.org, shuah@kernel.org,
 f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org,
 linux@roeck-us.net, srw@sladewatkins.net,
 Richard Palethorpe <rpalethorpe@suse.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 LTP List <ltp@lists.linux.it>, linux-nfs@vger.kernel.org,
 Eryu Guan <eguan@redhat.com>, rwarsow@gmx.de, pavel@denx.de,
 linux-kernel@vger.kernel.org, conor@kernel.org, sudipm.mukherjee@gmail.com,
 Benjamin Coddington <bcodding@redhat.com>, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8hCgpPbiBUaHUsIDUgT2N0IDIwMjMgYXQgMTA6NDAsIE5hcmVzaCBLYW1ib2p1IDxuYXJl
c2gua2FtYm9qdUBsaW5hcm8ub3JnPiB3cm90ZToKPiBPbiBXZWQsIDQgT2N0IDIwMjMgYXQgMjM6
NDEsIEdyZWcgS3JvYWgtSGFydG1hbgo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3Jv
dGU6Cj4gPgo+ID4gVGhpcyBpcyB0aGUgc3RhcnQgb2YgdGhlIHN0YWJsZSByZXZpZXcgY3ljbGUg
Zm9yIHRoZSA2LjEuNTYgcmVsZWFzZS4KPiA+IFRoZXJlIGFyZSAyNTkgcGF0Y2hlcyBpbiB0aGlz
IHNlcmllcywgYWxsIHdpbGwgYmUgcG9zdGVkIGFzIGEgcmVzcG9uc2UKPiA+IHRvIHRoaXMgb25l
LiAgSWYgYW55b25lIGhhcyBhbnkgaXNzdWVzIHdpdGggdGhlc2UgYmVpbmcgYXBwbGllZCwgcGxl
YXNlCj4gPiBsZXQgbWUga25vdy4KPiA+Cj4gPiBSZXNwb25zZXMgc2hvdWxkIGJlIG1hZGUgYnkg
RnJpLCAwNiBPY3QgMjAyMyAxNzo1MToxMiArMDAwMC4KPiA+IEFueXRoaW5nIHJlY2VpdmVkIGFm
dGVyIHRoYXQgdGltZSBtaWdodCBiZSB0b28gbGF0ZS4KPiA+Cj4gPiBUaGUgd2hvbGUgcGF0Y2gg
c2VyaWVzIGNhbiBiZSBmb3VuZCBpbiBvbmUgcGF0Y2ggYXQ6Cj4gPiAgICAgICAgIGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92Ni54L3N0YWJsZS1yZXZpZXcvcGF0Y2gt
Ni4xLjU2LXJjMS5nego+ID4gb3IgaW4gdGhlIGdpdCB0cmVlIGFuZCBicmFuY2ggYXQ6Cj4gPiAg
ICAgICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFi
bGUvbGludXgtc3RhYmxlLXJjLmdpdCBsaW51eC02LjEueQo+ID4gYW5kIHRoZSBkaWZmc3RhdCBj
YW4gYmUgZm91bmQgYmVsb3cuCj4gPgo+ID4gdGhhbmtzLAo+ID4KPiA+IGdyZWcgay1oCj4KPiBS
ZXN1bHRzIGZyb20gTGluYXJv4oCZcyB0ZXN0IGZhcm0uCj4gUmVncmVzc2lvbnMgb24gYXJtNjQg
YmNtMjcxMS1ycGktNC1iIGRldmljZSBydW5uaW5nIExUUCBkaW8gdGVzdHMgb24KPiBORlMgbW91
bnRlZCByb290ZnMuCj4gYW5kIExUUCBodWdldGxiIGh1Z2VtbWFwMTEgdGVzdCBjYXNlIGZhaWxl
ZCBvbiB4ODYgYW5kIGFybTY0IGJjbTI3MTEtcnBpLTQtYi4KPgo+IFJlcG9ydGVkLWJ5OiBMaW51
eCBLZXJuZWwgRnVuY3Rpb25hbCBUZXN0aW5nIDxsa2Z0QGxpbmFyby5vcmc+Cj4KPiBMVFAgaHVn
ZXRsYiB0ZXN0cyBmYWlsZWQgbG9nCj4gICB0c3RfaHVnZXBhZ2UuYzo4MzogVElORk86IDEgaHVn
ZXBhZ2UocykgcmVzZXJ2ZWQKPiAgIHRzdF90ZXN0LmM6MTU1ODogVElORk86IFRpbWVvdXQgcGVy
IHJ1biBpcyAwaCAwNW0gMDBzCj4gICBodWdlbW1hcDExLmM6NDc6IFRGQUlMOiBNZW1vcnkgbWlz
bWF0Y2ggYWZ0ZXIgRGlyZWN0LUlPIHdyaXRlCj4KPiBMVFAgZGlvIHRlc3RzIGZhaWxlZCBsb2cK
PiAgIGNvbXBhcmVfZmlsZTogY2hhciBtaXNtYXRjaDogaW5maWxlIG9mZnNldCA0MDk2OiAweDAx
IC4gICBvdXRmaWxlCj4gb2Zmc2V0IDQwOTY6IDB4MDAgLgo+ICAgZGlvdGVzdDAxICAgIDEgIFRG
QUlMICA6ICBkaW90ZXN0MS5jOjE1ODogZmlsZSBjb21wYXJlIGZhaWxlZCBmb3IKPiBpbmZpbGUg
YW5kIG91dGZpbGUKCkJpc2VjdGlvbiBsZWQgdG8gIk5GUzogRml4IE9fRElSRUNUIGxvY2tpbmcg
aXNzdWVzIiAodXBzdHJlYW0gY29tbWl0CjdjNjMzOTMyMmNlMGM2MTI4YWNiZTM2YWFjYzFlZWI5
ODZkZDdiZjEpLiBSZXZlcnRpbmcgdGhhdCBwYXRjaCBhbmQKIk5GUzogRml4IGVycm9yIGhhbmRs
aW5nIGZvciBPX0RJUkVDVCB3cml0ZSBzY2hlZHVsaW5nIiAodXBzdHJlYW0KY29tbWl0IDk1NDk5
OGI2MGNhYThmMmEzYmYzYWJlNDkwZGU2ZjA4ZDI4MzY4N2EpIChub3QgYSBjbGVhbiByZXZlcnQK
dGhpcyBvbmUpIG1hZGUgbHRwLWRpbyBwYXNzIGFnYWluLgoKR3JlZXRpbmdzIQoKRGFuaWVsIETD
rWF6CmRhbmllbC5kaWF6QGxpbmFyby5vcmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
