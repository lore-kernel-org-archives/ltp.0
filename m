Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7523CD3436
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 11:20:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C2A43E5D7E
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 13:20:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 844183C4EAA
 for <ltp@lists.linux.it>; Fri,  8 May 2026 13:20:16 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F0EE36002B8
 for <ltp@lists.linux.it>; Fri,  8 May 2026 13:20:15 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50e5bea4045so13678661cf.3
 for <ltp@lists.linux.it>; Fri, 08 May 2026 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778239215; x=1778844015; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tr45ZcCh4upldy8uX9aJuxHLJHf8/xN/8L1gneyUaQE=;
 b=QZANTk2rd9JZAgHeG/ABt6R0LWbLNyzAMFu0OpqRiVQvXKClvH41uQ8EGXFgrBVdll
 82phqHfdqiaXPfnbwg9QIo0Lb+dV7fbzoIxdctC4CUVH08bqcJAPTvSDVdRUwVuGzG52
 aC6iv/r9m31ED9w9JLPM0jMfHXKeKgKBi9nq8bA0DVwtNoQdH31FWCU8nGlKy1BSEAmL
 CG9vX0Ygyg+cAgAcQ3INnUXaYzUv0zrmZW09v/r6lIO1YA0CgHJk+SEaqoyiecrDrZJG
 8G1Ik9NNOQXP3fucf/tDeE7gFkaTcFaCANYGQ4vTy/ovoY+tQbu02AQKgsodwVw6CWUB
 AATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778239215; x=1778844015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tr45ZcCh4upldy8uX9aJuxHLJHf8/xN/8L1gneyUaQE=;
 b=rkf00eG2SUlfuLaRLyFYDjM8XAnAeoWss2/tPyI9m0xLcxZY1QFfqRPBzkUZxj7aOi
 nCOr1jov3Y/E8UMBFrULWtlMv7SV2ip9C0LMVk3NxmB3p9DebwuoKl3dhZ2/8sNqVglQ
 7Xw/B24X1/0dz9s6oS8alg+fFEmD8pdDdYc5YZZ7WWUMx805ZaBZj1i0ioNYF45c1Jbo
 bE1ksSANgILwq3b5UttfIzMZyoFhDbKaBkAe42uPj+YOpNQt5bzbWxSowlxnTzOrt+++
 sJU1Xy/VaMqt4XG74h/zKsHL8he0s6TwQ4MVOGee21QsxlbuNQgmWCGlCsyZYJKCCcZq
 Mpsg==
X-Gm-Message-State: AOJu0Yy7mS1lB5ZDHEumTGTIKECQDZpOFD3zDPV43nU9S7V9P1l2Wmi6
 iF3A8LYXZK3qlKBc51d83ZemjGh3SE0yWmShzFx+Nn4kusKxfbpv0D7WCx2Md2KBzGM=
X-Gm-Gg: AeBDietxdZvMU6DMRIuRgO9LYt+pkNuHTKqUH1uo5uzbYE0ja6xKA+SSPYmgHDt1QGc
 4BqKaynMTba9GcxTiSf8FMKG/SHPWM4Aqk1ka3v15Sltwg4GXiDqo/iQGVsZQ8+k2EbWz6qLu5i
 s4V9ILrJEbm0ooSwsHAq9mvimmIMwvCwd5ttclhai/ixQj3Hle5aDOITrsM4+ePwGzGxMpjxLnt
 3vkF9nfqH8dlhPGVmyfEFDPwTnBnYX42iOwe7KtpFL/sJFV3NLuCAb176VS41w9hA0daRlHtGVw
 RxB6rnCaGFMjwemUpWzMTGfE80pWqoCwVXOIfvDbwvyZQU9BiqGf6r1/wdyRwvWkSwPVRNl1ONr
 dlpoFi50GOvJiMxVnJneekh5Y9tfeivDz9IBaW1cgEhgO+TpdJFCi69T4ywf8uo5LzJVeiLZMhC
 MY8x5Dx22CrdtFvocghJBZFu9V2IgBLi8/I3YzbRaSmUTBlEXDz8JMqt5xLnqzbziCUN9uBHe7e
 aN9SmRnd7z5OlrMSm6tEKs1TKEPBAADeaczYDQ7GBlXkUZ/I5sHac1QdYt4DA==
X-Received: by 2002:ac8:7f47:0:b0:50b:577c:e259 with SMTP id
 d75a77b69052e-5148e9507b8mr27872871cf.35.1778239214636; 
 Fri, 08 May 2026 04:20:14 -0700 (PDT)
Received: from
 runnervmeorf1.f2vfsl0ystsenpp5sr4gipprta.ex.internal.cloudapp.net
 ([64.236.135.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e82ad3dsm13124411cf.26.2026.05.08.04.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:20:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri,  8 May 2026 11:20:13 +0000
Message-ID: <20260508112013.3998-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508100101.7741-1-wegao@suse.com>
References: <20260508100101.7741-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pthread_detach/1-2: Fix race condition between thread
 exit and join
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

SGkgV2VpLAoKT24gRnJpLCA4IE1heSAyMDI2IDEwOjAwOjU4ICswMDAwLCBXZWkgR2FvIHdyb3Rl
Ogo+IHB0aHJlYWRfZGV0YWNoLzEtMjogRml4IHJhY2UgY29uZGl0aW9uIGJldHdlZW4gdGhyZWFk
IGV4aXQgYW5kIGpvaW4KCj4gKyAgICAgICAvKiBXYWl0IGZvciB0aGUgbWFpbiB0aHJlYWQgdG8g
YWxsb3cgZXhpdCAqLwo+ICsgICAgICAgZG8gewo+ICsgICAgICAgICAgICAgICByZXQgPSBzZW1f
d2FpdCgmc2VtX2V4aXQpOwo+ICsgICAgICAgfQo+ICsgICAgICAgd2hpbGUgKChyZXQgPT0gLTEp
ICYmIChlcnJubyA9PSBFSU5UUikpOwoKPiArICAgICAgIC8qIEFsbG93IHRoZSB0aHJlYWQgdG8g
ZXhpdCAqLwo+ICsgICAgICAgZG8gewo+ICsgICAgICAgICAgICAgICByZXQgPSBzZW1fcG9zdCgm
c2VtX2V4aXQpOwo+ICsgICAgICAgfQo+ICsgICAgICAgd2hpbGUgKChyZXQgPT0gLTEpICYmIChl
cnJubyA9PSBFSU5UUikpOwoKPiArICAgICAgIHNlbV9kZXN0cm95KCZzZW1fZXhpdCk7CgpDb3Jy
ZWN0IGZpeC4gVGhlIHNlY29uZCBzZW1hcGhvcmUgZW5zdXJlcyB0aGUgY2hpbGQgaXMgc3RpbGwg
YWxpdmUgd2hlbgpwdGhyZWFkX2pvaW4oKSBpcyBjYWxsZWQsIGVsaW1pbmF0aW5nIHRoZSByYWNl
LgoKUmV2aWV3ZWQtYnk6IExUUCBBSSBSZXZpZXdlciA8bHRwLWFpQG5vcmVwbHkuZ2l0aHViLmNv
bT4KClByZS1leGlzdGluZyBpc3N1ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcgY29kZSAo
bm90IGludHJvZHVjZWQKYnkgdGhpcyBwYXRjaCk6CgotIDEtMi5jOiB1c2VzIHRlc3Rmcm13Lmgg
aGFybmVzcyB3aXRoIHRlc3RfbWFpbigpIGluc3RlYWQgb2YgcG9zaXh0ZXN0LmgKICBhbmQgbWFp
bigpIOKAlCBub3QgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLgoKLS0tCk5vdGU6CgpPdXIgYWdl
bnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLgoKVGhlIGFnZW50IGNhbiBzb21l
dGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdz
IGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UK
Y29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApM
VFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
