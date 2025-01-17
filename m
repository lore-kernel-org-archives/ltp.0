Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FCEC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:26:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA42C3C7C24
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:26:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD4BB3C2EE4
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:26:36 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 104931032C28
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737105994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0TCN2P+kUEGAOegPT/kVK/SLYYuCjBmrwOpItACvDk=;
 b=Ylz5Oda7aRH7cJA4ez6pAhz3JEaGuDucWjHuNsgQixhFGv2JcWiwZCHjRp+gEkbz9Zfg4N
 v2JMJ/VTxWJEnZM/6eAuLWEhUMjANzZZ55OTCwc3Iq6V/o8NMqCR4v8HO/L1f/SpYIX34z
 9H8AzRLHWY2IKTWbQwvzJ0YYhjUsFRA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-imqrcM_MMF2Y5hJlKJxoCw-1; Fri, 17 Jan 2025 04:26:32 -0500
X-MC-Unique: imqrcM_MMF2Y5hJlKJxoCw-1
X-Mimecast-MFC-AGG-ID: imqrcM_MMF2Y5hJlKJxoCw
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2f2a9f056a8so3827896a91.2
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 01:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737105991; x=1737710791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g0TCN2P+kUEGAOegPT/kVK/SLYYuCjBmrwOpItACvDk=;
 b=o28txqfhPoOzDwp18/miij9yBsA925kY1H/edqlAfJ2R3dZXQD8MKjAIkUxozodSby
 AD0+3iKUrdV+4ITZrYQDJ8u0d//hqE/uSmwi26qlOqabKS/LVWuwA4/yXnmCXml8jXoW
 qQGV17Xu1wJPEOtXGlUA+9ge9t5vssxsPi40BRGzjFtEUBtRND7V6MS28wMJKjeNfeO4
 +LBlu5MllqHrkJa1HOix5DivVYp1CCEK52eS0Sa3OqnZOazdQOJTvhiu9Q5m2Jh+8Ury
 2tGbxJD8pMNvrP59gYdKohfCna2me5X+vw99LNuaukN0LoAeQ78GPHvaLm5cfmldGZT1
 GzJQ==
X-Gm-Message-State: AOJu0YxfpS3W1MMj0ljKj4mXUCX6/i+XT+6VhrQ3OpL2YGz5x0rhNYtO
 6LaeTVFxo5w/iG/tSFmtmyDBH30By7MfxMMMnCTdnVCUPa0+SqpTvDNy8y7OO0sRbRmu7DwWrLc
 MYie3fqvrhIshNnTcy6sRnstQLjjDQLBcqCbujwUjWve0+7out7JUnenPqb4CpVwc3cj6CkWb+Y
 hUe9dlF7l5mRiGTpNs7AOhUt4=
X-Gm-Gg: ASbGncucC8hjjkQj6FrDyQilrHQF2jPxIquiBIeOQLcRF1qn5w90mNeQmTjI2P5O7fb
 xR6ODWVBXLG0t9AXReoRdrqr/M4MCaoFxsludpTY=
X-Received: by 2002:a17:90b:568e:b0:2ee:e18b:c1fa with SMTP id
 98e67ed59e1d1-2f782d2ec7cmr2665544a91.28.1737105991141; 
 Fri, 17 Jan 2025 01:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtN+mS4jk2EHwjYRzUSKdRoeFAz/ykt9SYtYraYFhiXDsnwkirzxVyy8031L3okRb4i1rNs7ZXaDXsDxkecks=
X-Received: by 2002:a17:90b:568e:b0:2ee:e18b:c1fa with SMTP id
 98e67ed59e1d1-2f782d2ec7cmr2665528a91.28.1737105990845; Fri, 17 Jan 2025
 01:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20250117084118.740225-1-pvorel@suse.cz>
 <CAEemH2c82HAwMdWJ7a5WPLzHTJWA-dhunXuJQdt4WK4zWdpPYg@mail.gmail.com>
 <20250117091603.GA742253@pevik>
In-Reply-To: <20250117091603.GA742253@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jan 2025 17:26:17 +0800
X-Gm-Features: AbW1kvbTGECXXkOcBwaisq4Qovd0fqbhrhUv5p1BNNONjyx2792qvV2ipY-sUNM
Message-ID: <CAEemH2fKfuXhBMaYA6W9=f1ML0m81qfBjxPGQRMSswGKFeMxyQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JRlzm19tPZzWWGWLluT00wjgi3U7Cs0bSeguqzuR7PE_1737105991
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real
 tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKYW4gMTcsIDIwMjUgYXQgNToxNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBPbiBGcmksIEphbiAxNywgMjAyNSBhdCA0OjQx4oCvUE0gUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gVEw7RFI6IHdyb25nIHBhdGNoLCBwbGVh
c2UgaWdub3JlIGl0Lgo+Cj4gLi4uCj4gPiA+ICtzdGF0aWMgaW5saW5lIGludCBmb28odW5zaWdu
ZWQgaW50IHRpbWVvdXQpCj4KPgo+ID4gV2hhdCBpcyB0aGUgZm9vKCkgdXNlZCBmb3I/Cj4KPiBJ
J20gc29ycnksIEkgbm90aWNlZCB0aGlzIGFmdGVyIHNlbmRpbmcgYXMgd2VsbC4gQnV0IGdvdCBz
bG93IGRvd24gZHVlCj4gVFNUX05PX0RFRkFVTFRfTUFJTiBpbiB0c3RfdGVzdC5jIGFzIHdlbGwu
Cj4KPiA+ID4gK3N0YXRpYyBpbmxpbmUgaW50IHRzdF9tdWx0aXBseV9vbl9zbG93X2NvbmZpZyh1
bnNpZ25lZCBpbnQgdGltZW91dCkKPiA+ID4gK3sKPiA+ID4gKyNpZm5kZWYgVFNUX05PX0RFRkFV
TFRfTUFJTgo+ID4gPiArICAgICAgIGlmICh0c3RfaGFzX3Nsb3dfa2NvbmZpZygpKQo+ID4gPiAr
ICAgICAgICAgICAgICAgdGltZW91dCAqPSA0Owo+ID4gPiArI2VuZGlmIC8qIFRTVF9OT19ERUZB
VUxUX01BSU4gKi8KPiA+ID4gKyAgICAgICByZXR1cm4gdGltZW91dDsKPiA+ID4gK30KPgo+Cj4g
PiBCdXQgdGhlIHRzdF90ZXN0LmMgaGFzIGRlZmluZWQgdGhlIFRTVF9OT19ERUZBVUxUX01BSU4g
bWFjcm8KPiA+IHNvIGl0IHdpbGwgZ28gY29tcGxpZSB3aXRoIHRoZSBzZWNvbmQgYnJhbmNoIGFs
d2F5cy4KPgo+ID4gSU9XLCB0aGUgdHN0X2hhc19zbG93X2tjb25maWcoKSB3aWxsIG5ldmVyIGJl
IHBlcmZvcm1lZC4KPgo+IFllcywgeW91J3JlIHJpZ2h0IHRoaXMgd291bGQgbm90IHdvcmsgKGl0
IHRvb2sgbWUgYSB3aGlsZSB0byBmaW5kIGl0IGFzCj4gd2VsbCkuCj4KPiBJIGhvcGVkIHdlIHdv
dWxkIGhhdmUgc29tZSBzbWFydCBldmFsdWF0aW9uIHdoaWNoIHdvdWxkIGFsbG93IG5vdCBoYXZp
bmcKPiB0byBhZGQKPiBhbnl0aGluZyB0byBmaWxlcyBpbiB0ZXN0Y2FzZXMvbGliLywgYnV0IHRo
aXMgd2lsbCBub3Qgd29yay4KPgo+IFdlIGNhbiBlaXRoZXIgY29tYmluZSB5b3VyIGFwcHJvYWNo
IHdpdGggdGhpcyAoaGF2ZSBhIG5ldyBkZWZpbml0aW9uICsKPiBzdGF0aWMKPgoKVGhhdCB3b24n
dCB3b3JrcyBhcyB3ZWxsLCBkZWZpbmUgYSBuZXcgbWFjcm8gbGlrZSBUU1RfSUdOT1JFX1NMT1df
S0NPTkZJRwppbiB0ZXN0Y2FzZS9saWIvKiBpcyB1c2VsZXNzLiBCZWNhdXNlIHRoZSBsaWJsdHAu
YSBpcyBpbmRlcGVuZGVudCBvZiBvdGhlcgp0aGluZ3MgdW5kZXIKdGVzdGNhc2UvIGRpci4gSXQg
aGFzIGJlZW4gZGVjaWRlZCB3aGVuIHdlIGxpbmsgdGhlIGxpYmx0cC5hLgoKU28gZXZlbnR1YWxs
eSB3ZSBoYXZlIHRvIGdvIHRoZSB3YXkgQW5kcmVhIHN1Z2dlc3RzLgoKCgo+IGZ1bmN0aW9uIGlu
IHRzdF90ZXN0LmgpIG9yIHVzZSBzdHJ1Y3QgdHN0X3Rlc3QgZmxhZyBhcyBBbmRyZWEgc3VnZ2Vz
dGVkLgo+IEknbSBub3QKPiBzdXJlIHdoYXQgaXMgYmV0dGVyLCBJIHNsaWdodGx5IHByZWZlcnJl
ZCB0aGUgZGVmaW5pdGlvbiwgYmVjYXVzZSBvbmUgZGF5Cj4gd2UKPiBtaWdodCB3YW50IHRvIGdl
dCByaWQgb2Ygc3RydWN0IHRzdF90ZXN0IHdvcmthcm91bmRzIGluIHRlc3RjYXNlcy9saWIKPiB0
aGVyZWZvcmUKPiBJIHdvdWxkIHByZWZlciBub3QgdG8gYWRkIHlldCBhbm90aGVyLgo+Cj4gRllJ
IHRzdF90ZXN0IHN0cnVjdCB1c2UgaXMgZm9yY2VkIGJ5IGNvZGUgaW4gc2FmZV9jbG9uZSgpIGxp
Yi90c3RfdGVzdC5jOgo+Cj4gcGlkX3Qgc2FmZV9jbG9uZShjb25zdCBjaGFyICpmaWxlLCBjb25z
dCBpbnQgbGluZW5vLAo+ICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHRzdF9jbG9uZV9h
cmdzICphcmdzKQo+IHsKPiAgICAgICAgIHBpZF90IHBpZDsKPgo+ICAgICAgICAgaWYgKCF0c3Rf
dGVzdC0+Zm9ya3NfY2hpbGQpCj4gICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJ0ZXN0
LmZvcmtzX2NoaWxkIG11c3QgYmUgc2V0ISIpOwo+Cj4gVGhpcyBjb3VsZCBiZSBhbHNvIGd1YXJk
ZWQgYnkgbmV3IGRlZmluaXRpb24uIFRoZW4gaXQgc2hvdWxkIGhhdmUgcHJvYmFibHkKPiBhCj4g
ZGlmZmVyZW50IG5hbWUgdGhhbiBUU1RfTk9fU0xPV19LQ09ORklHX0NIRUNLLiBTdXJlLCB3ZSBw
b3N0cG9uZSB0aGlzCj4gY2xlYW51cAo+IGFmdGVyIHRoZSByZWxlYXNlLgo+Cj4gQlRXIHdlIGhh
dmUgVENPTkYgb24gc3RhcnZhdGlvbi5jLiBUaGlzIHRlc3Qgd291bGQgd29yayBpZiB3ZSBkb24n
dAo+IHByb2xvbmcgaXQKPiBldmVuIGxvbmdlciB3aXRoIHRzdF9oYXNfc2xvd19rY29uZmlnKCks
IHRodXMgbWlnaHQgd2FudCB0byByZW1vdmUgVENPTkYKPiBhbmQKPiBkaXNhYmxlIHRzdF9oYXNf
c2xvd19rY29uZmlnKCkgdGhlcmUgYXMgd2VsbC4gV2UgY2FuIGRvIGl0IHdpdGggYm90aCB3YXlz
Lgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
