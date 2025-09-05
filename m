Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87846CA1010
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757083761; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JTyuEYtUq0VY8Uk+N7eAtOmG8WQ3BzO+t/EGKkk/ixo=;
 b=Y7KV2VMIAEK69AFKWRXdbUmC3MfFJkW9vllmTXjUZvFw6r0k8CUazg9fEAlvQFYJDoqxZ
 A4StZdfTIT1vFidxMB5GXI90CFwV5w2bp4AmdMd8hNINFIVipP1bhFipg+TGr4wsJLSFI3e
 C7bN2JjeRzjDzfn37G0LflKB2+on9nE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E72BD3CD509
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 16:49:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5C0E3C5837
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 16:49:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E07F020076B
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 16:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757083738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=daVFuQQMm4neq01YcGMrBxQ4iGS8K/mqR5lnAmkGv3A=;
 b=E1/LjtS2Yt4b8WMGYJW/YpMdAZ9dnn+7CRxj8JbMu7Nva62/PW8K8GvWd0WA1MzbTvDcDK
 5KhlP0oR2Z8GQNJ90A9f63Ui427OD5HPRRUppPzfBlrX5yWb3lNyAbz3zMSp1KaKG4akno
 ehRRa6hnMs9ss9i63B4ytox6xoZrhWE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-1_O1ztx0Mz6F3aCKRYiKew-1; Fri, 05 Sep 2025 10:48:57 -0400
X-MC-Unique: 1_O1ztx0Mz6F3aCKRYiKew-1
X-Mimecast-MFC-AGG-ID: 1_O1ztx0Mz6F3aCKRYiKew_1757083736
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-244581ce13aso46669375ad.2
 for <ltp@lists.linux.it>; Fri, 05 Sep 2025 07:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757083735; x=1757688535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=daVFuQQMm4neq01YcGMrBxQ4iGS8K/mqR5lnAmkGv3A=;
 b=dPv1HJeMwMIobkS52KO1ScvbeerIymopt8kozFe9FtWrIvDeoBWgxlFhWNoRqjZaXS
 F4vi1iKWuiDanJ9YrlT73HhjXBD7QKJlP8Zagtrw1UVlNOrGpkm5xOWoHE5njt68tWJR
 wZ+v0lADS5QWvkKupr01NkF/gQnVIy6nSwZqTYWyyFUKcCFv+hdeMZwya54VjByJZvjX
 QA/BR6m16QkZqjd2WXzUx01/0QTrK0VNAPIqna9veqBCxc9bH0V1SH5m1ozqBD3gW1NT
 znS2H0J1UQQ2HqeksnFPCK8nTkOAbvSYJX2MRydbDWubZUbgQig4ggQFOOOXYCjnOV4C
 qsxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOOyF8pb4UlqnDeRldjLdClQ0zfsudkxPd1LMpAz1Inxsho1gzxnC/tlnuNul8LBdz6j0=@lists.linux.it
X-Gm-Message-State: AOJu0YwJ7zaMSTWHP2OLYUy5FA6MU4GBvlgPOK8ID+Zkb/OxFLVC7pls
 sSLwJQ6E2fgIg+IvUP74WwlKGa/JYkfZVAg+Ou1Kc0R5JJzej4lEC190IRGn0UE+bF3hTg4Et2z
 DKqLX4Ud1uJwR8rmu+bEKm4wFPNp53QWwuaU+Wr6wJqwITblzLDVkcCBXbfSzwMc5pLPYUDNRpe
 rSNur+ha3lB0SGDMidTWI4eKfKorgjhE1hzQbuUQ==
X-Gm-Gg: ASbGnct6BYDHlusGTyvKc1tbiXs1/puctj4nGMamLRvBzW8hk+LpGMWYd4EKL+iuR1U
 KG9JK0CIO9XkdXcJ+SZTXRtxk2GjH4XNzT+y+mVZBPzop9M8IV14dY8bCze5KWzUALaUl5+j1YJ
 8ecuNeL++ZKdwf1d7IMqy20g==
X-Received: by 2002:a17:903:3d0f:b0:24c:c8d1:2bec with SMTP id
 d9443c01a7336-24cc8d12d26mr87313495ad.40.1757083735125; 
 Fri, 05 Sep 2025 07:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwPMaQ99pUkJtGKSMPNvi0A8hcUEgH1G/EAGz5PsLImK43od49PG50mOhTtZKwOWV3YIrXu6EZhx6yUAdrYlM=
X-Received: by 2002:a17:903:3d0f:b0:24c:c8d1:2bec with SMTP id
 d9443c01a7336-24cc8d12d26mr87313235ad.40.1757083734680; Fri, 05 Sep 2025
 07:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
 <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
 <aLqq9o9Dkbhr957V@yuki.lan>
 <CAEemH2cRQVq4N-SdRTFEuUzyUbqfCVg_mpQ58t1BeaNSO9NuvQ@mail.gmail.com>
 <aLrYUvN7UMpd64iJ@yuki.lan>
 <CAEemH2c_26s1ojGnStAxzGHVEhbVTpM0dL3PU=Od=G90gPvnGg@mail.gmail.com>
 <aLrpX5Cd0ljf66Yo@yuki.lan>
In-Reply-To: <aLrpX5Cd0ljf66Yo@yuki.lan>
Date: Fri, 5 Sep 2025 22:48:41 +0800
X-Gm-Features: Ac12FXy20pTy6HpFBLSJ0FpewnogV34E5XSu9-XDqKa1BxX5QPE_iCdd3uw1Vy8
Message-ID: <CAEemH2egih_E6dZq1UYJ8MFqOD9J+0dViMCLfSn2HrkS3KHDvA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A96KQimsOv25_Z1HAuX-0sNm6CeWsHWIEat3EhoMJy0_1757083736
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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

T24gRnJpLCBTZXAgNSwgMjAyNSBhdCA5OjQ04oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IFRoYW5rcywgSSBkbyBtYW51YWxseSB0ZXN0IGFuZCBu
b3cgYWxtb3N0IDEvMjAgdGltZXMgZmFpbC4KPiA+IEFuZCB0aGUgd29ydGggbWVudGlvbmluZyB0
aGF0IHRoaXMgaXMgbm90IGEgbmV3IGZhaWx1cmUgaW4gUkhFTCBrZXJuZWxzLgo+ID4gVGhvc2Ug
cGF0Y2hlcyBzaW5jZSB0aGUgYmFycmllciBoYXZlIGFscmVhZHkgbXVjaCBpbXByb3ZlZCB0aGUg
dGVzdAo+ID4gcmVzdWx0IGZyb20gUkhFTCBzaWRlLiBBdCBsZWFzdCBmcm9tIFJIRUwgUlQta2Vy
bmVsIEkgZGlkbid0IG9ic2VydmUKPiA+IGZhaWwgYW55IG1vcmUuCj4gPgo+ID4gU28gLGFzIGxv
bmcgYXMgdGhlIHBhdGNoIHdvcmtzIG9uIHRoZSBTVVNFIGtlcm5lbCB0byByZXNvbHZlIGl0J3Mg
TkVXCj4gPiBwcm9ibGVtLAo+ID4gSSB0aGluayB3ZSBjYW4gbWVyZ2UuCj4KPiBJIGdvdCBhbm90
aGVyIGlkZWEgbWVhbndoaWxlLCB3aGF0IGhhcHBlbnMgaWYgd2Uga2VlcCBidXNzeSBsb29wIGZv
ciB0aGUKPiBkZWZlbnNlIGFuZCBhZGQgdGhlIHNjaGVkX3lpZWxkKCkgb25seSB0byBvZmZlbnNl
IGFuZCBjcmF6eSBmYW5zPyBUaGF0Cj4gc2hvdWxkIGVuc3VyZSB0aGF0IGJlZm9yZSB0aGUga2lj
a29mZiB0aGUgZGVmZW5zZSB0aHJlYWRzIHNob3VsZCBiZQo+IGhvZ2dpbmcgdGhlIGF2YWlsYWJs
ZSBDUFVzLgo+CgpTb3VuZHMgZ3JlYXQsIG9yIHNvbWV0aGluZyB3ZSBjYW4gZG8gbW9yZSwgbWF5
YmUgcmVtb3ZlIHRoZSBidXN5LWxvb3AKZnJvbSB0aGUgY3JhenktZmFuIHRocmVhZHMsIHNpbmNl
IHRoZSBmYW4gdGhyZWFkcyBhcmUgdGhlIGRpc3RyYWN0aW9uCmR1cmluZyB0aGUKZ2FtZSBzbyB3
ZSBkb24ndCBuZWVkIHRvIGhhdmUgdGhlbSB3YWtpbmcgdXAgc28gZWFybHkgaW4gdGhlIGZpcnN0
IHBsYWNlLgoKV2l0aCB0aG9zZSByZWZpbmVkLCBJIHdvdWxkIG5vdCBnZXQgZmFpbHMgb24gUkhF
TCBub24tUlQga2VybmVsIGFueW1vcmUsCkkgd2lsbCBrZWVwIHRoZSBzY2hlZF9mb290YmFsbCB0
ZXN0IHJ1biBtb3JlIHRoYW4gMTAwMDAgdGltZXMgdG9uaWdodC4KICAgIGAgZm9yIGkgaW4gezEu
LjEwMDAwfTsgZG8gLi9zY2hlZF9mb290YmFsbCA7IGRvbmVgCgpJZiBldmVyeXRoaW5nIGdvZXMg
d2VsbCwgSSB3aWxsIHNpZ24gb2ZmIHBhdGNoIHYzIGFzIGJlbG93OgoKLS0tIGEvdGVzdGNhc2Vz
L3JlYWx0aW1lL2Z1bmMvc2NoZWRfZm9vdGJhbGwvc2NoZWRfZm9vdGJhbGwuYworKysgYi90ZXN0
Y2FzZXMvcmVhbHRpbWUvZnVuYy9zY2hlZF9mb290YmFsbC9zY2hlZF9mb290YmFsbC5jCkBAIC00
NCw2ICs0NCw3IEBACiBzdGF0aWMgdHN0X2F0b21pY190IHRoZV9iYWxsOwogc3RhdGljIGludCBw
bGF5ZXJzX3Blcl90ZWFtID0gMDsKIHN0YXRpYyBpbnQgZ2FtZV9sZW5ndGggPSBERUZfR0FNRV9M
RU5HVEg7CitzdGF0aWMgdHN0X2F0b21pY190IGtpY2tvZmZfZmxhZzsKIHN0YXRpYyB0c3RfYXRv
bWljX3QgZ2FtZV9vdmVyOwoKIHN0YXRpYyBjaGFyICpzdHJfZ2FtZV9sZW5ndGg7CkBAIC04MCw2
ICs4MSw5IEBAIHZvaWQgKnRocmVhZF9kZWZlbnNlKHZvaWQgKmFyZyBMVFBfQVRUUklCVVRFX1VO
VVNFRCkKIHsKICAgICAgICBwcmN0bChQUl9TRVRfTkFNRSwgImRlZmVuc2UiLCAwLCAwLCAwKTsK
ICAgICAgICBwdGhyZWFkX2JhcnJpZXJfd2FpdCgmc3RhcnRfYmFycmllcik7CisgICAgICAgd2hp
bGUgKCF0c3RfYXRvbWljX2xvYWQoJmtpY2tvZmZfZmxhZykpCisgICAgICAgICAgICAgICA7CisK
ICAgICAgICAvKmtlZXAgdGhlIGJhbGwgZnJvbSBiZWluZyBtb3ZlZCAqLwogICAgICAgIHdoaWxl
ICghdHN0X2F0b21pY19sb2FkKCZnYW1lX292ZXIpKSB7CiAgICAgICAgfQpAQCAtOTIsNiArOTYs
OSBAQCB2b2lkICp0aHJlYWRfb2ZmZW5zZSh2b2lkICphcmcgTFRQX0FUVFJJQlVURV9VTlVTRUQp
CiB7CiAgICAgICAgcHJjdGwoUFJfU0VUX05BTUUsICJvZmZlbnNlIiwgMCwgMCwgMCk7CiAgICAg
ICAgcHRocmVhZF9iYXJyaWVyX3dhaXQoJnN0YXJ0X2JhcnJpZXIpOworICAgICAgIHdoaWxlICgh
dHN0X2F0b21pY19sb2FkKCZraWNrb2ZmX2ZsYWcpKQorICAgICAgICAgICAgICAgc2NoZWRfeWll
bGQoKTsKKwogICAgICAgIHdoaWxlICghdHN0X2F0b21pY19sb2FkKCZnYW1lX292ZXIpKSB7CiAg
ICAgICAgICAgICAgICB0c3RfYXRvbWljX2FkZF9yZXR1cm4oMSwgJnRoZV9iYWxsKTsgLyogbW92
ZSB0aGUgYmFsbCBhaGVhZApvbmUgeWFyZCAqLwogICAgICAgIH0KQEAgLTExNSw5ICsxMjIsMTYg
QEAgdm9pZCByZWZlcmVlKGludCBnYW1lX2xlbmd0aCkKICAgICAgICBub3cgPSBzdGFydDsKCiAg
ICAgICAgLyogU3RhcnQgdGhlIGdhbWUhICovCi0gICAgICAgdHN0X2F0b21pY19zdG9yZSgwLCAm
dGhlX2JhbGwpOwotICAgICAgIHB0aHJlYWRfYmFycmllcl93YWl0KCZzdGFydF9iYXJyaWVyKTsK
ICAgICAgICBhdHJhY2VfbWFya2VyX3dyaXRlKCJzY2hlZF9mb290YmFsbCIsICJHYW1lX3N0YXJ0
ZWQhIik7CisgICAgICAgcHRocmVhZF9iYXJyaWVyX3dhaXQoJnN0YXJ0X2JhcnJpZXIpOworICAg
ICAgIHVzbGVlcCgyMDAwMDApOworCisgICAgICAgdHN0X2F0b21pY19zdG9yZSgwLCAmdGhlX2Jh
bGwpOworICAgICAgIHRzdF9hdG9taWNfc3RvcmUoMSwgJmtpY2tvZmZfZmxhZyk7CisgICAgICAg
aWYgKHRzdF9jaGVja19wcmVlbXB0X3J0KCkpCisgICAgICAgICAgICAgICB1c2xlZXAoMjAwMDAp
OworICAgICAgIGVsc2UKKyAgICAgICAgICAgICAgIHVzbGVlcCgyMDAwMDAwKTsKCiAgICAgICAg
LyogV2F0Y2ggdGhlIGdhbWUgKi8KICAgICAgICB3aGlsZSAoKG5vdy50dl9zZWMgLSBzdGFydC50
dl9zZWMpIDwgZ2FtZV9sZW5ndGgpIHsKQEAgLTEyNSwxNCArMTM5LDE0IEBAIHZvaWQgcmVmZXJl
ZShpbnQgZ2FtZV9sZW5ndGgpCiAgICAgICAgICAgICAgICBnZXR0aW1lb2ZkYXkoJm5vdywgTlVM
TCk7CiAgICAgICAgfQoKLSAgICAgICAvKiBTdG9wIHRoZSBnYW1lISAqLwotICAgICAgIHRzdF9h
dG9taWNfc3RvcmUoMSwgJmdhbWVfb3Zlcik7Ci0gICAgICAgYXRyYWNlX21hcmtlcl93cml0ZSgi
c2NoZWRfZm9vdGJhbGwiLCAiR2FtZV9PdmVyISIpOwotCiAgICAgICAgLyogQmxvdyB0aGUgd2hp
c3RsZSAqLwogICAgICAgIGZpbmFsX2JhbGwgPSB0c3RfYXRvbWljX2xvYWQoJnRoZV9iYWxsKTsK
ICAgICAgICB0c3RfcmVzKFRJTkZPLCAiRmluYWwgYmFsbCBwb3NpdGlvbjogJWQiLCBmaW5hbF9i
YWxsKTsKCisgICAgICAgLyogU3RvcCB0aGUgZ2FtZSEgKi8KKyAgICAgICB0c3RfYXRvbWljX3N0
b3JlKDEsICZnYW1lX292ZXIpOworICAgICAgIGF0cmFjZV9tYXJrZXJfd3JpdGUoInNjaGVkX2Zv
b3RiYWxsIiwgIkdhbWVfT3ZlciEiKTsKKwogICAgICAgIFRTVF9FWFBfRVhQUihmaW5hbF9iYWxs
ID09IDApOwogfQoKQEAgLTE1NCw2ICsxNjgsNyBAQCBzdGF0aWMgdm9pZCBkb190ZXN0KHZvaWQp
CiAgICAgICAgLyogV2UncmUgdGhlIHJlZiwgc28gc2V0IG91ciBwcmlvcml0eSByaWdodCAqLwog
ICAgICAgIHBhcmFtLnNjaGVkX3ByaW9yaXR5ID0gc2NoZWRfZ2V0X3ByaW9yaXR5X21pbihTQ0hF
RF9GSUZPKSArIDgwOwogICAgICAgIHNjaGVkX3NldHNjaGVkdWxlcigwLCBTQ0hFRF9GSUZPLCAm
cGFyYW0pOworICAgICAgIHRzdF9hdG9taWNfc3RvcmUoMCwgJmtpY2tvZmZfZmxhZyk7CgogICAg
ICAgIC8qCiAgICAgICAgICogU3RhcnQgdGhlIG9mZmVuc2UKCgoKCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
