Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471AAC43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 07:48:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 806603E2AE9
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 09:48:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DA073E1775
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 09:48:42 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0D594200269
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 09:48:42 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 d75a77b69052e-51c27a12102so3161371cf.1
 for <ltp@lists.linux.it>; Tue, 07 Jul 2026 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783410521; x=1784015321; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRXtrNJm+XFo9ca9lBhkLoA+5NgLneYCWHy+VbMWz1g=;
 b=sIk4PuWi5U5ylHh766xviTXDKmSJsTaAhs7M/O9g6bEsfif6CYqxf3JS1YeL0vJeka
 MzPk4TSCaDj0YWxFBHiX8N2xIWsd1QmLxkF4SGX3Ek3suA7ryR6Vkd8QdPcFpN2c/Mjq
 FGG48gncCMURbwB15coD7TiT2KLol8ayEn/r553sVXr00z8NoWaw6xdFAs5gGUTBmyk2
 ZRUCtANr0RiDJwW85faU5jUb6bAXZkrnCk7jLuUd04s8jCgKtd+djUmFaceCm6DPpb2r
 ovgQObE1lVZiXx3JyYopvsj9JN9E0om7i0/PqO097K8ePTOpNDuCYBiOqTRnNsAcohYc
 6qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783410521; x=1784015321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WRXtrNJm+XFo9ca9lBhkLoA+5NgLneYCWHy+VbMWz1g=;
 b=qqZBBtTNcj150ebaxq3F4k+r/R5UvYFAHyI5ZFdD4yB+ft9/h082uSKEAOSznWSBxV
 yiggIbYIbC+mZkxNYOFGkSSfjLnbajc6tcZL5H+agSnVISbRHmPghJ3eVMbhPmhKIRia
 24mZOjCHGaGlNyNItqqXlGT8iYDXI8kPOTVet7LCsPSX7Hqt1PMQfUA//BTe2lmVImvv
 fNhJyKE9OnOik89DKSDUhD6RIRg0xxgQnu7gj0GMZib3IDI81HwJqVoDhcX39YfBNnNY
 rfgSNbvqHLCpPJwOM5MAl/QIdobZ6vwaMRNjQrnIhePRVuQv/QIAdHeMDzxIwtu0QvWV
 3IUA==
X-Gm-Message-State: AOJu0Yw9xjxVFSzGX3b2hzJpk0pDaKwYGm8NvJ4aO5Wou8YZoT2DJvW0
 lgnTKMsgB8LdKmgJM3ThChXXbHE1UAF2j6JD+yZmRsY5A5CSEuJs7G9L
X-Gm-Gg: AfdE7clS42TAtOKWGCYYYYv3mup9YATphusKt4Agtl7op3u2vY9HBNIsoxJ+MSp7ul0
 MYX9tzcwWKwBsCiAv8rNlhe1ON1CAermb1QF4o5IpCBVkJLLKC1AHrOXc1x8PM2zlPWav7shXCj
 qPkF/qqGDqv2CX4ejBwxq2LwHKSmrzH4IAhmh1Y1km70S8GO42OJ+7zBa785u/0QNHUeIZeCiMt
 GzAMNT9JyWVsYYMwwdLoTY6im0O95rXLSWIyqs227LCxMd5G0UD15xWHlpBSzgDSyYLFJHyXcHe
 xQ/7jU3xmkrF5TQN6to7CqsUEWkkBpTsSKdEapRhlxnMoMEudniL5qMlh1q2YStj1MQHCXKSx3C
 fUUEYK9woAqv8Whwhvjgo88sgciOWIB8MIDXQXlvNEdiUohmLaaF3DUJTVLHYT7zBkTDKLRNAqb
 ZL4Sar8t5NIPu1+25oQTV+SXPeyP36ILYSZCbakpewe2WykJLnfPJEd/qkLOX4wGsW4Rhnny1Ah
 yNWrdYZQA2LGVoSGJKJdI09zNTA1A==
X-Received: by 2002:ac8:58cd:0:b0:51a:8c97:938d with SMTP id
 d75a77b69052e-51c748eda73mr42614451cf.68.1783410520425; 
 Tue, 07 Jul 2026 00:48:40 -0700 (PDT)
Received: from
 runnervmkkn4f.w5kyndb1gvhehekumsuunpfd1d.bx.internal.cloudapp.net
 ([172.214.104.51]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471fdc708sm152294446d6.38.2026.07.07.00.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 00:48:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue,  7 Jul 2026 07:48:39 +0000
Message-ID: <20260707074839.4197-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707054804.24232-2-wegao@suse.com>
References: <20260707054804.24232-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: New library function tst_get_free_uid
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

SGkgV2VpLAoKT24gVHVlLCA3IEp1bCAyMDI2IDA1OjQ3OjUzICswMDAwLCBXZWkgR2FvIHdyb3Rl
Ogo+IGxpYjogTmV3IGxpYnJhcnkgZnVuY3Rpb24gdHN0X2dldF9mcmVlX3VpZAoKLS0tIFtQQVRD
SCAxLzJdIC0tLQoKPiArLyoqCj4gKyAqIHRzdF9nZXRfZnJlZV91aWQoKSAtIEZpbmQgYSBVSUQg
bm90IGFzc2lnbmVkIHRvIGFueSB1c2VyLgo+ICsgKiBAc2tpcDogVUlEIHZhbHVlIHRvIHNraXAg
KHBhc3MgMCB0byBza2lwIG5vbmUpLgoKVGhlIHN1bW1hcnkgbGluZSBzYXlzIHRzdF9nZXRfZnJl
ZV91aWQoKSBidXQgdGhlIHN5bWJvbCBiZWluZyBkZWNsYXJlZAppcyB0c3RfZ2V0X2ZyZWVfdWlk
XygpLiBsaW51eGRvYyByZXF1aXJlcyB0aGUgc3VtbWFyeSBuYW1lIHRvIG1hdGNoIHRoZQpzeW1i
b2wgZXhhY3RseSwgc28gaXQgd291bGQgZmFpbCB0byBhc3NvY2lhdGUgdGhpcyAvKiogYmxvY2sg
d2l0aCB0aGUKaW1wbGVtZW50YXRpb24uCgpTaG91bGQgdGhpcyBiZSAidHN0X2dldF9mcmVlX3Vp
ZF8oKSAtIC4uLiIgdG8gbWF0Y2ggdGhlIHN5bWJvbCwgb3IgaXMKdGhlIGludGVudCB0byBkb2N1
bWVudCB0aGUgbWFjcm8gdHN0X2dldF9mcmVlX3VpZCgpIGluc3RlYWQ/CgpTYW1lIGlzc3VlIGFw
cGxpZXMgdG8gdGhlIG1vZGlmaWVkIHRzdF9nZXRfZnJlZV9naWQoKSBzdW1tYXJ5IGJlbG93LgoK
PiArdWlkX3QgdHN0X2dldF9mcmVlX3VpZF8oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxp
bmVubywgdWlkX3Qgc2tpcCk7CgpUaGUgZnVuY3Rpb24gaGFzIHRocmVlIHBhcmFtZXRlcnMgYnV0
IHRoZSBrZXJuZWwtZG9jIGJsb2NrIG9ubHkgZG9jdW1lbnRzCkBza2lwLiBsaW51eGRvYyBleHBl
Y3RzIGFuIEBuYW1lOiBlbnRyeSBmb3IgZXZlcnkgcGFyYW1ldGVyIGluIGRlY2xhcmF0aW9uCm9y
ZGVyLiBAZmlsZSBhbmQgQGxpbmVubyBhcmUgbWlzc2luZy4KClNhbWUgZ2FwIGluIHRoZSBtb2Rp
ZmllZCB0c3RfZ2V0X2ZyZWVfZ2lkXygpIGJsb2NrLgoKPiArCQlpZiAoZXJybm8gPT0gMCB8fCBl
cnJubyA9PSBFTk9FTlQgfHwgZXJybm8gPT0gRVNSQ0gpIHsKPiArCQkJdHN0X3Jlc18oZmlsZSwg
bGluZW5vLCBUSU5GTyB8IFRFUlJOTywKPiArCQkJCSJGb3VuZCB1bnVzZWQgVUlEICVkIiwgKGlu
dClyZXQpOwo+ICsJCQlyZXR1cm4gcmV0OwoKV2hlbiBnZXRwd3VpZCgpIHJldHVybnMgTlVMTCB3
aXRoIGVycm5vIHNldCB0byBFTk9FTlQgb3IgRVNSQ0gsIFRFUlJOTwphcHBlbmRzIHRoZSBlcnJu
byBzdHJpbmcgdG8gdGhlIG1lc3NhZ2UsIHByb2R1Y2luZyBvdXRwdXQgbGlrZToKIkZvdW5kIHVu
dXNlZCBVSUQgNTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSIuIFRoZSBmdW5jdGlvbiBzdWNj
ZWVkZWQsCnNvIHRoZSBlcnJvciBzdHJpbmcgaXMgbWlzbGVhZGluZy4gU2hvdWxkIFRFUlJOTyBi
ZSBkcm9wcGVkIGhlcmUsIG9yCnNob3VsZCBpdCBiZSBjb25kaXRpb25hbGx5IG9taXR0ZWQgd2hl
biBlcnJubyBpbmRpY2F0ZXMgIm5vdCBmb3VuZCI/CgotLS0gW1BBVENIIDIvMl0gLS0tCgo+ICtB
ZGQgTFRQIGNvdmVyYWdlIGZvciBrZXJuZWwgY29tbWl0IDMwYWJhNjY1NmY2MSAoTGludXggNC4x
OSksIHdoaWNoCj4gK2ludHJvZHVjZWQgcHJvdGVjdGlvbiBhZ2FpbnN0IHNwb29maW5nIGF0dGFj
a3MgdmlhIE9fQ1JFQVQgb2YgRklGT3MgYW5kCj4gK3JlZ3VsYXIgZmlsZXMgaW4gd29ybGQtd3Jp
dGFibGUgc3RpY2t5IGRpcmVjdG9yaWVzLgo+ICsKPiArVGhpcyBjb21taXQgYWRkcyB0ZXN0IGNh
c2VzIHRvIHZlcmlmeSB0aGVzZSBzZWN1cml0eSByZXN0cmljdGlvbnMgZm9yCj4gK29wZW5pbmcg
RklGT3MgYW5kIHJlZ3VsYXIgZmlsZXMgaW4gd29ybGQtd3JpdGFibGUgc3RpY2t5IGRpcmVjdG9y
aWVzLgoKdGNhc2VbMl0gdXNlcyBkaXJfbW9kZT0wMDMwfFNWVFggKGdyb3VwLXdyaXRhYmxlIHN0
aWNreSwgbGV2ZWwgMiksIHdoaWNoCnRoZSBjb21taXQgYm9keSBkb2Vzbid0IG1lbnRpb24uIFRo
ZSB0ZXN0J3Mgb3duIGRvYyBibG9jayBkZXNjcmliZXMgYm90aAoid29ybGQtd3JpdGFibGUgKGxl
dmVsIDEpIG9yIGdyb3VwLXdyaXRhYmxlIChsZXZlbCAyKSIgY29ycmVjdGx5IOKAlCBkb2VzCnRo
ZSBib2R5IG5lZWQgdXBkYXRpbmcgdG8gbWF0Y2g/CgpWZXJkaWN0IC0gTmVlZHMgcmV2aXNpb24K
Ci0tLQpOb3RlOgoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2
ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBp
c3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9y
ZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
