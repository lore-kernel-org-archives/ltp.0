Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4C606A339
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCkmEiGC
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 872553E99BE
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 21:49:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C271E3E98CB
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 21:48:52 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B2FB1000A0B
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 21:48:52 +0100 (CET)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c411e139259so236514966b.2
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 13:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793306931; cv=none;
 d=google.com; s=arc-20260327;
 b=qkWNePxoELhffqdYpvlkNt9I+Yt9k6MO7x4Z4NgqJSVM595R4//xq2rRTrcvUiXGtN
 qy9nC6h9ywh4PjtC8DBWmsSw7X/mnmRravtxE/nuw85q7xBR0wyeaihhtkqiO7pMGK60
 lMNdBqltZO9gOu8bklCKXSsfoJ4rXYnH6yO4LVAizth7QqNRfRSKQPJO4vmqluUK+/FW
 rW3L00535rDprDmiyDod94zcdpDzBsaH65MIRIc6CFaJEupT0epGqprGVjtGcV+6xZXm
 EVrt/JxncDt44nBOu+Z4MBxq1NkAR0f/RvdMqzkH3g01WiE52AQoQiAFggAfhzoZYkff
 tPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yyGVEok3SUnsRUPDNzW62kR2XDnd9rtJfHAqIMU3cc4=;
 fh=1SMTeKbyfpNuEk3TwPSj8vXbEoYmXOn2pxbrRWEicG4=;
 b=H+V/UeF0PwZPRfW1FZaAZigjHf5ZQ5C/hM9y6sGYTnb/kJ9OKTQT5CZrH3KArou6BO
 /iy6r3dRfMU9zuA7uuNfQAIHubdK/7puASyWODLL0y/vM3TMQMjigreStkHPwKOWiJZE
 f5c0hSOxsy7YnLna++l3ZkuWR6Fia7W/UkQQPCSbOeZbcfh4STrHrR1ZHzNo/ovyZ8On
 qhKZ6OGYKGOZI3lCcwfeWxKt/8cQVowR7NYvZbTGsIUtGtRxbsBNfFjbVSbwITwx0Oia
 XB9wh1olXhWWfPcQr7+vzO7AgFDbuq5Avg+FtZsXPoYUOd/r4yhJAfl85k2WDVmZnk3s
 fkxg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793306931; x=1793911731; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yyGVEok3SUnsRUPDNzW62kR2XDnd9rtJfHAqIMU3cc4=;
 b=YCkmEiGCR/HExJ+N6SGBqheJqttJZaSWO+vNWifDAkWdI/xmbcBZFNNKNz/QRLG0m2
 UcXtAX415qJIjNiIt7RtbBeQXMK+DlaieeZ7cOI7eVkFtgxSDh6K+ybVcW6I3EuLEzV7
 10Cn+a5h66OA/k6uiBIHhNpTyme1S392Cno8/n7Eb0h8tKEMXITODG1ttHOEPH8Boppf
 a0Mf+YCh1aRmcvzM8gbvvTOUsPYkJQM//oe55qV3Mmhlk8yJUMwOW2EJGb6Ljvl4qlRJ
 17y3FHuXKYd9HwAkE3VyZZ+JUo87BWtdgtfthwMFJaC6msVHmlV14fER9KQxn/lzZ1kD
 hIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793306931; x=1793911731;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yyGVEok3SUnsRUPDNzW62kR2XDnd9rtJfHAqIMU3cc4=;
 b=Q5V8gav9HOQwCACscjcA8cB5ODAQ7e28pAvN1NqPlVXQqG/plVe/LYsMvNIIAZaPL+
 81BbDwqxpRHZlTDu18Y6U7Iy0UIBEVibZr5jlnJ0/fmzRrfDdCmHe+IMyehbKRKmuXBG
 x2Xljgs2AWv7Qk+cGAxia7jlaYGpIQb+gKCGHtmEq9xs1zxCkWxzonQTqJu/8vJCZQ40
 n4XVQ0WJf/TncA3bGnx5nWCndR/XiW8qnuSoqKhDyaJWDgW3RKwjmaxwCfLmUT/5Bn+m
 Vjs39imt1rsctIPxNrOfoRgApc+v+BfOfZiyS1F7LUzhkEWxI5R4P7/L5U2ItkFFjXAq
 bVSA==
X-Gm-Message-State: AFq9FYJ6WLc+hlr0089s44B2EXcHvD9nY6S0b+5lV3IEIHX63s4FCyOq
 CNhsvZb+eQOz/qFL/7XrtgdQyLk6jptxgg2U3QVRFd83+EAdUsKopyvNtnWhzAV7Pr0sA0NlDhq
 7EY6w0SQT4UfrmnlsOsrr34Lr3KMvyE4=
X-Gm-Gg: AYBFou2IqY0Ym3OOMFyW0yxBha1Z4nyb92hC8c07bTBUQtPsw858bQKuxwvpO50F8js
 /K/bb3yodi9i0K59zLpVfO5LhGczbqegIS+IkhJdD4HWG6HwZLRGHygjsj5Q4bnWQPqOMaHaNdp
 +4fs0nulh4zcBLFMBENu/pkh5yiGuLfCnDM66PV7dR3I4bk5y+0/Irmse5kw7CUJatqkC/NPO5x
 TB+4T/uQMJXAn1zD/U3vB3IjWf8+YHApuqSK74vsNRC/8qwAgrbI59KOC7USMnbluGl6oh1HLyk
 J1fajA3TKMzoDnlCnUBjc6cZEZRrf5BMM6h2FhK4f8OUF4mejVvBv9yG8E0QpXHBTokoxwWag3p
 pX2jPxNtOfYJ36Hn4r3Z5vvAyQjQKMo+hZIyiVkp2yVKhYj8tvA4WUZwbhBcnMTL9HtmxH/Q=
X-Received: by 2002:a17:907:9c06:b0:c38:ee33:2931 with SMTP id
 a640c23a62f3a-c4ca7b5f423mr21132966b.37.1793306931390; Thu, 29 Oct 2026
 13:48:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029174907.98721-1-dennylin0707@gmail.com>
 <CAOQ4uxhc6a5jdwj+o_pCByYpwOC20=uHj0mi4D5n3UgrTqR7uQ@mail.gmail.com>
 <CAGEkeHdYqS_9wipk9oy=ofo=KbNpOwccuqVEYPg0LqzCykXUrw@mail.gmail.com>
 <CAGEkeHctUoNiE_zWUgyL7zoKdfb1JFaMnUuV80iqnrHff03pVQ@mail.gmail.com>
In-Reply-To: <CAGEkeHctUoNiE_zWUgyL7zoKdfb1JFaMnUuV80iqnrHff03pVQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 21:48:40 +0100
X-Gm-Features: AclHuK-Givt611yWPPOpcfU_eK22SOr0dtVokP5D-0hsrLczRm81zw8Y8xkfvoY
Message-ID: <CAOQ4uxjwSctaXOXA4o+=F5HT0zT0cbtPbxMvAhBQXLT-4gOZ3A@mail.gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] inotify13: check rename cookie pairing after
 adjacent moves
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBPY3QgMjksIDIwMjYgYXQgOToyM+KAr1BNIEh1bmd5dSBMaW4gPGRlbm55bGluMDcw
N0BnbWFpbC5jb20+IHdyb3RlOgo+Cj4gRm9sbG93aW5nIHVwIG9uIG15IGVhcmxpZXIgcmVwbHks
IEknZCBsaWtlIHRvIGNvbmZpcm0gdGhhdCBJJ3ZlIHVuZGVyc3Rvb2QKPiB5b3VyIGZlZWRiYWNr
IGNvcnJlY3RseSBiZWZvcmUgc2VuZGluZyB2NC4KPgo+IEJlbG93IGFyZSBleGFtcGxlIG91dHB1
dHMgZm9yIHRoZSBzZXZlbiBmYWlsdXJlIGRpYWdub3N0aWNzLgo+Cj4gMS4gRXh0cmEgZXZlbnQK
Pgo+ICAgICBmaWxlOiBnb3QgdW5uZWNlc3NhcnkgZXZlbnQgMzogbWFzaz0weDQwIHdkPTEgY29v
a2llPTEyMyBsZW49MTYgbmFtZT0iZW50cnkiCj4KPiAyLiBXcm9uZyBldmVudCBtYXNrCj4KPiAg
ICAgZmlsZTogZ290IGV2ZW50IDE6IG1hc2s9MHg4MCAoZXhwZWN0ZWQgMHg0MCkgd2Q9MiBjb29r
aWU9MTIzIG5hbWU9ImVudHJ5Igo+Cj4gMy4gV3Jvbmcgd2F0Y2ggZGVzY3JpcHRvcgo+Cj4gICAg
IGZpbGU6IGdvdCBldmVudCAwOiBtYXNrPTB4NDAgd2Q9MiAoZXhwZWN0ZWQgMSkgY29va2llPTEy
MyBuYW1lPSJlbnRyeSIKPgo+IDQuIFdyb25nIGZpbGVuYW1lCj4KPiAgICAgZmlsZTogZ290IGV2
ZW50IDA6IG1hc2s9MHg0MCB3ZD0xIGNvb2tpZT0xMjMgbGVuPTE2IG5hbWU9Im90aGVyIgo+IChl
eHBlY3RlZCAiZW50cnkiKQo+Cj4gNS4gTWlzc2luZyBldmVudAo+Cj4gICAgIGZpbGU6IGRpZG4n
dCBnZXQgZXZlbnQgMjogbWFzaz0weDgwIHdkPTIgbmFtZT0iZW50cnkiCj4KPiA2LiBJZGVudGlj
YWwgY29va2llcyBmb3IgdGhlIHR3byBGUk9NIGV2ZW50cwo+Cj4gICAgIGZpbGU6IGdvdCBzZWNv
bmQgRlJPTSBjb29raWU9MTIzIChleHBlY3RlZCAhPSAxMjMpLCB3ZD0xIG1hc2s9MHg0MAo+IG5h
bWU9ImVudHJ5Igo+Cj4gNy4gTWlzbWF0Y2hlZCBjb29raWVzIGZvciB0aGUgc2Vjb25kIEZST00v
VE8gcGFpcgo+Cj4gICAgIGZpbGU6IGdvdCBUTyBjb29raWU9MTI1IChleHBlY3RlZCAxMjQgZnJv
bSBzZWNvbmQgRlJPTSksIHdkPTIKPiBtYXNrPTB4ODAgbmFtZT0iZW50cnkiCj4KPiBEbyB0aGVz
ZSBmb2xsb3cgdGhlIHBhdHRlcm4geW91IG1lYW50PwoKWWVzLCBwZXJmZWN0LgoKPiBJbiBwYXJ0
aWN1bGFyLCB3b3VsZCB5b3Ugb21pdCBhbnkKPiBvZiB0aGUgYWRkaXRpb25hbCBldmVudCBjb250
ZXh0LCBzdWNoIGFzIHdkIG9yIGNvb2tpZSBpbiB0aGUgbWFzay1taXNtYXRjaAo+IG1lc3NhZ2U/
CgpJIHdvdWxkIGtlZXAgdGhlIGV2ZW50IGNvbnRleHQgaW4gMS00IGJlY2F1c2UgdGhhdCBpcyB0
aGUgY29tbW9uIHByYWN0aWNlCmFuZCBiZWNhdXNlIGluIHRoaXMgY2FzZSB0aGUgSU5GTyBpcyBu
b3QgcHJpbnRlZC4KCkkgd291bGQgb21pdCB0aGUgZXZlbnQgY29udGV4dCBpbiA2LDcgYmVjYXVz
ZSBpdCBpcyBhbHJlYWR5IHByZXNlbnQKaW4gdGhlIElORk8gbWVzc2FnZSBhbmQgaXJyZWxldmFu
dCB0byB0aGUgZXJyb3IuCgo+Cj4gSSdkIGFwcHJlY2lhdGUgeW91ciBmZWVkYmFjayBiZWZvcmUg
SSBzZW5kIHY0LgoKR29vZCBpZGVhLiBJIHNob3VsZCBoYXZlIGxlZCB3aXRoIGV4YW1wbGVzLgoK
VGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
