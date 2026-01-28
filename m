Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063EFD46C15
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 23:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769642500; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=jESolaCCRdDYM2AdfwAkNWbtUiK7qHVqcj0VjqqA08U=;
 b=MSsoSJ9FLS4zOJHNYIXNejAjP1CfqaKYmOzZRNWBs/O6jFUlpEKSB1ifJaa0o2AhH67tt
 7T3jQ4aEJ7U/8rcjxAD61L13wujAmP7jD0dZPRoT/RRpp2WjEyvv61QQLom8+0Nbv13Alsc
 mj+4tilWMECWRq9Ie+oP7Nyla9Q2hkE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B2913CAC1D
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 00:21:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20DBC3C4B46
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 00:21:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4BECD1A002C4
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 00:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769642472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/x4MrndIR9Pg9Q8qSG7ptnBapqT8NgXVZtEFnZ0A7gU=;
 b=BrVxyhwl2SaMailztbsavgoqGttk42yFcvPRmJ6MtfVYPkTYfAmRZnGe5HU25csGHD95QZ
 whZSPIyL8nG4U8A0R15Qys9MPT8VOdcf3WRplUyv1fOySB0cydIu6ZTKVMM4M5fjovteNc
 S/8gjYzrFUrbAg9Coqf/GarCUldplf0=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-WoFxMJCdMeO1iYEBy3dvaw-1; Wed, 28 Jan 2026 18:21:10 -0500
X-MC-Unique: WoFxMJCdMeO1iYEBy3dvaw-1
X-Mimecast-MFC-AGG-ID: WoFxMJCdMeO1iYEBy3dvaw_1769642469
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b738854780so584431eec.0
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 15:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769642468; x=1770247268;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/x4MrndIR9Pg9Q8qSG7ptnBapqT8NgXVZtEFnZ0A7gU=;
 b=H1sLFGB4aS/axyQp+eUS6z9AqjPL1ncyc9VW1GekiGKsJLAM2sDLk7DROqrCpd+1XA
 L19+ti629wQtegX9DpBLpii3Mqpb9OoNTBMK4IdUB7HZ17GkpaKjz0d5iDCGBD1eecCc
 fsrRWi6fAeNHtzB+DtlG+zTVZEZdT02P/KnH3GvTQmGjEfOAb3RdyhqZcUhvIbqUX9Os
 cVotRVvhEi9SVVHN/yziiyAjntJe3fuCDSETWHeq89Nn5s4zyS+L058PaDG3705ycXmU
 9Sr03QRDge8XBqbBzioe8YS/4pDOpAMjjJLtgNj3NaODLa1VoYjVQefFSQJbpjtpyfA8
 A2eg==
X-Gm-Message-State: AOJu0Ywxh/HPZPPRwI0jdUpcc4WmERQhII6+wnu/tTde9/i/jcL1kAdw
 qUfTC0A4IY/wmtIiuPSMgGvAtZBxd6//X5xtbaag3hw3tt5f3WhNIZSsq8pqjuYQGOFEBKYX/El
 ghYIgtKliXZfiW4avrgen3rvfHRVpqD+EOw2jvUzL4qcYAVzBHpQEYEQmavNLWnzcC3o1WV4QJc
 /uE9S6vJqc1hQMPvYggRBUB2IBbJNQ6jOWmFNADw==
X-Gm-Gg: AZuq6aIMT56n8D74NcDIBnynmEz3nz+CcHIO3IXRBrsI5hDVnmO2Bd8uq8Y2X3wPwX2
 zQ96kIffBJlJuR0NXEP266fl2tEkyCvFZTKtsOGC7pCv98ZwBXaqpsEUX2V4vtQKcfyHWxSOjW1
 7+5gSu+8NtFruUUuBMMNQefx75McP3ShbBjBMLjqlztc0ofHTsoI+kDWFSSXApYU0aF4M=
X-Received: by 2002:a05:7300:fd0a:b0:2b7:33a6:b270 with SMTP id
 5a478bee46e88-2b78d951cb4mr4144994eec.19.1769642467899; 
 Wed, 28 Jan 2026 15:21:07 -0800 (PST)
X-Received: by 2002:a05:7300:fd0a:b0:2b7:33a6:b270 with SMTP id
 5a478bee46e88-2b78d951cb4mr4144981eec.19.1769642467355; Wed, 28 Jan 2026
 15:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20260116022507.204549-1-liwang@redhat.com>
 <20260116022507.204549-2-liwang@redhat.com>
 <20260128212207.GA60105@pevik>
In-Reply-To: <20260128212207.GA60105@pevik>
Date: Thu, 29 Jan 2026 07:20:55 +0800
X-Gm-Features: AZwV_QibiQ97woEfKBujz6osSzlciUSdsL3MN_Q6e14cPhAigRmBJzvD1PgWaBU
Message-ID: <CAEemH2fkn3C4ov0YL9sx5SiBMuWEOoNfrwAzEsOwCZZDTtuEwA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wYrqs--Scl9apcBbjGsy-KZpodHZJXXW_nImJXuMJHs_1769642469
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] include/old: rename legacy headers to
 tso_* namespace
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

T24gVGh1LCBKYW4gMjksIDIwMjYgYXQgNToyMuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIGFsbCwKPgo+ID4gVG8gY2xlYXJseSBkaXN0aW5ndWlzaCBs
ZWdhY3kgaGVhZGVyIGZpbGVzIGZyb20gdGhlIGNvcmUgKHRzdF8qKSBhbmQKPiA+IGV4dGVuc2lv
biAodHNlXyopIExUUCBBUElzLCBsZWdhY3kgaGVhZGVyIGZpbGVzIGhhdmUgYmVlbiBncm91cGVk
Cj4gPiBpbnRvIHRoZSBvdHN0XyogbmFtZXNwYWNlLgo+Cj4gPiBTb21lIGxlZ2FjeSBoZWFkZXIg
ZmlsZXMgZG8gbm90IGJlZ2luIHdpdGggb2xkXywgdGhleSBzdGlsbCBiZWxvbmcKPiA+IHRvIHRo
ZSBsZWdhY3kgaGVhZGVyIGZpbGUgc2V0LiBGb3IgY2xhcml0eSwgYWxsIGxlZ2FjeSBoZWFkZXIg
ZmlsZXMKPiA+IGFyZSBub3cgdW5pZm9ybWx5IGdyb3VwZWQgaW50byB0aGUgdHNvXyogbmFtZXNw
YWNlLgo+Cj4gPiAgaW5jbHVkZS9vbGQve29sZF9jaGVja3BvaW50LmggPT4gdHNvX2NoZWNrcG9p
bnQuaH0KPiA+ICBpbmNsdWRlL29sZC97bHRwX2NwdWlkLmggPT4gdHNvX2NwdWlkLmh9Cj4gPiAg
aW5jbHVkZS9vbGQve29sZF9kZXZpY2UuaCA9PiB0c29fZGV2aWNlLmh9Cj4gPiAgaW5jbHVkZS9v
bGQve3RsaWJpby5oID0+IHRzb19saW8uaH0KPiA+ICBpbmNsdWRlL29sZC97b2xkX21vZHVsZS5o
ID0+IHRzb19tb2R1bGUuaH0KPiA+ICBpbmNsdWRlL29sZC97bHRwX3ByaXYuaCA9PiB0c29fcHJp
di5ofQo+ID4gIGluY2x1ZGUvb2xkL3tyYW5kb21fcmFuZ2UuaCA9PiB0c29fcmFuZG9tX3Jhbmdl
Lmh9Cj4gPiAgaW5jbHVkZS9vbGQve29sZF9yZXNvdXJjZS5oID0+IHRzb19yZXNvdXJjZS5ofQo+
ID4gIGluY2x1ZGUvb2xkL3tvbGRfc2FmZV9maWxlX29wcy5oID0+IHRzb19zYWZlX2ZpbGVfb3Bz
Lmh9Cj4gPiAgaW5jbHVkZS9vbGQve3NhZmVfbWFjcm9zLmggPT4gdHNvX3NhZmVfbWFjcm9zLmh9
Cj4gPiAgaW5jbHVkZS9vbGQve29sZF9zYWZlX25ldC5oID0+IHRzb19zYWZlX25ldC5ofQo+ID4g
IGluY2x1ZGUvb2xkL3tvbGRfc2FmZV9zdGRpby5oID0+IHRzb19zYWZlX3N0ZGlvLmh9Cj4gPiAg
aW5jbHVkZS9vbGQve2x0cF9zaWduYWwuaCA9PiB0c29fc2lnbmFsLmh9Cj4gPiAgaW5jbHVkZS9v
bGQve29sZF90bXBkaXIuaCA9PiB0c29fdG1wZGlyLmh9Cj4gPiAgaW5jbHVkZS9vbGQve3VzY3Rl
c3QuaCA9PiB0c29fdXNjdGVzdC5ofQo+Cj4gQXMgSSB3cm90ZSwgSSBkb24ndCBsaWtlIHRoZSB3
aG9sZSByZW5hbWUgYnV0IEkgd2lsbCBub3QgYmxvY2sgaXQuCj4gSSBndWVzcyBpdCB3aWxsIGJl
IG1lcmdlZCBhZnRlciB0aGUgcmVsZWFzZSwganVzdCBub3QgdG8gYnJlYWsgYW55dGhpbmcuCj4K
PiBCdXQgaXMgaXQgd29ydGggdG8gcmVuYW1lIHdob2xlIG9sZCBBUEkgc291cmNlcyBhbmQgaGVh
ZGVycz8gSXNuJ3QgaXQKPiBlbm91Z2gKPiBqdXN0IHRvIGtub3cgdGhhdCAndHN0Xycgb3IgJ3Rz
ZV8nIGFyZSBuZXcgQVBJLCB0aGUgcmVzdCBpcyB0aGUgb2xkIEFQSSBvcgo+IG5vCj4gQVBJPyBF
YWNoIHJlbmFtZSBtZWFucyB0aGF0ICdnaXQgbG9nJyByZXF1aXJlcyAnLS0nIGJlY2F1c2UgdGhl
IHJlbmFtZS4KPgoKV2VsbCwgeWVzLCB0aGF0J3MgbXkgaGVzaXRhdGlvbiB0b28uCgpIb3dldmVy
LCBJIGJlbGlldmUgdGhlIG9sZCBBUElzIG1heSBwZXJzaXN0IGZvciBhIGxvbmcgdGltZS4gVGhl
cmVmb3JlLAp1c2luZyBjb25zaXN0ZW50IG5hbWluZyBjb252ZW50aW9ucyBmb3IgYWxsIEFQSXMg
d2lsbCBtYWtlIGl0IGVhc2llciBmb3IKTFRQIGJlZ2lubmVycyB0byB1bmRlcnN0YW5kIHRoZSBj
b2RlIGxvZ2ljLgoKCj4KPiBBbnl3YXksIElNSE8gaXQgd291bGQgaGVscCAoYXMgYSBzZXBhcmF0
ZSBlZmZvcnQgYWZ0ZXIgdGhlIHJlbGVhc2UpIHRvCj4gZGVzY3JpYmUKPiB0aGUgcHJlZml4ZXMg
aW4gZG9jLgo+CgpZZXMsIGl0J3Mgbm90IGEgcnVzaCwgd2UgY291bGQgZ2l2ZSBlbm91Z2ggdGlt
ZSBmb3IgcmVmaW5lbWVudCB3b3JrLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
