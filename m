Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56DBD11183
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764244671; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xe5OlWR95ZByimkuIjU8+QZAo0G3EnbBAnYp6pNyDas=;
 b=eJMaXEIUXHUHbNLi17HuqZrWRvBXwT6/r52+DjempE3ZcFEqC/AT9Pyv6ezfYwvRAMxyV
 VG0LKo6hdwj0FT7fgO0Ue5wJNSAoq6v8lNEDlTbP91yAg7Am+mHubpZJTdqTugLUvtCQFSS
 r5uf1a5bpLcMXtRniafy/YzclbxNcFA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 146913CC54D
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 12:57:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 713783C81BB
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 12:57:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA6C06009CC
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 12:57:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764244646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=muqASUX6r+DjNJrxenImj5JeziEUyDJZ81dPUbxu7Yo=;
 b=Az65kKTV9huuHy5MdIcOO03FvLPmGCjPuvcTyhHdSCtb3EIlQI2Pv22rscC5h00tfPaUc0
 f4wz/GNFy7q5/QC54PICMwx68OUIdK7WdE6sQRNZ+Ag26+Fu22N0ZMv6FxaFTj5p+YhAVE
 aChu3ubsJDqN72j1WaLqGmpUPvIPybg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-I3Y8xWNoNeqvy_H1syoF-A-1; Thu, 27 Nov 2025 06:57:23 -0500
X-MC-Unique: I3Y8xWNoNeqvy_H1syoF-A-1
X-Mimecast-MFC-AGG-ID: I3Y8xWNoNeqvy_H1syoF-A_1764244643
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bdced916ad0so1268537a12.0
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 03:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764244643; x=1764849443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muqASUX6r+DjNJrxenImj5JeziEUyDJZ81dPUbxu7Yo=;
 b=CKRdUelxch2mph23mgBcL6NWsQct8N42ZMnIzz/pDG33qqIlRm/Xta59hYspD04F+7
 rlud5vpNhVpSjdcTLA9/xJ6epuhAPFUhX1AV4DRwbyldv8QNZ/zS6CgVu38MDMIrlj18
 mm9ncACmw0nYv8P/4ayGcg1N8Lnjb6iihM8M03CyWWO4prjA0+qMPuhVcuBTFXIna9Tq
 o8fBmqaX2okDXdMqAn+X71dX2HYvmihyl5BIaXk9jLY47GKrTSwO403KroxFmOSJIgwl
 D0sxixrk9a3ti6jtdQNnDCg47+SSWXCPGpFiElzpx1COP3tztUvKtpt79x+hgm9fIaTD
 yWCg==
X-Gm-Message-State: AOJu0YxuUysh0DPZFqYj2HiRMs/hMoAFQ1V2hqI7bSUBYdk0euQzwyP1
 T7uzL7vJ1myHU9fLAjlc28XAIDU5k5rAlLKu0kqK7fSDfFzKSTZFTN/c+B6AEbUxTUjSfcdVE34
 3FrD5NzWyZmpQIT3EBhdSTPbDh5rOetuHfU2O/X7UnFgPEnwhQ4VDvveEpsn/KyutqEHKsQ0ul5
 PxEl5S5fWjVSbd4p75hICU0ZWqVeg=
X-Gm-Gg: ASbGncuK4IgteWzzmSe2F6VPQCY6x9gIB/ft7nHb4kI+TjySaEdYpZpHCf6hi7P5X13
 /DjKbdJZv2wsoW+GxCixfgXH24twmPHqhYfzoPk7GCANkhMIXnQoAzyxwatBiljI7X2SwJq/Gbq
 Vq5rWiMsgZQ1hmaQXvFvrquBTZQC7ACefvOtrZMp334Beye+54lLgJpb/KKlzhUxLAAN0=
X-Received: by 2002:a05:7300:de01:b0:2a4:41c6:24f with SMTP id
 5a478bee46e88-2a7190b3e87mr11498922eec.7.1764244642629; 
 Thu, 27 Nov 2025 03:57:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPcTItHszjFFmVXE84QlurNqWVQ+SY3r4K2WO/IRITge4sBf8JdyCABCgrbStpaA75X8LRCtwG2GIKhdaP/TY=
X-Received: by 2002:a05:7300:de01:b0:2a4:41c6:24f with SMTP id
 5a478bee46e88-2a7190b3e87mr11498907eec.7.1764244642173; Thu, 27 Nov 2025
 03:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20251127082638.224110-1-pvorel@suse.cz>
 <20251127082638.224110-2-pvorel@suse.cz>
In-Reply-To: <20251127082638.224110-2-pvorel@suse.cz>
Date: Thu, 27 Nov 2025 19:57:10 +0800
X-Gm-Features: AWmQ_bm0UMa1lk0wd38lCuHqKcBU0jjLF-m-94kerZ6-Xzb4FXZixOSEu97uPAU
Message-ID: <CAEemH2cUYekSphFW_uj2w1FzYt3RWXDDnhmQ5TFAyr0T3HFxow@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wJF2Tzzaxq0iMOTNtlC_5niZ0ePnudSGaU_1colKKT4_1764244643
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/4] shell: Add tst_sudo.c helper
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCkkgZmVlbCB0aGF0IHRoZSBmaWxlbmFtZSB0c3Rfc3Vkby5jIGlzIGEgYml0IG1p
c2xlYWRpbmcuIFRoZSBoZWxwZXIgZG9lc27igJl0CnJlcGxpY2F0ZSBzdWRvIGJlaGF2aW9yIChh
dXRoZW50aWNhdGlvbiwgcHJpdmlsZWdlIGVzY2FsYXRpb24pLCBpdCBzaW1wbHkKZHJvcHMgZnJv
bSByb290IHRvIGEgZml4ZWQgVUlEL0dJRCBiZWZvcmUgZXhlY3V0aW5nIGEgY29tbWFuZC4KClNv
IHJlYWRlcnMgbWF5IGV4cGVjdCBhIOKAnHN1ZG8tbGlrZeKAnSBlbGV2YXRpb24gd3JhcHBlciB3
aGVuLCBob3dldmVyCml04oCZcyBhIHByaXZpbGVnZS1kcm9wcGluZyB0cmFtcG9saW5lLgoKV2hh
dCBhYm91dCByZW5hbWluZyBpdCB0bzoKICB0c3RfcnVuYXMuYywKICB0c3RfcnVuYXNfbm9ib2R5
LmMsIG9yCiAgdHN0X2Ryb3BfcHJpdnMuYz8KCgpPbiBUaHUsIE5vdiAyNywgMjAyNSBhdCA0OjI2
4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiBJdCB3aWxsIGJlIHVz
ZWQgaW4gTFRQIElNQSB0ZXN0cy4gTm90IG9ubHkgaXQgcmVtb3ZlcyBleHRlcm5hbAo+IGRlcGVu
ZGVuY3ksIGJ1dCBhbHNvIGZpeGVzIHByb2JsZW0gd2hlbiAnbm9ib2R5JyB1c2VyIGlzIG5vdCBw
b3NzaWJsZSB0bwo+IHVzZSBkdWUgdXNpbmcgL3Vzci9zYmluL25vbG9naW4gc2hlbGwuCj4KPiBT
dWdnZXN0ZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgo+IFNpZ25lZC1v
ZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IC0tLQo+ICBkb2MvdXNlcnMvc2V0
dXBfdGVzdHMucnN0IHwgIDQgKysrKwo+ICB0ZXN0Y2FzZXMvbGliLy5naXRpZ25vcmUgIHwgIDEg
Kwo+ICB0ZXN0Y2FzZXMvbGliL01ha2VmaWxlICAgIHwgIDIgKy0KPiAgdGVzdGNhc2VzL2xpYi90
c3Rfc3Vkby5jICB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ICA0IGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9saWIvdHN0X3N1ZG8uYwo+Cj4gZGlmZiAtLWdpdCBh
L2RvYy91c2Vycy9zZXR1cF90ZXN0cy5yc3QgYi9kb2MvdXNlcnMvc2V0dXBfdGVzdHMucnN0Cj4g
aW5kZXggMzg5NzZmM2IwYS4uOWM0OTg1MjgzMCAxMDA2NDQKPiAtLS0gYS9kb2MvdXNlcnMvc2V0
dXBfdGVzdHMucnN0Cj4gKysrIGIvZG9jL3VzZXJzL3NldHVwX3Rlc3RzLnJzdAo+IEBAIC03MSw2
ICs3MSwxMCBAQCB1c2Vycy4KPiAgICAgKiAtIExUUF9JTUFfTE9BRF9QT0xJQ1kKPiAgICAgICAt
IExvYWQgSU1BIGV4YW1wbGUgcG9saWN5LCBzZWUKPiA6bWFzdGVyOmB0ZXN0Y2FzZXMva2VybmVs
L3NlY3VyaXR5L2ludGVncml0eS9pbWEvUkVBRE1FLm1kYC4KPgo+ICsgICAqIC0gTFRQX1VTUl9V
SUQsIExUUF9VU1JfR0lECj4gKyAgICAgLSBTZXQgVUlEIGFuZCBHSUQgb2YgYGBub2JvZHlgYCB1
c2VyIGZvcgo+IDpkb2M6YC4uL2RldmVsb3BlcnMvYXBpX3NoZWxsX3Rlc3RzYCwKPiArICAgICAg
IHNlZSA6bWFzdGVyOmB0ZXN0Y2FzZXMvbGliL3RzdF9zdWRvLmNgLgo+ICsKPiAgICAgKiAtIExU
UF9WSVJUX09WRVJSSURFCj4gICAgICAgLSBPdmVycmlkZXMgdmlydHVhbCBtYWNoaW5lIGRldGVj
dGlvbiBpbiB0aGUgdGVzdCBsaWJyYXJ5LiBTZXR0aW5nCj4gaXQgdG8KPiAgICAgICAgIGVtcHR5
IHN0cmluZywgdGVsbHMgdGhlIGxpYnJhcnkgdGhhdCBzeXN0ZW0gaXMgbm90IGEgdmlydHVhbAo+
IG1hY2hpbmUuCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvLmdpdGlnbm9yZSBiL3Rlc3Rj
YXNlcy9saWIvLmdpdGlnbm9yZQo+IGluZGV4IDE5ZDdjNjdiYmUuLjc4NWQ2MzhjYmEgMTAwNjQ0
Cj4gLS0tIGEvdGVzdGNhc2VzL2xpYi8uZ2l0aWdub3JlCj4gKysrIGIvdGVzdGNhc2VzL2xpYi8u
Z2l0aWdub3JlCj4gQEAgLTI2LDMgKzI2LDQgQEAKPiAgL3RzdF9yZXNfCj4gIC90c3RfcnVuX3No
ZWxsCj4gIC90c3RfcmVtYWluaW5nX3J1bnRpbWUKPiArL3RzdF9zdWRvCj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9saWIvTWFrZWZpbGUgYi90ZXN0Y2FzZXMvbGliL01ha2VmaWxlCj4gaW5kZXgg
MjMwOWE0MmEzZC4uOWJlOTk0NjA1NyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMvbGliL01ha2Vm
aWxlCj4gKysrIGIvdGVzdGNhc2VzL2xpYi9NYWtlZmlsZQo+IEBAIC0xNyw2ICsxNyw2IEBAIE1B
S0VfVEFSR0VUUyAgICAgICAgICA6PSB0c3Rfc2xlZXAgdHN0X3JhbmRvbQo+IHRzdF9jaGVja3Bv
aW50IHRzdF9yb2QgdHN0X2t2Y21wXAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9n
ZXRfbWVkaWFuIHRzdF9oZXhkdW1wIHRzdF9nZXRfZnJlZV9waWRzCj4gdHN0X3RpbWVvdXRfa2ls
bFwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfY2hlY2tfa2NvbmZpZ3MgdHN0X2Nn
Y3RsIHRzdF9mc2ZyZWV6ZQo+IHRzdF9uc19jcmVhdGUgdHN0X25zX2V4ZWNcCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdHN0X25zX2lmbW92ZSB0c3RfbG9ja2Rvd25fZW5hYmxlZAo+IHRz
dF9zZWN1cmVib290X2VuYWJsZWQgdHN0X3Jlc19cCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgdHN0X3J1bl9zaGVsbCB0c3RfcmVtYWluaW5nX3J1bnRpbWUKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICB0c3RfcnVuX3NoZWxsIHRzdF9yZW1haW5pbmdfcnVudGltZSB0c3Rfc3Vkbwo+
Cj4gIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfdHJ1bmtfdGFyZ2V0
Lm1rCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvdHN0X3N1ZG8uYyBiL3Rlc3RjYXNlcy9s
aWIvdHN0X3N1ZG8uYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwMC4u
ZThkNWQ4ZGQ5ZAo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMvbGliL3RzdF9zdWRv
LmMKPiBAQCAtMCwwICsxLDUwIEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyCj4gKy8qCj4gKyAqIENvcHlyaWdodCAoYykgMjAyNSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4KPiArICovCj4gKwo+ICsjZGVmaW5lIExUUF9VU1JfVUlEIDY1NTM0Cj4g
KyNkZWZpbmUgTFRQX1VTUl9HSUQgNjU1MzQKPiArCj4gKyNkZWZpbmUgVFNUX05PX0RFRkFVTFRf
TUFJTgo+ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiArCj4gK3N0YXRpYyB2b2lkIHByaW50X2hl
bHAodm9pZCkKPiArewo+ICsgICAgICAgZnByaW50ZihzdGRlcnIsICJVc2FnZTogJXMgY21kIFth
cmdzXSAuLi5cbiIsIF9fRklMRV9fKTsKPiArICAgICAgIGZwcmludGYoc3RkZXJyLCAiVXNhZ2U6
ICVzIGNtZCBbLWhdIHByaW50IGhlbHBcblxuIiwgX19GSUxFX18pOwo+ICsKPiArICAgICAgIGZw
cmludGYoc3RkZXJyLCAiRW52aXJvbm1lbnQgVmFyaWFibGVzXG4iKTsKPiArICAgICAgIGZwcmlu
dGYoc3RkZXJyLCAiTFRQX1VTUl9VSUQ6IFVJRCBvZiAnbm9ib2R5JyB1c2VyLCBkZWZhdWx0cyAl
ZFxuIiwKPiArICAgICAgICAgICAgICAgICAgICAgICBMVFBfVVNSX1VJRCk7Cj4gKyAgICAgICBm
cHJpbnRmKHN0ZGVyciwgIkxUUF9VU1JfR0lEOiBHSUQgb2YgJ25vYm9keScgdXNlciwgZGVmYXVs
dHMgJWRcbiIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgTFRQX1VTUl9HSUQpOwo+ICt9Cj4g
Kwo+ICtpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQo+ICt7Cj4gKyAgICAgICBpZiAo
YXJnYyA8IDIgfHwgIXN0cmNtcChhcmd2WzFdLCAiLWgiKSkgewo+ICsgICAgICAgICAgICAgICBw
cmludF9oZWxwKCk7Cj4gKyAgICAgICAgICAgICAgIHJldHVybiAxOwo+ICsgICAgICAgfQo+ICsK
PiArICAgICAgIHVuc2lnbmVkIHVpZCA9IExUUF9VU1JfVUlELCBnaWQgPSBMVFBfVVNSX0dJRDsK
PiArCj4KCgo+ICsgICAgICAgY2hhciAqdWlkX2VudiA9IGdldGVudihUU1RfVE9fU1RSXyhMVFBf
VVNSX1VJRCkpOwo+ICsgICAgICAgY2hhciAqZ2lkX2VudiA9IGdldGVudihUU1RfVE9fU1RSXyhM
VFBfVVNSX0dJRCkpOwo+CgpJIGd1ZXNzIHlvdSBwcm9iYWJseSB3YW50OgoKLSAgICAgICBjaGFy
ICp1aWRfZW52ID0gZ2V0ZW52KFRTVF9UT19TVFJfKExUUF9VU1JfVUlEKSk7Ci0gICAgICAgY2hh
ciAqZ2lkX2VudiA9IGdldGVudihUU1RfVE9fU1RSXyhMVFBfVVNSX0dJRCkpOworICAgICAgIGNo
YXIgKnVpZF9lbnYgPSBnZXRlbnYoIkxUUF9VU1JfVUlEIik7CisgICAgICAgY2hhciAqZ2lkX2Vu
diA9IGdldGVudigiTFRQX1VTUl9HSUQiKTsKCgoKCj4gKwo+ICsgICAgICAgaWYgKHVpZF9lbnYp
Cj4gKyAgICAgICAgICAgICAgIHVpZCA9IFNBRkVfU1RSVE9MKHVpZF9lbnYsIDEsIElOVF9NQVgp
Owo+ICsKPiArICAgICAgIGlmIChnaWRfZW52KQo+ICsgICAgICAgICAgICAgICBnaWQgPSBTQUZF
X1NUUlRPTChnaWRfZW52LCAxLCBJTlRfTUFYKTsKPgoKSWYgeW91IHdhbnQgdG8gc3VwcG9ydCBy
b290IHByaXZpbGVnZSBoZXJlIHdlIG5lZWQgdG8gYWNjZXB0IDAuCgoKCj4gKwo+ICsgICAgICAg
dHN0X3JlcyhUSU5GTywgIlVJRDogJWQsIEdJRDogJWQiLCB1aWQsIGdpZCk7Cj4gKyAgICAgICBT
QUZFX1NFVEdST1VQUygwLCBOVUxMKTsKPiArICAgICAgIFNBRkVfU0VUUkVTR0lEKGdpZCwgZ2lk
LCBnaWQpOwo+ICsgICAgICAgU0FGRV9TRVRSRVNVSUQodWlkLCB1aWQsIHVpZCk7Cj4gKwo+ICsg
ICAgICAgU0FGRV9DTUQoKGNvbnN0IGNoYXIgKiBjb25zdCAqKSZhcmd2WzFdLCBOVUxMLCBOVUxM
KTsKPiArCj4gKyAgICAgICByZXR1cm4gMDsKPiArfQo+IC0tCj4gMi41MS4wCj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
