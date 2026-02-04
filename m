Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB27E9D3E2
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770214867; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0d+Z/ac7ndG7Edc6ZVmKIynyRJiTQEOimPKfwIr3KqY=;
 b=XE+Ov0NT6Oo5coYNe7EYYsc6JtlYQ+wIxYkB38zLr1wV8VlZufux+HtozKTFbrOOGrkex
 Sn2MKt29EQH4hntm8EllOUtUjFSJEX+QVIFpPia1Is6kyldDOqj66gCfE1BstxxXBx2OKr8
 QwZ4eGU6Xz+P04Ugsmi4YQjDrTz/fCo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1F5F3CE1B7
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 15:21:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A60CD3CE0E0
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 15:20:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5C67710000D2
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 15:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770214841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvOkNeBgBvPasBOu37xH6UTsNrxiRUJcL+vN5tOzRLM=;
 b=KHrqzwdpjzr4euu5IIfIaEtB7oQllbqHqRecuIMV9cjKEOAzrVEWHeeKcmA1afzvjeUb2T
 uKQY/VduTZOcNYa5nqYvOxpB3Cw1NYtIaUz2IzAI/qkPYTv+pscjwdnnVHJoooJs1Qzz86
 jf476M5uvq9N/HPTsuVqSLctaphY8WI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-PsX9aNujMTi8I25du3RTbg-1; Wed, 04 Feb 2026 09:20:40 -0500
X-MC-Unique: PsX9aNujMTi8I25du3RTbg-1
X-Mimecast-MFC-AGG-ID: PsX9aNujMTi8I25du3RTbg_1770214839
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a8c273332cso176671595ad.1
 for <ltp@lists.linux.it>; Wed, 04 Feb 2026 06:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770214839; x=1770819639;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qvOkNeBgBvPasBOu37xH6UTsNrxiRUJcL+vN5tOzRLM=;
 b=p4uTJW6rklno5C8SUKzEEwbxriULJR2dFqJ+68z6k3kXLVUkR1vLbM0RvP3LOqMDeH
 0fiEkhEPRqTMjPpqrEs1C9T9qHdegZWcvrFN9ozaHS32X8nkjj1ow4u93Z4peaXK09bs
 L+u/zWNk/kaEqUWQrtMU0QHF1+cbO8XlbQ/6t17FonM4PPgu4bGu9I+NECRDvxrAjtwB
 FplNMZqfxg1CV6Vd7ihlb9wY7Tj3NrGgZf4oz2vAjYIeRDS3p3+2H+xNSKIkd+DgfKZ4
 wD5zFexIWzPpofa1n/Zy+DAZzpDdXAui64TlVBnCos7r1X7cDi1V6u3U9686vT9nPT9U
 5y/g==
X-Gm-Message-State: AOJu0Yzo/nigTlzaP/dOClzVHtHffgef7/lyoUMtR7ogLRdX/ZW54HOS
 iYzi3c4uEuFSWqYnznB3bzytmh/HkVJ81iutmLbplFQDXLzgbDHvWYyvON5CUWCI6nRifwAIxhS
 bYp3PdezEuPMmXDl9e/urDksuYxE0iedtrFXkYEI8qSIskpjAbi6tBuIX4hBU
X-Gm-Gg: AZuq6aKBAsqNM8qNpjwFDUDeQLZx5YoDpaV3ODbI3fg/AFKfUO7t4fFZTyXqj5JbLQt
 soapUIKdm0K8efohJNv09TmMweK6Kn20lm3JXQ8VkP1LILN2lYRWq2UcqEm+OD0bkIOFCuqjMJ9
 W8PhR13gCq9o0Jd/4tN60vVdNOyVS9yYWDG26VNYFR/MdhVXNl0M2gOX20EH0ilYrOEvQnFngYl
 G0qcsMPtcTxZgFCUqK5vJjdHUG1oW5LKJeyqo0OMaYF2ey5mLAcvNsWHEwYXGMgNRo0zheBSzZs
 kiwF0Dtz3GeH2BtQnWrSj0BLpe1Eeq5MGl7MmKKBBfJYcpyaXXmd7UNVjenx5ypK66i5IpZioil
 yqNFW
X-Received: by 2002:a05:6a21:1304:b0:384:d0bf:1ff3 with SMTP id
 adf61e73a8af0-39372104c43mr3102438637.18.1770214838680; 
 Wed, 04 Feb 2026 06:20:38 -0800 (PST)
X-Received: by 2002:a05:6a21:1304:b0:384:d0bf:1ff3 with SMTP id
 adf61e73a8af0-39372104c43mr3102399637.18.1770214838048; 
 Wed, 04 Feb 2026 06:20:38 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338746c4sm23637315ad.27.2026.02.04.06.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 06:20:37 -0800 (PST)
Date: Wed, 4 Feb 2026 22:20:34 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYNVsiL4xf2P9R6A@redhat.com>
References: <20260203024320.227453-1-liwang@redhat.com>
 <20260204122332.GC224465@pevik>
MIME-Version: 1.0
In-Reply-To: <20260204122332.GC224465@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mM_uhK8Z6dGzCfvdtAJaAsqwIK0vaJAPVHSES791Rgk_1770214839
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] openat2: define _GNU_SOURCE and include
 <fcntl.h>
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

T24gV2VkLCBGZWIgMDQsIDIwMjYgYXQgMDE6MjM6MzJQTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiBoaSBMaSwKPiAKPiA+IE9uIEZlZG9yYSBSYXdoaWRlIChnbGliYyAyLjQzKyksIGxpYmMg
ZXhwb3NlcyBvcGVuYXQyKCkgYW5kIHN0cnVjdCBvcGVuX2hvdywKPiA+IHNvIG91ciBjb25maWd1
cmUgc2NyaXB0IGRlZmluZXMgSEFWRV9PUEVOQVQyIGFuZCB0aGUgZmFsbGJhY2sgZGVmaW5pdGlv
biBpbgo+ID4gbGFwaS9vcGVuYXQyLmggZ2V0cyBza2lwcGVkLiBCdXQgb3BlbmF0MjAqLmMgbmV2
ZXIgaW5jbHVkZWQgPGZjbnRsLmg+IChhbmQKPiA+IGxhY2tlZCBfR05VX1NPVVJDRSksIHNvIHRo
ZSBsaWJjLXByb3ZpZGVkIHByb3RvdHlwZSBhbmQgc3RydWN0IHN0YXllZCBoaWRkZW4sCj4gPiBz
byBjb21waWxhdGlvbiBmYWlsZWQ6Cj4gCj4gPiAgICMgdW5hbWUgLXIKPiA+ICAgNi4xOC4wLTY1
LmZjNDQueDg2XzY0Cj4gCj4gPiAgICMgcnBtIC1xZiAvdXNyL2luY2x1ZGUvZmNudGwuaAo+ID4g
ICBnbGliYy1kZXZlbC0yLjQzLTEuZmM0NC54ODZfNjQKPiAKPiA+ICAgIyBubSAtRCAvdXNyL2xp
YjY0L2xpYmMuc28uNiB8IGdyZXAgLXcgb3BlbmF0Mgo+ID4gICAwMDAwMDAwMDAwMGViODkwIFcg
b3BlbmF0MkBAR0xJQkNfMi40Mwo+IAo+ID4gICAjIG1ha2UgLUMgdGVzdGNhc2Uva2VybmVsL3N5
c2NhbGxzL29wZW5hdDIKPiA+ICAgb3BlbmF0MjAxLmM6Mjc6NjI6IGVycm9yOiBpbnZhbGlkIGFw
cGxpY2F0aW9uIG9mIOKAmHNpemVvZuKAmSB0byBpbmNvbXBsZXRlIHR5cGUg4oCYc3RydWN0IG9w
ZW5faG934oCZCj4gPiAgICAgMjcgfCAgICAgICAgIHsmZGlyX2ZkLCBURVNUX0ZJTEUsIE9fUkRX
UiwgU19JUldYVSwgMCwgJmhvdywgc2l6ZW9mKCpob3cpfSwKPiAKPiA+IERlZmluZSBfR05VX1NP
VVJDRSBhbmQgaW5jbHVkZSA8ZmNudGwuaD4gaW4gb3BlbmF0MiB0ZXN0cyB0byBtYWtlIHRoZQo+
ID4gcHJvdG90eXBlIGF2YWlsYWJsZSBhbmQgZml4IHRoZSBidWlsZC4KPiAKPiA+IFNpZ25lZC1v
ZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9vcGVuYXQyL29wZW5hdDIwMS5jIHwgMyArKysKPiA+ICB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL29wZW5hdDIvb3BlbmF0MjAyLmMgfCAzICsrKwo+ID4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDMuYyB8IDMgKysrCj4gPiAgMyBm
aWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKPiAKPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL29wZW5hdDIvb3BlbmF0MjAxLmMgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL29wZW5hdDIvb3BlbmF0MjAxLmMKPiA+IGluZGV4IGVjZDYzYjE1MC4uNDBhYzJm
NmQ5IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuYXQyL29w
ZW5hdDIwMS5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW5hdDIvb3Bl
bmF0MjAxLmMKPiA+IEBAIC00LDYgKzQsOSBAQAo+ID4gICAqCj4gPiAgICogQmFzaWMgb3BlbmF0
MigpIHRlc3QuCj4gPiAgICovCj4gPiArI2RlZmluZSBfR05VX1NPVVJDRQo+IAo+IFdoeSBfR05V
X1NPVVJDRT8gZ2xpYmMgdGVzdCB0c3Qtb3BlbmF0Mi5jIFsxXSB3aGljaCBpbmNsdWRlcyA8ZmNu
dGwuaD4sIHVzZXMKPiBzdHJ1Y3Qgb3Blbl9ob3cgYW5kIHRlc3Qgb3BlbmF0MigpIGRvZXMgbm90
IGRlZmluZSBpdC4gTmVpdGhlciBvcGVuYXQyKCkgbm9yCj4gc3RydWN0IG9wZW5faG93IGFyZSBn
dWFyZGVkIGJ5ICNpZmRlZiBfX1VTRV9HTlUuCj4gCj4gT19ESVJFQ1RPUlkgaXMgZ3VhcmRlZCBi
eSAjaWZkZWYgX19VU0VfWE9QRU4ySzggYnV0IHRoaXMgc2hvdWxkIGJlIHNhZmUgYXMgd2UKPiBj
b21waWxlIHdpdGggLXN0ZD1nbnU5OS4KPiAKPiBJIG1lYW4gaXQncyBub3QgYSBiaWcgZGVhbCwg
YnV0IGlmIGl0IHdvcmtzIHdpdGhvdXQgaXQgcGxlYXNlIHJlbW92ZSBpdC4KCkZyb20gbXkgdGVz
dCBvbiBGZWRvcmEtUmF3aGlkZSwgaXQgZG9lc24ndCB3b3JrIGlmIG5vdCBkZWZpbmUgaXQuCkxl
dCBtZSBkb3VibGUgY2hlY2suIE1heWJlIHJlcGx5IHRvIHlvdSB0b21vcnJvdy4KCj4gCj4gWzFd
IGh0dHBzOi8vc291cmNld2FyZS5vcmcvZ2l0Lz9wPWdsaWJjLmdpdDthPWJsb2I7Zj1zeXNkZXBz
L3VuaXgvc3lzdi9saW51eC90c3Qtb3BlbmF0Mi5jCj4gWzJdIGh0dHBzOi8vc291cmNld2FyZS5v
cmcvZ2l0Lz9wPWdsaWJjLmdpdDthPWJsb2I7Zj1zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9iaXRz
L29wZW5hdDIuaAo+IAo+ID4gKyNpbmNsdWRlIDxmY250bC5oPgo+IAo+IFNob3VsZCBub3Qgd2Ug
dXNlIGluY2x1ZGUgbGFwaS9mY250bC5oPwo+IAo+ID4gKwo+ID4gICNpbmNsdWRlICJ0c3RfdGVz
dC5oIgo+ID4gICNpbmNsdWRlICJsYXBpL29wZW5hdDIuaCIKPiAKPiBsYXBpL29wZW5hdDIuaCB1
c2VzIHN0cnVjdCBvcGVuX2hvdyBkaXJlY3RseSwgc2hvdWxkbid0IGJlIGluY2x1ZGVkIGxhcGkv
ZmNudGwuaAo+IHRoZXJlPwoKRnJvbSBteSB1bmRlcnN0YW5kIGxhcGkvKiBhcmUgYXBwZW5kaXgg
Zm9yIG1pc3Npbmcgc3R1ZmYgaW4gaGVhZGVyIGZpbGUuCgpUZXN0IGNhc2VzIHNob3VsZCBvbmx5
IGluY2x1ZGUgc3RhbmRhcmQgaGVhZGVyIGZpbGVzLCBhbmQgbGFwaSBzaG91bGQKb25seSBiZSB1
c2VkIGluIGNhc2Ugb2YgbWlzc2luZyBvciBjb25mbGljdGluZyBoZWFkZXIgZmlsZXMuCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
