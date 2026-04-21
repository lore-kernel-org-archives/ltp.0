Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B062CF8FA90
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 15:17:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 703743E4A82
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 17:17:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0FB33E4A82
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 17:17:03 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 85121200B7F
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 17:17:03 +0200 (CEST)
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dbb89ab229so4119962a34.1
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776784622; x=1777389422; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyXfFXBfYN001vPNd/rLz5DrQdiqEO0IWOBf2pp9tUA=;
 b=Vi2p5/iWy4G9PLLaA7mP9ZT88N5ciJIiweOPdgdbklSqt42SrJz7sidY4sgT0jb2p9
 gceZAyuf+qYcaOOVHN5SXGa6L/tnzPgVB1gYgPBTvHYg6t2ypf4Zm+tkvCAI74WzC0no
 Xhqros6ECvvEVYFll/SF1wBqBUPeLJ1FwaUoMqpJ1x6Rd5EKE2hX0+107zIdoGdQLxma
 xsXsneKOfCAlYLCjVSzpgCxZjQL8FK8q02PVOcLWaQnxdzdztzRGJsHWaP19cyTFSQaC
 zVQ419eNcqVVCQfgTytvvqOyFSTVc75v3TF/k2r83cNqeGq3EdYUwilcGSwe27oxfBeN
 O85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776784622; x=1777389422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OyXfFXBfYN001vPNd/rLz5DrQdiqEO0IWOBf2pp9tUA=;
 b=IRsD/hmC0kha51e9BJPG40i/LhMpkAB7bj7ui1v/wd7e6JOg05s0bRSJqtZis6Rr7z
 2A4KJ/923iqRM8/rSQEbmy5Dj6kVOpROSSFm3uL1mRMyynYyF7pTljZGcwiZs36cCKnP
 6fktY0TtNiTrWG3J6HaRCv1ZhIh25dBY1E1765+EXJ96M368ByxUS+6bUqDyVXjeu49c
 ihOdiwONJIUP0/Em0mNepAbbY3+LDn8PdOOfVRbPZ4PquWnUpRIUfn/Wv7AbeUBYlNLu
 Sc31ObGSDbAkoqtM8qlsFeb1PdgWkRXUg0e6viVOt7ZetUaEKOcDuj3D0d80ufiFpbLc
 0/dQ==
X-Gm-Message-State: AOJu0YzgMPhhrgl1WVgUMZ8Eb8PdX69DsZYP4bsPbdWOcXGR6Ids0Git
 /Yts+dufHHACjRI7Ol1ijjoyz3STYvWNvljq8NzZdHLE5euTiqnUShMONdu91AIz85k=
X-Gm-Gg: AeBDieuJKDepMST15rrV/RkGKe7Fr+VBj4GOsefI285xKDq0flFNzZJR17CHTq5APuc
 oFqJ/YYSmsbhCC67nZNIm+ErE6b7b+IhysE4ycLWTP+M551nNDYd3hOLMS0oWRJwPF4INCmhs63
 QufVRqwki8Z8NShe/nKagq6mpmBmQCBKiYCabCxqGF8oMTJtaRVXb4rVWb+9q6G9d1cvvBv2izj
 XqOp8B6D9kkrXD0eYC0KJv2K7IkXghdKsllw7uTHo0JPpyAn5yWh2w53ElrPL80SEhUhtKE/mN5
 J5ExlOXeQSuOjtpLu3PLstVs2iNhQkpmW/8aShIv61VHPo5xPbM65rwHXUOTePVhn7v1McRQVzx
 J7JB+tEGty2kg7GTcjnjnIhjbhE2Q33Vx64mwA9hMYvuy0VXeYaIHnOrAMJO4HocE1nvrvWdciM
 ZS33gWykDuZF1P4/QHRENpJdqSiniE+RWOqhL3bD1wVsnO1jZDeMZwR0+WMpPRJ9uupHBtE/lle
 164g0y1Wp6rmMyfG5bcP/FPX9ULh+O18Soh63yEPHey6gsdaAg=
X-Received: by 2002:a05:6808:181b:b0:46a:7ab9:c339 with SMTP id
 5614622812f47-4799c8f186cmr10119428b6e.14.1776784621542; 
 Tue, 21 Apr 2026 08:17:01 -0700 (PDT)
Received: from
 runnervmeorf1.cp2kj1zqiwluzlkaxfey11wpfg.ex.internal.cloudapp.net
 ([64.236.134.217]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe9638sm1099252185a.1.2026.04.21.08.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:17:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Apr 2026 15:16:59 +0000
Message-ID: <20260421151700.3873-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421144126.613547-1-pvorel@suse.cz>
References: <20260421144126.613547-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_test.h: Convert rest of doc to kerneldoc
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

SGkgUGV0ciwKCk9uIFR1ZSwgMjEgQXByIDIwMjYgMTY6NDE6MjYgKzAyMDAsIFBldHIgVm9yZWwg
d3JvdGU6Cj4gdHN0X3Rlc3QuaDogQ29udmVydCByZXN0IG9mIGRvYyB0byBrZXJuZWxkb2MKClRo
ZSBjb21taXQgbWVzc2FnZSBib2R5IGlzIG1pc3NpbmcuIFBsZWFzZSBhZGQgYXQgbGVhc3Qgb25l
IHNlbnRlbmNlCmV4cGxhaW5pbmcgd2h5IHRoaXMgY29udmVyc2lvbiBpcyBiZWluZyBkb25lIChl
LmcuIHRvIGVuYWJsZSBTcGhpbngKa2VybmVsZG9jIGV4dHJhY3Rpb24pLgoKPiArLyoqCj4gKyAq
IHRzdF9zZXRfdGltZW91dCgpIC0gU2V0cyB0aGUgdGltZW91dCBwYXJ0IG9mIHRoZSBvdmVyYWxs
IHRpbWVvdXQuCj4gKyAqClsuLi5dCj4gKyAqIEB0aW1lb3V0OiBBIHRpbWVvdXQgaW4gc2Vjb25k
cywgZGVmaW5lcyB0aGUgdG90YWwgdGltZSBhbGxvd2VkIGZvciBhIHNpbmdsZQo+ICsgKiB0ZXN0
IGl0ZXJhdGlvbiwgaW5jbHVkaW5nIHRoZSBzZXR1cCwgcnVudGltZSwgYW5kIHRlYXJkb3duIHBo
YXNlcy4KClRoZSBAdGltZW91dCBkZXNjcmlwdGlvbiBpcyBpbmFjY3VyYXRlLiBUaGUgaW1wbGVt
ZW50YXRpb24gY29tcHV0ZXM6CgogIG92ZXJhbGxfdGltZSA9IHRzdF9tdWx0aXBseV90aW1lb3V0
KERFRkFVTFRfVElNRU9VVCArIHRpbWVvdXQpICsgY29udGV4dC0+cnVudGltZQoKU28gQHRpbWVv
dXQgaXMgbm90IHRoZSB0b3RhbCB0aW1lIHBlciBpdGVyYXRpb24g4oCUIGl0IGlzIGFkZGVkIHRv
CkRFRkFVTFRfVElNRU9VVCBiZWZvcmUgbXVsdGlwbGljYXRpb24sIGFuZCB0aGUgcnVudGltZSBw
b3J0aW9uIGlzIGFkZGVkCnNlcGFyYXRlbHkuIFRoZSBkZXNjcmlwdGlvbiBzaG91bGQgcmVmbGVj
dCB3aGF0IHRoZSBhcmd1bWVudCBhY3R1YWxseQpjb250cm9scywgbm90IHRoZSByZXN1bHRpbmcg
b3ZlcmFsbF90aW1lLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcg
b2YgdGhlIHBhdGNoLgoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3Np
dGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmlu
ZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGln
bm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
