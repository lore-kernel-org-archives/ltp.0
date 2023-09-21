Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8093E7107E
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 14:44:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D69773CDE90
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 16:44:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDA4E3CA3A6
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 16:44:23 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 034291A00EC0
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 16:44:23 +0200 (CEST)
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-452c031f7b3so224586137.0
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695307462; x=1695912262; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFaHfoaxn08xsAqYV/UBPB0BsJ0aDfd3cBl6EMbcNgw=;
 b=Z4m47Izi7ihEic9B1IEGv0gH0HW9KTG6K+5xH/3FeBM1KhMGyKao1EKo85UgsdYSn5
 85se3++BfoQbpq0naEjFVXd+3yljBy6OyrYk52woMHq+YUD4LeiL/qVMDvLR6T1OzvmW
 YNUoPA5RWiDmBG+DDKtrAeePOA3AouLoCTAa27wfpHTgY7SIt+vASfXyp4N8SC9GGkAU
 MUXlA3Z08+YvncYcWXwcck0Lwt1wES6TfmP61BqRVXHlFp12wYCxMezEvX0pPbRPTLHd
 OwztPM/AgdNpOHBW1CGVu4QehwSG+372GONiid8BbhUGSKRW2uSHSMqR3S1w8LtJzCxC
 Dkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695307462; x=1695912262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFaHfoaxn08xsAqYV/UBPB0BsJ0aDfd3cBl6EMbcNgw=;
 b=JV7b8FSz8YTntaraQhIyGOZYxE8zHR7Amh+1Wf14SPHX7RjF3foPZUgpvwEAxtoYAr
 Jixi0tw/F7ddnwH8E5WO5+pz56Si1XPx/rU5i2U8Zlz4NvkUm0KS2NeyvBGkcx/Mrgp5
 rYJ/IThy+9rO1TJ4tCNhUcZpdpSUHTaSWxluNw+6SG1XD8g+2t1T2pBIO4Yc6azd1GA0
 8ssBaGtd35kVA3NCt+qyx9xtLIf5aA9zC7VTm95RdEBbPkgrtBX8RUNRJCqobkjSZVuT
 gdD8c9BeqiQu/4z7+KbD+MP7TXb61h/ll8Enc2VHyp6m6SVQgcxlL5EuiVxwOjHPExmm
 JhIQ==
X-Gm-Message-State: AOJu0YzP4+MXI9Yu5HehXzoHyeJZ/nPabHyKh7A7vN43gM72XQfZEzd1
 V1Uh7SjoJbsJ8yhvjYVWUKnyR5zihqegR2ZA+yo=
X-Google-Smtp-Source: AGHT+IEX0oUA/m6qcydkc/MWRxmpvID/DRX9SY5OT+po1vq9MZCQuVXYDV3BHR9AxQnZho/TDPq2BuQ2cxuIIY5YALM=
X-Received: by 2002:a67:e8da:0:b0:452:988c:f339 with SMTP id
 y26-20020a67e8da000000b00452988cf339mr5582120vsn.5.1695307461687; Thu, 21 Sep
 2023 07:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
In-Reply-To: <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Sep 2023 17:44:10 +0300
Message-ID: <CAOQ4uxj7-=pU_WR8PbV4QUK=cepZnmd_1eCqRcwthJNkkzA5VA@mail.gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgNDowMeKAr1BNIFJldWJlbiBIYXdraW5zIDxyZXViZW5o
d2tAZ21haWwuY29tPiB3cm90ZToKPgo+Cj4gT24gVHVlLCBTZXAgMTksIDIwMjMgYXQgMzo0M+KA
r0FNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBPbiBU
dWUsIFNlcCAxOSwgMjAyMyBhdCA1OjQ34oCvQU0ga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5z
YW5nQGludGVsLmNvbT4gd3JvdGU6Cj4+ID4KPj4gPgo+PiA+Cj4+ID4gSGVsbG8sCj4+ID4KPj4g
PiBrZXJuZWwgdGVzdCByb2JvdCBub3RpY2VkICJsdHAucmVhZGFoZWFkMDEuZmFpbCIgb246Cj4+
ID4KPj4gPiBjb21taXQ6IGY0OWEyMGM5OTJkN2ZlZDE2ZTA0YzRjZmE0MGU5ZjI4ZjE4ZjgxZjcg
KCJbUEFUQ0hdIHZmczogZml4IHJlYWRhaGVhZCgyKSBvbiBibG9jayBkZXZpY2VzIikKPj4gPiB1
cmw6IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdHMvUmV1YmVu
LUhhd2tpbnMvdmZzLWZpeC1yZWFkYWhlYWQtMi1vbi1ibG9jay1kZXZpY2VzLzIwMjMwOTA5LTEy
NDM0OQo+PiA+IGJhc2U6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdCAzMmJmNDNlNGVmZGI4N2UwZjdlOTBiYTM4ODNlMDdiODUy
MjMyMmFkCj4+ID4gcGF0Y2ggbGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMw
OTA5MDQzODA2LjM1MzktMS1yZXViZW5od2tAZ21haWwuY29tLwo+PiA+IHBhdGNoIHN1YmplY3Q6
IFtQQVRDSF0gdmZzOiBmaXggcmVhZGFoZWFkKDIpIG9uIGJsb2NrIGRldmljZXMKPj4gPgo+PiA+
IGluIHRlc3RjYXNlOiBsdHAKPj4gPiB2ZXJzaW9uOiBsdHAteDg2XzY0LTE0YzFmNzYtMV8yMDIz
MDcxNQo+PiA+IHdpdGggZm9sbG93aW5nIHBhcmFtZXRlcnM6Cj4+ID4KPj4gPiAgICAgICAgIGRp
c2s6IDFIREQKPj4gPiAgICAgICAgIGZzOiBleHQ0Cj4+ID4gICAgICAgICB0ZXN0OiBzeXNjYWxs
cy0wMC9yZWFkYWhlYWQwMQo+PiA+Cj4+ID4KPj4gPgo+PiA+IGNvbXBpbGVyOiBnY2MtMTIKPj4g
PiB0ZXN0IG1hY2hpbmU6IDQgdGhyZWFkcyAxIHNvY2tldHMgSW50ZWwoUikgQ29yZShUTSkgaTMt
MzIyMCBDUFUgQCAzLjMwR0h6IChJdnkgQnJpZGdlKSB3aXRoIDhHIG1lbW9yeQo+PiA+Cj4+ID4g
KHBsZWFzZSByZWZlciB0byBhdHRhY2hlZCBkbWVzZy9rbXNnIGZvciBlbnRpcmUgbG9nL2JhY2t0
cmFjZSkKPj4gPgo+PiA+Cj4+ID4KPj4gPgo+PiA+IElmIHlvdSBmaXggdGhlIGlzc3VlIGluIGEg
c2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEgbmV3IHZlcnNpb24gb2YKPj4g
PiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWdzCj4+ID4g
fCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNvbT4K
Pj4gPiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjMwOTE5MTAx
OC42OGVjODdkNy1vbGl2ZXIuc2FuZ0BpbnRlbC5jb20KPj4gPgo+PiA+Cj4+ID4KPj4gPiBDT01N
QU5EOiAgICAvbGtwL2JlbmNobWFya3MvbHRwL2Jpbi9sdHAtcGFuICAgLWUgLVMgICAtYSAzOTE3
ICAgICAtbiAzOTE3IC1wIC1mIC9mcy9zZGIyL3RtcGRpci9sdHAtUjhCcWh0c3Y1dC9hbGx0ZXN0
cyAtbCAvbGtwL2JlbmNobWFya3MvbHRwL3Jlc3VsdHMvTFRQX1JVTl9PTi0yMDIzXzA5XzEzLTIw
aF8xN21fNTNzLmxvZyAgLUMgL2xrcC9iZW5jaG1hcmtzL2x0cC9vdXRwdXQvTFRQX1JVTl9PTi0y
MDIzXzA5XzEzLTIwaF8xN21fNTNzLmZhaWxlZCAtVCAvbGtwL2JlbmNobWFya3MvbHRwL291dHB1
dC9MVFBfUlVOX09OLTIwMjNfMDlfMTMtMjBoXzE3bV81M3MudGNvbmYKPj4gPiBMT0cgRmlsZTog
L2xrcC9iZW5jaG1hcmtzL2x0cC9yZXN1bHRzL0xUUF9SVU5fT04tMjAyM18wOV8xMy0yMGhfMTdt
XzUzcy5sb2cKPj4gPiBGQUlMRUQgQ09NTUFORCBGaWxlOiAvbGtwL2JlbmNobWFya3MvbHRwL291
dHB1dC9MVFBfUlVOX09OLTIwMjNfMDlfMTMtMjBoXzE3bV81M3MuZmFpbGVkCj4+ID4gVENPTkYg
Q09NTUFORCBGaWxlOiAvbGtwL2JlbmNobWFya3MvbHRwL291dHB1dC9MVFBfUlVOX09OLTIwMjNf
MDlfMTMtMjBoXzE3bV81M3MudGNvbmYKPj4gPiBSdW5uaW5nIHRlc3RzLi4uLi4uLgo+PiA+IDw8
PHRlc3Rfc3RhcnQ+Pj4KPj4gPiB0YWc9cmVhZGFoZWFkMDEgc3RpbWU9MTY5NDYzNjI3NAo+PiA+
IGNtZGxpbmU9InJlYWRhaGVhZDAxIgo+PiA+IGNvbnRhY3RzPSIiCj4+ID4gYW5hbHlzaXM9ZXhp
dAo+PiA+IDw8PHRlc3Rfb3V0cHV0Pj4+Cj4+ID4gdHN0X3Rlc3QuYzoxNTU4OiBUSU5GTzogVGlt
ZW91dCBwZXIgcnVuIGlzIDBoIDAybSAzMHMKPj4gPiByZWFkYWhlYWQwMS5jOjM2OiBUSU5GTzog
dGVzdF9iYWRfZmQgLTEKPj4gPiByZWFkYWhlYWQwMS5jOjM3OiBUUEFTUzogcmVhZGFoZWFkKC0x
LCAwLCBnZXRwYWdlc2l6ZSgpKSA6IEVCQURGICg5KQo+PiA+IHJlYWRhaGVhZDAxLmM6Mzk6IFRJ
TkZPOiB0ZXN0X2JhZF9mZCBPX1dST05MWQo+PiA+IHJlYWRhaGVhZDAxLmM6NDU6IFRQQVNTOiBy
ZWFkYWhlYWQoZmQsIDAsIGdldHBhZ2VzaXplKCkpIDogRUJBREYgKDkpCj4+ID4gcmVhZGFoZWFk
MDEuYzo1NDogVElORk86IHRlc3RfaW52YWxpZF9mZCBwaXBlCj4+ID4gcmVhZGFoZWFkMDEuYzo1
NjogVFBBU1M6IHJlYWRhaGVhZChmZFswXSwgMCwgZ2V0cGFnZXNpemUoKSkgOiBFSU5WQUwgKDIy
KQo+PiA+IHJlYWRhaGVhZDAxLmM6NjA6IFRJTkZPOiB0ZXN0X2ludmFsaWRfZmQgc29ja2V0Cj4+
ID4gcmVhZGFoZWFkMDEuYzo2MjogVEZBSUw6IHJlYWRhaGVhZChmZFswXSwgMCwgZ2V0cGFnZXNp
emUoKSkgc3VjY2VlZGVkCj4+ID4KPj4KPj4gUmV1YmVuLAo+Pgo+PiBUaGlzIHJlcG9ydCBpcyBv
biBhbiBvbGQgdmVyc2lvbiBvZiB5b3VyIHBhdGNoLgo+PiBIb3dldmVyOgo+PiAxLiBMVFAgdGVz
dCByZWFkYWhlYWQwMSB3aWxsIG5lZWQgdG8gYmUgZml4ZWQgdG8gYWNjZXB0IGFsc28gRVNQSVBF
Cj4+IDIuIEkgYW0gc3VycHJpc2VkIHRoYXQgd2l0aCB0aGUgb2xkIHBhdGNoIHJlYWRhaGVhZCBv
biBzb2NrZXQgZGlkIG5vdAo+PiAgICAgZmFpbC4gRG9lcyBzb2NrZXQgaGF2ZSBhb3BzPwo+Pgo+
PiBQbGVhc2UgdHJ5IHRvIHJ1biBMVFAgdGVzdCByZWFkYWhlYWQwMSBvbiB0aGUgcGF0Y2ggdGhh
dCBDaHJpc3RpYW4gcXVldWVkCj4+IGFuZCBzZWUgaG93IGl0IGJlaGF2ZXMgYW5kIGlmIGFueXRo
aW5nIG5lZWRzIHRvIGJlIGZpeGVkIHdydCBzb2NrZXRzLgo+Pgo+PiBUaGFua3MsCj4+IEFtaXIu
Cj4KPgo+IGFjay4gIFdpbGwgdHJ5IHRvIHRlc3QuICBNeSBVYnVudHUgMjIuMDQgc3lzdGVtIHdh
c24ndCBhYmxlIHRvIGZpbmQgcGFja2FnZXMgY2FsbGVkCj4gZm9yIGJ5IHRoZSB0ZXN0IGNhc2Us
IHNvIGl0J2xsIHRha2UgbWUgYSBsaXR0bGUgd2hpbGUgdG8gZmlndXJlIG91dCBob3cgdG8gZ2V0
IHRoZQo+IHRlc3QgY2FzZSB3b3JraW5nLi4uCgpIZWghIHlvdSBjYW4gd3JpdGUgYSBzbWFsbCBD
IHByb2dyYW0gaW5zdGVhZCwgeW91IGRvbid0IGV2ZW4gbmVlZCB0bwpidWlsZCB0aGUgTFRQIHRl
c3QuCgpJdCBpcyBjbGVhciB3aGF0IHRoZSBmYWlsZWQgdGVzdCBpcyBkb2luZzoKCnN0YXRpYyB2
b2lkIHRlc3RfaW52YWxpZF9mZCh2b2lkKQp7CiAgICAgICAgaW50IGZkWzJdOwoKICAgICAgICB0
c3RfcmVzKFRJTkZPLCAiJXMgcGlwZSIsIF9fZnVuY19fKTsKICAgICAgICBTQUZFX1BJUEUoZmQp
OwogICAgICAgIFRTVF9FWFBfRkFJTChyZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2VzaXplKCkp
LCBFSU5WQUwpOwogICAgICAgIFNBRkVfQ0xPU0UoZmRbMF0pOwogICAgICAgIFNBRkVfQ0xPU0Uo
ZmRbMV0pOwoKICAgICAgICB0c3RfcmVzKFRJTkZPLCAiJXMgc29ja2V0IiwgX19mdW5jX18pOwog
ICAgICAgIGZkWzBdID0gU0FGRV9TT0NLRVQoQUZfSU5FVCwgU09DS19TVFJFQU0sIDApOwogICAg
ICAgIFRTVF9FWFBfRkFJTChyZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2VzaXplKCkpLCBFSU5W
QUwpOwogICAgICAgIFNBRkVfQ0xPU0UoZmRbMF0pOwp9CgpUaGUgcmVwb3J0IGNsYWltcyB0aGF0
IHJlYWRhaGVhZCBvbiBzb2NrZXQgc3VjY2VlZHMKYW5kIHRoaXMgaXMgc3VycHJpc2luZy4KClRo
YW5rcywKQW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
