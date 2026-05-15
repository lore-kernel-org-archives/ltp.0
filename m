Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48456CD4F25
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 09:56:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A99CA3E2842
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 11:56:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D8563E249B
 for <ltp@lists.linux.it>; Fri, 15 May 2026 11:56:04 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2A015200B6F
 for <ltp@lists.linux.it>; Fri, 15 May 2026 11:56:04 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50fb4a7d704so68021361cf.1
 for <ltp@lists.linux.it>; Fri, 15 May 2026 02:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778838963; x=1779443763; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9EVcryOCfTktiDJwijuFcXWLPKlrJXuF9UHIy/AxR4=;
 b=I0K/dzSHVmEODRd/YmBkW7CapVFTrrYpbjna4XvapgG+B9VM20xOuKXkCzboDGPJj2
 urYkO3qbMdEWqROfyDykNAFChr1W1XIzmur1L6W4Tqenw7G1AFBcXJCnspCRGEXhpx/d
 yqh5XJl+J22ePOQvDfARNGerDZrCv9tQbrkD2c3Ut/3wliRqohHC9KBbffkSDNxM52QV
 mSWB2BoWjJujmImtP5aQsDGxzHNn8GAu4XBS2ed1T2OfffIPjWDnePsw7ZR6Q3xtGQbe
 0zd2fothpSDDRE8FG1Z6NHZf9HsR1wgu623O/P7Z37KfxZ2djVhhSCQIv/1TEAcUKBE+
 6cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778838963; x=1779443763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J9EVcryOCfTktiDJwijuFcXWLPKlrJXuF9UHIy/AxR4=;
 b=LPiFDXS94f+B9A6B0F+8kn+vipAGtRJRqx1an16c+BeDz5hj9uWXIbCh4DgVv6M9xY
 +wWPLDpgIBaW3Y0IfBXpZ8VfzfcYYIJUTsd37GJsEH/sMSdrXDVxChRdIju76r0JhNSJ
 4FJFqg7loQVGczt+SXAHWD2Dot8V+QqAwJydwwudmbRdYFVdwjKFZHbSVVzJ57cXhfMo
 N2EFmn63x6SsN4G9PtGR+ZXmSqgEakol1g9qKrW0FOD24+yQTKZfE3hirLYMabu1Vl0r
 411yGj8RXXgd9r0XXC9uhOUScsSnpAuh/+koN3ij9NwpBHSfHjb+EZprPlkD4PzLelQR
 Jocw==
X-Gm-Message-State: AOJu0YxRDTOou4mzB/YOn+BaY+htqVEtKZHjzgdkgQl8uwmH0twNEXrg
 FlXVwVeILHhVpJElQVc6mykrfbfS0tdlPhGsCWmpxk0bnKic58LiwyOX
X-Gm-Gg: Acq92OEJxl5t0FCd49mjMsLtYFzigeSeUBeOKw2dumkYFkZ5dCp7muytjH9B5wRUjLP
 CjN4lHV3ztTE7vNuzczk6q6q3nAaNrwyw8PBxZm+9U+EgFSNAyGyMIhX/N74QaGB114ZKeAR9ii
 SZXSRKP3DZLBhF5BzYoAT8hN2iXhfO8A8ucsTexPhCth58xxNimZDgbIxw76DyDxRzP1OV8CWmD
 g0mOi8/RkADmgJgRRjwmSzzbP7bQAseAjlFUnNoYdAPbLyhtJEvsG/Q4PZQjK70Oz0zQcfe0nQ4
 JHg3pAMK7YMHmMdz3lZjNnIq+Edy2kHJd6S1KoKhn43upd7BrYg3mcTlIohzUTXd0k1ysOVdo94
 2f9ezcVLVJvdi3fQbF+1s0k3RLsUyy4wx0FA90Dtk935uN1gjmZoo9mswlEsHcitMpFXELim+hH
 0tl/VomeYEiALw1YAh+gnQ8fSxz9/pOH5kzoiGLenre9IulpAGVPWuLEqAdCY8YjSxfVsswqINI
 t+ySUnWEfHXQdmgFUdpltJ/6anYslZh7KLKsrb3bw==
X-Received: by 2002:ac8:5cc5:0:b0:515:6c6b:48a5 with SMTP id
 d75a77b69052e-5165a086833mr43386881cf.27.1778838962807; 
 Fri, 15 May 2026 02:56:02 -0700 (PDT)
Received: from
 runnervmeorf1.gsy2v5g5vcjefpjhwj5tqngg5b.ex.internal.cloudapp.net
 ([135.232.208.176]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516456d5c4dsm40245871cf.12.2026.05.15.02.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 02:56:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri, 15 May 2026 09:56:01 +0000
Message-ID: <20260515095601.3983-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509073921.8487-1-wegao@suse.com>
References: <20260509073921.8487-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pthread_detach_1-2: Fix failure on modern glibc
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

SGkgV2VpLAoKT24gU2F0LCA5IE1heSAyMDI2LCBXZWkgR2FvIHdyb3RlOgo+IHB0aHJlYWRfZGV0
YWNoXzEtMjogRml4IGZhaWx1cmUgb24gbW9kZXJuIGdsaWJjCgo+ICsJLyogV2FpdCBmb3IgdGhl
IG1haW4gdGhyZWFkIHRvIGFsbG93IGV4aXQgKi8KPiArCWRvIHsKPiArCQlyZXQgPSBzZW1fd2Fp
dCgmc2VtX2V4aXQpOwo+ICsJfQo+ICsJd2hpbGUgKChyZXQgPT0gLTEpICYmIChlcnJubyA9PSBF
SU5UUikpOwo+ICsJaWYgKHJldCA9PSAtMSkgewo+ICsJCVVOUkVTT0xWRUQoZXJybm8sICJGYWls
ZWQgdG8gd2FpdCBmb3IgdGhlIGV4aXQgc2VtYXBob3JlIik7Cj4gKwl9CgpbLi4uXQoKPiArCXJl
dCA9IHNlbV9pbml0KCZzZW1fZXhpdCwgMCwgMCk7Cj4gKwlpZiAocmV0ICE9IDApIHsKPiArCQlV
TlJFU09MVkVEKGVycm5vLCAiRmFpbGVkIHRvIGluaXQgdGhlIGV4aXQgc2VtYXBob3JlIik7Cj4g
Kwl9CgpbLi4uXQoKPiArCXNlbV9kZXN0cm95KCZzZW1fZXhpdCk7CgpGaXggbG9va3MgY29ycmVj
dC4gVGhlIGV4dHJhIHNlbWFwaG9yZSBlbnN1cmVzIHRoZSBjaGlsZCBzdGF5cyBhbGl2ZSBwYXN0
CnRoZSBwdGhyZWFkX2pvaW4oKSBwcm9iZSwgc28gZ2xpYmMgcmVsaWFibHkgc2VlcyBUSFJFQURf
U1RBVEVfREVUQUNIRUQKYW5kIHJldHVybnMgRUlOVkFMIHJhdGhlciB0aGFuIEVTUkNILgoKUmV2
aWV3ZWQtYnk6IExUUCBBSSBSZXZpZXdlciA8bHRwLWFpQG5vcmVwbHkuZ2l0aHViLmNvbT4KClBy
ZS1leGlzdGluZyBpc3N1ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcgY29kZSAobm90IGlu
dHJvZHVjZWQKYnkgdGhpcyBwYXRjaCk6CgotIDEtMi5jOjUg4oCUIHRlc3Rmcm13LmggdXNlZCBp
bnN0ZWFkIG9mIHBvc2l4dGVzdC5oOyBlbnRyeSBwb2ludCBpcwogIHRlc3RfbWFpbigpIHJhdGhl
ciB0aGFuIG1haW4oKSDigJQgZXN0YWJsaXNoZWQgY29udmVudGlvbiBmb3IgdGhpcwogIHRlc3Qg
ZnJhbWV3b3JrIHN1YmRpcmVjdG9yeS4KLSAxLTIuYzoxNzgg4oCUIGJyZWFrIGluc2lkZSAjaWYg
VkVSQk9TRSA+IDAgY2F1c2VzIGNhc2UgMSBmYWxsLXRocm91Z2gKICB3aGVuIFZFUkJPU0U9MDsg
aGFybWxlc3MgYmVjYXVzZSBjYXNlIDIvZGVmYXVsdCBhcmUgYWxzbyBnYXRlZCBieSB0aGUKICBz
YW1lICNpZmRlZi4KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9m
IHRoZSBwYXRjaC4KClRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRp
dmVzIGFsdGhvdWdoIG9mdGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQg
aXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25v
cmUgdGhlIHN1Z2dlc3Rpb25zLgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
