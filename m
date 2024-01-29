Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D16C47422
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 11:37:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4A053CE187
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 12:37:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AE253CC96A
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 12:37:13 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 113F91401256
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 12:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706528231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kD5Nd8nSS2GmH00Tii0CCkRcbAnNLSUY7x8ebZL0WFg=;
 b=hGU1POfkjxLyZFNCVCx7sQ9OgMJiRBQ1U+fqL0qAimJI237ljPgRRBZ2MfpndMypcEBX4F
 q6eTN9aRd2Z31K/LNEczVbLS1qxBYJqPPVyQ7DSB3NK2MMCt1lWjVQvMVysidFKkMi1A/p
 n+WZaHhj480/0Crres16ppjdgPG4uJc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-fp0AFU_1NdqzjBtgJr0RDQ-1; Mon, 29 Jan 2024 06:37:09 -0500
X-MC-Unique: fp0AFU_1NdqzjBtgJr0RDQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-295078347ddso2377159a91.0
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 03:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706528227; x=1707133027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kD5Nd8nSS2GmH00Tii0CCkRcbAnNLSUY7x8ebZL0WFg=;
 b=a2QuDDrzOsmpGNaZsvZPnE9H3eGj7cjXPM+q03BwGrvvOenB05uu1S2Y/2VvjLgvxB
 qigo2UFayQ8CLZrI9WzK3vqBEQBnzUNCKrAauOaA9cXZvAFlKLhNUjj6J7P+ocaH4jRq
 1NveKMtRem6f9I1A7T/pi8ipsJwG2xvcX7GtPG6qbxhMO4iatEJHew/ZlSN+8meLcrfk
 7sSPIjzSSWH1duLUU1whOJ3FOeZGaaGHNCP+B8eqcxxhTkvyrpbzZi0RQrs9Vth3KnHh
 b86Uaja+PT+lLbb/cLpo3rscQfwkHtXV5BB+JJz/DHTz/i8tnV/3AX2idWRl70+nKonj
 8tRw==
X-Gm-Message-State: AOJu0YyjicysNEe/tNtE2q6Yq55+Z/u0tSB5OzBol70yYkSXbwboIVJk
 M14y2xR37udttOWIzDtY11G5qFIu3eeGsZuDKO6jpK+sC/85dusyzsoU7Z3oLI67bREY3+SNjM9
 Sa9ZjOPp2uClES6inQcsuyfIWpmxp44nKMtKuL02DJctqmgjS7sLkJQfjxHFkZp8+mD324/xoBN
 AOosiGmARvKxv9j91CBMQ1nFHXejECjT63J0Hn
X-Received: by 2002:a17:90a:9313:b0:290:16e6:deeb with SMTP id
 p19-20020a17090a931300b0029016e6deebmr3103391pjo.47.1706528227464; 
 Mon, 29 Jan 2024 03:37:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBqo5v8HrkQjJbCciaqEyNS6bgrPvM3UP7YB2+Siw/0LjPohDmrW0kWmUFPESuoUq0v9Fd80BAIDmrS5ddDjQ=
X-Received: by 2002:a17:90a:9313:b0:290:16e6:deeb with SMTP id
 p19-20020a17090a931300b0029016e6deebmr3103381pjo.47.1706528227215; Mon, 29
 Jan 2024 03:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20240128024838.2699248-1-liwang@redhat.com>
 <20240128024838.2699248-9-liwang@redhat.com>
 <20240129080314.GA581064@pevik>
In-Reply-To: <20240129080314.GA581064@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Jan 2024 19:36:54 +0800
Message-ID: <CAEemH2drVzga9NqWN4i5jZ76n5Q6Np-Cra61mGbnOttRbgbYnQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 8/8] libswap: Refactor is_swap_supported
 function to return status
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

SGkgUGV0ciwKCk9uIE1vbiwgSmFuIDI5LCAyMDI0IGF0IDQ6MDPigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gVGhpcyB1cGRhdGVzIHRoZSBpc19zd2FwX3N1cHBv
cnRlZCBmdW5jdGlvbiBpbiB0aGUgbGlibHRwc3dhcAo+ID4gdG8gcmV0dXJuIGFuIGludGVnZXIg
c3RhdHVzIGluc3RlYWQgb2Ygdm9pZCwgYWxsb3dpbmcgdGhlIGZ1bmN0aW9uCj4gPiB0byBjb21t
dW5pY2F0ZSBzdWNjZXNzIG9yIGZhaWx1cmUgdG8gdGhlIGNhbGxlci4gSXQgaW50cm9kdWNlcwo+
ID4gY2hlY2tzIGFuZCByZXR1cm5zIDAgb24gdmFyaW91cyBmYWlsdXJlIGNvbmRpdGlvbnMgd2hp
bGUgbG9nZ2luZwo+ID4gdGhlIGZhaWx1cmUgd2l0aG91dCBhYm9ydGluZyB0aGUgdGVzdCBjYXNl
Lgo+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+IC0t
LQo+ID4gIGluY2x1ZGUvbGlic3dhcC5oICAgICAgICAgfCAgMiArLQo+ID4gIGxpYnMvbGlibHRw
c3dhcC9saWJzd2FwLmMgfCAyOCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPgo+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGlic3dhcC5oIGIvaW5jbHVkZS9saWJzd2FwLmgKPiA+IGluZGV4
IGU2N2Q2NTc1Ni4uMWUwOWRiMDMxIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saWJzd2FwLmgK
PiA+ICsrKyBiL2luY2x1ZGUvbGlic3dhcC5oCj4gPiBAQCAtMjAsNSArMjAsNSBAQCBpbnQgbWFr
ZV9zd2FwZmlsZShjb25zdCBjaGFyICpzd2FwZmlsZSwgaW50IGJsb2NrcywKPiBpbnQgc2FmZSk7
Cj4gPiAgICogQ2hlY2sgc3dhcG9uL3N3YXBvZmYgc3VwcG9ydCBzdGF0dXMgb2YgZmlsZXN5c3Rl
bXMgb3IgZmlsZXMKPiA+ICAgKiB3ZSBhcmUgdGVzdGluZyBvbi4KPiA+ICAgKi8KPiBSZXZpZXdl
ZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KPiBUaGFua3MgZm9yIGZ1cnRoZXIg
aW1wcm92aW5nIGl0LiBGZXcgY29tbWVudHMgdG8gZml4IG9sZCBpc3N1ZXMsIHdoZW4gd2UKPiBh
cmUgYXQKPiBpdCAoYW5kIHBsYW4gdG8gbWVyZ2UgYWZ0ZXIgdGhlIHJlbGVhc2UpLiBCdXQgZmVl
bCBmcmVlIHRvIGlnbm9yZS4KPgo+IEJUVyBkbyB5b3UgcGxhbiB0byB1c2UgaXQgc29tZXdoZXJl
Pwo+Cj4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb2ZmL3N3YXBvZmYwMS5jCj4KPiBu
aXQ6IEkgd291bGQgY29tbWVudCBoZXJlIHRoZSByZXR1cm4gY29kZS4KPiBBbHNvIG1heWJlIHVz
ZSBib29sIChmcm9tIHN0ZGJvb2wuaCk/IFRoZSBhZHZhbnRhZ2UgaXMgdGhhdCB3ZSBkb24ndCB0
aGluawo+IHdoYXQKPiB0aGUgcmV0dXJuIGNvZGUgaXMgKHNvbWV0aW1lcyB3ZSB1c2Ugc3lzY2Fs
bHMgYXBwcm9hY2ggd2hlbiAwIGlzIHN1Y2Nlc3MsCj4gb3RoZXJ3aXNlIC0gbGlrZSBoZXJlIC0g
MCBpcyBmYWlsdXJlKS4gU2xvd2x5IGNvbnZlcnRpbmcgdG8gYm9vbCB3b3VsZCBiZQo+IHRoZQo+
IGJlc3QuCj4KCkdvb2QgcG9pbnQsIGFjdHVhbGx5IEkgYW0gdGlyZWQgb2YgZmlndXJpbmcgb3V0
IHRoZSByZXR1cm4gMCBtZWFucyAnRkFJTCcgb3IKJ1NVQ0NFU1MnIGluIHRoZSBsaWIsIGl0IG1l
c3NlcyBhIGxvdCBpbiBzb21lIGZ1bmN0aW9ucy4gQW5kIGFzIHlvdSBzdWdnZXN0LApib29sIHZh
bHVlIHNob3VsZCBiZSBhIGdvb2Qgd2F5IHRvIHJlc29sdmUgdGhpcy4KCkJ1dCB0aGUgYm9vbCB0
eXBlIGlzIG5vdCBidWlsdCBpbnRvIHRoZSBsYW5ndWFnZSBwcmlvciB0byB0aGUgQzk5IHN0YW5k
YXJkLgpUaGUgQzk5IHN0YW5kYXJkIGludHJvZHVjZWQgYSBfQm9vbCB0eXBlIGFuZCB0aGUgaGVh
ZGVyIDxzdGRib29sLmg+LAp3aGljaCBkZWZpbmVzIGJvb2wgYXMgYSBtYWNybyBmb3IgX0Jvb2wu
CgpJIGFtIG5vdCBzdXJlIGlmIExUUCBub3dhZGF5cyBvbmx5IHN1cHBvcnRzIEM5OSBhbmQgbGF0
ZXIuCm9yIHNob3VsZCB3ZSBtYWtlIHVzZSBvZiBib29sIHNhZmVseSAob3IgdXNlIHN5c2NhbGxz
IGFwcHJvYWNoCjAgPT0gc3VjY2VzcykgaW4gb3VyIHBhdGNoPwoKQEN5cmlsIEhydWJpcyA8Y2hy
dWJpc0BzdXNlLmN6PiB3aGF0IGRvIHlvdSB0aGluaz8KCgoKCj4gPiBAQCAtMTY4LDcgKzE2OCw3
IEBAIGludCBtYWtlX3N3YXBmaWxlKGNvbnN0IGNoYXIgKnN3YXBmaWxlLCBpbnQgYmxvY2tzLAo+
IGludCBzYWZlKQo+ID4gICAqIENoZWNrIHN3YXBvbi9zd2Fwb2ZmIHN1cHBvcnQgc3RhdHVzIG9m
IGZpbGVzeXN0ZW1zIG9yIGZpbGVzCj4gPiAgICogd2UgYXJlIHRlc3Rpbmcgb24uCj4gPiAgICov
Cj4gbml0OiBBbHRob3VnaCBJIGRpZCBub3QgbGlrZSBkb2MgYmVpbmcganVzdCBhdCB0aGUgaGVh
ZGVyLCBJIG5vdyBwcmVmZXIgaXQKPiBub3cKPiB0byBoYXZlIGl0IGp1c3QgYXQgdGhlIGhlYWRl
ciBiZWNhdXNlIHdlIGRvbid0IGhhdmUgdG8gc3luYyB0aGUgc2FtZSB0ZXh0Cj4gb24gdHdvCj4g
cGxhY2VzLgo+CgpBZ3JlZS4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
