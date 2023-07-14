Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6F3EB64DD
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 02:54:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F2C13CE69D
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 04:54:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C75B63C9753
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 04:54:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 69FFB10001B5
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 04:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689303279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkPtdP9/z7sZWfPXy2bsuuErn6INtzlBuYfEJpPFzw4=;
 b=BK/LMHuPF+SLBBXD4VNsPYTB1UXEgoeJ/Sy/jBHQgBDWQg7UCI9OGIFsM4gsSJWVj+/RPI
 JbzTYf40IaJ4PXja4l22O6sjpgv72eXgIwY54x2iArEKe6C3BnEXj7FsPqdUoEVFRcKshY
 OVM1F/wxmZ8+m5ILi9oVca4Ez1vZ8sk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-APo1CXXkP-ugEDTmmckovA-1; Thu, 13 Jul 2023 22:54:35 -0400
X-MC-Unique: APo1CXXkP-ugEDTmmckovA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b7430d23ffso13505311fa.3
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 19:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689303274; x=1691895274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TkPtdP9/z7sZWfPXy2bsuuErn6INtzlBuYfEJpPFzw4=;
 b=WNfitb73L0bWWPQTdn+C4nXgg+D9sijfXLGC6sfd98XADQEdtt8ELBBU6+biiBtpaM
 dZLbhnCyFjpQYCTqUpTrtLxxHsQ0dehKO2A64PXA6TYDpxe7lmHBz5aPTjj8JwHBuoPh
 8CFoxE7Hd1wmRO+asDaWbPYi+ec9bEUQZfdJWDTioHPTSUuo0xyazVIejWJ5yqtHssg2
 K9XkdLEOZo8V2EvSdcnFrAhj2GeVoF488RmKa3UE2UXxG8b8xQDTsz7oyynEgU5W2fcu
 HlvEP5vDvIZBQVcMn+sQGsw3fsHXMpWZtNgAfWpO5t/ZMYRgiu+fUgr7+Q7V9u3sIT0k
 9c5Q==
X-Gm-Message-State: ABy/qLZRLsLo7f8dNchztqfPG7WJQ6RLV8fPu5GjUEMYHyvDiufDEpxt
 bNYmHQnh/uNna8f4TaNeWoupQNSATIrygUH7Vt+kv5M+Sf8AYibmveP1RFY05m1jugpa80B4r9/
 bKRUj2lx9Dv9fdA70VD2tMXOiz44=
X-Received: by 2002:a2e:3603:0:b0:2b6:d536:1bba with SMTP id
 d3-20020a2e3603000000b002b6d5361bbamr3012151lja.18.1689303273888; 
 Thu, 13 Jul 2023 19:54:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF9bC6sTLg1eNIbc8AE1E09OhqAEzou5kS4Cq7IDa/z5I5/4aL1mwDylTi5ZC42Z6+1RVrx+br5d+MXLTWs3U0=
X-Received: by 2002:a2e:3603:0:b0:2b6:d536:1bba with SMTP id
 d3-20020a2e3603000000b002b6d5361bbamr3012144lja.18.1689303273512; Thu, 13 Jul
 2023 19:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230704091933.496989-1-pvorel@suse.cz>
 <20230704091933.496989-2-pvorel@suse.cz>
 <20230704092536.GA497945@pevik> <ZK_m_8OuewzitKmH@yuki>
In-Reply-To: <ZK_m_8OuewzitKmH@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Jul 2023 10:54:21 +0800
Message-ID: <CAEemH2eE8PUY_at7C-aUX+75ALdM-jjm71L=M-ETYc94RKJFcg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/3] Makefile: Add C header with generated LTP
 version
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

T24gVGh1LCBKdWwgMTMsIDIwMjMgYXQgNzo1N+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBvYnZpb3VzbHkgdGhpcyBpcyB3cm9uZywgYmVjYXVz
ZSAkKHRvcF9zcmNkaXIpL1ZlcnNpb24gKGx0cC12ZXJzaW9uLmgKPiA+IGRlcGVuZGVuY3kpIGlz
IG5vdCBzcGVjaWZpZWQgaW4gdGhlIHRvcCBsZXZlbCBNYWtlZmlsZSAob25seSBWZXJzaW9uIGlz
Cj4gPiB0aGVyZSkuIEJ1dCBJJ20gbm90IHN1cmUgaWYgaXQgc2hvdWxkIGJlIGNoYW5nZWQgdG8K
PiA+ICQodG9wX3NyY2RpcikvVmVyc2lvbi4KPiA+Cj4gPiBJIHN1cHBvc2UgbHRwLXZlcnNpb24u
aCBzaG91bGQgYmUgaW4gaW5jbHVkZS8KPgo+IE5vdCByZWFsbCwgYXMgbG9uZyBhcyBpdCdzIHVz
ZWQgb25seSBpbiB0aGUgbGlicmFyeSBpdCBjYW4gc3RheSBpbiB0aGUKPiBsaWIvCj4KPiA+ICwg
YnV0IGhlcmUgSSdtIGNvbXBsZXRlbHkgbG9zdCB3aXRoIGRlcGVuZGVuY2llcyB1bmRlciBsaWIv
LiBNeSBnb2FsCj4gPiBpcyB0byB0eXBlIG1ha2UgaW4gbGliLyBhbmQgbWFrZSBzdXJlIHRoZSBo
ZWFkZXIgaXMgZ2VuZXJhdGVkCj4gPiAoZGVwZW5kZW5jaWVzIGNvcnJlY3RseSByZXNvbHZlZCku
Cj4KPiBUaGVyZSBpcyBhbm90aGVyIHByb2JsZW0gYXMgd2VsbCwgY3VycmVudGx5IHRoZSBWZXJz
aW9uIGZpbGUgaXMKPiBnZW5lcmF0ZWQgYXQgdGhlIGVuZCBvZiB0aGUgTFRQIGJ1aWxkLCB0aGF0
IG1lYW5zIGlmIHlvdSBkbyBhIGdpdCBwdWxsCj4gYW5kIG1ha2UgaXQncyBub3QgdXBkYXRlZCB1
bnRpbCB0aGUgYnVpbGQgaGFzIGZpbmlzaGVkLgo+Cj4gQWxzbyB3ZSB3aWxsIGhhdmUgdG8gcmVi
dWlsZCB0c3RfdGVzdC5jIGVhY2ggdGltZSBWZXJzaW9uIGZpbGUgaGFzIGJlZW4KPiByZXdyaXR0
ZW4sIHdoaWNoIGFjdHVhbGx5IGhhcHBlbnMgZWFjaCB0aW1lIG1ha2UgaXMgYnVpbGQgaW4gdGhl
IHRvcAo+IGxldmVsIGRpcmVjdG9yeSwgd2hpY2ggd291bGQgY2F1c2UgdXNlbGVzcyByZWJ1aWxk
cy4KPgo+IFRoZSBiZXN0IEkgY291bGQgY2FtZSB1cCB3aXRoOgo+Cj4gLS0tCj4gIGxpYi8uZ2l0
aWdub3JlICAgICB8ICAyICsrCj4gIGxpYi9NYWtlZmlsZSAgICAgICB8IDEzICsrKysrKysrKysr
KysKPiAgbGliL2dlbl92ZXJzaW9uLnNoIHwgMTYgKysrKysrKysrKysrKysrKwo+ICAzIGZpbGVz
IGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi8uZ2l0
aWdub3JlCj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSBsaWIvZ2VuX3ZlcnNpb24uc2gKPgo+IGRpZmYg
LS1naXQgYS9saWIvLmdpdGlnbm9yZSBiL2xpYi8uZ2l0aWdub3JlCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQKPiBpbmRleCAwMDAwMDAwMDAuLjE3ODg2N2E5NAo+IC0tLSAvZGV2L251bGwKPiArKysg
Yi9saWIvLmdpdGlnbm9yZQo+IEBAIC0wLDAgKzEsMiBAQAo+ICtsdHAtdmVyc2lvbi5oCj4gK2Nh
Y2hlZC12ZXJzaW9uCj4gZGlmZiAtLWdpdCBhL2xpYi9NYWtlZmlsZSBiL2xpYi9NYWtlZmlsZQo+
IGluZGV4IDliOTkwNmYyNS4uMzcxMTE5ZWRlIDEwMDY0NAo+IC0tLSBhL2xpYi9NYWtlZmlsZQo+
ICsrKyBiL2xpYi9NYWtlZmlsZQo+IEBAIC0yMCw2ICsyMCwxOSBAQCBwY19maWxlICAgICAgICAg
ICAgICAgICAgICAgIDo9Cj4gJChERVNURElSKS8kKGRhdGFyb290ZGlyKS9wa2djb25maWcvbHRw
LnBjCj4KPiAgSU5TVEFMTF9UQVJHRVRTICAgICAgICAgICAgICAgIDo9ICQocGNfZmlsZSkKPgo+
ICt0c3RfdGVzdC5vOiBsdHAtdmVyc2lvbi5oCj4gKwo+ICtsdHAtdmVyc2lvbi5oOiBnZW5fdmVy
c2lvbgo+ICsKPiArTUFLRV9UQVJHRVRTKz1nZW5fdmVyc2lvbgo+ICsKPiArLlBIT05ZOiBnZW5f
dmVyc2lvbgo+ICtnZW5fdmVyc2lvbjoKPiArICAgICAgIEBlY2hvIEdFTiBsdHAtdmVyc2lvbi5o
Cj4gKyAgICAgICBALi9nZW5fdmVyc2lvbi5zaAo+ICsKPiArQ0xFQU5fVEFSR0VUUys9bHRwLXZl
cnNpb24uaCBjYWNoZWQtdmVyc2lvbgo+ICsKPiAgJChwY19maWxlKToKPiAgICAgICAgIHRlc3Qg
LWQgIiQoQEQpIiB8fCBta2RpciAtcCAiJChARCkiCj4gICAgICAgICBpbnN0YWxsIC1tICQoSU5T
VEFMTF9NT0RFKSAiJChidWlsZGRpcikvJChARikiICIkQCIKPiBkaWZmIC0tZ2l0IGEvbGliL2dl
bl92ZXJzaW9uLnNoIGIvbGliL2dlbl92ZXJzaW9uLnNoCj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUK
PiBpbmRleCAwMDAwMDAwMDAuLjdlY2ZiOTA3Nwo+IC0tLSAvZGV2L251bGwKPiArKysgYi9saWIv
Z2VuX3ZlcnNpb24uc2gKPiBAQCAtMCwwICsxLDE2IEBACj4gKyMhL2Jpbi9zaAo+ICsKPiArdG91
Y2ggY2FjaGVkLXZlcnNpb247Cj4gKwo+ICtpZiBnaXQgZGVzY3JpYmUgPi9kZXYvbnVsbCAyPiYx
OyB0aGVuCj4gKyAgICAgICBWRVJTSU9OPWBnaXQgZGVzY3JpYmVgCj4gK2Vsc2UKPiArICAgICAg
IFZFUlNJT049YGNhdCAkKHRvcF9zcmNkaXIpL1ZFUlNJT05gCj4gK2ZpCj4gKwo+ICtDQUNIRURf
VkVSU0lPTj1gY2F0IGNhY2hlZC12ZXJzaW9uYAo+ICsKPiAraWYgWyAiJENBQ0hFRF9WRVJTSU9O
IiAhPSAiJFZFUlNJT04iIF07IHRoZW4KPiArICAgICAgIGVjaG8gIiRWRVJTSU9OIiA+IGNhY2hl
ZC12ZXJzaW9uCj4gKyAgICAgICBlY2hvICIjZGVmaW5lIExUUF9WRVJTSU9OIFwiJFZFUlNJT05c
IiIgPiBsdHAtdmVyc2lvbi5oCj4KCgpXaGF0IHdlIGFyZSBkb2luZyBpbiB0aG9zZSBlZmZvcnRz
IGlzIHRvIGhhdmUgYW4gYXZhaWxhYmxlIG1hY3JvCkxUUF9WRVJTSU9OLCByaWdodD8KClNvIHdo
eSBub3QgdXNlIHRoZSBzY3JpcHQgdG8gYXBwZW5kIHRoYXQgb25lIGxpbmUgaW4gdHN0X3Rlc3Qu
aCBkaXJlY3RseT8KVGhlIGx0cC12ZXJzaW9uLmggbG9va3MgcXVpdGUgcmVkdW5kYW50IGFuZCB3
ZSBjb3VsZCBldmVuIHB1dCB0aGlzIHNjcmlwdAppbnRvIGJ1aWxkLnNoIHRvZ2V0aGVyLCBJTUhP
LgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
