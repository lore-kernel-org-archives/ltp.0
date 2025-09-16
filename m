Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8A1CAC592
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 16:31:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8B4B3CDB57
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 18:31:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 298C93CD344
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 18:31:26 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F93C60073C
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 18:31:25 +0200 (CEST)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-25e5e1cd552so27482635ad.1
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758040284; x=1758645084; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sh23vzAY4zhgyBViC+bSV8XfkSwZGUCWtaMJhyioQaQ=;
 b=XXbOoJjOR7VRwGYv9dd3KMRqX1ntgKKXLEktuIBvPAwDwuZGBIKczhDf7QJbWb63aw
 oAz7bhg0wJwp+EmKtnRVw/+6Uw4pV00XHZ6MfYAi2XcKGvtvLs2YDsF/0EF8E8AWXT4u
 ozK69V3WA2w2gJIYFH/El3aNd9fBm9auShV6ZGQRql0sjNOJI68lnQnNjdk9RCirzSXe
 86viiBaLOJHFxAr0cNvrxI5eIKkmgoAnWXngaZ36gaV3shk2KSayKWIZ020ZYGS29dz/
 5PtBbszp7rLMoSfRWNHSvy01gIVSPEvhsH/nTigXjXBw7AgmwPsYo2Y3Ki9NJJr6gmBs
 GLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758040284; x=1758645084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sh23vzAY4zhgyBViC+bSV8XfkSwZGUCWtaMJhyioQaQ=;
 b=Fr1sibvJkSrY/eaRLZhzSlQqcXNzn5E1voGsyawX1QN/LKZBmCc7HJKkL8zjM66/o5
 akPx8/ygXnlLoegRD0RMRmj6KrJUMtoA1atH8xna6X2mvol/LT8pkNf69sOL5ksK8JAi
 3ytgLAqm+Xc96x5/2huHFpZJRXLaW8wHk1zlhnwlu3dpH+hVzq1SaxLvDYgJz2zoTzN9
 SVqjkpBNJetTNVoTfNH5wEQfRvaX1ZjAgUrs172QVDJt1z0WqXWaJMcgTuNs+2qP1/Pb
 zWPH4gTH1dOXh5mVwaA+cToEy3OC2e26MXe95+R3nA2/7Ldf2Ug812NnyPMmbF6M85mH
 AvOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOSvzxvpmDAUIsp9/7m40xnTIM/tMfgbOhTW4rpaGCezeYtcdiA2sHOvI4b6mExekN/bE=@lists.linux.it
X-Gm-Message-State: AOJu0YytTtTdjj2o8/W6txKU/wmBhmCZQ0i5l5QIfnUdXTTsnsagUgzg
 ai7WbZk1CNcoynlSrM4WciwoFjSVMTe9RL01BnEgYPEtMwzvyLsDkaNLtzUvtNIRawwo9lab2QA
 W675QBLInOVcmel8sdzVFJjECTgJhJVTBiHgdj7q5aA==
X-Gm-Gg: ASbGnctKiESenDSKtwtXH4nDeJretY5xfHERXp4NyP2E/WspTxFeBzMsP4SbZn/mCPl
 rts8l4Csdpl/pUwRC7wP3XNTCFmdazIs31dX76jPRLlY0WWwKd9xY7Yw1H4+muZhd/rALdZvf6a
 oXcN/icWwta0vVp2eO93z/nFXoGFlgPtufVuyxRR6g0Ml0XoiXmu0r55CA0qAUWFr5TBJ/FPmKg
 tLovAAgddF9iJnjrN161X5IeTzKSJmoxV3r6ip7DblArgqdhcR5AOQ9znPvXIbsZXKvXcs=
X-Google-Smtp-Source: AGHT+IECix1AVjlUybWwIVsJ9ka34tk4B2CLcGJk1N772RB5xGMQFqHG7lxLaX0geY/djsujO8rX54rNeXzB0pVIUu4=
X-Received: by 2002:a17:903:22c9:b0:246:4077:4563 with SMTP id
 d9443c01a7336-25d26077119mr182620025ad.34.1758040283778; Tue, 16 Sep 2025
 09:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuFdesVkgGOow7+uQpw-QA6hdqBBUye8CKMxGAiwHagOA@mail.gmail.com>
 <arfepejkmgi63wepbkfhl2jjbhleh5degel7i3o7htgwjsayqg@z3pjoszloxni>
 <h3ov4pformuvguwsxtziqui2alarqno37kdru4bjsppeok4sth@yb4iposv7okd>
In-Reply-To: <h3ov4pformuvguwsxtziqui2alarqno37kdru4bjsppeok4sth@yb4iposv7okd>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Sep 2025 22:01:11 +0530
X-Gm-Features: AS18NWAmN3EQ1CXxJUBXHQK10t01W_4u2E9Mk2iKi6ZR0XCV66DIDrPHefQHuH8
Message-ID: <CA+G9fYu7RAGNnHEJjLdH=YhEyUJ8gvcR-+JV79Z4OxO3ODTu-g@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next-20250915: LTP chdir01 df01_sh stat04
 tst_device.c:97: TBROK: Could not stat loop device 0
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
Cc: Christian Brauner <brauner@kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-block <linux-block@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAxNiBTZXB0IDIwMjUgYXQgMTc6MDQsIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+IHdy
b3RlOgo+Cj4gT24gVHVlIDE2LTA5LTI1IDEzOjA0OjQyLCBKYW4gS2FyYSB3cm90ZToKPiA+IE9u
IFR1ZSAxNi0wOS0yNSAxMjo1NzoyNiwgTmFyZXNoIEthbWJvanUgd3JvdGU6Cj4gPiA+IFRoZSBm
b2xsb3dpbmcgTFRQIGNoZGlyMDEgZGYwMV9zaCBhbmQgc3RhdDA0IHRlc3RzIGZhaWxlZCBvbiB0
aGUgcm9jay1waS00Ygo+ID4gPiBxZW11LWFybTY0IG9uIHRoZSBMaW51eCBuZXh0LTIwMjUwOTE1
IHRhZyBidWlsZC4KPiA+ID4KPiA+ID4gRmlyc3Qgc2VlbiBvbiBuZXh0LTIwMjUwOTE1Cj4gPiA+
IEdvb2Q6IG5leHQtMjAyNTA5MTIKPiA+ID4gQmFkOiBuZXh0LTIwMjUwOTE1Cj4gPiA+Cj4gPiA+
IFJlZ3Jlc3Npb24gQW5hbHlzaXM6Cj4gPiA+IC0gTmV3IHJlZ3Jlc3Npb24/IHllcwo+ID4gPiAt
IFJlcHJvZHVjaWJpbGl0eT8geWVzCj4gPiA+Cj4gPiA+ICogcmszMzk5LXJvY2stcGktNGIsIGx0
cC1zbW9rZQo+ID4gPiAqIHFlbXUtYXJtNjQsIGx0cC1zbW9rZQo+ID4gPiAqIHFlbXUtYXJtNjQt
Y29tcGF0LCBsdHAtc21va2UKPiA+ID4gIC0gY2hkaXIwMQo+ID4gPiAgIC0gZGYwMV9zaAo+ID4g
PiAgIC0gc3RhdDA0Cj4gPiA+Cj4gPiA+IFRlc3QgcmVncmVzc2lvbjogbmV4dC0yMDI1MDkxNTog
TFRQIGNoZGlyMDEgZGYwMV9zaCBzdGF0MDQKPiA+ID4gdHN0X2RldmljZS5jOjk3OiBUQlJPSzog
Q291bGQgbm90IHN0YXQgbG9vcCBkZXZpY2UgMAo+ID4KPiA+IFRoaXMgaXMgcmVhbGx5IHN0cmFu
Z2UuIFRob3NlIGZhaWxpbmcgdGVzdHMgYWxsIHN0YXJ0IHRvIGNvbXBsYWluIHRoYXQKPiA+IC9k
ZXYvbG9vcDAgZG9lc24ndCBleGlzdCAob3BlbiBnZXRzIEVOT0VOVCkuLi4gVGhlIGZhY3QgdGhh
dCB0aGlzIGlzCj4gPiBsaW1pdGVkIHRvIG9ubHkgYSBmZXcgYXJjaHMgc3VnZ2VzdHMgaXQncyBz
b21lIHJhY2Ugc29tZXdoZXJlIGJ1dCBJIGRvbid0Cj4gPiBzZWUgYW55IHJlbGV2YW50IGNoYW5n
ZXMgaW4gbGludXgtYmxvY2sgaW4gbGFzdCB0aHJlZSBkYXlzLi4uCj4KPiBIYSwgTWFyayBCcm93
biB0cmFja2VkIHRoaXMgWzFdIHRvIGNoYW5nZXMgaW4gVkZTIHRyZWUgaW4KPiBleHRlbnNpYmxl
X2lvY3RsX3ZhbGlkKCkuIE1vcmUgZGlzY3Vzc2lvbiB0aGVyZSBJIGd1ZXNzLgoKVGhhdCByaWdo
dCwKQW5kZXLigJlzIGJpc2VjdGlvbiBjb25maXJtZWQgdGhlIHNhbWUgY29tbWl0IHRoYXQgTWFy
ayBCcm93biByZXBvcnRlZC4KCiMgZmlyc3QgYmFkIGNvbW1pdDoKIFs2MDk0OTA1N2EyZTcxYzky
NDRlODI2MDhhZGYyNjllNjJlNmFjNDQzXQpibG9jazogdXNlIGV4dGVuc2libGVfaW9jdGxfdmFs
aWQoKQoKPgo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMDJkYTMzZTMtNjU4My00
MzQ0LTg5MmYtYTk3ODRiOWM1YjFiQHNpcmVuYS5vcmcudWsKPgo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb256YQo+Cj4g
LS0KPiBKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4KPiBTVVNFIExhYnMsIENSCgotIE5hcmVzaAoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
