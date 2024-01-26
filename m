Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE39C47DDB
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 07:38:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A56683CE1A9
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 08:38:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BB373CD443
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 08:38:28 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A15426023E4
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 08:38:27 +0100 (CET)
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-42a6d091a67so9762061cf.0
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 23:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706254706; x=1706859506; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DccnCr3lD8maV2Gd++Hl0nakiG73vP9XpaOgMARE+HY=;
 b=eNc3UB6AVrHCl4VkJBArZkQXgMuDNWvAK1REIU7uIavCc0n0mqioUZ6yNVtnBiBI/A
 MLgQshrUbXAqvR8y68rAMLtRtO0nj7crKEkwzzYl5GPBE6X8pSG+EWXNIanCCWSBVUG1
 wwTfzP4TkL2OP6cb4H50UD6LsPxtb/MBP5h86fNGdsBZu9EO82ykpeAwEcbkOpDI0ez1
 fRhuZxnGhgt+EAQhOQ3npm91AGCnBQHv7xqzgMlj8RNK4tzAlxGXuF06IwsFog+pj8sA
 AQuwKPBcpdW/427nzjK8Joj8Lvf2/NPiyA1AVJWSN5Gd70ij2Lv106UH7blc5sRcGvSV
 91uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706254706; x=1706859506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DccnCr3lD8maV2Gd++Hl0nakiG73vP9XpaOgMARE+HY=;
 b=G4N1yUCRdlD5a9Ov98XPXJ/TUNn3ZYr4irER2EBUhp6yQd+713X7Y5wvec+G2Ws+XQ
 883YKYVie5eeO/KnmlYtHoPEfGPw2o731OIGZQiOHEe2lc/DrBCyEMLi8QWrhojdL5qu
 LRXxMYe9tmSNva6qpOAl8DKHn0O+puPu2z9/8u5BgioQOqOkHXnEvmKfpqxbQTX0l3Us
 p5NN7W38BBOm5S7ZCJseJ63Rw1+RkEIEMDcGtRj/HBqLuUx7GVysGpgZjjUECKdn0sKZ
 A13OERO40YyuMrXV4recfyEaf59wynpkxWWGPJBwgF7P4rU9A+gOKBUXrzinjavFb43Q
 jzvg==
X-Gm-Message-State: AOJu0Yz6BrhxW0Bzy5jXDbP+5hIwWIIBHQY9UV328OmJvOewua05BvSn
 h8TcGoQKuqGrgnqryAsp7IgzsSifulruRXN0NkYkYBm1+WvOk/EbszIY+3NdvkPXiHUDwQ6TcNI
 kXOQGKC3MvHnxSZofti3EPIrgi0I=
X-Google-Smtp-Source: AGHT+IGPt4wOLFfrml0NrmQMDVNeKPfGKKnv8tiVKObCJZt/wWie7CLeuRMkumC9W8iYm9A6TvTjX6NDjvfq2N50X+Q=
X-Received: by 2002:a05:6214:29e6:b0:681:7231:de7d with SMTP id
 jv6-20020a05621429e600b006817231de7dmr766812qvb.42.1706254706237; Thu, 25 Jan
 2024 23:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20240125110510.751445-1-amir73il@gmail.com>
 <20240125122337.GA398849@pevik>
 <CAOQ4uxjMiPG5E5=jirxT_D=NDxdUfA2Vp8u1yNZ=YH_SxC0S8Q@mail.gmail.com>
 <20240125144453.GB398849@pevik>
In-Reply-To: <20240125144453.GB398849@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jan 2024 09:38:14 +0200
Message-ID: <CAOQ4uxh8D+vW5n+A1gFeF+pKEHDPcUoMVZ3B1hJRN5-1JkMS2Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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

T24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgNDo0NOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+ID4gT24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgMjoyM+KAr1BNIFBldHIg
Vm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ID4gPiA+IFdoZW4gdGVzdGVkIGZzIGhh
cyB6ZXJvIGZzaWQgKGUuZy4gZnVzZSkgYW5kIGV2ZW50cyBhcmUgcmVwb3J0ZWQKPiA+ID4gPiB3
aXRoIGZzaWQrZmlkLCB3YXRjaGluZyBkaWZmZXJlbnQgZmlsZXN5c3RlbXMgd2l0aCB0aGUgc2Ft
ZSBncm91cCBpcwo+ID4gPiA+IG5vdCBzdXBwb3J0ZWQuCj4KPiA+ID4gPiBUcnkgdG8gc2V0dXAg
YSBib2d1cyBtYXJrIG9uIHRlc3QgdG1wIGRpciwgaW4gYWRkaXRpb24gdG8gdGhlIG1hcmsKPiA+
ID4gPiBvbiB0aGUgdGVzdGVkIGZpbGVzeXN0ZW0sIHRvIGNoZWNrIGlmIG1hcmtzIG9uIGRpZmZl
cmVudCBmaWxlc3lzdGVtcwo+ID4gPiA+IGFyZSBzdXBwb3J0ZWQuCj4KPiA+ID4gPiBSdW4gb24g
YWxsIGZpbGVzeXN0ZW0gdG8gdGVzdCBib3RoIGZzIHdpdGggemVybyBmc2lkIChlLmcuIGZ1c2Up
IGFuZAo+ID4gPiA+IGZzIHdpdGggdmFsaWQgZnNpZC4KPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gPiA+ID4gLS0tCj4KPiA+ID4g
SGkgQW1pciwKPgo+ID4gPiA+IFBldHIsCj4KPiA+ID4gPiBUaGUgZmFub3RpZnkgdGVzdHMgY2hh
bmdlcyB0aGF0IHlvdSBhbHJlYWR5IHBpY2tlZCBmcm9tIG15IGdpdGh1YiBbMV0KPiA+ID4gPiBo
YXZlIHRvIGRvIHdpdGggZml4aW5nIG5ldyB0ZXN0IGZhaWx1cmVzIGluIHY2LjcgYW5kIHY2Ljgt
cmMxLCBkdWVzIHRvCj4gPiA+ID4gdGhlIGZhY3QgdGhhdCBlYWNoIG9mIHRob3NlIGtlcm5lbCB2
ZXJzaW9ucyBhZGRlZCBuZXcgZmlsZXN5c3RlbXMgdGhhdAo+ID4gPiA+IHN1cHBvcnQgZmFub3Rp
ZnkgZXZlbnRzIHdpdGggZmlkK2ZzaWQuCj4KPiA+ID4gPiBUaGlzIGlzIHRoZSBvbmx5IGNoYW5n
ZSB0byB0ZXN0IG5ldyBmdW5jdGlvbmFsaXR5IGluIHY2LjgtcmMxLCBuYW1lbHksCj4gPiA+ID4g
dGhhdCBmb3IgZnMgd2l0aCB6ZXJvIGZzaWQgKGUuZy4gZnVzZSksIGFuIGZhbm90aWZ5IGdyb3Vw
IGNhbiB3YXRjaCBhCj4gPiA+ID4gc2luZ2xlIGZzIGluc3RhbmNlLgo+Cj4gPiA+IFRoaXMgcGF0
Y2ggd291bGQgaGF2ZSB0byBiZSByZWJhc2VkLCB0byBiZSBhcHBsaWNhYmxlIG9mIHRoZSBwcmV2
aW91cyBvbmUgKHdoaWNoCj4gPiA+IHRvdWNoZXMgbW9yZSB0ZXN0cykgaW4geW91ciBicmFuY2gu
Cj4KPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCAtIHRoaXMgcGF0Y2ggaXMgYWxyZWFkeSByZWJhc2Vk
Lgo+IEkgbWVhbnQsIHlvdSBzZW50IGp1c3QgdGhpcyAybmQgY29tbWl0LCB3aXRob3V0IDFzdCBj
b21taXQKPiBmODBkYzUxMmUgKCJmYW5vdGlmeXswMSwwOSwxMH06IENoZWNrIGZvciByZXBvcnQg
ZmlkIHN1cHBvcnQgd2l0aCBtb3VudCBtYXJrIikKPiBUaGVyZWZvcmUgdGhpcyBjb21taXQgaXMg
bm90IGFwcGxpY2FibGUuIEkgZ290IGp1c3QgY29uZnVzZWQgeW91IHNlbmQgb25seQo+IHRoaXMg
Y29tbWl0IHdpdGggd2l0aG91dCB0aGUgcHJldmlvdXMgb25lLi4uCj4KPiA+IEkgaGF2ZSBpdCBp
biBteSBicmFuY2ggYWZ0ZXIgdGhlIGZpeCBwYXRjaGVzOgo+Cj4gPiA3ZGIyZGFjOWYgKEhFQUQg
LT4gZmFub3RpZnlfZnNpZCkgZmFub3RpZnkwMTogVGVzdCBzZXR0aW5nIHR3byBtYXJrcwo+ID4g
b24gZGlmZmVyZW50IGZpbGVzeXN0ZW1zCj4gPiBmODBkYzUxMmUgZmFub3RpZnl7MDEsMDksMTB9
OiBDaGVjayBmb3IgcmVwb3J0IGZpZCBzdXBwb3J0IHdpdGggbW91bnQgbWFyawo+ID4gOTA2Mjgy
NGE3IChtYXN0ZXIpIGZhbm90aWZ5MTY6IEZpeCB0ZXN0IGZhaWx1cmUgb24gRlVTRQo+ID4gZWEw
ODU3MTNmIGZhbm90aWZ5ezE0LDE1LDE2fTogQ2hlY2sgZm9yIGZpbGVzeXN0ZW0gbWFyayBzdXBw
b3J0IG9uIGZpbGVzeXN0ZW0KPiA+IDkyMWYwY2U4NiBmYW5vdGlmeTEzOiBVc2UgZ2VuZXJpYyBj
aGVjayBmb3IgbWFyayB0eXBlIHN1cHBvcnQgb24gZmlsZXN5c3RlbQo+Cj4KPiA+ID4gSSBhbHNv
IHdvbmRlciB3aGF0IEkgZGlkIHdyb25nLCB0aGUgYnJhbmNoIHdvcmtzIGFmdGVyIHJlYm9vdCwg
dGVzdGVkIG9uOgo+ID4gPiAxKSBtYWlubGluZSBrZXJuZWwgNi44LjAtcmMxIGluIHJhcGlkby1s
aW51eAo+ID4gPiAyKSBvcGVuU1VTRSBrZXJuZWwgNi44LjAtcmMxLTIuZ2Y0YmE1ZGItZGVmYXVs
dAo+ID4gPiAzKSA2LjcuMC05LmdhZWRkYTgwLWRlZmF1bHQKPgo+Cj4gPiBXaGljaCBicmFuY2gg
d29ya3M/IExUUCBtYXN0ZXIgYnJhbmNoPwo+Cj4gSSBtZWFudCBIRUFEIG9mIHlvdXIgZmFub3Rp
ZnlfZnNpZCBicmFuY2guCj4KPiA+IE15IGNsYWltIGlzIHRoYXQgd2l0aCB0aGUgY3VycmVudCBM
VFAgbWFzdGVyIGJyYW5jaCwgZmFub3RpZnkwMSwwOSwxMAo+ID4gd291bGQgZmFpbCBvbiBrZXJu
ZWwgNi44LjAtcmMxIHdoZW4gcnVubmluZyB3aXRoCj4gPiBMVFBfREVWX0ZTX1RZUEU9ZXhmYXQg
KG5vdCBMVFBfU0lOR0xFX0ZTX1RZUEU9ZXhmYXQpCj4KPiBJJ20gc29ycnksIEkgb3Zlcmxvb2tl
ZCB0aGUgZGlmZmVyZW50IHZhcmlhYmxlLgo+IEkgc2VlIExUUF9ERVZfRlNfVFlQRT1leGZhdCBn
ZXRzIEVPUE5PVFNVUFAgb24gTFRQIG1hc3RlciBvbiA2LjguMC1yYzE6Cj4gZmFub3RpZnkwMS5j
OjEwNjogVEJST0s6IGZhbm90aWZ5X21hcmsoMywgMHgxMSwgMHgzYiwgLi4uLCBmc19tbnQvdGZp
bGVfNDUwMykgZmFpbGVkOiBFT1BOT1RTVVBQICg5NSkKPgo+ID4gU28gYXQgbGVhc3QgeW91IHNo
b3VsZCBjb25zaWRlciBhcHBseWluZyB0aGlzIGZpeCBmb3IgdGhlIHJlbGVhc2U6Cj4gPiBmODBk
YzUxMmUgZmFub3RpZnl7MDEsMDksMTB9OiBDaGVjayBmb3IgcmVwb3J0IGZpZCBzdXBwb3J0IHdp
dGggbW91bnQgbWFyawo+Cj4gSSBzZWUuIFllcywgSSByZXByb2R1Y2VkIHRoZSBwcm9ibGVtIGFu
ZCB0aHVzIGNoZXJyeS1waWNrZWQgYW5kIG1lcmdlZCB0aGlzIG9uZQo+IGFzIGJhZThlYzlhMy4K
Pgo+IEFsdGhvdWdoIHRoaXMgcGF0Y2ggKHRoZSAybmQgY29tbWl0KSBzaG91bGQgYWxzbyB3b3Jr
IGV2ZXJ5d2hlcmUsIEknbGwgYmFja3BvcnQKPiBpdCBqdXN0IGFmdGVyIHRoZSByZWxlYXNlLgoK
U291bmRzIGdvb2QuCkJldHRlciBhbHNvIHdhaXQgZm9yIEFDSyBmcm9tIEphbiBvbiB0aGlzIG5l
dyB0ZXN0LgoKPgo+IFRoYW5rcyBhIGxvdCBmb3IgZXhwbGFuYXRpb24gYW5kIHNvcnJ5IGZvciB0
aGUgY29uZnVzaW9uLgo+CgpObyB3b3JyaWVzLgoKVGhlIGNoYW5nZSBvZiBiZWhhdmlvciB0aGF0
IG1hbnkgZnMgc3RhcnRlZCBzdXBwb3J0aW5nIGZhbm90aWZ5CndpdGggZmlkIGV2ZW50cyB3YXMg
YSBiaXQgY2hhbGxlbmdpbmcgZm9yIHRob3NlIHRlc3RzLgoKU29ycnkgZm9yIG5vdCBmb3Jlc2Vl
aW5nIHRoaXMgb3V0Y29tZS4gR2xhZCBpdCBhbGwgd29ya2VkIG91dC4KClRoYW5rcywKQW1pci4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
