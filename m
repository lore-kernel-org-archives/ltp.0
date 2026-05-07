Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5C6CD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:22:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25F4D3E614D
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 16:22:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3D243C4C09
 for <ltp@lists.linux.it>; Thu,  7 May 2026 16:22:05 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2D9A61000465
 for <ltp@lists.linux.it>; Thu,  7 May 2026 16:22:05 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-5102582e237so5742411cf.2
 for <ltp@lists.linux.it>; Thu, 07 May 2026 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778163724; x=1778768524; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/t1riouThnqDX32afmFOwYqminBz1QpIPmXw6XzPFY=;
 b=Z91n+acFUK8zzMH+stMzEu37LX0HueWME2mJOL9RJ26lINcV8w31lnti54UNNEpoRc
 ZFu4kvHo0wurBySVmNk3PtQT9QwTIeJ4FW0yXrmo1bErALmGZ4bCluRkMzKICQ0Clw1q
 Kn4HfJm6D1iZPTkXbeHzZawrf8qq3/+7WW8fh09CQQ8ZhmQYet7yQZkUhEAj3gAaPKzN
 R4pcOUb3SIYWJ0/zk5m8+7yhPLcYH2a7KeQbYy36qhonFUaIutMzJ6/AZD6CujzdBQUP
 x+i53IZmEYwVeiUc8Fw2iTpX1OMWF0H29SrL7AlEiRBl6drZoYoIM4BMcaWW5KK7f/YP
 91Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778163724; x=1778768524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r/t1riouThnqDX32afmFOwYqminBz1QpIPmXw6XzPFY=;
 b=Ek24vcM4dSU2R9j/uklRYRLTmgBfIwwntDQA5nl1tOgXa0zEnYp8q/21dwcLSByXf8
 loIW0DjHhWk4dSCrQO56eTTAth5pd/6pUGKeJQ7LdOMquwLMrImKwkGkZxEIk8k3n050
 zcvR208eISoq/Q3HNoZUqSmN9ep0Ri+/aFEC2WUcddLavNH11apvMP3bpq6vc2iY+FMI
 XLPti1oHdY/Fd9SIwoAQSb3LfpW8aAPsg4UJFFNBS0u7vRCp5ATgRNPfhNrXnq0PXe0g
 qifFpcYAh+cPlUuUdYH67g079GZcMHkQfi0NLsYMDiTz3ODi2lPelB4YkTQQr6FQAATI
 ZuxA==
X-Gm-Message-State: AOJu0YyPhHXoyPin8wBNqLncCY98Dfo0XofqMDqPhLeBe3NIvIfT0Bbf
 zalLV9iQ4/hrARNb3csU/cQKPNd5s1AV7ZRtQ8Re86TOHcbOLxkYFiI1
X-Gm-Gg: AeBDievt9TVeAS/FlBSKtcJCaDJb2ddfsimhiIAf+4gwgk/1u/4s7GJ8fZMIYP8ZFbQ
 mdI2qZW99xJKE0rne9wxQkVBI9Z6Hgd8bTSZxT+HI3wPJFkufw2IQVeRtnnlq29Pc45yI1wN3v6
 SyQZ/3UM9lgLi2SAO+nQWZZkC1gik8vYNePQsM2zqVDtOaUBRVIp/ey7VcztWzVd/SIrIv05wk7
 EkGFsuDg23Q2yuZ6u2d+26sK+PxMi4pMzhw3D4jO2qp4pKk55njUKw2Gl/7PNOi6TjjTMtYPQaj
 sFlWsXDyQ0qY9wDxS/aOGvzDmNP3rnN30vYk0nNIOmwMYZrtwxnplmLv1C9EI5Xheg7TTLUuILz
 Cln1byHxlvpzguCWAn+qlTnG5OMeONWPoCeFp1PadRWhHDpZZkcJbDs4mGjEhTTF1p5cOeXkyl7
 j/w7G42aSkCUaGhvnbrIt3VVzP855bFtrlu00cWYFYjhw52FQlueHUsrkR6DiuQZ8/p8rXWxUvB
 ryEM5PmSc06WoHfkBF6gy7cr6ExnQ4d7Ydc1Y8VQJlaSJEy0g==
X-Received: by 2002:a05:622a:5589:b0:50d:6a40:692a with SMTP id
 d75a77b69052e-51461c25a17mr114342041cf.18.1778163723839; 
 Thu, 07 May 2026 07:22:03 -0700 (PDT)
Received: from
 runnervmeorf1.ojwbv2crwgce5ixxwjd2zbzc1d.bx.internal.cloudapp.net
 ([20.83.158.131]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040b87d97sm179327041cf.28.2026.05.07.07.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 07:22:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Thu,  7 May 2026 14:22:02 +0000
Message-ID: <20260507142202.4150-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507122858.19670-1-rbranco@suse.de>
References: <20260507122858.19670-1-rbranco@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add helper for checking UFFD feature support
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

SGkgUmljYXJkbywKCi0tLSBbUEFUQ0ggMS8zXSAtLS0KCk9uIFRodSwgNyBNYXkgMjAyNiAxNDoy
ODo1MyArMDIwMCwgUmljYXJkbyBCcmFuY28gd3JvdGU6Cj4gW1BBVENIIDEvM10gdXNlcmZhdWx0
ZmQ6IEFkZCBoZWxwZXIgZm9yIGNoZWNraW5nIFVGRkQgZmVhdHVyZSBzdXBwb3J0Cgo+ICsJdWZm
ZCA9IFNBRkVfVVNFUkZBVUxURkQoT19DTE9FWEVDIHwgT19OT05CTE9DSywgZmFsc2UpOwo+ICsK
PiArCXVmZmRpb19hcGkuYXBpID0gVUZGRF9BUEk7Cj4gKwlTQUZFX0lPQ1RMKHVmZmQsIFVGRkRJ
T19BUEksICZ1ZmZkaW9fYXBpKTsKCklmIFNBRkVfSU9DVEwgY2FsbHMgdHN0X2JyayhUQlJPSykg
aGVyZSwgdGhlIGxvY2FsIGB1ZmZkYCBpcyBub3QKY2xvc2VkIGJlZm9yZSB0aGUgdGVzdCBydW5u
ZXIgdGFrZXMgb3ZlcjsgdGhlIGNsZWFudXAgZnVuY3Rpb25zIG9ubHkKdHJhY2sgdGhlIGdsb2Jh
bCBgdWZmZGAuIENsb3NlIGl0IGJlZm9yZSB0aGUgU0FGRV9JT0NUTCBjYWxsLCBvcgpyZXN0cnVj
dHVyZSB0byBndWFyYW50ZWUgU0FGRV9DTE9TRSBvbiBhbGwgZXhpdCBwYXRocy4KCi0tLSBbUEFU
Q0ggMi8zXSAtLS0KCk9uIFRodSwgNyBNYXkgMjAyNiAxNDoyODo1NCArMDIwMCwgUmljYXJkbyBC
cmFuY28gd3JvdGU6Cj4gW1BBVENIIDIvM10gdXNlcmZhdWx0ZmQ6IFVzZSB0d28tc3RlcCBoYW5k
c2hha2UgdG8gcHJvYmUgZmVhdHVyZXMKCj4gRml4ZXM6IDE4NDBlZTIzZDE3MmI1YWIwNGNjYTdj
MmFjZmE0ODc1NWIwNDE5MTEKClRoaXMgY29tbWl0IGlzIG5vdCByZWFjaGFibGUgaW4gdGhlIGxv
Y2FsIGdpdCBoaXN0b3J5IChncmFmdGVkIHNoYWxsb3cKY2xvbmUpLiBQbGVhc2UgdmVyaWZ5IHRo
ZSBGaXhlczogdGFnIHJlc29sdmVzIGNvcnJlY3RseSBhZ2FpbnN0IHRoZQp1cHN0cmVhbSBMVFAg
dHJlZS4KClByZS1leGlzdGluZyBpc3N1ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcgY29k
ZSAobm90IGludHJvZHVjZWQKYnkgdGhpcyBwYXRjaCk6CgotIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvdXNlcmZhdWx0ZmQvdXNlcmZhdWx0ZmQwNi5jOjE0MiDigJQgbm8KICAubWluX2t2ZXIg
c2V0OyBVRkZEX0ZFQVRVUkVfUE9JU09OIHJlcXVpcmVzIExpbnV4IDYuNi4KCi0tLQpOb3RlOgoK
T3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4KClRoZSBhZ2VudCBj
YW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVuIGl0cwpm
aW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNzdWVzIHdpdGggdGhlIHJldmlldywg
cGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dlc3Rpb25zLgoKUmVn
YXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
