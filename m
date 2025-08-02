Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCF0C87FC9
	for <ltp@archiver.kernel.org>; Sat,  2 Aug 2025 03:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754105200; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=q7UeMxMDE8nKLiP3IBwVveq737NNdWobrtjpA0RU56g=;
 b=JjURcLUBwHNlTUI2trYhRWExxNOC+o6xY4nHvrdtfQ4HiYYLQRA2Amis0D5mWI/Nflb8H
 IgnM73o3RB0FrM7GIcH4Bljmrsy8TmMpy53w2FT6R/+H1+gaBajL9uS/BsmgMLX8hi2i3s6
 KXHHuaSzSfDi9hgfCdkh/SOU3u7q60k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 969CB3CCBB8
	for <ltp@archiver.kernel.org>; Sat,  2 Aug 2025 05:26:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 936003CCAA6
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 05:26:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AD39D600EB8
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 05:26:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754105173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qt+8RVdZVTM6G2buvLxGNfqmzTNNXHh1p9t0C/BNWjo=;
 b=Uo0J4OKO2axzAY6WOZ4Omdf/2nRTqVGsTT2t31QJqM7NhlOzbMzCYhHDzpZ5vDpwLbucXs
 5yJf4ToXZMougcxeZ381PVsLNQhlztOwPuQnLKQ46DWPsL2UWc6DVEqy1M5Mdifx53egqZ
 HjZGczk6H/IFvyOwdgaS8/sAACtsLwk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-x8AzVUM_OKS3qFJKNiey0w-1; Fri, 01 Aug 2025 23:26:11 -0400
X-MC-Unique: x8AzVUM_OKS3qFJKNiey0w-1
X-Mimecast-MFC-AGG-ID: x8AzVUM_OKS3qFJKNiey0w_1754105170
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4225b9c0d8so1109203a12.2
 for <ltp@lists.linux.it>; Fri, 01 Aug 2025 20:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754105170; x=1754709970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qt+8RVdZVTM6G2buvLxGNfqmzTNNXHh1p9t0C/BNWjo=;
 b=h6l/vLfbxEeRIB9+VdqG9a1pg7AJcZkQdK5NndCDxAVvR6oiNjSyu070DA70Czq72f
 ny6lBXnW7qxWORDEC8tiEAuwtpDsQ177/I/H83LjCHBFb4NW1deZ1AR4lkmpiPADp3pn
 bvCCIuXqReuHQ6j/pVOskGSuKAeA9tNSGIzPIagsPCDyli4VdpEf2ClAV/CrIpT/9GCY
 Nyk2puKhMP4UJyA0lQ33YsFDTxPxw2tipsRu3myRFrmpz/BvQuD62/T5jRkVhy9aMueA
 EVBsqgOLdXzvx2EIkXbcplLhnI/X/4d7p5Rl5ZmwrZJW7IaI9CgE9KcGDbAIYVmgqJsa
 GryA==
X-Gm-Message-State: AOJu0YxpZbiZJtmrn5C5+zqcJLrQmL1rM+IWgtn5JBPBQ4LmLAJlZvUh
 kwoaik1KqJchRJ7NFUc/o99BWhNGd8vaEkMtTTXDtXaMg7xBemtV+XP2fMIjw3Yk4uqiqC8sTk7
 e6fc6BFt6wNy+f6Ad85plb+ewu0llXYLuGCUXuFQ4dfdAwVlqnHmWX82Q5wIonRSHbv6h3IUY8t
 Or3HvHgK/8tTFXASFhIr5RyCL3J3Y=
X-Gm-Gg: ASbGncvxjfGrdf4A/K72Nci8kBneSP7aBZjcLpBc7t3jeRvN0Www9KFNvxbcfIkLNpE
 WDxMjwx/M6sF0zZC/tucQ8PdFmq4/ZSkAf+MGlpqzvKflKEZLEBAWU4QP7XByZPeCfUClo9VrHD
 tJAtxnXMg7PMAd5+bUTKk5Sw==
X-Received: by 2002:a05:6a20:549d:b0:234:cd25:735 with SMTP id
 adf61e73a8af0-23df91262f9mr3276608637.38.1754105170237; 
 Fri, 01 Aug 2025 20:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXQmxZ5pvanmOk4ItXq8PwhTLoyNsFumk9N4dAmKm/nJQ84X+YbSGlD2HWh01BBGVZD0La/5Zh9lhKxbMcasU=
X-Received: by 2002:a05:6a20:549d:b0:234:cd25:735 with SMTP id
 adf61e73a8af0-23df91262f9mr3276570637.38.1754105169782; Fri, 01 Aug 2025
 20:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250801100935.974351-1-pvorel@suse.cz>
In-Reply-To: <20250801100935.974351-1-pvorel@suse.cz>
Date: Sat, 2 Aug 2025 11:25:57 +0800
X-Gm-Features: Ac12FXycN-Y9RunINrQYnUitJZmzHZhWSjk0NojV0UjjgY7oUR1NT5kyBEn9WF4
Message-ID: <CAEemH2cvLsgVYkLOuVFZ4FrhqoUBFF54xRW0CF-0JN-tOCO8KQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zcq-aRTfwBU1-8ZXUpAKGnU8tfuvM062PruAGsSwlqM_1754105170
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] Makefile: Add kernel modules related make
 targets
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

T24gRnJpLCBBdWcgMSwgMjAyNSBhdCA2OjA54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBMVFAgY29udGFpbnMgZmV3IGtlcm5lbCBtb2R1bGVzIGFuZCB0ZXN0cyB3
aGljaCBhcmUgdXNpbmcgdGhlbS4gIFRoZXNlCj4gcmVxdWlyZSB0byBiZSBidWlsdCB3aXRoIHRo
ZSBzYW1lIGtlcm5lbCBoZWFkZXJzIGFzIHRoZSBydW5uaW5nIGtlcm5lbAo+IChTVVQpLiBTb21l
dGltZXMgdGhlIGJlc3Qgd2F5IHRvIGFjaGlldmUgdGhpcyBpcyB0byBjb21waWxlIHRoZW0gb24g
dGhlCj4gU1VULgo+Cj4gQWRkICdtb2R1bGVzJywgJ21vZHVsZXMtY2xlYW4nIGFuZCAnbW9kdWxl
cy1pbnN0YWxsJyBtYWtlIHRhcmdldHMgdG8KPiBtYWtlIGl0IGVhc2llciB0byBidWlsZCB0aGVt
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4g
SGksCj4KPiBJJ20gc29ycnkgZm9yIHRoZSBub2lzZS4KPgo+IE1vc3Qgb2YgdGhlIHBlb3BsZSB3
aWxsIG5lZWQganVzdCBtb2R1bGVzLWluc3RhbGwsIGJ1dCBsZXQncyBiZQo+IGNvbnNpc3RlbnQg
d2l0aCBvdGhlciBMVFAgbWFrZSB0YXJnZXRzLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+
IENoYW5nZXMgdjEtPnYyOgo+ICogQWRkIGFsc28gbW9kdWxlcy1jbGVhbiBhbmQgbW9kdWxlcy1p
bnN0YWxsCj4gVGhpcyBpcyBuZWVkZWQgYXMgJ21ha2UgbW9kdWxlcyBjbGVhbicgb3IgJ21ha2Ug
bW9kdWxlcyBpbnN0YWxsJwo+IHdvdWxkIGJlIHJ1bm5pbmcgMiBzZXBhcmF0ZSB0YXJnZXRzLgo+
Cj4gdjE6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjUwODAxMDk0MjA1Ljk2NTY0
NS0xLXB2b3JlbEBzdXNlLmN6Lwo+Cj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9q
ZWN0L2x0cC9wYXRjaC8yMDI1MDgwMTA5NDIwNS45NjU2NDUtMS1wdm9yZWxAc3VzZS5jei8KPgo+
ICBJTlNUQUxMICB8IDEwICsrKysrKysrKysKPiAgTWFrZWZpbGUgfCAyNCArKysrKysrKysrKysr
KysrKysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCj4KPiBkaWZm
IC0tZ2l0IGEvSU5TVEFMTCBiL0lOU1RBTEwKPiBpbmRleCBjYmUyN2YzMmVhLi4xMGMxOWQ0MTA1
IDEwMDY0NAo+IC0tLSBhL0lOU1RBTEwKPiArKysgYi9JTlNUQUxMCj4gQEAgLTE2NSw2ICsxNjUs
MTYgQEAgUEtHX0NPTkZJR19MSUJESVI9L3Vzci9saWIvaTM4Ni1saW51eC1nbnUvcGtnY29uZmln
Cj4gQ0ZMQUdTPS1tMzIgTERGTEFHUz0tbTMyIC4vYwo+ICAqIEFyY2ggTGludXgKPiAgUEtHX0NP
TkZJR19MSUJESVI9L3Vzci9saWIzMi9wa2djb25maWcgQ0ZMQUdTPS1tMzIgTERGTEFHUz0tbTMy
Cj4gLi9jb25maWd1cmUKPgo+ICtLZXJuZWwgbW9kdWxlcwo+ICstLS0tLS0tLS0tLS0tLQo+ICsK
PiArTFRQIGNvbnRhaW5zIGZldyBrZXJuZWwgbW9kdWxlcyBhbmQgdGVzdHMgd2hpY2ggYXJlIHVz
aW5nIHRoZW0uCj4gK1RoZXNlIHJlcXVpcmUgdG8gYmUgYnVpbHQgd2l0aCB0aGUgc2FtZSBrZXJu
ZWwgaGVhZGVycyBhcyB0aGUgcnVubmluZwo+IGtlcm5lbCAoU1VUKS4KPiArU29tZXRpbWVzIHRo
ZSBiZXN0IHdheSB0byBhY2hpZXZlIHRoaXMgaXMgdG8gY29tcGlsZSB0aGVtIG9uIHRoZSBTVVQu
Cj4gKwo+ICsnbW9kdWxlcycsICdtb2R1bGVzLWNsZWFuJyBhbmQgJ21vZHVsZXMtaW5zdGFsbCcg
bWFrZSB0YXJnZXRzIGFyZQo+IHNob3J0Y3V0cwo+ICt0byBidWlsZCBqdXN0IHRoZXNlIG1vZHVs
ZXMgYW5kIHRlc3RzLgo+ICsKPiAgQW5kcm9pZCBVc2Vycwo+ICAtLS0tLS0tLS0tLS0tCj4KPiBk
aWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQo+IGluZGV4IGVhYjQwZGE4YTYuLjkzM2Uz
M2NhNzUgMTAwNjQ0Cj4gLS0tIGEvTWFrZWZpbGUKPiArKysgYi9NYWtlZmlsZQo+IEBAIC0yMTIs
NiArMjEyLDMwIEBAIGVuZGlmCj4gIHRlc3QtbWV0YWRhdGE6IG1ldGFkYXRhLWFsbAo+ICAgICAg
ICAgJChNQUtFKSAtQyAkKGFic19zcmNkaXIpL21ldGFkYXRhIHRlc3QKPgo+ICtNT0RVTEVfRElS
UyA6PSBjb21tYW5kcy9pbnNtb2QgXAo+CgpIZXJlIHNob3VsZCBiZToKCi1NT0RVTEVfRElSUyA6
PSBjb21tYW5kcy9pbnNtb2QgXAorTU9EVUxFX0RJUlMgOj0gdGVzdGNhc2VzL2NvbW1hbmRzL2lu
c21vZCBcCgoKCj4gKyAgICAgICB0ZXN0Y2FzZXMva2VybmVsL2Zpcm13YXJlIFwKPiArICAgICAg
IHRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMgXAo+ICsgICAgICAgdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9kZWxldGVfbW9kdWxlIFwKPiArICAgICAgIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZmluaXRfbW9kdWxlIFwKPiArICAgICAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvaW5pdF9tb2R1bGUKPiArCj4gKy5QSE9OWTogbW9kdWxlcyBtb2R1bGVzLWNsZWFuIG1vZHVs
ZXMtaW5zdGFsbAo+ICttb2R1bGVzOgo+ICsgICAgICAgQCQoZm9yZWFjaCBkaXIsJChNT0RVTEVf
RElSUyksXAo+ICsgICAgICAgICAgICAgICBlY2hvICJCdWlsZCAkKGRpcikiO1wKPiArICAgICAg
ICAgICAgICAgJChNQUtFKSAtQyAkKGFic19zcmNkaXIpLyQoZGlyKTsgXAo+ICspCj4gK21vZHVs
ZXMtY2xlYW46Cj4gKyAgICAgICBAJChmb3JlYWNoIGRpciwkKE1PRFVMRV9ESVJTKSxcCj4gKyAg
ICAgICAgICAgICAgIGVjaG8gIkJ1aWxkICQoZGlyKSI7XAo+ICsgICAgICAgICAgICAgICAkKE1B
S0UpIC1DICQoYWJzX3NyY2RpcikvJChkaXIpIGNsZWFuOyBcCj4gKykKPiArbW9kdWxlcy1pbnN0
YWxsOiBtb2R1bGVzCj4gKyAgICAgICBAJChmb3JlYWNoIGRpciwkKE1PRFVMRV9ESVJTKSxcCj4g
KyAgICAgICAgICAgICAgIGVjaG8gIkJ1aWxkICQoZGlyKSI7XAo+ICsgICAgICAgICAgICAgICAk
KE1BS0UpIC1DICQoYWJzX3NyY2RpcikvJChkaXIpIGluc3RhbGw7IFwKPiArKQo+ICsKPiAgIyMg
SGVscAo+ICAuUEhPTlk6IGhlbHAKPiAgaGVscDoKPiAtLQo+IDIuNTAuMQo+Cj4KCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
