Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2F8C636CD
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 11:42:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A7393CC069
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 12:42:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 423F93CB83D
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 12:42:38 +0100 (CET)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 63F4E600D5B
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 12:42:38 +0100 (CET)
Received: by mail-io1-xd41.google.com with SMTP id a10so1835621iod.0
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 03:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=35pct/s2RNHX1pvnDdDc5mXhaGPyHShBIKPD9EDDTx4=;
 b=C1XLzSS2TnMjLTi50bv7wQ03Xs2ux5EiA9bgD3VHVo9cdG0xu6jC615Bxp7g+FuY3n
 0YTAv5ldbRk10tJBlRAQgIJWAPmJr0WTIv071KslIuDX7Wu9M0FTVnDBdllKs1QnJCjl
 MjnJZr2jet92GjyKfitKw/Q56TuXwrg1SzwUOI15DVkz3y9yHb/wS96vGfCBUrr9TVJj
 BcPQVq4mwlCZ2FjU9pCqqKYwMbrvkQlqj2WgwRcXK+OBczbvVHTqChfvAarozPLu/TvZ
 OSPmmbWpI4hDIxuLyAgs+vaGcXpM3mxrc6V+xFWUFIxD4MoLY1gcdJmOEUTyjeuALexU
 x/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35pct/s2RNHX1pvnDdDc5mXhaGPyHShBIKPD9EDDTx4=;
 b=rNbey1Z1vH9lDNh/kE6x7CSY3lK+ToP9WOl5c2zjDLvKwYUv6ceRrDyeUsh5/wDzSC
 EursCHHwhsBNouRMHZtqTbCS6vVottJDyWJBEQWpJ9gpfq1M4guwdCCR14fTpGVIoqik
 P5mfXMpHSAZ0tQoYY2YaytpXt2B1GK4W/Jr6uEm++sSB0zl3FTqcFkReGOjKX4IaZsWO
 kDH5MvIb48baXOKWUeB8OUgXjGDLGyjbffAt4s2w4WgXIPgyYqWJyeTlzlnYe6ND8tKz
 7Mu89bX9wrvOz2i9GEt33NcZbOe2Pq9Pl4ERNlAZMtoEF/TG8jXrt55rSzzTvC6hFNSN
 zwqg==
X-Gm-Message-State: AO0yUKWDUvi8dblJYqjzugQsPNCHOmxsjKVT1mcRM+ahxC3U/c7PaGfh
 r+C5ZoHTWYbqhAalSNuHwK5TB1FZLoiBhBEiC/s=
X-Google-Smtp-Source: AK7set8yPD5z1T9nOfoN9mhiZoUyYn/fVK3lpQkC0q5jY6IOGPfztib2RYcJfCFuoKaj3J/NrNNQgtSNp9mcSSWbXJM=
X-Received: by 2002:a6b:ea0e:0:b0:71b:9a7d:2eda with SMTP id
 m14-20020a6bea0e000000b0071b9a7d2edamr7730419ioc.86.1676029357036; Fri, 10
 Feb 2023 03:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20230210084408.8360-1-xiaoshoukui@gmail.com>
 <Y+YglzySGK8ts8y3@rei>
In-Reply-To: <Y+YglzySGK8ts8y3@rei>
From: xiao shoukui <xiaoshoukui@gmail.com>
Date: Fri, 10 Feb 2023 19:42:19 +0800
Message-ID: <CAOHshYVJDij+fqanWw+XMod-LWa0tqvJDZWXPqhSZxcBSHH8mA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1 1/1] Add ioctl_loop08 test for LOOP_GET_STATUS
 lock imbalance
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

U2luY2VyZSB0aGFua3MgZm9yIHlvdXIgYWR2aWNlLgpCYXNlZCBvbiBteSB0ZXN0c++8jHRoZSBs
b2NrZGVwIHdpbGwgYmxvY2sgdGhlIGlvY3RsIHJlcXVlc3QgdGhyZWFkIHJldHVybiB0bwp1c2Vy
c3BhY2Ugd2hlbiBpdCBkZXRlY3QgYSBsb2NrIGltYmFsYW5jZS4gUGxhY2UgaW9jdGwgcmVxdWVz
dCBpbiB0aGUgbWFpbgp0aHJlYWQsIHRoZXJlIGlzIG5vIGNoYW5jZSB0byBleGVjdXRlIGZpbmRf
a21zZyBmb3IgZGV0ZXJtaW5pbmcgd2hhdApleGFjdGx5IGEgbG9jayBwcm9ibGVtIGhhcHBhbmVk
IGFuZCBwcmludGluZyB0aGUgdGVzdCByZXN1bHQuCgpPbiBGcmksIEZlYiAxMCwgMjAyMyBhdCA2
OjQ3IFBNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiAr
c3RhdGljIHZvaWQgdmVyaWZ5X2lvY3RsX2xvb3Aodm9pZCkKPiA+ICt7Cj4gPiArICAgICBzdHJ1
Y3QgdGNhc2UgKnRjID0gJnRjYXNlc1swXTsKPiA+ICsgICAgIHB0aHJlYWRfdCB0aDEsIHRoMjsK
PiA+ICsKPiA+ICsgICAgIHB0aHJlYWRfY3JlYXRlKCZ0aDEsIE5VTEwsIGlvY3RsX3RocmVhZCwg
dGMpOwo+ID4gKyAgICAgdXNsZWVwKDUwMDAwMCk7Cj4gPiArICAgICBwdGhyZWFkX2NyZWF0ZSgm
dGgyLCBOVUxMLCBpb2N0bF90aHJlYWQsIHRjICsgMSk7Cj4gPiArICAgICB1c2xlZXAoNTAwMDAw
KTsKPgo+IFRoaXMgcGFydCBsb29rcyBzdHJhbmdlLCB3aHkgZG8gd2UgcnVuIHRoZSBjb2RlIHRo
YXQgY2FsbHMgdGhlIGlvY3RsIGluCj4gYSBzZXBhcmF0ZSB0aHJlYWQgaWYgd2UgYXJlIHNsZWVw
aW5nIGFmdGVyIHRoZSB0aHJlYWQgaGFzIGJlZW4gY3JlYXRlZAo+IGFuZCBxdWl0ZSBsaWtlbHkg
dGhlIHRocmVhZCB3aWxsIGZpbmlzaCBiZWZvcmUgdGhlIG1haW4gdGhyZWFkIHJldHVybnMKPiBm
cm9tIHRoZSBzbGVlcD8KPgo+IFdoeSBjYW4gd2UganVzdCBjYWxsIHRoZSBpb2N0bF90aHJlYWQo
KSBzZXF1ZW50aWFsbHkgaGVyZT8KPgo+ID4gKyAgICAgaWYgKCFmaW5kX2ttc2cobG9ja19pbWJh
bGFuY2UpKQo+ID4gKyAgICAgICAgICAgICB0c3RfcmVzKFRGQUlMLCAiVHJpZ2dlciBsb2NrIGlt
YmFsYW5jZSIpOwo+ID4gKyAgICAgZWxzZQo+ID4gKyAgICAgICAgICAgICB0c3RfcmVzKFRQQVNT
LCAiTm90aGluZyBiYWQgaGFwcGVuZWQsIHByb2JhYmx5Iik7Cj4gPiArfQo+ID4gKwo+ID4gK3N0
YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ICsgICAgIC50ZXN0X2FsbCA9IHZlcmlm
eV9pb2N0bF9sb29wLAo+ID4gKyAgICAgLm5lZWRzX3Jvb3QgPSAxLAo+ID4gKyAgICAgLm5lZWRz
X2tjb25maWdzID0gKGNvbnN0IGNoYXIgKltdKSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiQ09ORklHX0xPQ0tERVA9eSIsCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMIH0sCj4gPiArICAgICAudGFncyA9IChj
b25zdCBzdHJ1Y3QgdHN0X3RhZ1tdKSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgeyAibGludXgtZ2l0IiwgImJkYWM2MTZkYjliYiAifSwKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7fQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB9LAo+ID4gKyAgICAgLm5lZWRzX2RyaXZlcnMgPSAoY29u
c3QgY2hhciAqY29uc3RbXSkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJsb29wIiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBOVUxMIH0KPgo+IFRoZSB3aGl0ZXNwYWNlcyBoZXJlIGFyZSBhbGwgbWVz
c2VkIHVwLgo+Cj4gPiArfTsKPiA+IC0tCj4gPiAyLjIwLjEKPiA+Cj4gPgo+ID4gLS0KPiA+IE1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4g
LS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
