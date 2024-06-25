Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E145C2BBCA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 03:16:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10CCE3D0FB2
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 05:16:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09763CFA21
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 05:15:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 392812002A5
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 05:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719285349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uDruxi+uzUXC9aQrhqRoNngaHNO0J6PEZuPjPZDT7XQ=;
 b=hNMoOJ51NVXMwg/9y1JZ7OmyFdmXPKiDOuESwuiW2lJhyMdKkj19DGnnjE/fUrq85z/hUa
 AsIEdH54JoWciBiEWvXmMLw1QqAjLAhuKVueZ6xOzz2uyMDSIwFewbgQJyEq2KG5fiBJrz
 H8b1bybKTOA3yBDSvANWdLGCIIh1Q/E=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-KMh6c7n_OBiKIqQQYNUuhQ-1; Mon, 24 Jun 2024 23:15:45 -0400
X-MC-Unique: KMh6c7n_OBiKIqQQYNUuhQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-70dbb7e9bf2so6239301a12.2
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 20:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719285345; x=1719890145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uDruxi+uzUXC9aQrhqRoNngaHNO0J6PEZuPjPZDT7XQ=;
 b=wr/lZ1jOetRzdviSdCiW57sWHv5Y81iCDnLk4nlOquVirGa4iPl6i1MXM9yuUyePat
 6ATAGPMvRnBrTHauxNH7Nk5qgAATglTa9L5593n71EEKv1NBprnsjmV9WbRBcXMw5WFE
 Y+Epi9uFT2sUo1AyKIIm9+kO3+Q/E0MMX4oY6VYyZkZqETSUo7SNi0r2KVagYwB9hjTm
 dkiT9WVzQlCrGL6opWCC+kpBUEQJ4NfScN6ddW0K7L28ENQ/WE9MtdJLqHpIPK1dhHh+
 T1KGqQlH5v33OMgNRuNK3sziNGsp9TTTE2LvEG5wmw2Q8yk9j4gfsaM4lB6c4XhlTmXB
 Xj7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGTZUt6XzRiLxKfQL6XQDqV6+vxuBwpfS6ujsgqQSgScU8cEQGBqgYnwiWYPj1ntyD78uUF1UI3NA0LL2TDBWKAPE=
X-Gm-Message-State: AOJu0YzFJCg1EpI4g38C+rTHnL05DCCUr8s/BREzlKzkXSIAnOANx+ai
 V0gTJVbcV6NejxbyDYgJHyayQ3yZOyQqaH22rgadfCzRjfDy9nlEC1UFyKw0AdijhmdQdHueLyX
 6tiPQHdi8dCxClTRCekDr2ZQWodg3rUQu2pntUJsin6GEazQrv8bmeqKFq7S6Z5dZRs7UiLJJKN
 MQvmSgGoKgupMyLCD/0vp4Qa0=
X-Received: by 2002:a05:6a20:6d18:b0:1bd:1af0:385c with SMTP id
 adf61e73a8af0-1bd1af03948mr739766637.9.1719285344708; 
 Mon, 24 Jun 2024 20:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr/gIl/J+Ii5Kg/XDwqkB1yMbs7q9pll0/IJuwIw4DahkE4TqbyLMMooZ1WU8GH2AqVfo7DbSN6T8e5g7TzAg=
X-Received: by 2002:a05:6a20:6d18:b0:1bd:1af0:385c with SMTP id
 adf61e73a8af0-1bd1af03948mr739752637.9.1719285344309; Mon, 24 Jun 2024
 20:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-3-jstultz@google.com>
 <Zi9jL1jycx6oo37g@yuki>
 <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki> <ZnlORS6RGTAA4UhS@yuki>
 <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
In-Reply-To: <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 25 Jun 2024 11:15:32 +0800
Message-ID: <CAEemH2fT2NsoZfRvNrhRrstF=dhzF8Y90HqVQSCf1VxqpNHgEw@mail.gmail.com>
To: John Stultz <jstultz@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
Cc: Darren Hart <darren@os.amperecomputing.com>, kernel-team@android.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSm9obiwKCk9uIFR1ZSwgSnVuIDI1LCAyMDI0IGF0IDg6MDXigK9BTSBKb2huIFN0dWx0eiB2
aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+Cndyb3RlOgoKPiBPbiBNb24sIEp1biAyNCwgMjAy
NCBhdCAzOjQ14oCvQU0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+ID4K
PiA+IEhpIQo+ID4gRllJIHRoZSBwYXRjaCB0aGF0IHJlbW92ZXMgdGhlIGF1dG90b29scyBmcm9t
IHRoZSB0ZXN0Y2FzZXMvcmVhbHRpbWUgaGFzCj4gPiBiZWVuIG1lcmdlZCwgaXQgc2hvdWxkIGJl
IHBvc3NpYmxlIHRvIHVzZSB0aGUgaW5jbHVkZS90c3RfYXRvbWljLmggYW5kCj4gPiBvdGhlciBo
ZWFkZXJzIHdpdGhvdXQgY29uZmxpY3RzIG5vdy4KPgo+IEhleSBDeXJpbCEKPgo+IEkgd2VudCB0
byB0YWtlIGEgc3RhYiBhdCB0aGlzLCBidXQgdGhlIG1hc3RlciBicmFuY2ggb24KPiBodHRwczov
L2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC5naXQgZG9lc24ndCBzZWVtIHRvIGJ1
aWxkOgo+ICAgJCAuL2NvbmZpZ3VyZSAtLXdpdGgtcmVhbHRpbWUtdGVzdHN1aXRlCj4gICAkIG1h
a2UgLWogPiAvZGV2L251bGwKPiBtYWtlWzNdOiAqKiogTm8gcnVsZSB0byBtYWtlIHRhcmdldCAn
TWFrZWZpbGUuYW0nLCBuZWVkZWQgYnkKPiAnTWFrZWZpbGUuaW4nLiAgU3RvcC4KPiBtYWtlWzJd
OiAqKiogWy4uLy4uL2luY2x1ZGUvbWsvZ2VuZXJpY190cnVua190YXJnZXQuaW5jOjEwODogYWxs
XSBFcnJvciAyCj4gbWFrZVsxXTogKioqIFsuLi9pbmNsdWRlL21rL2dlbmVyaWNfdHJ1bmtfdGFy
Z2V0LmluYzoxMDg6IGFsbF0gRXJyb3IgMgo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6ODU6IHRlc3Rj
YXNlcy1hbGxdIEVycm9yIDIKPgo+IEJpc2VjdGluZyBwb2ludHMgdG8gY29tbWl0IGEwNTI5OGVj
NDQ5NCAoInRlc3RjYXNlczogcmVhbHRpbWU6IEdldCByaWQKPiBvZiBhdXRvdG9vbHMiKQo+Cj4g
SSdtIHVuZm9ydHVuYXRlbHkgbm90IHNhdnZ5IGVub3VnaCB3aXRoIGJ1aWxkIHN5c3RlbXMgdG8g
aGF2ZSBtdWNoIG9mCj4gYW4gaWRlYSBvZiB3aGF0IGlzIG5lZWRlZCBoZXJlLgo+Cj4gQW55IHN1
Z2dlc3Rpb25zPwo+CgpMb29rcyBsaWtlIHlvdSB3ZXJlIHRyeWluZyB0byBjb25maWd1cmUgcmVh
bHRpbWUtdGVzdHN1aXRlIGluIExUUCBidWlsZC4KClRyeSB0aGlzOgoKIyBjZCBsdHAgZGlyLwoj
IG1ha2UgYXV0b3Rvb2xzCiMgIC4vY29uZmlndXJlCiMgIG1ha2UgLUMgdGVzdGNhc2VzL3JlYWx0
aW1lLwpTZWU6Cmh0dHBzOi8vbGludXgtdGVzdC1wcm9qZWN0LnJlYWR0aGVkb2NzLmlvL2VuL2xh
dGVzdC91c2Vycy9xdWlja19zdGFydC5odG1sCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
