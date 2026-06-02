Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514CCCD5BD1
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 17:34:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5904D3E722A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 19:34:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E3643D0EA6
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 19:34:33 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0DA6A6005CC
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 19:34:33 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-91541fa94aaso391716985a.2
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780421672; x=1781026472; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWQSzAmFp7gSs1mzoTCtnIQVbbQU3l3lEF9E/l7chJc=;
 b=nK6/obaEw+3l3rJfkoES+R4bVLfL3oqXFjKPw/wserXDdLQB9zLWLgfToQGYTYaPrP
 Ug33P/MNzdy+r5x2aOnyMiVzmgX6l4CyIhey3TR445IfVvjWvGPD8KgHGOqcmbWMJlYg
 29XSWCPtqQLjw50Pq1Xd6kP6qvGz83/VG5UofupUfdkpb2nQGrxVON3jxJfeDS+QFbCR
 aXftnnKKsDndbkkchtfu9nGiBsyKqdPbj65QK/J55cqtt+NySp9kW/ocdmdzrnqkrY3c
 /31EknKqnKfWLXs9jj108BY8YgGVnh5rAETktZZBe6PC0c5PqN9/sj3rPvU6f2qRLt6b
 Ldvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780421672; x=1781026472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oWQSzAmFp7gSs1mzoTCtnIQVbbQU3l3lEF9E/l7chJc=;
 b=ikI9+GJNmOak78FTvYMEs0bO3NHMI0W/oJDHxwPzACyL00JdFdSHU02GxE+wPYNIk0
 nhQPSqTrYI3omCqDo0Rxr1CwSwcHLancL4jckA2H126Ziw3ubxOsNTlzxkI5GaOr9Oob
 cOZ9q9TgnxoiAfAuk7GwuMeRMIk1mG07uqHl5oz/jySHsygqa7VuKOvRBr9tf+gAxWmn
 sWerMRBtWsIyXosUgGCkwyZZeZREucLvKhbwwTu7bhaw3nonzDZxbQQfgee+HfEYWNT0
 F8lrLS29jDSuoz52TZiDToHCtBWKahth2kxIUZrekGA+nVQXGsJzBcTPwAk2SO8Hd2Sd
 XO4w==
X-Gm-Message-State: AOJu0Yyii/pBrZ+WyLMoHmOd30fDrdlsrtEfVGJ6SNBHCk7mj6C27WPV
 f+sBM3zqQbtLVMSVN1AEAPX0mHk/aeXlYlERvjX256wFQjVTRGeicEYQ
X-Gm-Gg: Acq92OHXAXGLsNjJwOLBsc3wta8chXhp4mCWJYPu/JFsaL37NpTQeI5BEpebyI/il8v
 D93hyVRvHUnm1v73mkqEHa8TKmADsib6MIM8daiUO16BIXgvupIgicpH16xf7sIZFof7q6jX6GP
 jhJvpYMUZPU4pWskz2VdjaYs07VRxIExU1YR1wE/FPoVksE12GNXmxtEXtt1ex+pn+ENUNCy2iA
 HURsAELWNu+s4RPYqmnILeAK0s7Z0kAjz8V3QeeH0tyZTQukMyLVQ2a8TW8qL0z5rE/OIvv/ySY
 pDcq7OuOUigKGz+aahKGcdg6NxuuQZBD6bIuLsJwUgvX0DoGAo4mljfDk2Usv1NcdFFiLV+Rv4+
 tYl9Ky5wjHwziCIplZTg7tw/KX+hTeDwS6OW45eXRX608boQM7ujgPhx0Pe0MuLR+23gsnOqu+c
 hGtALz5qIgXTLPWkvJSsg0Abk5dfCFSWDOT/4/IZDpQcMtMpZ5oTIZTyvEjo358OhU+n4+WKiTo
 FuXM4ya7yRzsoL90RekAK79T3lBrrcTGZ5MeeLBJ6Dt7xKTpQ==
X-Received: by 2002:a05:620a:172b:b0:915:3d27:a816 with SMTP id
 af79cd13be357-9158a39997cmr19812985a.49.1780421671633; 
 Tue, 02 Jun 2026 10:34:31 -0700 (PDT)
Received: from
 runnervm3jyl0.morafjup3qwelmjmd1ehkbn3kc.bx.internal.cloudapp.net
 ([20.106.183.52]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3eea49sm5267985a.44.2026.06.02.10.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 10:34:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue,  2 Jun 2026 17:34:30 +0000
Message-ID: <20260602173430.4191-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602-doc_add_missing_headers-v3-1-474deff77d2a@suse.com>
References: <20260602-doc_add_missing_headers-v3-1-474deff77d2a@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Add missing API references to api_c_tests.rst
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

SGksCgpbUEFUQ0ggMS8zXSBkb2M6IEFkZCBtaXNzaW5nIEFQSSByZWZlcmVuY2VzIHRvIGFwaV9j
X3Rlc3RzLnJzdAoKVGhlIGNvbW1pdCBtZXNzYWdlIGFjY3VyYXRlbHkgZGVzY3JpYmVzIHRoZSBj
aGFuZ2VzLiBUaGUgRml4ZXM6IHRhZyBpcwpjb3JyZWN0LiBUaGUga2VybmVsLWRvYyBmb3JtYXQg
Y29udmVyc2lvbnMgbG9vayBnb29kIG92ZXJhbGwsIGJ1dCB0aGVyZQppcyBvbmUgYnVnIChzZWUg
YmVsb3cpLgoKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90c3RfZnV6enlfc3luYy5oIGIvaW5jbHVk
ZS90c3RfZnV6enlfc3luYy5oCj4gLi4uCj4gKy8qKgo+ICsgKiB0c3RfZnpzeW5jX3dhaXRfYSgp
IC0gV2FpdCBpbiB0aHJlYWQgQS4KPiArICogQHBhaXI6IEZ1enp5IHN5bmMgcGFpci4KPiArICov
Cj4gICovCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCB0c3RfZnpzeW5jX3dhaXRfYShzdHJ1Y3QgdHN0
X2Z6c3luY19wYWlyICpwYWlyKQoKQlVHOiBUaGUgcGF0Y2ggYWRkcyBhIG5ldyBjbG9zaW5nIGAq
L2AgYXQgbGluZSA2MTcgYnV0IGRvZXMgbm90IHJlbW92ZQp0aGUgcHJlLWV4aXN0aW5nIGAqL2Ag
YXQgbGluZSA2MTggKHRoZSBvbGQgY29tbWVudCdzIGNsb3NpbmcgbWFya2VyKS4KVGhlIHJlc3Vs
dCBpbiB0aGUgZmlsZSBpcyB0d28gY29uc2VjdXRpdmUgYCovYCBsaW5lczoKCiAgNjE0OiAvKioK
ICA2MTU6ICAqIHRzdF9menN5bmNfd2FpdF9hKCkgLSBXYWl0IGluIHRocmVhZCBBLgogIDYxNjog
ICogQHBhaXI6IEZ1enp5IHN5bmMgcGFpci4KICA2MTc6ICAqLwogIDYxODogICovICAgICAgICAg
ICAgPC0tIHN0cmF5OyBjYXVzZXMgYSBjb21waWxhdGlvbiBlcnJvcgogIDYxOTogc3RhdGljIGlu
bGluZSB2b2lkIHRzdF9menN5bmNfd2FpdF9hKHN0cnVjdCB0c3RfZnpzeW5jX3BhaXIgKnBhaXIp
CgpBIGJhcmUgYCovYCBhdCBmaWxlIHNjb3BlIGlzIGludmFsaWQgQyBhbmQgd2lsbCBmYWlsIHRv
IGNvbXBpbGUuClBsZWFzZSBkcm9wIGxpbmUgNjE4LgoKVmVyZGljdDogTmVlZHMgcmV2aXNpb24g
4pyXCgotLS0KCltQQVRDSCAyLzNdIGRvYzogQ29tcGxldGUgc3RydWN0IHRzdF90ZXN0IHRhYmxl
IGFuZCBzaGVsbCBBUEkgZG9jcwoKVGhlIGVpZ2h0IG5ldyAuc3RydWN0IHRzdF90ZXN0IHJvd3Mg
YWxsIGNvcnJlc3BvbmQgdG8gcmVhbCBmaWVsZHMgaW4KaW5jbHVkZS90c3RfdGVzdC5oLiBUaGUg
bW50X2ZsYWdzIC8gbWluX3N3YXBfYXZhaWwgcmUtb3JkZXJpbmcgaXMKY29ycmVjdCAoYWxwaGFi
ZXRpY2FsIG9yZGVyIGlzIG5vdyBtaW5fciA8IG1pbl9zIDwgbW50X2YpLiBUaGUgc2hlbGwKQVBJ
IHZhcmlhYmxlIHJlZmVyZW5jZSBzZWN0aW9uIGhhcyBiZWVuIHZlcmlmaWVkIGFnYWluc3QgdGhl
CmltcGxlbWVudGF0aW9uIGluIHRlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2g6CgotIFRTVF9DSEVD
S1BPSU5UX1dBSVQvV0FLRS9XQUtFMi9XQUtFX0FORF9XQUlUIHNpZ25hdHVyZXMgYXJlIGFjY3Vy
YXRlLgotIFRTVF9SRVRSWV9GVU5DICgyIGFyZ3MpIGFuZCBUU1RfUkVUUllfRk5fRVhQX0JBQ0tP
RkYgKDMgYXJncykgbWF0Y2guCi0gVFNUX05FRURTX0tDT05GSUdTX0lGUyBkZWZhdWx0IGRlbGlt
aXRlciAoY29tbWEpIGlzIGNvcnJlY3QuCi0gVFNUX0RFVklDRV9TSVpFLCBUU1RfU0tJUF9JTl9M
T0NLRE9XTiwgVFNUX1NLSVBfSU5fU0VDVVJFQk9PVCwKICBUU1RfVElNRU9VVCBhbGwgbWF0Y2gg
dGhlIHNoZWxsIGxpYnJhcnkuCi0gLmZvcmtzX2NoaWxkIC8gLnJ1bnNfc2NyaXB0IGFzICJub3Qg
YXBwbGljYWJsZSIgaW4gc2hlbGwgaXMgY29ycmVjdC4KLSAubWluX3J1bnRpbWUgLyAubmVlZHNf
YWJpX2JpdHMgYXMgXC0gKG5vIHNoZWxsIGVxdWl2YWxlbnQpIGlzIGNvcnJlY3QuCgpWZXJkaWN0
OiBSZXZpZXdlZC1ieTogTFRQIEFJIFJldmlld2VyIDxsdHAtYWktcmV2aWV3ZXJAZXhhbXBsZS5j
b20+IOKckwoKLS0tCgpbUEFUQ0ggMy8zXSBkb2M6IEFkZCBTQUZFXyogbWFjcm9zIHJlZmVyZW5j
ZSBwYWdlCgpUaGUgbmV3IGFwaV9zYWZlX21hY3Jvcy5yc3QgZmlsZSBsaXN0cyAyNDUgU0FGRV8q
IGVudHJpZXMsIG1hdGNoaW5nCnRoZSBjb3VudCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuIFRoZSBT
QUZFX01NQVAgc2lnbmF0dXJlIHdhcyB2ZXJpZmllZAphZ2FpbnN0IHRzdF9zYWZlX21hY3Jvc19p
bmxpbmUuaC4gVGhlIHRvY3RyZWUgcGxhY2VtZW50IGluIGRvYy9pbmRleC5yc3QKKGFmdGVyIGFw
aV9jX3Rlc3RzLCBiZWZvcmUgYXBpX3NoZWxsX3Rlc3RzKSBpcyBsb2dpY2FsLiBUaGUgRm9yCkRl
dmVsb3BlcnMgc2VjdGlvbiBibHVyYiBpcyBhY2N1cmF0ZS4KClZlcmRpY3Q6IFJldmlld2VkLWJ5
OiBMVFAgQUkgUmV2aWV3ZXIgPGx0cC1haS1yZXZpZXdlckBleGFtcGxlLmNvbT4g4pyTCgotLS0K
ClNlcmllcyB2ZXJkaWN0OiBOZWVkcyByZXZpc2lvbgoKVGhlIG9ubHkgYmxvY2tpbmcgaXNzdWUg
aXMgaW4gcGF0Y2ggMS8zOiB0aGUgZHVwbGljYXRlIGAqL2Agb24gbGluZSA2MTgKb2YgaW5jbHVk
ZS90c3RfZnV6enlfc3luYy5oLCBpbnRyb2R1Y2VkIHdoZW4gY29udmVydGluZyB0aGUKdHN0X2Z6
c3luY193YWl0X2EoKSBjb21tZW50IHRvIGtlcm5lbC1kb2MgZm9ybWF0LiBUaGlzIGlzIGEgY29t
cGlsYXRpb24KZXJyb3IuIFBhdGNoZXMgMi8zIGFuZCAzLzMgbG9vayBnb29kLgoKTFRQIEFJIFJl
dmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
