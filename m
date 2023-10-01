Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DE7E748E9
	for <ltp@archiver.kernel.org>; Sun,  1 Oct 2023 04:22:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E47A23D05B5
	for <ltp@archiver.kernel.org>; Sun,  1 Oct 2023 06:22:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 938983D034E
 for <ltp@lists.linux.it>; Sun,  1 Oct 2023 06:22:10 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CAF6E200142
 for <ltp@lists.linux.it>; Sun,  1 Oct 2023 06:22:09 +0200 (CEST)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51e24210395so6925a12.0
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 21:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696134129; x=1696738929; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/QVXkLGNL8BCQ4ov9kCzWM678kZeqphhHUahiBiuWCs=;
 b=lc3/8XfjrNY8bvMPK6XRze0YLQxTYHL2twnnmO0MsyqfdWi0KFxyH2dXAidskDVoB8
 zOo2n2VHQRX9lGxf9vB6h7fsHeQ1U+ap6DoCdPqSuMo+PsCoLPUA66Anj34duk0D9Z0P
 hp5FlA5ocyCeGMVZE/8y3jYYLjNekgtzVvv2DQmV8oH/chiYOhjysugDG59+hcZKS2v9
 x2GZ/9fyURxb9nLUhaLDLz2g3aEovc3wHLA8X7KSs01jqbxiSc9r8QtJ2gdAAmW8VSlT
 aM5i2vCGtAlP+Vf+WudPOWbUDDv7MOIv73jgTLbT3rVg1W+s8AY7+LoFagSJXSsQqd66
 AMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696134129; x=1696738929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/QVXkLGNL8BCQ4ov9kCzWM678kZeqphhHUahiBiuWCs=;
 b=q+QQiROQZuySF2MXGnRrvXIdJR0hO0TuKeM0W+Fx8rP7jicLAOKFzuG2ln0Zf1doQA
 7nJFyz/tpux4UNJVT1IsPYrMkqPgk9zXaDgLNaRfBAwEmGwL7CWp96lHVq5qHs0B57zV
 AwpczIz0dy6XDhEYfY6VHwh4+89Vz+theEvoX4JQef+/inNM7YCjk+sMuMgUFXcuUmnH
 APm5+8/JWwCyhu8SVCImrPFNEXCTCx0HpsM6aXK2kZvp/tDpHcQACmbOzOKxZakWNsp+
 RymInWZUzsX+Yo3jIRa2HhGkkPXKRkdv5CnFKipQFzg3nT5GheJyd7fk1jSLQllvUsC6
 oFkg==
X-Gm-Message-State: AOJu0YyzWIeUzDu4R7mbsNiVnI3VgYGf1xzU+fDfNK3rNqiIUkksNYGs
 Uv/sQozllCL7aqz48Ap/p7JZo/7HPbgcPtSv3Q8Txr0XiaRdl+bnNyk=
X-Google-Smtp-Source: AGHT+IGQH6gYx/wrLy54XFeNw9Ful82woJ3GuTUnVhjjicRABKfPzXl3kqeW3fPTyI4u2D8udOlnBTv9Vy7nZAgv8oQ=
X-Received: by 2002:a50:9b1a:0:b0:523:caae:d6ee with SMTP id
 o26-20020a509b1a000000b00523caaed6eemr45585edi.2.1696134128939; Sat, 30 Sep
 2023 21:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230930000007.4052837-1-edliaw@google.com>
 <20230930063438.GB414289@pevik>
In-Reply-To: <20230930063438.GB414289@pevik>
Date: Sat, 30 Sep 2023 21:21:58 -0700
Message-ID: <CAG4es9V2QyuThyfGmuccOq1xdMV+Lsk=XVnLgShZcLhf7DNERQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] pipe07: close /proc/self/fd after counting fds
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBTZXAgMjksIDIwMjMsIDExOjM04oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBFZHdhcmQsCj4KPiA+IExlYXZpbmcgdGhlIGRpcmVjdG9yeSBmZCBv
cGVuIHdpbGwgY291bnQgYWdhaW5zdCB0aGUgbWF4IG51bWJlciBvZiBmZHMKPiA+IG9wZW5lZCwg
c28gdGhlIGZpbmFsIGV4cGVjdGVkIGNvdW50IHdpbGwgYmUgb2ZmLgo+Cj4gPiBBbHNvLCByZW1v
dmVkIHRoZSBoYWx2aW5nIC8gZG91Ymxpbmcgb2YgZXhwX251bV9waXBlcyBzaW5jZSBpdCBpcwo+
ID4gcmVkdW5kYW50LgoKCj4gPiBTaWduZWQtb2ZmLWJ5OiBFZHdhcmQgTGlhdyA8ZWRsaWF3QGdv
b2dsZS5jb20+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BpcGUvcGlw
ZTA3LmMgfCA4ICsrKysrLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvcGlwZS9waXBlMDcuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9waXBlL3BpcGUw
Ny5jCj4gPiBpbmRleCAxOTY0ODU2ODQuLjAxZjZiNzhmOCAxMDA2NDQKPiA+IC0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvcGlwZS9waXBlMDcuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9waXBlL3BpcGUwNy5jCj4gPiBAQCAtNDUsNiArNDUsOCBAQCBzdGF0aWMg
aW50IHJlY29yZF9vcGVuX2Zkcyh2b2lkKQo+ID4gICAgICAgICAgICAgICBvcGVuZWRfZmRzW251
bV9vcGVuZWRfZmRzKytdID0gZmQ7Cj4gPiAgICAgICB9Cj4KPiA+ICsgICAgIFNBRkVfQ0xPU0VE
SVIoZGlyKTsKPiBJTUhPIHRoaXMgY2hhbmdlcyBjb3VudGluZyBmcm9tIDEwMjA6Cj4KPiBwaXBl
MDcuYzo1NjogVElORk86IGdldGR0YWJsZXNpemUoKSA9IDEwMjQKPiBwaXBlMDcuYzo2MDogVElO
Rk86IGV4cGVjdGVkIG1heCBmZHMgdG8gYmUgb3BlbmVkIGJ5IHBpcGUoKTogMTAyMAo+IHBpcGUw
Ny5jOjc1OiBUUEFTUzogZXJybm8gPT0gRU1GSUxFICgyNCkKPiBwaXBlMDcuYzo3NjogVFBBU1M6
IGV4cF9udW1fcGlwZXMgKiAyID09IG51bV9waXBlX2ZkcyAoMTAyMCkKPgo+IHRvIDEwMjEsIHdo
aWNoIGxlYWRzIHRvIGZhaWx1cmU6Cj4KPiBwaXBlMDcuYzo1ODogVElORk86IGdldGR0YWJsZXNp
emUoKSA9IDEwMjQKPiBwaXBlMDcuYzo2MjogVElORk86IGV4cGVjdGVkIG1heCBmZHMgdG8gYmUg
b3BlbmVkIGJ5IHBpcGUoKTogMTAyMQo+IHBpcGUwNy5jOjc3OiBUUEFTUzogZXJybm8gPT0gRU1G
SUxFICgyNCkKPiBwaXBlMDcuYzo3ODogVEZBSUw6IGV4cF9udW1fcGlwZXMgKDEwMjEpICE9IG51
bV9waXBlX2ZkcyAoMTAyMCkKPgo+ID4gKwo+ID4gICAgICAgcmV0dXJuIG51bV9vcGVuZWRfZmRz
Owo+IFRoaXMgaXMgbm90IGVsZWdhbnQsIGJ1dCBnZXQncyB0aGUgY29ycmVjdCBjb3VudC4gV2ls
bCBpdCBmYWlsIG9uIEFPU1A/Cj4KPiByZXR1cm4gbnVtX29wZW5lZF9mZHMgKyAxOwo+CgpJJ2xs
IGdldCBiYWNrIHRvIHlvdSBvbiBNb25kYXksIGJ1dCBJIHRoaW5rIHRoaXMgaXMgYmVjYXVzZSBl
YWNoIHBpcGUKY3JlYXRlcyB0d28gZmRzLCB0aGUgcmVzdWx0aW5nIGV4cCBudW1iZXIgb2YgcGlw
ZXMgd2lsbCBoYXZlIHRvIGJlIGV2ZW4sCmFuZCBJIG1lc3NlZCB0aGF0IHVwIGJ5IHJlbW92aW5n
IHRoZSBoYWx2aW5nL2RvdWJsaW5nLiAgV2hlbiBJIHRlc3RlZCBpdCwKdGhlIGV4cF9udW1fcGlw
ZXMgaGFwcGVuZWQgdG8gYmUgZXZlbiwgc28gSSBkaWRuJ3QgcnVuIGludG8gdGhlIG9kZCBjYXNl
LgoKPiAgfQo+Cj4gPiBAQCAtNTYsOCArNTgsOCBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+
ID4gICAgICAgdHN0X3JlcyhUSU5GTywgImdldGR0YWJsZXNpemUoKSA9ICVkIiwgbWF4X2Zkcyk7
Cj4gPiAgICAgICBwaXBlX2ZkcyA9IFNBRkVfTUFMTE9DKG1heF9mZHMgKiBzaXplb2YoaW50KSk7
Cj4KPiA+IC0gICAgIGV4cF9udW1fcGlwZXMgPSAobWF4X2ZkcyAtIHJlY29yZF9vcGVuX2Zkcygp
KSAvIDI7Cj4gPiAtICAgICB0c3RfcmVzKFRJTkZPLCAiZXhwZWN0ZWQgbWF4IGZkcyB0byBiZSBv
cGVuZWQgYnkgcGlwZSgpOiAlZCIsCj4gZXhwX251bV9waXBlcyAqIDIpOwo+ID4gKyAgICAgZXhw
X251bV9waXBlcyA9IG1heF9mZHMgLSByZWNvcmRfb3Blbl9mZHMoKTsKPiA+ICsgICAgIHRzdF9y
ZXMoVElORk8sICJleHBlY3RlZCBtYXggZmRzIHRvIGJlIG9wZW5lZCBieSBwaXBlKCk6ICVkIiwK
PiBleHBfbnVtX3BpcGVzKTsKPgo+IEl0J2QgYmUgc2xpZ2h0bHkgbW9yZSByZWFkYWJsZSBpZiB0
aGlzIHdhcyBpbiBzZXBhcmF0ZSBwYXRjaAo+IChhcyBpdCBtb2RpZmllcyB0aGUgc2FtZSB2YXJp
YWJsZSksIGJ1dCBpdCdzIHVwIHRvIHlvdS4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiA+
ICB9Cj4KPiA+ICBzdGF0aWMgdm9pZCBydW4odm9pZCkKPiA+IEBAIC03Myw3ICs3NSw3IEBAIHN0
YXRpYyB2b2lkIHJ1bih2b2lkKQo+ID4gICAgICAgfSB3aGlsZSAoIVRTVF9SRVQpOwo+Cj4gPiAg
ICAgICBUU1RfRVhQX0VRX0xJKGVycm5vLCBFTUZJTEUpOwo+ID4gLSAgICAgVFNUX0VYUF9FUV9M
SShleHBfbnVtX3BpcGVzICogMiwgbnVtX3BpcGVfZmRzKTsKPiA+ICsgICAgIFRTVF9FWFBfRVFf
TEkoZXhwX251bV9waXBlcywgbnVtX3BpcGVfZmRzKTsKPgo+ID4gICAgICAgZm9yIChpbnQgaSA9
IDA7IGkgPCBudW1fcGlwZV9mZHM7IGkrKykKPiA+ICAgICAgICAgICAgICAgU0FGRV9DTE9TRShw
aXBlX2Zkc1tpXSk7Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
