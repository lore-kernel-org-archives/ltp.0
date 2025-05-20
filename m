Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71744C3ABDD
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747740609; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=IeuVELrPZ0HFKvkFaMFfkVeHTnJ7IxDiysaxulgFgbk=;
 b=fBlV+q/hg4N1xkq5DRZr8CJ6D101g+clOqOgUM7Ty+VyNobIektpL4VokkQpNPcQ5TPvW
 QlYdbhVDsMGtp2ycPoC3z7bITtPUBq3nai5wtujIkD6XmXbYXU+Y2wZD1KMHFVXQTnCY2xa
 BopSuNZaANZ1rrgmDVU/Qsh0T9M3HMk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2AA03CC75F
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 13:30:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7E2B3CC6F9
 for <ltp@lists.linux.it>; Tue, 20 May 2025 13:29:47 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E256B207728
 for <ltp@lists.linux.it>; Tue, 20 May 2025 13:29:46 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a35b7e60cbso3529061f8f.1
 for <ltp@lists.linux.it>; Tue, 20 May 2025 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747740586; x=1748345386; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WdkzDeB4ZEbYNzMM/CFCs1n82xYu4av80SH+5gEyYCk=;
 b=G/rwGnWsLiUTL6ojoyS6xN2JsYlcYyDv/2+bSeY/O8BoQVyLYY3WqldHoiaR5HLTmC
 WXRK1eZwwJgIOsUqkGuvOZr49U6Df7CAyGxIehu13CKKXYSeG1K62ND1nyHVHzWt4pc0
 4VM9/njU4arYme0bf+5pZ8Mn5FDj9MN/ufteDyGgcqywtNqlWFTFVl54J8JMt0ecF5w1
 1XYb4C2Q1iukGQhhJJPh5lpBdfr7eH4k9lsAl5zAburFSxtgAJrkVRMIjJZR1sZNcOZ1
 9gu3H4dmKotOcG3bSN8hN9dnZ42RIMSJSD6QgJWV3Mjj8kzDRIP3CeA19gkd2R9uoeK5
 c9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747740586; x=1748345386;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WdkzDeB4ZEbYNzMM/CFCs1n82xYu4av80SH+5gEyYCk=;
 b=c4F0QeXpGBix1uF8khy63w72IdZ+5QchsQEGfkwhV3a+9cuHT166eXChzlWB+0oeSU
 TDFdArpQ4MxYbycf7Xowh8fsYeLI91bXqR9J1ioSwQ1WOniBoI9LfiRT7CmzxV+VAQ0e
 b0ef5x/iT4wLaXshf9MLNk4mt1cml0mgpQHpUjAeeL1SrIR33RAGvsO7lAJDQWWnGo77
 Jo5HgKa95alOyiqj/1zOd9OjJCzZR3At/W+1vqBXPCnUC7Ic5AhZmVbtGo3XOLF01jVm
 YbHnoe3jx0WQHLHhoSGh9UMG0m8NNmkLSqWkhP4GOm16kUg/dxAacjSXrWJxdMm1CPFa
 tOLQ==
X-Gm-Message-State: AOJu0YzkDYfbJoB9FhMgMtTPxuKqyTTjtZf5VjSpYFKScbx1se6UzzbV
 N4fsp/n//XgKEImt69+9FivsDB/9nHuN5H4Kju+JyRiKeSSpA1l/sX/ndWtdPLMxpE4=
X-Gm-Gg: ASbGnctRlIrOOtK9aXmqPPL18mYuEHNDHompPA+10mn6C1mhGuEcFqfwcdZtDawQlZb
 o4hbCV8STfgkbvQ/yYHbio7uL+5Uw/2UV8s9f1wNwoI6zabf07HYAzWexwkVgPBqI3Tsrau1TmG
 QvnhVy+L5p/LWRa43ZdmpIrKt+GVp+j/KXCY/mDN3BS//YdFxALUprKjWYSrLYrPno8A+8Yt/gs
 WY8MRI+F3AiFaGDeW1cU/Yo8+tyFNDpFbsrWS+CJfOa/p6ySRE8WW98V2MaiTZsExw/zoe2MxaY
 D6+WZT8WyUFQcDtfYmOZfDGdrmzoPZo0wXVpkxveVuD/4ucyyw==
X-Google-Smtp-Source: AGHT+IHHv7kPcQMhrG1FhXUMNdYLPgQb4Hwp/XPzgpaiI/7bsPgvNTgrMpcB73uYqQLSAGg7w2DR0Q==
X-Received: by 2002:a05:6000:186d:b0:3a3:6ae4:660c with SMTP id
 ffacd0b85a97d-3a36ae46808mr8451765f8f.22.1747740586135; 
 Tue, 20 May 2025 04:29:46 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-52dbab6b42esm8229927e0c.40.2025.05.20.04.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:29:45 -0700 (PDT)
Date: Tue, 20 May 2025 08:29:38 -0300
MIME-Version: 1.0
Message-Id: <20250520-fixes-modify_ldt-v3-1-a78c79341d0c@suse.com>
X-B4-Tracking: v=1; b=H4sIAKJnLGgC/33OQQ6CMBAF0KuYrq22BWx05T2MMaUdYBJpTQeJh
 HB3W1YsjMuf/Dd/ZkYQEYhddjOLMCJh8CkU+x2znfEtcHQpMyVUJSqheYMfIN4Hh830eLqBQ20
 b55TRrhAssVeEtZPU7Z5ybQh4HY23XT4UIrboj72hAWLud0hDiNP6wSiz+jM2Si65FkadzmWet
 Vd6Exxs6FneGtXGS/XDq+TBQFNVWkNZwsYvy/IFmD6t7g8BAAA=
X-Change-ID: 20250507-fixes-modify_ldt-ebcfdd2a7d30
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713; i=rbm@suse.com;
 h=from:subject:message-id; bh=eaM2i3e6aMvjSE2ObVL79AYpU+oXMt8r7ttaV3WJDuc=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoLGemDEM9lYAshw59a8LWBWSPzdUO9uAs4/7zS
 j6EWMEuFtCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCxnpgAKCRDJC4p8Y4ZY
 ph2AEAC3QJdzHaujwEed/hcvF85jw5f/3JKIgTE4bM7sKGj10oFeOOEGYipF72YJXHFwQLq+mWN
 xtGLCZQj8mA3lJ9v9WY0Cw0tervIdWetfT/Eu3X6T4iWqmBEt91H/mhCAEelxb8MtKmYbTH1Q03
 gcivmNGVSVbI3jOBCRaTujE0bLOapF9DI3xnfOd1MOy6QwRG3NlswXojg3UTCHTyOwsCvBTeZuA
 avENKcbqXvjzhfkP8PjOew4ypIiDMMSRqjlQNs9TwdlW7t8MXDiiqV0nsuwd3KXYmgIVeSCAbDR
 iU0dF8lHM5rjF9LVBpU/Zd5q14lJ9iMoJL5uUrHkPc0KX55SBvP7cJg/++xDmpEIrSohRTv1p1i
 rKcYusrPYp8VkG+FMn2r50F/fjMFRPXSXj0Y7HEgKUPujrkm398Lrx78agvGGczWKb6m8coGoqr
 bMQZ08AgICSIaz7y9PVlpQXISVpWLwWPoGcJZAIkEqSSN8FZ4fKNO9GE3vxocLMMwAP785E3Blh
 iqA63c1VNpOe32h+eFqyPeJtS7YRBt4fgXvJAl1rH7WgCboo9WEqG3z9vayFBkrmk3wnxHcGbKD
 uhXBNtN8mVJomqWjH1Qj8UcGobeP+l7yT5eQiKcy4rrjddshqSCjseZosp3WXrzXB695dbimife
 K3VLMExaHUasf0Q==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] ldt.h: Add workaround for x86_64
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBjb21taXQgYmUw
YWFjYTJmNzQyICgic3lzY2FsbHMvbW9kaWZ5X2xkdDogQWRkIGxhcGkvbGR0LmgiKSBsZWZ0IGJl
aGluZAphbiBpbXBvcnRhbnQgZmFjdG9yIG9mIG1vZGlmeV9sZHQoKTogdGhlIGtlcm5lbCBpbnRl
bnRpb25hbGx5IGNhc3RzIHRoZQpyZXR1cm4gdmFsdWUgdG8gdW5zaWduZWQgaW50LiBUaGlzIHdh
cyBoYW5kbGVkIGluCnRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jIGJ1dCB3YXMgcmVtb3Zl
ZC4gQWRkIGl0IGJhY2sgdG8gdGhlIHJlbGV2YW50CmZpbGUuCgpSZXBvcnRlZC1ieTogTWFydGlu
IERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PgpSZXZpZXdlZC1ieTogTWFydGluIERvdWNoYSA8bWRv
dWNoYUBzdXNlLmN6PgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1
c2UuY29tPgotLS0KQ2hhbmdlcyBpbiB2MzoKLSBFRElUTUU6IGRlc2NyaWJlIHdoYXQgaXMgbmV3
IGluIHRoaXMgc2VyaWVzIHJldmlzaW9uLgotIEVESVRNRTogdXNlIGJ1bGxldHBvaW50cyBhbmQg
dGVyc2UgZGVzY3JpcHRpb25zLgotIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyNTA1MTItZml4ZXMtbW9kaWZ5X2xkdC12Mi0xLWVhZWY1NTc3ZTQ0ZUBzdXNlLmNvbQoK
Q2hhbmdlcyBpbiB2MjoKLSBBZGRlZCBUQlJPSyBmb3IgYW55IHJldCAhPSAwIGluIG1vZGlmeV9s
ZHQgY2FsbCBpbiBjdmUtMjAxNS0zMjkwLmMKLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjUwNTA3LWZpeGVzLW1vZGlmeV9sZHQtdjEtMS03MGEyNjk0Y2ZkZGNAc3Vz
ZS5jb20KLS0tCiBpbmNsdWRlL2xhcGkvbGR0LmggfCAzMCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2xkdC5oIGIvaW5jbHVkZS9sYXBpL2xkdC5oCmlu
ZGV4IDZiNWEyZDU5Y2I0MWJmYzI0ZWI1YWMyNmMzZDQ3ZDQ5ZmI4ZmY3OGYuLjI1MzNlNTBiOWMw
MmE5NzQ5NDdjNjYyOGU5ZmEyMGM5YzYyNmFhMzQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGFwaS9s
ZHQuaAorKysgYi9pbmNsdWRlL2xhcGkvbGR0LmgKQEAgLTMxLDcgKzMxLDI3IEBAIHN0cnVjdCB1
c2VyX2Rlc2Mgewogc3RhdGljIGlubGluZSBpbnQgbW9kaWZ5X2xkdChpbnQgZnVuYywgY29uc3Qg
c3RydWN0IHVzZXJfZGVzYyAqcHRyLAogCQkJICAgICB1bnNpZ25lZCBsb25nIGJ5dGVjb3VudCkK
IHsKLQlyZXR1cm4gdHN0X3N5c2NhbGwoX19OUl9tb2RpZnlfbGR0LCBmdW5jLCBwdHIsIGJ5dGVj
b3VudCk7CisJbG9uZyBydmFsOworCisJZXJybm8gPSAwOworCXJ2YWwgPSB0c3Rfc3lzY2FsbChf
X05SX21vZGlmeV9sZHQsIGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKKworI2lmZGVmIF9feDg2XzY0
X18KKwkvKgorCSAqIFRoZSBrZXJuZWwgaW50ZW50aW9uYWxseSBjYXN0cyBtb2RpZnlfbGR0KCkg
cmV0dXJuIHZhbHVlCisJICogdG8gdW5zaWduZWQgaW50IHRvIHByZXZlbnQgc2lnbiBleHRlbnNp
b24gdG8gNjQgYml0cy4gVGhpcyBtYXkKKwkgKiByZXN1bHQgaW4gc3lzY2FsbCgpIHJldHVybmlu
ZyB0aGUgdmFsdWUgYXMgaXMgaW5zdGVhZCBvZiBzZXR0aW5nCisJICogZXJybm8gYW5kIHJldHVy
bmluZyAtMS4KKwkgKi8KKwlpZiAocnZhbCA+IDAgJiYgKGludClydmFsIDwgMCkgeworCQl0c3Rf
cmVzKFRJTkZPLAorCQkJIldBUk5JTkc6IExpYmMgbWlzaGFuZGxlZCBtb2RpZnlfbGR0KCkgcmV0
dXJuIHZhbHVlIik7CisJCWVycm5vID0gLShpbnQpZXJybm87CisJCXJ2YWwgPSAtMTsKKwl9Cisj
ZW5kaWYgLyogX194ODZfNjRfXyAqLworCisJcmV0dXJuIHJ2YWw7CiB9CiAKIHN0YXRpYyBpbmxp
bmUgaW50IHNhZmVfbW9kaWZ5X2xkdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5v
LCBpbnQgZnVuYywKQEAgLTQwLDcgKzYwLDE1IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNhZmVfbW9k
aWZ5X2xkdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCBpbnQgZnVuYywKIHsK
IAlpbnQgcnZhbDsKIAorCWVycm5vID0gMDsKIAlydmFsID0gbW9kaWZ5X2xkdChmdW5jLCBwdHIs
IGJ5dGVjb3VudCk7CisjaWZkZWYgX194ODZfNjRfXworCWlmIChydmFsID09IC0xICYmIGVycm5v
ID09IEVJTlZBTCkgeworCQl0c3RfYnJrXyhmaWxlLCBsaW5lbm8sIFRDT05GIHwgVFRFUlJOTywK
KwkJCSAibW9kaWZ5X2xkdCglZCwgJXAsICVsdSk6IDE2LWJpdCBkYXRhIHNlZ21lbnRzIGFyZSBw
cm9iYWJseSBkaXNhYmxlZCIsCisJCQkgZnVuYywgcHRyLCBieXRlY291bnQpOworCX0KKyNlbmRp
ZgogCWlmIChydmFsID09IC0xKSB7CiAJCXRzdF9icmtfKGZpbGUsIGxpbmVubywgVEJST0sgfCBU
RVJSTk8sCiAJCQkgIm1vZGlmeV9sZHQoJWQsICVwLCAlbHUpIiwgZnVuYywgcHRyLCBieXRlY291
bnQpOwoKLS0tCmJhc2UtY29tbWl0OiBiMDcwYTU2OTJlMDM1ZWMxMmMzZDNjN2E3ZTllOTdjMjcw
ZmQ0ZDdkCmNoYW5nZS1pZDogMjAyNTA1MDctZml4ZXMtbW9kaWZ5X2xkdC1lYmNmZGQyYTdkMzAK
CkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
