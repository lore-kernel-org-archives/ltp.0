Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD9BC4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 03:52:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C4C13CFCB9
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 04:52:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD11C3CDFBE
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 04:52:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9C0EF100023A
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 04:52:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701229924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFGzEhHVY9flTXDIB2zslg/z1sDObGeeCLFJHltS45g=;
 b=J0JTIflaVQ+gTiZ9kA/wBKM9HoV/CglBv2AQIgKodxURfJx4IH1V+s6lMQbA+HLoq8rwxI
 bVrmXKP6zYzkAl7bITHVqaAWIJfiU2M0oOI6f3dr3/4s9qz+jLxrn96z0FWjfjRiSY7QFE
 R1oVN2JkSBJbEXLEaAK3Y34xY7zo0K8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-sXYRFj6WO2i9wOtWnW6UwA-1; Tue, 28 Nov 2023 22:52:02 -0500
X-MC-Unique: sXYRFj6WO2i9wOtWnW6UwA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5090b341d6bso292645e87.1
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 19:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701229921; x=1701834721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rFGzEhHVY9flTXDIB2zslg/z1sDObGeeCLFJHltS45g=;
 b=cjPGoiZAGPVm4LGNp7f6FhghpRB2+wjjVwsPsioOrXxH4JPYAhwo/gErGMVIc5cNu8
 8eEvOI6qDjIsUFRmudyoUqExW2cqhZSCXhJvlpFM486BfdNkMCTvpasVHGP2B6RHD8L6
 dAcu7d+HJVLyW/wCm0PFTxrkFjYvCV+7FZXPS8Kqk1+CZAuA8OkHn/tbiZDTv2BPOxCB
 1sEUQgygcrHu8mUGJdO7eQPy97eBlyOBWLXGksQzEr5oeBqNDazRnb2PeTHhCxMI3W1J
 +H3QXpxjKHtvsqHvSJb0ZajCHma7zWWFgpL0LS5bafJO/i6HNWloyccQmlW1n9SnMJA6
 X2xA==
X-Gm-Message-State: AOJu0YxR6U0vW5lfN1C7AnF2Pn8QIt6U+Ad/Yhscjb6ODQ6UtHQ+ReAl
 AjfJKa/F9pLYYJCtPc1CLhkhDzi33FZb5/2kUYFwoeXWfsU0cDgqThOaOr4F0tWzog7lqKEqpvl
 Lvne5oP8/gdvP0m73irCNKLXhtZM=
X-Received: by 2002:a05:6512:3b86:b0:50a:ae89:491f with SMTP id
 g6-20020a0565123b8600b0050aae89491fmr7879667lfv.3.1701229921004; 
 Tue, 28 Nov 2023 19:52:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhiQ0mcBwBgzA7wHAY/vJ8su/RQsr2JmQyjOti1tQfKeWVscXkivUWk/3JBfQ7uHAPtRhmPfsGfHH80qOE6Gk=
X-Received: by 2002:a05:6512:3b86:b0:50a:ae89:491f with SMTP id
 g6-20020a0565123b8600b0050aae89491fmr7879656lfv.3.1701229920589; Tue, 28 Nov
 2023 19:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20231127174517.2369593-1-shr@devkernel.io>
 <20231128074626.GA298624@pevik>
 <CAEemH2dQDVg+nLD4cTjgReoUaZ+FU7TFEsg=Vc8h6sdV-VqLpg@mail.gmail.com>
 <20231128165132.GA406520@pevik>
In-Reply-To: <20231128165132.GA406520@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Nov 2023 11:51:48 +0800
Message-ID: <CAEemH2fqamX720diM1N+iN9a8HM30_5sHg8V0EMHgHdrh3iZPw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] mem: disable KSM smart scan for ksm tests
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
Cc: david@redhat.com, Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org,
 oliver.sang@intel.com, kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBOb3YgMjksIDIwMjMgYXQgMTI6NTHigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IEhpIFN0ZWZhbiwgTGksCj4KPiA+IEhpIFN0ZWZhbiwgUGV0ciwKPgo+
ID4gT24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgMzo0NuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToKPgo+ID4gPiBIaSBTdGVmYW4sCj4KPiA+ID4gPiBUaGlzIGRpc2FibGVz
IHRoZSAic21hcnQgc2NhbiIgS1NNIGZlYXR1cmUgdG8gbWFrZSBzdXJlIHRoYXQgdGhlCj4gdm9s
YXRpbGUKPiA+ID4gPiBjb3VudCByZW1haW5zIGF0IDAuCj4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gUm9lc2NoIDxkZXZrZXJuZWwuaW8+Cj4gPiA+IG5pdDogeW91IGZvcmdvdCAnc2hy
QCcKPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIFJvZXNjaCA8c2hyQGRldmtlcm5lbC5pbz4K
Pgo+ID4gPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8b2xpdmVyLnNhbmdAaW50
ZWwuY29tPgo+ID4gPiA+IENsb3NlczoKPiA+ID4KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9v
ZS1sa3AvMjAyMzExMTYxMTMyLjEzZDhjZTVhLW9saXZlci5zYW5nQGludGVsLmNvbQo+ID4gPiA+
IC0tLQo+ID4gPiA+ICB0ZXN0Y2FzZXMva2VybmVsL21lbS9saWIvbWVtLmMgfCA0ICsrKysKPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4gPiA+ID4gZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+ID4gPiBiL3Rlc3RjYXNlcy9rZXJu
ZWwvbWVtL2xpYi9tZW0uYwo+ID4gPiA+IGluZGV4IGZiZmVlZjAyNi4uZWYyNzRhM2FjIDEwMDY0
NAo+ID4gPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+ID4gPiA+ICsr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+ID4gPiA+IEBAIC00NTQsNiArNDU0
LDkgQEAgdm9pZCBjcmVhdGVfc2FtZV9tZW1vcnkoaW50IHNpemUsIGludCBudW0sIGludAo+IHVu
aXQpCj4gPiA+ID4gICAgICAgICAgICAgIHsnYScsIHNpemUqTUJ9LCB7J2EnLCBzaXplKk1CfSwg
eydkJywgc2l6ZSpNQn0sIHsnZCcsCj4gPiA+IHNpemUqTUJ9LAo+ID4gPiA+ICAgICAgIH07Cj4K
PiA+ID4gPiArICAvKiBEaXNhYmxlIHNtYXJ0IHNjYW4gZm9yIGNvcnJlY3Qgdm9sYXRpbGUgY291
bnRzLiAqLwo+ID4gPiA+ICsgIFNBRkVfRklMRV9QUklOVEYoUEFUSF9LU00gInNtYXJ0X3NjYW4i
LCAiMCIpOwo+ID4gPiBOT1RFLCB0aGlzIGZhaWxzIG9uIHRoZSBzeXN0ZW1zIHdpdGhvdXQgL3N5
cy9rZXJuZWwvbW0va3NtL3NtYXJ0X3NjYW46Cj4KPiA+ID4gbWVtLmM6NDU4OiBUQlJPSzogRmFp
bGVkIHRvIG9wZW4gRklMRSAnL3N5cy9rZXJuZWwvbW0va3NtL3NtYXJ0X3NjYW4nCj4gZm9yCj4g
PiA+IHdyaXRpbmc6IEVBQ0NFUyAoMTMpCj4KPiA+ID4gTk9URSwgd2Ugbm9ybWFsbHkgaGFuZGxl
IHRoZSBzZXR1cCBsaWtlIHRoaXMgaW4gdGVzdCBzZXR1cCBmdW5jdGlvbi4KPgo+ID4gPiBCdXQg
bmV3IEFQSSBoYXMgLnNhdmVfcmVzdG9yZSB3aGljaCBpcyBtb3JlIHJvYnVzdCBmb3IgdGFza3Mg
IGxpa2UKPiB0aGlzLgo+ID4gPiBJdCdzIGFscmVhZHkgdXNlZCBpbiBrc20wMS5jLCB5b3UgbmVl
ZCBqdXN0IHRvIGFkZCB0aGlzIGxpbmU6Cj4gPiA+ICAgICAgICAgeyIvc3lzL2tlcm5lbC9tbS9r
c20vc21hcnRfc2NhbiIsICIwIiwgVFNUX1NSX1NLSVB9LAo+Cj4KPiA+IEkgZ3Vlc3Mgd2UgbmVl
ZCB0byBzZXQgJ1RTVF9TUl9TS0lQX01JU1NJTkcgfCBUU1RfU1JfVEJST0tfUk8nCj4gPiBhcyB0
aGUgbGFzdCBmaWVsZC4gQmVjYXVzZSBUU1RfU1JfU0tJUCB3aWxsIGNvbnRpbnVlIHRoZSB0ZXN0
IHdpdGhvdXQKPiA+IHdyaXRpbmcgJzAnIHRvIHRoZSBzbWFydF9zY2FuIGZpbGUsIHRoYXQncyBu
b3QgY29ycmVjdCBpZiB0aGUgZmlsZQo+IGV4aXN0cy4KPiA+IEl0IHdpbGwKPiA+IGlnbm9yZSBh
IGtlcm5lbCBidWcgKHNtYXJ0X3NjYW4gY2FuJ3QgYmUgd3JpdHRlbikgYnkgdGhhdCBjb25maWcu
Cj4KPiA+IFBlciB0aGUgRG9jIFBldHIgcG9pbnRlZCBiZWxvdzoKPiA+ICAgVFNUX1NSX1NLSVBf
TUlTU0lORyDigJMgQ29udGludWUgd2l0aG91dCBzYXZpbmcgdGhlIGZpbGUgaWYgaXQgZG9lcyBu
b3QKPiA+IGV4aXN0Cj4gPiAgIFRTVF9TUl9UQlJPS19STyDigJMgRW5kIHRlc3Qgd2l0aCBUQlJP
SyBpZiB0aGUgZmlsZSBpcyByZWFkLW9ubHkKPiA+ICAgVFNUX1NSX1NLSVBfUk8g4oCTIENvbnRp
bnVlIHdpdGhvdXQgc2F2aW5nIHRoZSBmaWxlIGlmIGl0IGlzIHJlYWQtb25seQo+ID4gICBUU1Rf
U1JfU0tJUCDigJMgRXF1aXZhbGVudCB0byAnVFNUX1NSX1NLSVBfTUlTU0lORyB8IFRTVF9TUl9T
S0lQX1JPJwo+Cj4KPgo+ID4gPiAoaW5zdGVhZCBvZiBib3RoIFNBRkVfRklMRV9QUklOVEYpCj4K
PiA+ID4gU2VlOgo+Cj4gPiA+Cj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVj
dC9sdHAvd2lraS9DLVRlc3QtQVBJIzEyNy1zYXZpbmctLXJlc3RvcmluZy1wcm9jc3lzLXZhbHVl
cwo+Cj4gPiA+IEkgd29uZGVyIGlmIGtzbTAxLmMgaXMgdGhlIG9ubHkga3NtIHRlc3Qgd2hpY2gg
bmVlZHMgdG8gZGlzYWJsZSB0aGlzLgo+Cj4KPiA+IEkgdGhpbmsgYWxsIG9mIHRoZSBrc20wKi5j
IHRlc3RzIHNob3VsZCBkaXNhYmxlIGl0IGJ5IHRoZSBjb25maWcuIFRoZQo+ID4gc21hcnRfc2Nh
bgo+ID4gd2lsbCBpbXBhY3QgYWxsIHRoZSB0ZXN0cyB3aXRoIGludm9rZSBrZXkgZnVuY3Rpb24g
Y3JlYXRlX3NhbWVfbWVtb3J5KCkuCj4KPiBrc20wNS5jIGFuZCBrc20wNi5jIGRvZXMgbm90IHVz
ZSBjcmVhdGVfc2FtZV9tZW1vcnkoKS4gT3IgZGlkIEkgb3Zlcmxvb2sKPiBzb21ldGhpbmc/Cj4K
Ckdvb2QgY2F0Y2gsIEkgbG9va2VkIGludG8gdGhlc2UgdGVzdHMsIHNlZW1zIG9ubHkga3NtMDUg
aXMgZGViYXRhYmxlCmZvciBkaXNhYmxpbmcgc21hcnRfc2NhbiwgYXMgYSBzaW1wbGUgcmVncmVz
c2lvbiwgaXQgc3VnZ2VzdHMgZGlzYWJsaW5nCmtzbSBkYWVtb24gdG8gYXZvaWQgZGlzdHVyYiBh
Y2NvcmRpbmcgdG8gc29tZSB3b3JrbG9hZC4KaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3Qt
cHJvamVjdC9sdHAvYmxvYi9tYXN0ZXIvdGVzdGNhc2VzL2tlcm5lbC9tZW0va3NtL2tzbTA1LmMj
TDMwCgprc20wNiBpcyBkZWZpbml0ZWx5IG5lZWQgZGlzYWJsZSBzbWFydF9zY2FuLCBpdCB0ZXN0
cyBLU00gaW4gZGlmZmVyZW50CidydW4nIHN0YXRlIGZvciBtZXJnZV9hY2Nyb3Nfbm9kZXMuCgpU
byBiZSBvbiB0aGUgc2FmZSBzaWRlLCBJIHdvdWxkIHN1Z2dlc3QgYXBwbHlpbmcgdGhlIHBhdGNo
IHRvIGFsbCBrc20qCnRlc3RzLAphbmQgd3JpdGUgYSBuZXcgc2luZ2xlIGZvciBzbWFydF9zY2Fu
IGlmIG5lZWRlZC4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
