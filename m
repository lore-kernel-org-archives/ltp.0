Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D89C3DA49
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 10:10:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 702793D1B13
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 12:10:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5B563D0D24
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 12:10:13 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DB748618FF9
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 12:10:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721297411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1FREP4dhp3RdZqFOUlw6ujpZTWmaVfAJaxlFbTJdDzk=;
 b=i68N0cNS4D3t41LunP2+Y/ngsdbjaeiaALBxYfQ388wP9rXRwvg79A/7yV18iksMAqhaSH
 2T8m0DiMHnoNFQaeaBwMhBbAYIdfn0zz0k5YblFhwpANlZkJvpdThpDtHhGboksj65L89G
 LfdjHSvMTL4k4bozrPA+u4YJm733cMI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-WsspPVDfPLaSebdPuN0uAw-1; Thu, 18 Jul 2024 06:10:09 -0400
X-MC-Unique: WsspPVDfPLaSebdPuN0uAw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cb4c2276b6so160774a91.1
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 03:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721297408; x=1721902208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1FREP4dhp3RdZqFOUlw6ujpZTWmaVfAJaxlFbTJdDzk=;
 b=sm5iR25XM5xBnkHh2iyhOsNwbke2HLMhmL04iISp4QRTNK2FLkq5E5jM+Qbx4eaD1E
 PQm2fDM4OY/U2gkvO0/Yz3rd7/6yMJ4q9IaednCawyE4Qp4UKa928s6i72lltEzNMd8g
 V3metpOhsnZackUsh5FvV6oHqBM+TQuNleOAYDldfmvymIUlPPhCcM9w1ito8F2hFByw
 iDUKb3ScIJ1w4LhmUw8HCAKN/6oHY2KAKgUC3at0V9Xhg6yDfdWSu13caP7gBzrgfzw2
 JRjpldMJf+pMWB6cfVj3LnZBAUDUL20HFNSPP4e2JF11bw1oKsshcyBw9xYoBfEvABt5
 m7lw==
X-Gm-Message-State: AOJu0YzOuSM4k+fA2gf3cCSfccWFNbfucSFj2JTIZtUG0apShxfbDylW
 tIZg8CR+vyCfrjNM87/0s38NZSRdt/xbam/glX8D71h8xGc3w1vdYnrdHZLi6RGRpB3ePWjwUef
 GGpwam1oQNwFUfTPO9NJCwAwLei96A1BCeaSDcmSBsv21tNalZE0I1Jmafa8rrzw1nF+zTMtzhT
 eNp1+nDMiaJh9tqy3/wZExwu+9Zqa48gO0h7i3
X-Received: by 2002:a17:90a:66cf:b0:2c8:653:8c96 with SMTP id
 98e67ed59e1d1-2cb5281bd3cmr3033714a91.40.1721297408126; 
 Thu, 18 Jul 2024 03:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsCpkGhqIinGWI7obMCfY32GXgBvN83vWYaaLdj/yHMdTVUgme9JmUt23qGY8hSZB5Rhs6GvjrXVbJ+91axFo=
X-Received: by 2002:a17:90a:66cf:b0:2c8:653:8c96 with SMTP id
 98e67ed59e1d1-2cb5281bd3cmr3033701a91.40.1721297407792; Thu, 18 Jul 2024
 03:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721293231.git.pengfei.xu@intel.com>
 <554f6a9949dae600e880dad306819afdf8aaf914.1721293231.git.pengfei.xu@intel.com>
 <CAEemH2cAXHb_bkUVk+bF3zXqROR_07MjVGvnQQcs9NDq6pdOeg@mail.gmail.com>
In-Reply-To: <CAEemH2cAXHb_bkUVk+bF3zXqROR_07MjVGvnQQcs9NDq6pdOeg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Jul 2024 18:09:56 +0800
Message-ID: <CAEemH2d=t3Ki2dmQo30FH6naBmDKCSYCiVh6dhM7Bigr3hbg6A@mail.gmail.com>
To: Pengfei Xu <pengfei.xu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 1/1] migrate_pages03: remove
 wait_ksmd_full_scan() check because it's not necessary
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
Cc: Andrea Arcangeli <andreaa@redhat.com>, feij.fnst@cn.fujitsu.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U29ycnksIGZvcmdvdCB0byBjYyBBbmRyZWEgQXJjYW5nZWxpIGluIHRoZSBsYXN0IHJlcGx5LgoK
Ck9uIFRodSwgSnVsIDE4LCAyMDI0IGF0IDY6MDbigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cgo+IFBlbmdmZWkgWHUgPHBlbmdmZWkueHVAaW50ZWwuY29tPiB3cm90ZToK
Pgo+IFJlbW92ZSB3YWl0X2tzbWRfZnVsbF9zY2FuKCkgY2hlY2sgYmVjYXVzZSBpdCdzIG5vdCBh
IG5lY2Vzc2FyeSBzdGVwIGZvcgo+PiBtaWdyYXRlX3BhZ2VzMDMgc3lzY2FsbCB0ZXN0Ogo+PiAx
LiBLU00oa2VybmVsIHNhbWVwYWdlIG1lcmdpbmcpIGNvdWxkIGJlIGVuYWJsZWQgYW5kIGl0IGlz
IG9wdGlvbmFsIGZvcgo+PiBtaWdyYXRlX3BhZ2VzIHN5c2NhbGwgdGVzdGluZy4KPj4KPgo+IFRo
ZSB3YWl0X2tzbWRfZnVsbF9zY2FuIGd1YXJhbnRlZXMgdGhlIGFjdHVhbCBtZXJnaW5nIGhhcHBl
bnMgdGhlbiB0ZXN0Cj4gY2FuIG1pZ3JhdGUgdGhvc2UgbWVyZ2VkIEtTTSBwYWdlcyB0byByZXBy
b2R1Y2UgdGhlIHJlZ3Jlc3Npb24gcGFuaWMgaW4KPiBrZXJuZWwgY29tbWl0IDRiMGVjZTZmYTAx
NjdiLgo+Cj4gU28gdGhpcyBpcyBhIG5lY2Vzc2FyeSBjb25maWd1cmF0aW9uIGJlZm9yZSB0ZXN0
aW5nLgo+Cj4KPj4gMi4gV2hlbiBzZXJ2ZXIgbGF1bmNoZWQgYW55IHFlbXUgZ3Vlc3QsIHdhaXRf
a3NtZF9mdWxsX3NjYW4oKSB3aWxsIGluCj4+IGluZmluaXRlIGxvb3AgZHVlIHRvIC9zeXMva2Vy
bmVsL21tL2tzbS9mdWxsX3NjYW5zIG51bWJlciB3b3VsZCBub3QKPj4gaW5jcmVhc2UgYW55bW9y
ZSwgYW5kIG1pZ3JhdGVfcGFnZXMwMyB3aWxsIGZhaWxlZCB3aXRoIHRpbWVvdXQgcmVhc29uLgo+
PiBBZnRlciByZW1vdmVkIHdhaXRfa3NtZF9mdWxsX3NjYW4oKSwgbWlncmF0ZV9wYWdlczAzIGNv
dWxkIHBhc3Mgd2l0aG91dAo+PiBpc3N1ZS4KPgo+Cj4gWWVzLCB0aGlzIHRpbWVvdXQgcHJvYmxl
bSBsaWtlbHkgZXhpc3RzLiBUaGF0IGlzIHRoZSBLU00gZGVzaWduIHdoaWNoIGNhbid0Cj4gYXZv
aWQgInVucmVsYXRlZCIgcGFnZSBtZXJnaW5nIGhhcHBlbmluZyBpbiB0aGUgYmFja2dyb3VuZC4K
PiBCdXQgcmVtb3ZpbmcgdGhlIHdhaXRfa3NtZF9mdWxsX3NjYW4gbWlnaHQgbm90IGJlIGEgZ29v
ZCBhcHByb2FjaCBJTUhPLgo+Cj4gQ2MgQEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdlQHJlZGhh
dC5jb20+IGlmIGhlIGhhcyBnb29kIHN1Z2dlc3Rpb25zIG9uCj4gdGhlIHRlc3QuCj4KPgo+PiBT
aWduZWQtb2ZmLWJ5OiBQZW5nZmVpIFh1IDxwZW5nZmVpLnh1QGludGVsLmNvbT4KPj4gLS0tCj4+
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21pZ3JhdGVfcGFnZXMvbWlncmF0ZV9wYWdlczAz
LmMgfCAxIC0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21pZ3JhdGVfcGFnZXMvbWlncmF0ZV9wYWdl
czAzLmMKPj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21pZ3JhdGVfcGFnZXMvbWlncmF0
ZV9wYWdlczAzLmMKPj4gaW5kZXggNGQzMjk5YjYxLi5mNTE0ZWQxMGMgMTAwNjQ0Cj4+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWlncmF0ZV9wYWdlcy9taWdyYXRlX3BhZ2VzMDMu
Ywo+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21pZ3JhdGVfcGFnZXMvbWlncmF0
ZV9wYWdlczAzLmMKPj4gQEAgLTk1LDcgKzk1LDYgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkK
Pj4KPj4gICAgICAgICBTQUZFX0ZJTEVfU0NBTkYoUEFUSF9LU00gInJ1biIsICIlZCIsICZvcmln
X2tzbV9ydW4pOwo+PiAgICAgICAgIFNBRkVfRklMRV9QUklOVEYoUEFUSF9LU00gInJ1biIsICIl
ZCIsIDEpOwo+PiAtICAgICAgIHdhaXRfa3NtZF9mdWxsX3NjYW4oKTsKPj4gIH0KPj4KPj4gIHN0
YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKPj4gLS0KPj4gMi40My4wCj4+Cj4+Cj4+IC0tCj4+IE1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Pgo+
Pgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
