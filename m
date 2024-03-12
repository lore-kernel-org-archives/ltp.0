Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE84C54E58
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 15:01:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 471B83D060F
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 16:01:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CABE63CD7F5
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:00:51 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B372B14060B4
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:00:50 +0100 (CET)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-42f4250a382so13399461cf.1
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710255649; x=1710860449; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6Mj/gLAQQ51nBnA6p9anFmUi0Zlt9v0TBj50ymPCbQ=;
 b=nFlT6XMsvly5l+Ppsj0VM5b8IX8vb7eMvrbqC1/LwDGHwhtbpvPSYQxybU5YcCpunE
 mMaDtBhpdD8gmdqq9fFoFvCdF2LQe42YFYkl5nq/1XRaFaCp8z7FGN19g7PKTpKmzoY+
 zF4Sdo7yHQVnzm+Bb3kDAGA1FtAb8WAN/Az5pRswukV5Yg6TOfLvdwJbMK4xJkwuZeud
 Ok6XxrBiowXVtMTsOH/mU+ayiQgEODIm+WwwD7+0tvP5w65AytSTp3j1caTj/rSZCdsu
 HEKHrIHaJQ7aIyUDsKqpSZ80QX00sUtK5Jdzc6kQ1GGPV7aALBDD5aA1hH/je8rIAoO9
 R1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710255649; x=1710860449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6Mj/gLAQQ51nBnA6p9anFmUi0Zlt9v0TBj50ymPCbQ=;
 b=UFB78NW1PI+rnTG7EbwOZClrUNn7+6NXGdE68OH3GaMLEcSdBDWOE9nosJy7kjXSzt
 0o9mGdIojSw5CalyADPCo2VpGf6KNBqeDqe7GRMC9E+YItnTTR6LlD1lDu/IWyhAwiZp
 rvUjikcKcpUIA08ozf6SyTzy4d1k74byifjijb5AuV8Mb/eP6Qs6B21HtjbbF4zeL1sE
 3FuNVTWtpo5tXqjfEFY/CgpZBSc+BBRhMsYrKw1BvnhiawrlBZTVXV/xzlkWvdmD3TIZ
 lQF5GGGxAtjt7coLQYlQVUr7Sx8oKN5e206n/rq+IPXBw6eqFlkiZWlmuKzH07DdlltY
 3FQQ==
X-Gm-Message-State: AOJu0YzeFnux2eMf6eaBi8DBAIA899ngd1ndmSywZ2OnrSEs17kF+gVq
 QA6Nz/BJbmL80lZReev+r0OQwk3nvWEPPZj9ryk9Y/5HfZym/7A/yaZBS9EtdwPHGnLzx9aG2c0
 39fAEWKssKt9xXEzT1ZebrLYHzI46fdET+LI=
X-Google-Smtp-Source: AGHT+IGH6YNipXYg72RsCSIcih6KOcEVpIBD8U5MIIIlXqIL3Zn26Chw1GOMEF+r31T1cBlzV36oNntB3ir/Go4CEIM=
X-Received: by 2002:a05:622a:100c:b0:42e:e020:46ef with SMTP id
 d12-20020a05622a100c00b0042ee02046efmr12475882qte.48.1710255649278; Tue, 12
 Mar 2024 08:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240312120829.178305-1-meted@linux.ibm.com>
 <20240312120829.178305-2-meted@linux.ibm.com>
In-Reply-To: <20240312120829.178305-2-meted@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Mar 2024 17:00:38 +0200
Message-ID: <CAOQ4uxgPK=t25OvBcevkQseFEr9S6p7PtU35p8T+snzqzN+ndg@mail.gmail.com>
To: Mete Durlu <meted@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] fanotify14: fix anonymous pipe testcases
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMTIsIDIwMjQgYXQgMjowOeKAr1BNIE1ldGUgRHVybHUgPG1ldGVkQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+Cj4gV2hlbiBTRWxpbnV4IGlzIGluIGVuZm9yY2luZyBzdGF0ZSBh
bmQgU0Vwb2xpY2llcyBkaXNhbGxvdyBhbm9ueW1vdXMKPiBwaXBlIHVzYWdlIHdpdGggZmFub3Rp
ZnlfbWFyaygpLCByZWxhdGVkIGZhbm90aWZ5MTQgdGVzdGNhc2VzIGZhaWwgd2l0aAo+IEVBQ0NF
UyBpbnN0ZWFkIG9mIEVJTlZBTC4gQWNjZXB0IGJvdGggZXJybm9zIHdoZW4gU0VsaW51eCBpcyBp
bgo+IGVuZm9yY2luZyBzdGF0ZSB0byBjb3JyZWN0bHkgZXZhbHVhdGUgdGVzdCByZXN1bHRzLgo+
Cj4gUmVwbGFjZSBUU1RfRVhQX0ZEX09SX0ZBSUwgd2l0aCBUU1RfRVhQX0ZBSUwgd2hlbiB0ZXN0
aW5nCj4gZmFub3RpZnlfbWFyaygpIGFzIGl0IHJldHVybnMgLTEgb24gZmFpbHVyZSBhbmQgMCBv
biBzdWNjZXNzIG5vdCBhIGZpbGUKPiBkZXNjcmlwdG9yLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWV0
ZSBEdXJsdSA8bWV0ZWRAbGludXguaWJtLmNvbT4KPiAtLS0KPiAgLi4uL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMgICAgIHwgMzIgKysrKysrKysrKysrKysrKystLQo+ICAx
IGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jCj4gaW5kZXgg
ZDAyZDgxNDk1Li41MmMzMjdkZmYgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYwo+IEBAIC0yNywxMiArMjcsMTQgQEAKPiAgI2RlZmlu
ZSBfR05VX1NPVVJDRQo+ICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiAgI2luY2x1ZGUgPGVycm5v
Lmg+Cj4gKyNpbmNsdWRlIDxzdGRsaWIuaD4KPgo+ICAjaWZkZWYgSEFWRV9TWVNfRkFOT1RJRllf
SAo+ICAjaW5jbHVkZSAiZmFub3RpZnkuaCIKPgo+ICAjZGVmaW5lIE1OVFBPSU5UICJtbnRwb2lu
dCIKPiAgI2RlZmluZSBGSUxFMSBNTlRQT0lOVCIvZmlsZTEiCj4gKyNkZWZpbmUgU0VMSU5VWF9T
VEFUVVNfUEFUSCAiL3N5cy9mcy9zZWxpbnV4L2VuZm9yY2UiCj4KPiAgLyoKPiAgICogTGlzdCBv
ZiBpbm9kZSBldmVudHMgdGhhdCBhcmUgb25seSBhdmFpbGFibGUgd2hlbiBub3RpZmljYXRpb24g
Z3JvdXAgaXMKPiBAQCAtMjQwLDYgKzI0MiwxOSBAQCBzdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90
IHsKPiAgICAgICAgIH0sCj4gIH07Cj4KPiArc3RhdGljIGludCBpc19zZWxpbnV4X2VuZm9yY2lu
Zyh2b2lkKQo+ICt7Cj4gKyAgICAgICBjaGFyIHJlczsKPiArICAgICAgIGludCBmZDsKPiArCj4g
KyAgICAgICBmZCA9IG9wZW4oU0VMSU5VWF9TVEFUVVNfUEFUSCwgT19SRE9OTFkpOwo+ICsgICAg
ICAgaWYgKGZkIDw9IDApCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICsgICAgICAgU0FG
RV9SRUFEKDEsIGZkLCAmcmVzLCAxKTsKPiArICAgICAgIFNBRkVfQ0xPU0UoZmQpOwo+ICsgICAg
ICAgcmV0dXJuIGF0b2koJnJlcyk7Cj4gK30KPiArCj4gIHN0YXRpYyB2b2lkIGRvX3Rlc3QodW5z
aWduZWQgaW50IG51bWJlcikKPiAgewo+ICAgICAgICAgc3RydWN0IHRlc3RfY2FzZV90ICp0YyA9
ICZ0ZXN0X2Nhc2VzW251bWJlcl07Cj4gQEAgLTI3NSwxNyArMjkwLDI4IEBAIHN0YXRpYyB2b2lk
IGRvX3Rlc3QodW5zaWduZWQgaW50IG51bWJlcikKPiAgICAgICAgIC8qIFNldCBtYXJrIG9uIG5v
bi1kaXIgb25seSB3aGVuIGV4cGVjdGluZyBlcnJvciBFTk9URElSICovCj4gICAgICAgICBjb25z
dCBjaGFyICpwYXRoID0gdGMtPmV4cGVjdGVkX2Vycm5vID09IEVOT1RESVIgPyBGSUxFMSA6IE1O
VFBPSU5UOwo+ICAgICAgICAgaW50IGRpcmZkID0gQVRfRkRDV0Q7Cj4gKyAgICAgICBpbnQgc2Vf
ZW5mb3JjaW5nID0gMDsKPgo+ICAgICAgICAgaWYgKHRjLT5wZmQpIHsKPiAgICAgICAgICAgICAg
ICAgZGlyZmQgPSB0Yy0+cGZkWzBdOwo+ICAgICAgICAgICAgICAgICBwYXRoID0gTlVMTDsKPiAr
ICAgICAgICAgICAgICAgc2VfZW5mb3JjaW5nID0gaXNfc2VsaW51eF9lbmZvcmNpbmcoKTsKPiAg
ICAgICAgIH0KPgo+ICAgICAgICAgdHN0X3JlcyhUSU5GTywgIlRlc3RpbmcgJXMgd2l0aCAlcyIs
Cj4gICAgICAgICAgICAgICAgIHRjLT5tYXJrLmRlc2MsIHRjLT5tYXNrLmRlc2MpOwo+IC0gICAg
ICAgVFNUX0VYUF9GRF9PUl9GQUlMKGZhbm90aWZ5X21hcmsoZmFub3RpZnlfZmQsIEZBTl9NQVJL
X0FERCB8IHRjLT5tYXJrLmZsYWdzLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdGMtPm1hc2suZmxhZ3MsIGRpcmZkLCBwYXRoKSwKPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRjLT5leHBlY3RlZF9lcnJubyk7Cj4gKwo+ICsgICAg
ICAgaWYgKHRjLT5wZmQgJiYgc2VfZW5mb3JjaW5nKSB7Cj4gKyAgICAgICAgICAgICAgIGNvbnN0
IGludCBleHBfZXJyc1tdID0ge3RjLT5leHBlY3RlZF9lcnJubywgRUFDQ0VTfTsKPiArCj4gKyAg
ICAgICAgICAgICAgIFRTVF9FWFBfRkFJTF9BUlIoZmFub3RpZnlfbWFyayhmYW5vdGlmeV9mZCwg
RkFOX01BUktfQUREIHwgdGMtPm1hcmsuZmxhZ3MsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdGMtPm1hc2suZmxhZ3MsIGRpcmZkLCBwYXRoKSwKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBleHBfZXJycyk7Cj4gKyAgICAgICB9IGVsc2Ugewo+ICsgICAgICAg
ICAgICAgICBUU1RfRVhQX0ZBSUwoZmFub3RpZnlfbWFyayhmYW5vdGlmeV9mZCwgRkFOX01BUktf
QUREIHwgdGMtPm1hcmsuZmxhZ3MsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHRjLT5tYXNrLmZsYWdzLCBkaXJmZCwgcGF0aCksCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjLT5leHBlY3RlZF9lcnJu
byk7Cj4gKyAgICAgICB9Cj4KClRoaXMgbG9va3MgZmluZSB0byBtZSwgYnV0IG9uIHNlY29uZCB0
aG91Z2h0IEkgYW0gbm90IHN1cmUgaG93IGltcG9ydGFudAppdCBpcyB0byBzcGVjaWFsIGNhc2Ug
c2VfZW5mb3JjaW5nLgpXZSBjb3VsZCBwcm9iYWJseSBhbHdheXMgY2hlY2sgZm9yIGVpdGhlciBl
cnJvciB2YWx1ZS4KCkxldCdzIHNlZSB3aGF0IEphbiBhbmQgUGV0ciB0aGluay4KClRoYW5rcywK
QW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
