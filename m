Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EEBCED63E
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 09:44:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 725EB3C278D
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 11:44:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0DF23C259D
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:44:32 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BCA55600D73
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/rDuSSK+WoADOPDiSTqGi/xSVW3sWXWakFNsWvi87w=;
 b=PLqIrl+6IiYCVM6ygm/gOBju2BBMYFt4fOpzT289HSHy3lFuDMQg2Kzx71C68MQJcYC2Nc
 MaB9oiWd+rt3aFmUB8IW9WM89eUDAr552qJtqQ1WdHXYjQq5YXHkM1/szuTrlN8PwxuoAc
 Mgr9roiziY9IJeudHnA0Gt/ObTG1tJA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-AJEmPl8uMtCp2TIWPhfGwA-1; Wed, 09 Oct 2024 05:44:28 -0400
X-MC-Unique: AJEmPl8uMtCp2TIWPhfGwA-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7167afaa6e4so470962a34.0
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 02:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467068; x=1729071868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/rDuSSK+WoADOPDiSTqGi/xSVW3sWXWakFNsWvi87w=;
 b=dhGxsd61ytMIQe6ZXQ6yz/Z7FMo6Q3e9dncl3wGsrRPMxdrk26Utuq+T9Ai4AvgyzF
 TlbN/Rx1JciaohDCFj9U6qWxXu9jT2yuue8vz6LWzW38NoakMDk7B5LYLeYk0nMhuugT
 q3SeZoPl8JfL3th1z4offSR0W/RNv2Q893ZvSYwhYfCcAtncgCCLYJdfcP4AcIXKOOiE
 xOWI+ypSTbcs6re8sjHTwTgT+yrgFDPFN5d75mhPJ9RvO+5Nycrevn6UnPa8PKUjzXK9
 oMXH2iPKTfb45Wvq5IJt3N9ua75f9IqMbrLn/4ZZxTqL1WcQspKEXpbyfGrYp6C1wtFg
 34Lg==
X-Gm-Message-State: AOJu0Yyw/dDxIGO3SVZbLwOveP9tE2ka1F+Qc4wBLP/AgusG5p/+XabJ
 +kHlqVTbrRcfhxsgndVdonp700Yframib2CNfA192CRGoL9fZAcrf0NCIaNs8srAoRaXljhesCu
 7y4w0tkX51VzfGPHYkgCz6tCMrh23ucp7tDH92wskwatqYz7IJtwpfyj/IQpayNQcpfCb3EfiT0
 oB+B4qLn+44W2H8XCrIMuKbkA=
X-Received: by 2002:a05:6808:14cf:b0:3e0:41ce:e95e with SMTP id
 5614622812f47-3e3db593696mr3653881b6e.2.1728467067777; 
 Wed, 09 Oct 2024 02:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyjZy2CUJV7KblshcZvXJey0arrtrUcm9ScbSHgNMOCEbxQTHysCAkDGSph65N/yQgnqlHbqvFaTlblugnpcE=
X-Received: by 2002:a05:6808:14cf:b0:3e0:41ce:e95e with SMTP id
 5614622812f47-3e3db593696mr3653873b6e.2.1728467067485; Wed, 09 Oct 2024
 02:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241008135934.2491333-1-david@redhat.com>
In-Reply-To: <20241008135934.2491333-1-david@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Oct 2024 11:44:04 +0200
Message-ID: <CAASaF6yLa6F9Bz9Adck=Y5RJePzYmboSAizYWJP_BHmy12cQ=g@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] move_pages04: fixes and improvements
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

T24gVHVlLCBPY3QgOCwgMjAyNCBhdCAzOjU54oCvUE0gRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlk
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBpcyB2MiBvZiBbMV0uCj4KPiBGaXggYW5kIGV4
dGVuZCB0aGUgbW92ZV9wYWdlczA0IHRlc3QgY2FzZSB0byBtYWtlIGl0IHBhc3Mgb24gdXBzdHJl
YW0KPiBrZXJuZWxzIGFnYWluLiBXaGlsZSBhdCBpdCwgY2xlYW4gaXQgdXAgYSBiaXQgYW5kIGNv
bnZlcnQgaXQgdG8gdGhlIG5ldwo+IHRlc3QgQVBJLgoKT3RoZXIgdGhhbiBhIHNtYWxsIHR5cG8g
aGVyZSAod2hpY2ggY2FuIGJlIGZpeGVkIGR1cmluZyBwdXNoKQoKLSAqICAgICAgMS4gUGFzcyB0
aGUgYWRkcmVzcyBvZiBhIHZhbGlkIG1lbW9yeSBhcmVhIHdoZXJlIG5vIHdoZXJlIG5vIHBhZ2Ug
aXMKKyAqICAgICAgMS4gUGFzcyB0aGUgYWRkcmVzcyBvZiBhIHZhbGlkIG1lbW9yeSBhcmVhIHdo
ZXJlIG5vIHBhZ2UgaXMKCml0IGxvb2tzIGdvb2QgdG8gbWUsIGFuZCBiZWhhdmVzIGFzIGV4cGVj
dGVkIHdpdGggNi4xMi1yYzEuCgpJZiBwZW9wbGUgZmluZCBpdCB0b28gbm9pc3kgbm93IGZvciBv
bGRlciBrZXJuZWxzLCB3ZSBjb3VsZCBhZGQgLm1pbl9rdmVyID0gIiIKdG8gdGhlIHRlc3QuCgpS
ZXZpZXdlZC1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cgo+Cj4gWzFdIGh0
dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAyNDA4MjkxNDEwMDIuMTk2MjMwMy0xLWRhdmlkQHJl
ZGhhdC5jb20KPgo+IENjOiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KPiBDYzog
Q3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4KPiBEYXZpZCBIaWxkZW5icmFuZCAoMyk6
Cj4gICBtb3ZlX3BhZ2VzMDQ6IGNoZWNrIGZvciAiaW52YWxpZCBhcmVhIiwgIm5vIHBhZ2UgbWFw
cGVkIiBhbmQgInNoYXJlZAo+ICAgICB6ZXJvIHBhZ2UgbWFwcGVkIgo+ICAgbW92ZV9wYWdlczA0
OiByZW1vdmUgc3BlY2lhbC1jYXNpbmcgZm9yIGtlcm5lbHMgPCA0LjMKPiAgIG1vdmVfcGFnZXMw
NDogY29udmVydCB0byBuZXcgdGVzdCBBUEkKPgo+ICAuLi4va2VybmVsL3N5c2NhbGxzL21vdmVf
cGFnZXMvbW92ZV9wYWdlczA0LmMgfCAyNjcgKysrKysrKysrLS0tLS0tLS0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMjcgaW5zZXJ0aW9ucygrKSwgMTQwIGRlbGV0aW9ucygtKQo+Cj4gLS0KPiAyLjQ2
LjEKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
