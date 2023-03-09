Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B22C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 12:09:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 808BF3CD87D
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 13:09:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1C373C1014
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 13:09:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D96791000BE3
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 13:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678363778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ff8TkSPNJq/QEkn8lDhWHMz7IvjsiIMKtg6A61ayZYg=;
 b=UcQk4gps2psU/eCOn6pzQlE80DTLiP70hbD6BVLvpSY3N89WEGmHN3Wn++r7RQuEuuB18h
 ix3ke14Erj0E03q+1KG5qZy5fqRmq6y/krjefDbfOIFnGzA1PIzoMayElEyFDbtUuMaOE0
 WuxnHqyYdOwgzqUNT/XvXFjXtpgV2rM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-8_x_uFqLPSGxCW9pLPn_LA-1; Thu, 09 Mar 2023 07:09:37 -0500
X-MC-Unique: 8_x_uFqLPSGxCW9pLPn_LA-1
Received: by mail-vs1-f72.google.com with SMTP id
 d5-20020a056102040500b004214c07da17so594033vsq.0
 for <ltp@lists.linux.it>; Thu, 09 Mar 2023 04:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678363776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ff8TkSPNJq/QEkn8lDhWHMz7IvjsiIMKtg6A61ayZYg=;
 b=UwwHJJBfddYoaIqOyNHObTU+h0RIBZZsm4dxkdBF+0+nmYaRdHcsekb88l9G1xI9O3
 FXl4xis4qXw1QAQd9EolM73tTF3C5ZRn/wwCICVEf+xOraUoDhe8U5lpmVXl1ghIPcOP
 RkcZ1CMMtkA+ljfhK9YD6vrBs0/W/Q7fPIn+KynhgnCfSdWQfYqVSocd0MYMAdHo32W1
 lMlMJQcelSsVMb3xxveVgsqcR5h8KQz3aaoWcW2h0ulOfc00E+V8ny/KhBFKSRJE2mw2
 GhwJ25vq+igvwqwVf+1bogn5axWsSNJWZvXfsZ/IZh96icVP6gIokGsmnU7xS0QQz8k2
 pwog==
X-Gm-Message-State: AO0yUKWYQF6ASJf85bk8cqH6ozjZA2vb31WQi1A6dPWwyq7UiaI1TeqS
 K7aQONiKDjPb44hyGE34A899OQZftMqbBazZvGjsrtaqcby6+Z65lPSSuz41vasxGwoYi3Fws63
 cp7ogbzWLGQYt4YfPZ8os1drZtM0=
X-Received: by 2002:a1f:4358:0:b0:429:73a8:6dba with SMTP id
 q85-20020a1f4358000000b0042973a86dbamr8706265vka.0.1678363776489; 
 Thu, 09 Mar 2023 04:09:36 -0800 (PST)
X-Google-Smtp-Source: AK7set/0RlmhixJdJpxI53QrSTUjCTNojbkLgyxtF26aFg6boHOYftPzitmw7jO32K+DIYYug9gZ+nOH2/mSKOBQwUw=
X-Received: by 2002:a1f:4358:0:b0:429:73a8:6dba with SMTP id
 q85-20020a1f4358000000b0042973a86dbamr8706263vka.0.1678363776233; Thu, 09 Mar
 2023 04:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20230309103346.5574-1-pvorel@suse.cz>
 <20230309104418.GA6311@pevik>
 <CAASaF6xDJskSnQRpocnz8TWXGbdvmxxRkS5ZJC1em4d_0ckP6w@mail.gmail.com>
In-Reply-To: <CAASaF6xDJskSnQRpocnz8TWXGbdvmxxRkS5ZJC1em4d_0ckP6w@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 Mar 2023 13:09:39 +0100
Message-ID: <CAASaF6y+GqhXUc4-EZHx89nRWcxV2_hRfAzdsMhbjVM4=A_qDw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] endian_switch01.c: Remove useless
 TST_NO_DEFAULT_MAIN
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

T24gVGh1LCBNYXIgOSwgMjAyMyBhdCAxMjoxN+KAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgTWFyIDksIDIwMjMgYXQgMTE6NDTigK9BTSBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4gPgo+ID4gSGkgSmFuLAo+ID4KPiA+
IG91dCBvZiBjdXJpb3NpdHksIHdoYXQgaXMgbWFpbjQoKSB1c2VkIGZvcj8KPgo+IEl0J3MgZnJv
bSAwODZjMTRmN2E0NjUgKCJUaGUgZm9sbG93aW5nIGhhY2sgZml4ZXMgdGhlCj4gImVuZGlhbl9z
d2l0Y2gwMS5jOjExNTogd2FybmluZzog4oCYbWFpbuKAmSB0YWtlcyBvbmx5IHplcm8gb3IgdHdv
Cj4gYXJndW1lbnRzIiB3YXJuaW5nLiBTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkBj
Y2xvbS5jbj4uIikKPiBidXQgSSdtIG5vdCBzdXJlIGl0IGlzIHN0aWxsIHVzZWQgdGhlc2UgZGF5
cy4KPgo+IEFzIHlvdSBmb3VuZCBteSBtaXNwbGFjZWQgVFNUX05PX0RFRkFVTFRfTUFJTiwgdGhh
dCBzZWVtcyB0byBjb25maXJtCj4gd2UgY2FuIGRvIHdpdGhvdXQgaXQuIEknbGwgaGF2ZSBhIGxv
b2sgb24gYSBwcGMgc3lzdGVtLgoKU28gSSBhZ3JlZSB3aXRoIHlvdXIgcGF0Y2ggaGVyZS4gQW5k
IHRoZW4gSSdkIHN1Z2dlc3Qgd2UgZm9sbG93IGl0CndpdGggb25lIHRoYXQgcmVwbGFjZXMgbWFp
bjQgd2l0aAoKQEAgLTQyLDYgKzQyLDkgQEAgdm9pZCBjaGVja19sZV9zd2l0Y2hfc3VwcG9ydGVk
KHZvaWQpCiAgICAgICAgICAgICAgICBleGl0KGVycm5vKTsKICAgICAgICB9CgorICAgICAgIGlm
ICghKGdldGF1eHZhbChBVF9IV0NBUCkgJiBQUENfRkVBVFVSRV9UUlVFX0xFKSkKKyAgICAgICAg
ICAgICAgIHRzdF9icmsoVENPTkYsICJQcm9jZXNzb3IgZG9lcyBub3Qgc3VwcG9ydCBsaXR0bGUt
ZW5kaWFuIG1vZGUiKTsKKwoKV2hhdCBkbyB5b3UgdGhpbms/CgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
