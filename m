Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B14DFF8868
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 17:00:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D28E33E5373
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 19:00:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B60F3E2D7C
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 18:59:55 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 60C0B1400B96
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 18:59:54 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8ef45a6d9dfso843029285a.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777395593; x=1778000393; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQleimgUpS8ICOkm5f9N+2w7SwgsrrETX6bacE4cDHI=;
 b=GwknENEFfXIdtgyKPGjFAPiWYLa5x4yDOvFjhqNFsgdorCwUwdGzXAvZtwugA22nV1
 xl54sewe7k/NeKg9Eqa78eZzeq/2dVrGN57q5SXD5qJ9RdukIIPcQtFUfXKtIsZK3y03
 doR6XIY1tjCuSW7VvruDKWcOIw4dYAaRwL6CJEq8oZp4NDIsrHxdvo827OuDJxYJ8sIK
 Na1ydtye1fWgcSsoUXSSzWWFAzBj6GwrYIt3yTh2PM1YPDmRZs5H6F75jY3STFR/uw04
 sQrr5BX4eiySKi00eemzTtooPuvoP6HK/MQA7VFsLySyUgeZBaaW39G/p9g9kMqzWN5g
 A4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777395593; x=1778000393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tQleimgUpS8ICOkm5f9N+2w7SwgsrrETX6bacE4cDHI=;
 b=fRrQmACBiGOcddCWmhEa3mfQN63x/ZQz7qabq1IcVjSY0nuVCo+fflI97Ft8mIBHm2
 2aUhZ5J1o44Yg+v3RqZ628GkvbhEufaWbGMshyprjrKXRLphyHm0C4uXthVAt5F5ZcMD
 QWYyBAc8fOPdo5SkmE8I/TxceN/veal63wGfjoyXQOPacqH34OqXmue4ltPT23GqGNTJ
 VTutpvnThYfdE/tFA5S5YevRT2DB4uRrJDw091Qiydh06N6tnkmxpZxCpG2yGEJncv8K
 7Es+bGuByYIbPKOGPkVXyFFHC8jqUWk5hP8gTOw3HdI3UX1+2j3rhpJ5R/LoBSCxs7oB
 UGLw==
X-Gm-Message-State: AOJu0YzobLxB9sEUL2EWLxaZFT7YFCwjf3oecpZzAJuC96THzCf6+eWG
 kKtg5XMrLMUXPMh5HLDveZH1IMc+fCeVRbxn1ny/EFMd2Cp0JucKY+Yc
X-Gm-Gg: AeBDievLKzjrun+Li4+YChON6TliTsBFGGlurSbpTiAv/n3EYsgXRpiCZyBX/vmv833
 jGwvSSvr3dU2rDXnDh8S4ijR2Z6+mss/OdsfISOl1arneq+zm9/xVYe1YK9hEX9rBDF8mE5dSEA
 0cLCI90h+ukg3qdVDMDsj7oswH4gyUYtoGjHwJ841UzgD4vUGpt7La0ZOnG0BGvQMGvJkcs2B/g
 1FT5eFiSiuWZqM0AtBXWE3ThMd1fmKgsa49miE+/SSxxAnkCcQ7e03qAVr12Gw7kJGdB1SgCwLX
 l0uno0SbmoErSZq7gUbkfOj/W9rTfVebQMXlfS9aSjsw3e94wSD4bug7xaGoUPcIgU7D9ieitnN
 RbpDtJVhIFueWtOI5YDiuNmNwnBIud++sbn4cWSGWEnkgagJ1h6hgjQS24k6D1tglcaEf37RJ9d
 H2smzitO2dcRLV06h1c/nMKR2Of74DkBsNAAQNBnEgP93Ch2TS5lSnEuiXDwnxmN4M4utz/ciOs
 ORpjpvJFeij0PegufDwTJo+o1cvzD8xOh+knQ6aEIKatNPN
X-Received: by 2002:a05:620a:2850:b0:8f8:5905:8291 with SMTP id
 af79cd13be357-8f8590588cfmr311762385a.47.1777395592874; 
 Tue, 28 Apr 2026 09:59:52 -0700 (PDT)
Received: from
 runnervmhkfpo.pkiwiyq2oyfulktwfhbrosnyua.bx.internal.cloudapp.net
 ([172.214.44.5]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c53a556esm236789985a.21.2026.04.28.09.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:59:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Apr 2026 16:59:51 +0000
Message-ID: <20260428165951.3950-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428161034.947614-1-pvorel@suse.cz>
References: <20260428161034.947614-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_violations.sh: Wait for ima_mmap to exit
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFR1ZSwgQXByIDI4LCAyMDI2IGF0IDE4OjEwOjMzICswMjAwLCBQZXRyIFZv
cmVsIHdyb3RlOgo+IGltYV92aW9sYXRpb25zLnNoOiBXYWl0IGZvciBpbWFfbW1hcCB0byBleGl0
Cj4gaW1hX3Zpb2xhdGlvbnMuc2g6IGltYV9tbWFwLmM6IFJlcGxhY2Ugc2xlZXAgd2l0aCBjaGVj
a3BvaW50cwoKQm90aCBwYXRjaGVzIGxvb2sgZ29vZC4KClJldmlld2VkLWJ5OiBMVFAgQUkgUmV2
aWV3ZXIgPGx0cC1haUBub3JlcGx5LmdpdGh1Yi5jb20+CgpQcmUtZXhpc3RpbmcgaXNzdWVzIG5v
dGljZWQgaW4gdGhlIHN1cnJvdW5kaW5nIGNvZGUgKG5vdCBpbnRyb2R1Y2VkCmJ5IHRoaXMgcGF0
Y2gpOgoKLSBpbWFfbW1hcC5jOjItOCDigJQgbm8gZG9jIGNvbW1lbnQgZGVzY3JpYmluZyB0aGUg
dGVzdDsgb25seSBhIGNvcHlyaWdodCBibG9jayBwcmVzZW50Ci0gaW1hX3Zpb2xhdGlvbnMuc2gg
4oCUIG1pc3NpbmcgIyAtLS0gZG9jIGFuZCAjIC0tLSBlbnYgYmxvY2tzCi0gaW1hX21tYXAuYzox
OC0yNSDigJQgY2xlYW51cCgpIGRvZXMgbm90IHNldCBmaWxlID0gTlVMTCBhZnRlciBTQUZFX01V
Tk1BUAoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBh
dGNoLiBUaGUgZnVsbCByZXZpZXcgY2FuIGJlCmZvdW5kIGF0OiBodHRwczovL2dpdGh1Yi5jb20v
bGludXgtdGVzdC1wcm9qZWN0L2x0cC1hZ2VudC9hY3Rpb25zL3J1bnMvMjUwNjYxMzA4MDQKClRo
ZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9m
dGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNzdWVzIHdpdGggdGhl
IHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dlc3Rp
b25zLgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
