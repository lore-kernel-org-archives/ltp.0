Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C57C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748344310; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=VxzytIPzlHB0Z659gxeUqt0zIFgxvOOAWtpf5QSAyis=;
 b=Fwg2rTdqrujohN3k2DIKN5/CP//MATMCWY6BwWVBzo9J7RwW+O5vVaT9Qe6U8vcfcmJtb
 fwGlw2u6MNCSBuzK+6vzd26MEt0YNtMfoK71Xc7hWQIv2d2ecNNPaPOrASLIYshZ51EEpAz
 IV+IXm1dFbATue7TR8pmDOhYe6IU7EY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FA8B3C58EE
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:11:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F1773C2B90
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:11:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6B322600716
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748344285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgHr0Zgf8CfhEw6ZFYs0/JDrc9tELSCA2HKBizrwy8A=;
 b=Ccm1WQ/Nb5p4ht1Pr2iU87iHnjcQDJU+1SoPZCjL2fy0idWQOSrqjmgw3WG4NKZNtNnk0x
 LRIlayII2IiilN/XThc5g9qSIa7N83mI6Pnmxpvmkp+RkEgw/B2mbrjhIu6Up2eFGrD8Ge
 UMunLj8fphpClMe9mYeG+B5JKcV7Xnw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-_SZd1LcwOtuZYq0VWZKCTA-1; Tue, 27 May 2025 07:11:23 -0400
X-MC-Unique: _SZd1LcwOtuZYq0VWZKCTA-1
X-Mimecast-MFC-AGG-ID: _SZd1LcwOtuZYq0VWZKCTA_1748344283
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-30a59538b17so2859001a91.3
 for <ltp@lists.linux.it>; Tue, 27 May 2025 04:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748344280; x=1748949080;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tgHr0Zgf8CfhEw6ZFYs0/JDrc9tELSCA2HKBizrwy8A=;
 b=vFhaA/IUKLD5dOj2lbmfL9DAqJQpeM2RAOuVuzzCql/NFzsDs6z4Xs/9vl2c/o2kp6
 v3fRbLIqJYR6e/WeOj4O/pgqiMNYNoRBhD5Pq06+9AMy0vzcHCrz4qH236pPYDJQz3FL
 SuIIHHnTyvo6bdTv3G/hBWUg9NXUEAm6Fwfc4EJne+z0onV+rmZ5gSUGyHngGswmXtEs
 LLFSQZls+iKtwuc8cSVsf+AcBcS7szUt5NixgzvbxIxDWr7DFisU0jFFJNg3ZbCg/hka
 VOgyZlAG6ANbYJrIT27d6BlhAYF1GJ4rqJVPL4LzghttHKQMWojAG8opIteAAxy27MZc
 NYHA==
X-Gm-Message-State: AOJu0YyMNQ3APLWTZDGURribbVe42cC6ys3KD0ecx5dPD4DxgFfFYMId
 /et5E2qIOK1kFpp6JEV2FXB2QgQ0kMsSixM4lLDt+0H8ilebGHoxJV9bhi1ktq5/K09DZxfPl1W
 C5QwRIjP9vBlhb/y19pZpesOGeD0h/D5TDiGNpnNrvRbU8v0/JJL3PrjEB/R5+OpK5TKbgBPLyk
 xZ8XOegTJAjA6RS1bBhzPSOR2tyUJ1j46zNPw=
X-Gm-Gg: ASbGncs9HAj7udLvMjVY+xZ3325xFp0M31+dT6x0dmcax3Q3HYE/1BbDzHPIawT1l5x
 zKbsk9ftnRTO9ZW+UU7yH+9weHayZN1itYFxbVme/IvBjHa74xdjsS10xX2vJXr77qgHkdw==
X-Received: by 2002:a17:90b:35cc:b0:2ee:6d08:7936 with SMTP id
 98e67ed59e1d1-3110f31df19mr19183030a91.20.1748344280351; 
 Tue, 27 May 2025 04:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+WMgLp/A5NHFii4OSBXonKeKpt8Y5ldWqdklAMssnQJEJFjLGl7O2yVZdqKn101t+tbv4/uVJ9n/0+MIO6J8=
X-Received: by 2002:a17:90b:35cc:b0:2ee:6d08:7936 with SMTP id
 98e67ed59e1d1-3110f31df19mr19183000a91.20.1748344279957; Tue, 27 May 2025
 04:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
In-Reply-To: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
Date: Tue, 27 May 2025 19:11:07 +0800
X-Gm-Features: AX0GCFtcqD2sOAuFll-E5ePGRljl-Cei8_NYCOol27Cliq1tCp26aoN5pDTl78o
Message-ID: <CAEemH2dD50C9LBpx8eFq3pug3oys-4r05s6K_fT-9N7Vj5D8mA@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G9MlfGeCyZ-O9iLz20-buSZ7aN8M3GQ0ZxbFhBng3jw_1748344283
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMjcsIDIwMjUgYXQgNzowMOKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IEhlbGxvIEFsbCwKPgo+IEFmdGVyIHJldmlld2luZyBzb21lIExUUCBI
VE1MIHRlc3QgcmVwb3J0cywgSSBub3RpY2VkIHRoYXQgdGhlIHRlbiB0ZXN0cwo+IGFsb25lIHRh
a2UgbmVhcmx5IDIwIG1pbnV0ZXMgdG8gY29tcGxldGUuIEZvciBleGFtcGxlOgo+Cj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPiBiaW5kMDYgICAgICAgICAgIDMwMC4xNXMKPiBtc2dzdHJlc3MwMSAg
ICAgIDE4MC40NHMKPiBmc3gyMiAgICAgICAgICAgIDE3MC40N3MKPiBwdHkwNyAgICAgICAgICAg
IDE1MC4wNHMKPiBwdHkwNiAgICAgICAgICAgIDE1MC4wMnMKPiBnZjE4ICAgICAgICAgICAgIDEy
MS4wOXMKPiBnZjE3ICAgICAgICAgICAgIDEyMC44MnMKPiBnZjE2ICAgICAgICAgICAgIDEyMC4x
M3MKPiBkaXJ0eWMwd19zaG1lbSAgIDEyMC4xMXMKPiBzZXRzb2Nrb3B0MDcgICAgICA3Ni40N3MK
Pgo+IEluIHRvdGFsLCBydW5uaW5nIHRoZSBmdWxsIGx0cC1saXRlIHN1aXRlIGN1cnJlbnRseSB0
YWtlcyB+MWgyMG0sIHdoaWNoIGlzIGEgYml0Cj4gbG9uZyBmb3IgQ0kgb3IgcHJlLW1lcmdlIHZh
bGlkYXRpb24gcGlwZWxpbmVzLgoKRm9yZ2V0IHRvIG1lbnRpb246CgpUaGUgMWgyMG1pbiBjb250
YWlucyBMVFAgY29tcGlsaW5nIHRpbWUuIFdlIG5vdyB0cnkgdG8gYnVpbGQgcnBtIHBhY2thZ2UK
Zm9yIG91ciBDSSB0ZXN0aW5nIHRoYXQgd291bGQgcmVkdWNlIHNvbWUgdW5uZWNlc3NhcnkgdGlt
ZS4KCkFwYXJ0IGZyb20gdGhhdCwgSWYgd2UgY291bGQgZG8gc29tZXRoaW5nIHRvIHNwZWVkIHVw
IHRoZSBydW5uaW5nIHRpbWUsCnRoYXQgd291bGQgYmUgZ3JlYXQgdG9vLgoKPgo+IEknbSB3b25k
ZXJpbmcgd2hldGhlciBhbGwgdGhlc2UgLnJ1bnRpbWUgdmFsdWVzIGFyZSB0cnVseSBuZWNlc3Nh
cnkgdG8gcmVwcm9kdWNlCj4gdGhlIGludGVuZGVkIGlzc3VlcyAoZS5nLiwgcmFjZSBjb25kaXRp
b25zLCBmdXp6aW5nLCBzeW5jIHRpbWluZyBpc3N1ZXMpLgo+IE9yIGlmIHdlIGNvdWxkOgo+ICAt
IFNldCBhIGxvd2VyIHRocmVzaG9sZCBmb3IgLnJ1bnRpbWUgb24gZ2VuZXJhbC1wdXJwb3NlIHN0
cmVzcy9mdXp6IHRlc3RzCj4gIC0gSW50cm9kdWNlIGEgcnVudGltZSBfcG9saWN5XyBmb3IgZGlm
ZmVyZW50IGVudmlyb25tZW50cyAoZS5nLiwgZmFzdAo+IENJIHZzLiBmdWxsIHdlZWtseSBydW5z
KQo+Cj4gSXQgbWlnaHQgYmUgYmVuZWZpY2lhbCB0byByZXZpc2l0IHRoZSAucnVudGltZSB2YWx1
ZXMgb2YgbG9uZy1ydW5uaW5nIHRlc3RzIGFuZAo+IHNldCBhIG1pbmltYWwgeWV0IGVmZmVjdGl2
ZSBkdXJhdGlvbiB0aGF0IGJhbGFuY2VzIHJlcHJvZHVjaWJpbGl0eSB3aXRoIHJlc291cmNlCj4g
ZWZmaWNpZW5jeS4gVGhpcyBjb3VsZCBoZWxwIHNhdmUgdGltZSBhbmQgZnJlZSB1cCB0ZXN0IHJl
c291cmNlcyBlYXJsaWVyLgo+Cj4gQW55IHRob3VnaHRzL2NvbW1lbnRzIHdvdWxkIGJlIGFwcHJl
Y2lhdGVkLgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKCgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
