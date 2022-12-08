Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBABC4708D
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 01:36:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7B2E3CD996
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 02:36:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB72A3CA846
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 02:36:11 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 161DC60076B
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 02:36:11 +0100 (CET)
Received: by mail-pj1-x102b.google.com with SMTP id
 u15-20020a17090a3fcf00b002191825cf02so46560pjm.2
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 17:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z7fsxClu+Jd0NjsKaMgykMd0B6rUNb/ikhiPp8Ecv50=;
 b=jSOCGFfQXTv7C6fiSj3keLmm2Sq4F2mY9D9nO4IYVKX1hPEC61qXF+irZ0+ybvsab5
 ek9riN+E1ArwCXK9mkJ/u/01U8/LVzcpI9XLH6lQrfE1hurbZsz9u1XOGHytDPmYVFtn
 U+0okgzsa5kX6h846rbZAlzgLKkDoih61YnNOxdzvKiYjjg4kOxZNskp+OBHpmYbo7TN
 JeXcNfP9k34kF4B7S3eMfEJ9U4FJNYW6qjEGmIglAmpoEHci+8wxtqmcVF5C+en5q4YJ
 HBh2DBmLyg6kXgDZ9nb0iu9WiGqW8sQNlnBSm5ZLrnFk9Pj0VOHd6tPnxqbV2rYR0zLC
 k/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z7fsxClu+Jd0NjsKaMgykMd0B6rUNb/ikhiPp8Ecv50=;
 b=3UgWJFvxmbMRynufagS6RvEegHVxkKWUo1qxrlIItfwunGXc1DqosAoum5jM1wAKXx
 ApE0Z0n1O9QzeF6Lmbvf1Ym9LnmFuY2VgTrLPu1GbMGxzZumD8JZhZXKZ/MZk1nkqaSn
 1bvCQckcmpBdknovIHfrE36kVIgZpFNG+0OSF0502v3sPdN1XdtvrHEHNgl7Vh5RCtD8
 VI57iOmubecbAdI7jKQkbD/cpMkw4WE8aLaOYD/8GQ3RQfg2XG72Aeix9lo6NbZFMbW7
 iqrfjpbW1kTHozRaysoBbRylysMU5wDRNCZ99u3u5eaVfo3r4k5ewbEpyVdaR9VQOSPn
 lqLQ==
X-Gm-Message-State: ANoB5pmmtudaOKlasN8Yvn+B2RGLP6RonpjFbYKWeQ30QygxbYZ969hg
 C3SjfhGJBqboBqdXjWjWiDDTLw==
X-Google-Smtp-Source: AA0mqf5lVcwscHjcTHlexgdjucEx1RkH82KSuPvdJV0UjV2u7ZYNBp0UlKILRUfrDVy0Stgnws+aig==
X-Received: by 2002:a17:902:b416:b0:186:a22a:177e with SMTP id
 x22-20020a170902b41600b00186a22a177emr76022166plr.163.1670463369398; 
 Wed, 07 Dec 2022 17:36:09 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 f29-20020aa79d9d000000b00576ee69c130sm6464039pfq.4.2022.12.07.17.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Dec 2022 17:36:08 -0800 (PST)
Message-ID: <e05d3b3d-223f-ecf9-0e41-25bbae33eb54@kernel.dk>
Date: Wed, 7 Dec 2022 18:36:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To: Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYv_UU+oVUbd8Mzt8FkXscenX2kikRSCZ7DPXif9i5erNg@mail.gmail.com>
 <b7d8193c-7e15-f5cd-08d4-8ef788d9bb36@kernel.dk>
 <CADYN=9LaiBU-Q5=FSvFKTi_qzE1C45DkdUAfbaZH7FZhn2tbYw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADYN=9LaiBU-Q5=FSvFKTi_qzE1C45DkdUAfbaZH7FZhn2tbYw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next: LTP: syscalls: epoll_clt() if fd is an invalid fd
 expected EBADF: EINVAL (22)
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
Cc: regressions@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTIvNy8yMiAzOjI34oCvUE0sIEFuZGVycyBSb3hlbGwgd3JvdGU6Cj4gT24gV2VkLCA3IERl
YyAyMDIyIGF0IDE3OjIyLCBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+IHdyb3RlOgo+Pgo+
PiBPbiAxMi83LzIyIDg6NTg/QU0sIE5hcmVzaCBLYW1ib2p1IHdyb3RlOgo+Pj4gTFRQIHN5c2Nh
bGxzIGVwb2xsX2N0bDAyIGlzIGZhaWxpbmcgb24gTGludXggbmV4dCBtYXN0ZXIuCj4+PiBUaGUg
cmVwb3J0ZWQgcHJvYmxlbSBpcyBhbHdheXMgcmVwcm9kdWNpYmxlIGFuZCBzdGFydHMgZnJvbSBu
ZXh0LTIwMjIxMjA1Lgo+Pj4KPj4+IEdPT0QgdGFnOiBuZXh0LTIwMjIxMjAyCj4+PiBCQUQgdGFn
OiBuZXh0LTIwMjIxMjA1Cj4+Pgo+Pj4gdHN0X3Rlc3QuYzoxNTI0OiBUSU5GTzogVGltZW91dCBw
ZXIgcnVuIGlzIDBoIDA1bSAwMHMKPj4+IGVwb2xsX2N0bDAyLmM6ODc6IFRQQVNTOiBlcG9sbF9j
bHQoLi4uKSBpZiBlcGZkIGlzIGFuIGludmFsaWQgZmQgOiBFQkFERiAoOSkKPj4+IGVwb2xsX2N0
bDAyLmM6ODc6IFRQQVNTOiBlcG9sbF9jbHQoLi4uKSBpZiBmZCBkb2VzIG5vdCBzdXBwb3J0IGVw
b2xsIDogRVBFUk0gKDEpCj4+PiBlcG9sbF9jdGwwMi5jOjg3OiBURkFJTDogZXBvbGxfY2x0KC4u
LikgaWYgZmQgaXMgYW4gaW52YWxpZCBmZAo+Pj4gZXhwZWN0ZWQgRUJBREY6IEVJTlZBTCAoMjIp
Cj4+PiBlcG9sbF9jdGwwMi5jOjg3OiBUUEFTUzogZXBvbGxfY2x0KC4uLikgaWYgb3AgaXMgbm90
IHN1cHBvcnRlZCA6IEVJTlZBTCAoMjIpCj4+PiBlcG9sbF9jdGwwMi5jOjg3OiBUUEFTUzogZXBv
bGxfY2x0KC4uLikgaWYgZmQgaXMgdGhlIHNhbWUgYXMgZXBmZCA6IEVJTlZBTCAoMjIpCj4+PiBl
cG9sbF9jdGwwMi5jOjg3OiBUUEFTUzogZXBvbGxfY2x0KC4uLikgaWYgZXZlbnRzIGlzIE5VTEwg
OiBFRkFVTFQgKDE0KQo+Pj4gZXBvbGxfY3RsMDIuYzo4NzogVFBBU1M6IGVwb2xsX2NsdCguLi4p
IGlmIGZkIGlzIG5vdCByZWdpc3RlcmVkIHdpdGgKPj4+IEVQT0xMX0NUTF9ERUwgOiBFTk9FTlQg
KDIpCj4+PiBlcG9sbF9jdGwwMi5jOjg3OiBUUEFTUzogZXBvbGxfY2x0KC4uLikgaWYgZmQgaXMg
bm90IHJlZ2lzdGVyZWQgd2l0aAo+Pj4gRVBPTExfQ1RMX01PRCA6IEVOT0VOVCAoMikKPj4+IGVw
b2xsX2N0bDAyLmM6ODc6IFRQQVNTOiBlcG9sbF9jbHQoLi4uKSBpZiBmZCBpcyBhbHJlYWR5IHJl
Z2lzdGVyZWQKPj4+IHdpdGggRVBPTExfQ1RMX0FERCA6IEVFWElTVCAoMTcpCj4+Cj4+IFRoaXMg
c2hvdWxkIGZpeCBpdDoKPj4KPj4KPj4gZGlmZiAtLWdpdCBhL2ZzL2V2ZW50cG9sbC5jIGIvZnMv
ZXZlbnRwb2xsLmMKPj4gaW5kZXggZWM3ZmZjZTgyNjVhLi5kZTljNTUxZTE5OTMgMTAwNjQ0Cj4+
IC0tLSBhL2ZzL2V2ZW50cG9sbC5jCj4+ICsrKyBiL2ZzL2V2ZW50cG9sbC5jCj4+IEBAIC0yMTk1
LDYgKzIxOTUsNyBAQCBpbnQgZG9fZXBvbGxfY3RsKGludCBlcGZkLCBpbnQgb3AsIGludCBmZCwg
c3RydWN0IGVwb2xsX2V2ZW50ICplcGRzLAo+PiAgICAgICAgIH0KPj4KPj4gICAgICAgICAvKiBH
ZXQgdGhlICJzdHJ1Y3QgZmlsZSAqIiBmb3IgdGhlIHRhcmdldCBmaWxlICovCj4+ICsgICAgICAg
ZXJyb3IgPSAtRUJBREY7Cj4+ICAgICAgICAgdGYgPSBmZGdldChmZCk7Cj4+ICAgICAgICAgaWYg
KCF0Zi5maWxlKQo+PiAgICAgICAgICAgICAgICAgZ290byBlcnJvcl9mcHV0Owo+IAo+IFllcyB0
aGlzIHBhdGNoIGZpeGVkIHRoZSBpc3N1ZSBbMV0uCj4gCj4gQ2hlZXJzLAo+IEFuZGVycwo+IFsx
XSBodHRwczovL2xrZnQudmFsaWRhdGlvbi5saW5hcm8ub3JnL3NjaGVkdWxlci9qb2IvNTkzMTM2
NSNMMTM3MQoKR3JlYXQsIHRoYW5rcyBmb3IgY29uZmlybWluZy4gSSBkaWQgcXVldWUgdXAgdGhl
IGZpeC4KCi0tIApKZW5zIEF4Ym9lCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
