Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F4606A326
	for <ltp@archiver.kernel.org>; Sun,  1 Nov 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZWz92k5
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ACBA3E187B
	for <ltp@archiver.kernel.org>; Sun,  1 Nov 2026 17:47:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB5DF3C0069
 for <ltp@lists.linux.it>; Sun,  1 Nov 2026 17:46:48 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C8D56006DE
 for <ltp@lists.linux.it>; Sun,  1 Nov 2026 17:46:48 +0100 (CET)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so3634829a12.2
 for <ltp@lists.linux.it>; Sun, 01 Nov 2026 08:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793551608; cv=none;
 d=google.com; s=arc-20260327;
 b=mjBA4bXKt+L+aH2V+L1vXCUm7yrabEMrFg7t9CFrF5oBtNHwSWCL2bKmzuhz6mnJW2
 D3j6lrJoHSSwdWjqYxmU9YFzz5Ho4R6y3BbwN2OPWXRxkY3838QmStaAdaOrcbwAzqeD
 BcfePT12y9kstyR67UMz6dnDznYYedi5/IsPzDIrsSp36q7wsx7OukT3qJg4yX5G80hT
 FG+wYwuLSDpiCmso50OcA/Er8K9ZHoiehUdHUpxzrRP/run09Boxw7qVY8rzmzbxUmcz
 +5Kyi2IexXPXwBHEtX6uB6w7VJZ0xkZivfw9o0Weg6LA1pTrj/VRB0wEFmMhgOLUH+Ln
 JKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U4JgK0ABOqEpyXjy10uc1HGsEm7VlkLxuneFENtsw0M=;
 fh=uEtJhRULKvLSYzZ7YMUoa2ORjJFpzsYg86OmxpJ9RKU=;
 b=PbimW0VwQYh6qA9EgWylxt/K+SYpgZL/Su/fSOqFjMCsxSNt7nnzDVWxi4Yhz6IUEo
 wfN80H6JMcgp38f5ilEXwLnJfCC3a1F73uKupzROtsU09m2MAg9XVbLFfmbaNhMmTkFs
 AUw6NLflp0HAGKxuZoJ9Fykdun5P0sRS068z4H61U7q9GDCSF952S/5uL18FefSeen6o
 MTa4DJVlY2H18YIzfeggtc91RKs8wwVU/eAOQpV67RxuIWjJUWxGCAUWo30BySb51hp3
 coclWbrKTDafWNex3JAkmre4dHmGu+n5qrj/NXJGN+nCn+Gq4Jtg2mci6wFKMdx0E8FI
 U4hQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793551608; x=1794156408; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U4JgK0ABOqEpyXjy10uc1HGsEm7VlkLxuneFENtsw0M=;
 b=zZWz92k55z7nfFgh5S4MRMBsrbsA7lpq+x2zQezWR/ajgsXMDL3k5VmVqgzorLkIvE
 /7aIM4/6c5dW2FQq6JJLI46HLGKcvHLd3s47J58uz1TuTI0jxSNMKx+6jxh9sJis+iO5
 OFCbe61RPMs5/gzFZ1wsRjU9vqLfcJWupRStuPwAzO+MsxjUBQbNyMa6u3fm78SP6Dk6
 PUwYaAZYnQFTOO8Ob6m3lk8skhHmypC61nn/nEvBe5He6bRLf8K3EXxIYlMFOS5Ax0R2
 dvk7T8PkGhR4C9fwRvMASqFSLb1gTYP5kCcuvm6feJY1fTiZLfn4t+3amYa5v0ZzMug2
 udZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793551608; x=1794156408;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U4JgK0ABOqEpyXjy10uc1HGsEm7VlkLxuneFENtsw0M=;
 b=Wz7sQRWkPluPeGl+q+SjAWw+/f0KKEVQIZ0CIj+0y9adJdqettoAxpUVfoi0G9V4yb
 2qcwzIvuhlr3PMbVsthimg3QNgFY9VanuTlR6ysnyIwy2fllgGinhgA1pp8jgVu2CEIQ
 m0LBsmAotmDtC+7Ug4zrewaEhSe9UeUpda/4LfVx4hEBwr1AngaEMutLdoN5CYmV/6u7
 ZuV4Etmj/LVKkeIMqemEJ0lI/o2tqDCbK43r9to+4yWyc39HPxz0QtWShOOiBWHf81I7
 3KEuNtSLBxRxNCwrqVdOzesTEZPNLjTfKI02eYGS5lSO4xjwF9GmgV+wNhUdYBi5vNUg
 yqcA==
X-Gm-Message-State: APuU4Z+UZYpgIb8PFuxhK0pk1oyhuIBHmcNp8YmrXgi8meUsNqbnPmhj
 1MoAtFMHbITh3f/IDmIAVAiMw3vdC0VoYZNymMN7VhwkTu9AFGUgm+EQE94EK6wrypCnzMvJ6bT
 jTNWQM0YdbqhyeoFE/07JsbIxlR4HTR8=
X-Gm-Gg: AYBFou3F/IfrRsGPU0XtPNav2EBZjKy6g/1oVSDAh59fO4EuMToIChuNG1lokq0tJtl
 7guzr14WmLG1k3ijp/FfSxbXA0XqiT/dTUN8Dgworb4R8Mi683nhgTmLHw5uZzRUdLO2Zd0RMzv
 uyUtlVfOjQZ66GWEmeBvIP8BjIa1JzebAqs+5tQ9rSgPS1RNAkpA6SRCagyscnkMfidkwVXm9Vw
 /BBJOJNL0Dowh0WTxczPcVMX110d+nO3PTxQKtnHNd/w+YMLrodh0Vf3rsqOVazTwK03BltVbXr
 7ru8j08vjqqgP+NXBEm3pxevYp0naKvkCu0gwTKMCMbjeGH/JZKxSeOWERzUMVqjQysrpylL6W4
 BDYE6I8DpUfnDkL/7nXTB7cSw2uN7y3DvtvtJ11cNgtyeFuhLh9y0J2CbLrptcL+VPwUf2Q==
X-Received: by 2002:a05:6402:21d0:b0:6b4:953e:3157 with SMTP id
 4fb4d7f45d1cf-6b4d4d83da2mr4976844a12.35.1793551607434; Sun, 01 Nov 2026
 08:46:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <P5I00QE--F-9@tuta.io>
In-Reply-To: <P5I00QE--F-9@tuta.io>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Nov 2026 17:46:35 +0100
X-Gm-Features: AclHuK96p0K-oP1o6mPETU5jKyTjsw7kiZWBhDwRqGiyU3aEx7BiAQ9exLSLZEs
Message-ID: <CAOQ4uxhZL5Vk1NQ+Q4MW1f9kRLD0wWvAHZp-c8UwaESpyq+c-A@mail.gmail.com>
To: Edvard Conrad <edvard@tuta.io>
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify26: Move from staging to syscalls
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Jan Kara <jack@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBPY3QgMzEsIDIwMjYgYXQgNjozMeKAr1BNIEVkdmFyZCBDb25yYWQgPGVkdmFyZEB0
dXRhLmlvPiB3cm90ZToKPgo+IFRoZSBrZXJuZWwgZml4IHRoZSBzZWNvbmQgdGVzdCBjYXNlIG5l
ZWRzLCBjb21taXQgYzNkMzU1ZjQyN2NlICgiZnM6Cj4gbGV0IGJhY2tpbmcgZmlsZXMgaW5oZXJp
dCBGTU9ERV9OT05PVElGWSBmcm9tIHRoZSB1c2VyIGZpbGUiKSwgd2FzCj4gbWVyZ2VkIGludG8g
TGludXMnIHRyZWUgb24gMjAyNi0xMC0zMCBhbmQgd2lsbCBhcHBlYXIgaW4gdjcuNC1yYzEuCj4K
PiBNb3ZlIHRoZSB0ZXN0IG91dCBvZiBydW50ZXN0L3N0YWdpbmcsIGFuZCByZWNvcmQgdGhlIGZp
eCBpbiBhCj4gbGludXgtZ2l0IHRhZyBzbyB0aGF0IGEgZmFpbHVyZSBwb2ludHMgYXQgdGhlIG1p
c3Npbmcga2VybmVsIGNvbW1pdAo+IHJhdGhlciB0aGFuIGF0IHRoZSB0ZXN0Lgo+Cj4gU2lnbmVk
LW9mZi1ieTogRWR2YXJkIENvbnJhZCA8ZWR2YXJkQHR1dGEuaW8+Cj4gLS0tCj4gVGhlIGZvbGxv
dy11cCBQZXRyIGFza2VkIGZvciBvbiB0aGUgZmFub3RpZnkyNiB0aHJlYWQ6Cj4gICBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjEwMzAxMTAyMzMuR0E2NjE5MEBwZXZpay8KPgo+IFRo
ZSBmaXggaXMgaW4gTGludXMnIHRyZWUgYXMgb2YgMjAyNi0xMC0zMCwgYnV0IHY3LjQtcmMxIGlz
IG5vdCB0YWdnZWQKPiB5ZXQsIHNvIGlmIHlvdSB3b3VsZCByYXRoZXIgaG9sZCB0aGlzIHVudGls
IHRoZSByYyBpcyBvdXQsIHBsZWFzZSBkby4KCk5vdCBvbmx5IGlzIHJjMSBub3Qgb3V0IHlldCwg
YnV0IHdlIGFscmVhZHkgaGF2ZSBhIHJlcG9ydCBvbgp0aGUgZGlyIG9wZW4gYnVnIGZvciB3aGlj
aCB5b3UgaGF2ZSBhZGRlZCBhbm90aGVyIHRlc3QgY2FzZS4KU28gSSB0aGluayBpdCBpcyBiZXN0
IHdhaXQgZm9yIHRoZSBvdGhlciBidWcgZml4IHRvIGxhbmQsIGhvcGVmdWxseQpzb21ldGltZSBu
ZXh0IHdlZWsgYmVmb3JlIG1vdmluZyB0aGUgdGVzdCBvdXQgb2Ygc3RhZ2luZy4KCk9uIHRoZSBv
dGhlciBoYW5kLCBQZXRyLCB0aGlzIGlzIG5vdCBhIG5ldyBmZWF0dXJlLCBpdCBpcyBhIHJlYWwg
YnVnIGZpeC4KQXJlIHdlIGhvbGRpbmcgb2ZmIG9uIHJ1bm5pbmcgdGVzdHMgb24gbmV3bHkgZm91
bmQgYnVncwp1bnRpbCB0aG9zZSBidWdzIGFyZSBmaXhlZCB1cHN0cmVhbT8KCkhvcGVmdWxseSB0
aGVyZSBpcyBub3QgZ29pbmcgdG8gYmUgYSBsYXJnZSB0aW1lIGdhcCBiZXR3ZWVuCmJ1ZyByZXBv
cnQgYW5kIGJ1ZyBmaXgsIHNvIGl0IGRvZXMgbm90IG1hdHRlciBtdWNoLgpJIHdhcyBqdXN0IHdv
bmRlcmluZyBhYm91dCBiZXN0IHByYWN0aWNlLgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
