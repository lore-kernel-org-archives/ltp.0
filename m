Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0AFC48297
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 02:21:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DE903CE54D
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 03:21:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D76B73C9EE1
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 03:21:35 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EFA3510185B8
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 03:21:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707272493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8oXHp7qJiEINbkUJ1pFsljXM2kBlHczpE0qvN+XCuo=;
 b=P7nfbCIii8dQ9G3jWDiDdjZ9aEgGQD4mVdC/Z+HAqyji7wTbEcofgcLyh8pIzndF7rPsVF
 cJfz5wT53insFOi97D+oVy5Cb42jVrwF/528B6Wkr216ZYizBuQwVgKWNMMVkrEsaqvNOi
 47en8/kOGzdEN6V0EGCVdaB1nkhGiRg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-bDAzebwPOoeHTtKSNqJRKA-1; Tue, 06 Feb 2024 21:21:29 -0500
X-MC-Unique: bDAzebwPOoeHTtKSNqJRKA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2969941edb5so153831a91.0
 for <ltp@lists.linux.it>; Tue, 06 Feb 2024 18:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707272488; x=1707877288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h8oXHp7qJiEINbkUJ1pFsljXM2kBlHczpE0qvN+XCuo=;
 b=E3t6YnL+l5dbK+GUpYXYJRcpPZblWO1oVQFMIQagIGhEIeoH3FtBkfP1872kYrsukV
 PiKM5hifinS0ufz4jmt7zvjZtvm48Qamxry1ORxaT5D1mW80KtSqQGzzCCFvI3UIv0mP
 /8E5UAJ1BR0ihCxc27C08vKoJ+hYOWCzkjqtmAbr68YQpyOg9uSbBi6yYyXaHKfMDORL
 qniWU2QzAcOJRrmaZmqulyn76QkGRKE/Btm30DL5Op9VVVW/UWNfyDzWhvAXT7x8X1ZA
 VnHPaxZ0JRbZ7HSOkOgtYCFwLVkyUGwc/DPHaUWhth13QlTt+HnT3V26Nm4ntqgjAsBh
 sx7A==
X-Gm-Message-State: AOJu0YwKQhfWAhx5GO5N5gRW0UmSaqwEhZyuMQjByEIVCxh955gPK6J8
 9E1d77N0CjnQLZTABEnadLYBPM9m919MWcZqTJbo1WrH8SJUXn9czrcSFOz2vpRvztDOYVQWa6d
 0Qp3iXE4I8XE9f5OEhAq3rTWImv4zKSORl3k3nHNE1Qq5XAaj0rXLIjVkKzKGPiiKlkRpTPrZ1S
 wLmKWOYeLqdz7EXKpVWxr0Zak=
X-Received: by 2002:a17:90b:1d91:b0:296:c084:4c5b with SMTP id
 pf17-20020a17090b1d9100b00296c0844c5bmr1384568pjb.25.1707272488161; 
 Tue, 06 Feb 2024 18:21:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4m+8um9dpd9u3fdjgMdkbUIk1le167sXlPGH99J7L3ZQ7CFRtEwP3vRpXVbVJ0bXS39AaN4V5O6otVYsE8L8=
X-Received: by 2002:a17:90b:1d91:b0:296:c084:4c5b with SMTP id
 pf17-20020a17090b1d9100b00296c0844c5bmr1384554pjb.25.1707272487781; Tue, 06
 Feb 2024 18:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20240205102653.2789879-1-liwang@redhat.com>
 <20240206115126.GF270992@pevik>
In-Reply-To: <20240206115126.GF270992@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 7 Feb 2024 10:21:15 +0800
Message-ID: <CAEemH2e-VK=fWaA=SAPnVHjb6ORceDHL+zsJE0O_xDFxgX4VJg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] process_state: Enhancement of process state
 detection
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

T24gVHVlLCBGZWIgNiwgMjAyNCBhdCA3OjUx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwgSWFuLAo+Cj4gPiBUaGUgZnVuY3Rpb25zIHdpbGwgYmUgbW9y
ZSByb2J1c3QgYWdhaW5zdCBwcm9jZXNzIG5hbWVzIHdpdGgKPiA+IHVudXN1YWwgY2hhcmFjdGVy
cyBhbmQgd2lsbCBjb3JyZWN0bHkgcmVhZCB0aGUgc3RhdGUgY2hhcmFjdGVyCj4gPiBmcm9tIHRo
ZSAvcHJvYy9bcGlkXS9zdGF0IGZpbGUuIFRoaXMgaXMgYSBuZWNlc3NhcnkgY2hhbmdlCj4gPiBi
ZWNhdXNlIHRoZSBwcm9jZXNzIG5hbWUsIHdoaWNoIGlzIGEgZnJlZS1mb3JtIHN0cmluZywgY2Fu
Cj4gPiBjb250YWluIHNwYWNlcyBhbmQgb3RoZXIgY2hhcmFjdGVycyB0aGF0IHdvdWxkIG90aGVy
d2lzZQo+ID4gZGlzcnVwdCB0aGUgc2ltcGxlIHBhcnNpbmcgbG9naWMgb2YgdGhlIG9yaWdpbmFs
IGZvcm1hdCBzdHJpbmcuCj4KPiA+IGUuZy4KPiA+ICAkIGNhdCAvcHJvYy83OTI0NDIvc3RhdAo+
ID4gIDc5MjQ0MiAoV2ViIENvbnRlbnQpIFMgMTY0MjEzIDQzNTEgNDM1MSAwIC0xIDQxOTQ1NjAg
Li4uCj4KPiA+IFJlcG9ydGVkLWJ5OiBJYW4gV2llbmFuZCA8aXdpZW5hbmRAcmVkaGF0LmNvbT4K
PiA+IFNpZ25lZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+ID4gQ2M6IENo
dW55dSBIdSA8Y2h1aHVAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIGxpYi90c3RfcHJvY2Vzc19z
dGF0ZS5jIHwgNCArKy0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPgo+ID4gZGlmZiAtLWdpdCBhL2xpYi90c3RfcHJvY2Vzc19zdGF0ZS5jIGIv
bGliL3RzdF9wcm9jZXNzX3N0YXRlLmMKPiA+IGluZGV4IDA4YTlkMDk2Ni4uYzE1MjgzYzNkIDEw
MDY0NAo+ID4gLS0tIGEvbGliL3RzdF9wcm9jZXNzX3N0YXRlLmMKPiA+ICsrKyBiL2xpYi90c3Rf
cHJvY2Vzc19zdGF0ZS5jCj4gPiBAQCAtMjIsNyArMjIsNyBAQCBpbnQgdHN0X3Byb2Nlc3Nfc3Rh
dGVfd2FpdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQKPiBsaW5lbm8sCj4KPiA+ICAgICAg
IGZvciAoOzspIHsKPiA+ICAgICAgICAgICAgICAgc2FmZV9maWxlX3NjYW5mKGZpbGUsIGxpbmVu
bywgY2xlYW51cF9mbiwgcHJvY19wYXRoLAo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIiUqaSAlKnMgJWMiLCAmY3VyX3N0YXRlKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICIlKlteKV0lKmMgJWMiLCAmY3VyX3N0YXRlKTsKPgo+IE9idmlvdXNseSBjb3JyZWN0
LCB0aGFua3MuCj4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4K
PiBCdXQgdGhlcmUgaXMgYWxzbyB0aGUgc2FtZSBpc3N1ZSBpbiBsaWIvdHN0X3RocmVhZF9zdGF0
ZS5jLAo+IEkgZ3Vlc3MgaXQgYXBwbGllcyB0byB0aGF0LiBMaSwgY291bGQgeW91IHBsZWFzZSBh
bHNvIGZpeCBpdCBiZWZvcmUgbWVyZ2U/Cj4KCkdvb2QgcG9pbnQsIGFwcGxpZWQgd2l0aCB0aGUg
dHN0X3RocmVhZF9zdGF0ZSBjaGFuZ2UuCgoKCj4KPiBBbHNvLCBBbmRyZWEsIHlvdSBhZGRlZCB0
c3RfdGhyZWFkX3N0YXRlX3dhaXQoKSBhbmQKPiBUU1RfVEhSRUFEX1NUQVRFX1dBSVQoKSBmb3IK
PiBmdXRleF93YWl0djBbMjNdIHJlbGF0ZWQgdGVzdHMgWzFdLCBidXQgaXQncyBub3cgbm90IHVz
ZWQgYW55d2hlcmUgZHVlCj4gSmFuJ3MKPiBjaGFuZ2VzIFsyXSBbM10uIEkgd29uZGVyIGlmIGl0
J3Mgc3RpbGwgdXNlZnVsIG9yIHdoZXRoZXIgd2Ugc2hvdWxkIHJlbW92ZQo+IGl0Lgo+CgpBZ3Jl
ZWQgd2l0aCBKYW4sIGl0IGlzIHN0aWxsIHVzZWZ1bCBpbiB0aGUgZnV0dXJlLgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
