Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447C2C3ABBC
	for <ltp@archiver.kernel.org>; Tue,  6 May 2025 07:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746514802; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8sMn833b+SW97ftWm0kcoIrBOc9Li8sd0ENHFqGfUG0=;
 b=lbFyDeJubjEPGBSngiCbAidSX0oO6Qo0aCGT+xnaMmQPMKeWQl9V3wLMGcXhJtymJV5RP
 oXeadbMJu0GOKMULCLJW/i6RKiKcuESkaYyCB9VJU9/FLqCC2fRVhbcOGAiMgyKExIV2Jng
 oy1jUuOW7THKsW8aGF3D3pELUXGfdSM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D564A3C4C12
	for <ltp@archiver.kernel.org>; Tue,  6 May 2025 09:00:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 906513C1B04
 for <ltp@lists.linux.it>; Tue,  6 May 2025 08:59:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 52102100043B
 for <ltp@lists.linux.it>; Tue,  6 May 2025 08:59:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746514777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g2rZsIsTbsFQaPFND+3MeanBlPwk+nuLpsuOvxEDXaI=;
 b=gaV1Q1Jqg9+8w4wK8nSAdxNIiEOeNAig/1Ge7uRBPCBrK+e1aE/gSWCzO9DopxOuL9CSlE
 Zb4cJwRkQtDbLYuch/OjtHAPREbVgPcBgjj3OIqqc1n7WpjhWpTXI1sdN0wjBhkDetU7ct
 gKinbdE4kGoYTVISpFLf5xtZB6kFHhg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-BT08K0I4OsuLOX_FW6BVew-1; Tue, 06 May 2025 02:59:35 -0400
X-MC-Unique: BT08K0I4OsuLOX_FW6BVew-1
X-Mimecast-MFC-AGG-ID: BT08K0I4OsuLOX_FW6BVew_1746514774
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff6167e9ccso6089356a91.1
 for <ltp@lists.linux.it>; Mon, 05 May 2025 23:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746514774; x=1747119574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g2rZsIsTbsFQaPFND+3MeanBlPwk+nuLpsuOvxEDXaI=;
 b=J4ahGvbF9MNjM2EXu5fT/8ITDMoCh6s9wzmmRtzMCk7P2ArGWj56fJw8II0FlLb1Ru
 TdAPlnVfsDX6nWjr+TO1KyMk+3dwuCHLvbWwGkN6ZYKnbk9+rqY2c4sFHSaZ/Ph7KWBE
 K+zfUGIM+J6hZ+Vpk9LxznBnVxslAxaLAb3wOnMx+a1Tw4J3FXZb76ekXxzaUZ/RWXO0
 oy8KbtapBrpzi26e/5x4Tz2kOCYyAgolb24Ea9zNvmJiavSimLUUAX+0ik2OTNXj6QO8
 0/E6IwNz9PPhD6hzm/RkQjhwS7+wMlSmjli1SW4LNTRWgb19FOkmeHl4be9TFG011S0E
 L50g==
X-Gm-Message-State: AOJu0YzqkQnPtOoPV+K3UQWGfMSfrUqFwZlB2PNEoFK3qZDffgJvichf
 aSLnAYtYETEK5qzVJXEEvWiun0g2dgaiTUBpMl1jvEumSm969asUEm2lp8fCRHO4OXGfL6dfUA8
 61phCo/nFFFKaHcDAKB8M2Wc9DtcGi65QPKiOgiPUePqlWherZ2vYOql36jtF0N6Q82M/UBehjy
 xjSVFY8wCER1vqZhUFFG5RMH4=
X-Gm-Gg: ASbGncvlsfuStAGoWJ/G4ZQ34Vr5HkvmtPIOywFfSfKGn5rg4+1f/tTljw+tAl/aBla
 PaLbGiQkNR+3KcrA+ObmRAhUINLc7ZonO6mvG9j1wekU3L409n321WFP2bBsHMKokva/sdA==
X-Received: by 2002:a17:90b:548b:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-30a6196ef42mr14906799a91.6.1746514774271; 
 Mon, 05 May 2025 23:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqh8VNNo3Mbmcg7wS9QUPfqKmXWm9+yhdX6m70mAA1axXy0nY9Uw/QaIMwSF43du81ljIW2ihdkInAd9wIca0=
X-Received: by 2002:a17:90b:548b:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-30a6196ef42mr14906775a91.6.1746514773783; Mon, 05 May 2025
 23:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250505105310.15072-1-mdoucha@suse.cz>
In-Reply-To: <20250505105310.15072-1-mdoucha@suse.cz>
Date: Tue, 6 May 2025 14:59:21 +0800
X-Gm-Features: ATxdqUHTZORNLMTeMvC-Q3r_7I6KDZGJYud-JsJt3FuPE8adu9xC0RLA3QNBqPk
Message-ID: <CAEemH2c7jonDBMfUwdotiH20M8AdNX0GZciEOpZmUVcRhtz8Qg@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gx5XGvwro9-cUE4CXKYozsvdjt6eWqNV_PB27qvn0aQ_1746514774
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] memcontrol03: Account for process size in cgroup
 allocation
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXkgNSwgMjAyNSBhdCA2OjUz4oCvUE0gTWFydGluIERvdWNoYSA8bWRvdWNoYUBz
dXNlLmN6PiB3cm90ZToKCj4gVGhlIGZpcnN0IHRydW5rX0cgYWxsb2NhdGlvbiBoYXMgMk1CIHNh
ZmV0eSBtYXJnaW4gdG8gYXZvaWQgdHJpZ2dlcmluZwo+IE9PTSBraWxsZXIuIEhvd2V2ZXIsIG9u
IHN5c3RlbXMgd2l0aCA2NEsgcGFnZXNpemUsIHRoaXMgbWF5IG5vdCBiZSBlbm91Z2guCj4gQWNj
b3VudCBmb3IgcHJvY2VzcyBzaXplIGFzIHJlcG9ydGVkIGJ5IGNncm91cCBtZW1vcnkgc3RhdHMg
YmVmb3JlCj4gYWxsb2NhdGluZyBtZW1vcnkgaW4gY2hpbGQgcHJvY2Vzc2VzLgo+Cj4gU2lnbmVk
LW9mZi1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6Pgo+CgpSZXZpZXdlZC1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgLi4uL2tlcm5lbC9jb250cm9sbGVy
cy9tZW1jZy9tZW1jb250cm9sMDMuYyAgIHwgMjAgKysrKysrKysrKysrKysrLS0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2wwMy5jCj4g
Yi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2wwMy5jCj4gaW5k
ZXggYjViYmI5OTU0Li5kMmU0ODlhZDYgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9j
b250cm9sbGVycy9tZW1jZy9tZW1jb250cm9sMDMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
Y29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDAzLmMKPiBAQCAtOTQsMTcgKzk0LDIzIEBAIHN0
YXRpYyB2b2lkIGNsZWFudXBfc3ViX2dyb3Vwcyh2b2lkKQo+ICB9Cj4KPiAgc3RhdGljIHZvaWQg
YWxsb2NfYW5vbl9pbl9jaGlsZChjb25zdCBzdHJ1Y3QgdHN0X2NnX2dyb3VwICpjb25zdCBjZywK
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHNpemVfdCBzaXplLCBjb25z
dCBpbnQgZXhwZWN0X29vbSkKPiArICAgICAgIHNpemVfdCBzaXplLCBjb25zdCBpbnQgZXhwZWN0
X29vbSkKPiAgewo+ICAgICAgICAgaW50IHN0YXR1czsKPiAgICAgICAgIGNvbnN0IHBpZF90IHBp
ZCA9IFNBRkVfRk9SSygpOwo+ICsgICAgICAgc2l6ZV90IGNnbWVtOwo+Cj4gICAgICAgICBpZiAo
IXBpZCkgewo+ICAgICAgICAgICAgICAgICBTQUZFX0NHX1BSSU5URihjZywgImNncm91cC5wcm9j
cyIsICIlZCIsIGdldHBpZCgpKTsKPiArICAgICAgICAgICAgICAgU0FGRV9DR19TQ0FORihjZywg
Im1lbW9yeS5jdXJyZW50IiwgIiV6dSIsICZjZ21lbSk7Cj4gKyAgICAgICAgICAgICAgIHNpemUg
PSBzaXplID4gY2dtZW0gPyBzaXplIC0gY2dtZW0gOiAwOwo+Cj4gICAgICAgICAgICAgICAgIHRz
dF9yZXMoVElORk8sICJDaGlsZCAlZCBpbiAlczogQWxsb2NhdGluZyBhbm9uOiAlIlBSSWRQVFIs
Cj4gICAgICAgICAgICAgICAgIGdldHBpZCgpLCB0c3RfY2dfZ3JvdXBfbmFtZShjZyksIHNpemUp
Owo+IC0gICAgICAgICAgICAgICBhbGxvY19hbm9uKHNpemUpOwo+ICsKPiArICAgICAgICAgICAg
ICAgaWYgKHNpemUpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYWxsb2NfYW5vbihzaXplKTsK
PiArCj4gICAgICAgICAgICAgICAgIGV4aXQoMCk7Cj4gICAgICAgICB9Cj4KPiBAQCAtMTI4LDkg
KzEzNCwxMCBAQCBzdGF0aWMgdm9pZCBhbGxvY19hbm9uX2luX2NoaWxkKGNvbnN0IHN0cnVjdAo+
IHRzdF9jZ19ncm91cCAqY29uc3QgY2csCj4gIH0KPgo+ICBzdGF0aWMgdm9pZCBhbGxvY19wYWdl
Y2FjaGVfaW5fY2hpbGQoY29uc3Qgc3RydWN0IHRzdF9jZ19ncm91cCAqY29uc3QgY2csCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHNpemVfdCBzaXplKQo+ICsg
ICAgICAgc2l6ZV90IHNpemUpCj4gIHsKPiAgICAgICAgIGNvbnN0IHBpZF90IHBpZCA9IFNBRkVf
Rk9SSygpOwo+ICsgICAgICAgc2l6ZV90IGNnbWVtOwo+Cj4gICAgICAgICBpZiAocGlkKSB7Cj4g
ICAgICAgICAgICAgICAgIFRTVF9DSEVDS1BPSU5UX1dBSVQoQ0hJTERfSURMRSk7Cj4gQEAgLTEz
OCwxMCArMTQ1LDE1IEBAIHN0YXRpYyB2b2lkIGFsbG9jX3BhZ2VjYWNoZV9pbl9jaGlsZChjb25z
dCBzdHJ1Y3QKPiB0c3RfY2dfZ3JvdXAgKmNvbnN0IGNnLAo+ICAgICAgICAgfQo+Cj4gICAgICAg
ICBTQUZFX0NHX1BSSU5URihjZywgImNncm91cC5wcm9jcyIsICIlZCIsIGdldHBpZCgpKTsKPiAr
ICAgICAgIFNBRkVfQ0dfU0NBTkYoY2csICJtZW1vcnkuY3VycmVudCIsICIlenUiLCAmY2dtZW0p
Owo+ICsgICAgICAgc2l6ZSA9IHNpemUgPiBjZ21lbSA/IHNpemUgLSBjZ21lbSA6IDA7Cj4KPiAg
ICAgICAgIHRzdF9yZXMoVElORk8sICJDaGlsZCAlZCBpbiAlczogQWxsb2NhdGluZyBwYWdlY2Fj
aGU6ICUiUFJJZFBUUiwKPiAgICAgICAgICAgICAgICAgZ2V0cGlkKCksIHRzdF9jZ19ncm91cF9u
YW1lKGNnKSwgc2l6ZSk7Cj4gLSAgICAgICBhbGxvY19wYWdlY2FjaGUoZmQsIHNpemUpOwo+ICsK
PiArICAgICAgIGlmIChzaXplKQo+ICsgICAgICAgICAgICAgICBhbGxvY19wYWdlY2FjaGUoZmQs
IHNpemUpOwo+ICsKPiAgICAgICAgIFNBRkVfRlNZTkMoZmQpOwo+Cj4gICAgICAgICBUU1RfQ0hF
Q0tQT0lOVF9XQUtFKENISUxEX0lETEUpOwo+IC0tCj4gMi40OS4wCj4KPgo+IC0tCj4gTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
