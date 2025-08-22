Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1903ACA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 08:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755851553; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=afA/3/ad3eXf8OBQiZQ2iKiRuXaT4xmMg5q6c5P2i+4=;
 b=fSbZ8d7d/ET+vJWY2qSHzTxEXp7LNIUG6z+Oqec52mtIzqAzGiCxLzLkQYlz+D491MNiI
 Ww0M/+xjTfzAlKtP43YqLnVyNSDZe8qo48SYQOMYq8pSZJQwWHCMpY2h+sL8EkSy3LuI10C
 531Qhq9brxRZKI8ovLucDZjzmbKdKoI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DD243CCE54
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 10:32:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 074113CC93F
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 10:32:11 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55C7A140013A
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 10:32:11 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-afcb731ca8eso298262866b.0
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755851531; x=1756456331; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3ZNexLe3/W/78xjJBDicdJj+RdPhBeyD9t/3bkdLXR8=;
 b=UuGuXkZUyD7EtPJlE++yUv8JxYpGxB/FiEfBmaJlcaFBIwaC5x+VYPmOAeC5d2cycb
 9niMYFzICnXcca51tvexR58AV4ymxl7rGZTOjRUoj83+sUnFAl+ElI2FPnxdQjWQlZOM
 bvX4TUmIIJA5xFH1C6g6q+2eLIOgA5IZn2QTIOFUBNlnROvNgkeSofiYFtyndFWl6f4s
 pU0zKCow8LtDoxHPnF0AWAET5v+kDPDkE5ASzuO5fhi9qn9DqsvYLUgcUhnthwNEH0XN
 5Fot3qSy0KCp+Jzpjtv4ceed2hEX4pnZudlUj6r7joYttytor2zACLfdtjAR8PBAQ0Vu
 H7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755851531; x=1756456331;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZNexLe3/W/78xjJBDicdJj+RdPhBeyD9t/3bkdLXR8=;
 b=YeJpXO4niI+cRtDCPPpWuQkR0U7GlYrYBh/MbuqkcscMnNTNwnEXcxjVxr9Yy51idE
 2RpmjkHL5kKwEIcicj4Yugqr5MD8lnoCg6nWE3iFuDGlbG0Q/HD7DDCanBf+/4oiFBGF
 503HZC119BEGsIx9TmeG0yFSuK2gHk4NpBHtKZYl8XuTjP6dmRBugKjd0whhUb9WEAL+
 OImbJWDgbn3q42GvUk+J0CLM5V7QFqFpDB8gWoll91+WPV84fxyTw6lWIefc8U45tmF1
 nsoyABSWWPIQfR1opCV8gcZbz+KugTYiWMd17D3YSDY7gLctX0eEWMOGRCPtwC5OUEIu
 ozyg==
X-Gm-Message-State: AOJu0YyuHFw4UKReYztC5YtF6sBKn6rt9BeKPcAqxKLW5rN78HJpOkWt
 dVsXz29+JdMkO7UICvqiawCjDIYsqIyjGuYdal/wV3qx6+8UTq4XXMIz9ghfSQpPoQ==
X-Gm-Gg: ASbGncs61PVnWQ5PzSh1b/L7TU9I+/bNSW26O7XpMWj2Hj9Bp3VYlFjl9IkV+p0kOZH
 P+uamS1GNELa/qFaoyZ5d/nwuwvx+gtHNWeXEZmdNJOOtj9FNL6ydCAqGwkJ9giFPKka3QxutDv
 kEzYNpP8YIweS/v8euj2kOKUZB8JLNQnPmXy+87IUTWcwAUJ754me2k+crildE5tQG55ly9/1kg
 F++TA66sdzlToCeon59fK3HQ3tr6dqRXVCVqwoEY7jx1fQT28msWLI5EfH9gtZ/wp+cQvPsCe1T
 D1ayV0r/Z/bhLVtzGT6iIe/+at+OGTE7v/bHJy3Q7YMNboqAQzwyqojLn+mXRgKq+fUBX8vQZBX
 VX/o4T2/hIkVRL7PQxJbqFqO9Yoa2BJjQmWbju46l54o=
X-Google-Smtp-Source: AGHT+IG257kIWOuSGFjuzHlkf4GKiJTKR6DUagWAKYSrGk2GPiBnvxCqeYBa6DEf9crOlvgoPRbCxw==
X-Received: by 2002:a17:907:7f0c:b0:ae0:d8f2:9065 with SMTP id
 a640c23a62f3a-afe294d99bfmr198457366b.39.1755851530489; 
 Fri, 22 Aug 2025 01:32:10 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afded3070dbsm548532266b.46.2025.08.22.01.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 01:32:10 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:32:08 +0000
To: Li Wang <liwang@redhat.com>
Message-ID: <aKgrCMBfWsOzcwAb@localhost>
References: <CAEemH2fM4vHRdgHh62krquK5CFuHvpKdJtj--S6Vvt_i0xRBFw@mail.gmail.com>
 <20250822074811.2192404-1-liwang@redhat.com>
 <aKgkLd9SIJc3YcHZ@localhost>
 <CAEemH2dzFP75VXDLu=ZynXML9EfK-zY10Sd_+0g34zT=ywCkVw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dzFP75VXDLu=ZynXML9EfK-zY10Sd_+0g34zT=ywCkVw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] mount: check path exists before
 tst_is_mounted in cleanup
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMjIsIDIwMjUgYXQgMDQ6MTI6MjBQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBGcmksIEF1ZyAyMiwgMjAyNSBhdCA0OjAz4oCvUE0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5j
b20+IHdyb3RlOgo+IAo+ID4gT24gRnJpLCBBdWcgMjIsIDIwMjUgYXQgMDM6NDg6MTFQTSArMDgw
MCwgTGkgV2FuZyB2aWEgbHRwIHdyb3RlOgo+ID4gPiB0c3RfaXNfbW91bnRlZCgpIG5vdyBpbnRl
cm5hbGx5IHJlc29sdmVzIHRoZSBtb3VudCBwYXRoIHZpYSByZWFscGF0aCgpLAo+ID4gPiB3aGlj
aCB3aWxsIGZhaWwgaWYgdGhlIHBhdGggZG9lcyBub3QgZXhpc3QuIEluIHNvbWV0ZXN0IChlLmcu
IG1vdW50MDUpLAo+ID4gPiBNTlRQT0lOVDIgbWF5IG5vdCBleGlzdCB5ZXQgZHVyaW5nIGNsZWFu
dXAsIGNhbGxpbmcgdHN0X2lzX21vdW50ZWQoKQo+ID4gPiBkaXJlY3RseSBjb3VsZCBwcm9kdWNl
IG1pc2xlYWRpbmcgd2FybmluZ3Mgb3IgZXJyb3JzLgo+ID4gPgo+ID4gPiBBZGQgYW4gZXhwbGlj
aXQgYWNjZXNzKFBBVEgsIEZfT0spIGNoZWNrIGJlZm9yZSBjYWxsaW5nIHRzdF9pc19tb3VudGVk
KCkKPiA+ID4gaW4gdGhlIGNsZWFudXAsIGVuc3VyaW5nIHdlIG9ubHkgcXVlcnkgbW91bnRzIGZv
ciBleGlzdGluZyBwYXRocy4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3
YW5nQHJlZGhhdC5jb20+Cj4gPiA+IC0tLQo+ID4gPgo+ID4gPiBOb3RlczoKPiA+ID4gICAgIHYx
IC0tPiB2MjoKPiA+ID4gICAgICAgICAgICAgcGF0Y2ggMS8yLCBrZWVwIG5vIGNoYW5nZSwgZG8g
bm90IHNlbmQgdjIuCj4gPiA+ICAgICAgICAgICAgIHBhdGNoIDIvMiwgYWRkaW5nIHR3byBtb3Jl
IGZpbGVzIGZvciBwYXRoIGV4aXN0IGNoZWNrCj4gPiA+Cj4gPiA+ICB0ZXN0Y2FzZXMva2VybmVs
L2NvbnRhaW5lcnMvbXFucy9tcW5zXzAzLmMgfCAyICstCj4gPiA+ICB0ZXN0Y2FzZXMva2VybmVs
L2NvbnRhaW5lcnMvbXFucy9tcW5zXzA0LmMgfCAyICstCj4gPiA+ICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL21vdW50L21vdW50MDUuYyAgfCAyICstCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiA+IFN0aWxsIG1vcmUgdGVzdCBjYXNl
IG5lZWQgdXBkYXRlIHN1Y2ggYXMgZm9sbG93aW5nPwo+ID4gICAxMyAgICAxMTEgIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMi5jIDw8Y2xlYW51cD4+Cj4gPiAgICAgICAg
ICAgICAgaWYgKHRzdF9pc19tb3VudGVkKE1OVFBPSU5UKSkKPiA+ICAgMTQgICAgMjAyICB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMuYyA8PGNsZWFudXA+Pgo+ID4gICAg
ICAgICAgICAgIGlmICh0c3RfaXNfbW91bnRlZChNTlRQT0lOVCkpCj4gPiAgIDE1ICAgICAyMSAg
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDA0LmMgPDxjbGVhbnVwPj4KPiA+
ICAgICAgICAgICAgICBpZiAodHN0X2lzX21vdW50ZWQoTU5UUE9JTlQpKQo+ID4KPiAKPiBJIHdh
c24ndCBlbmNvdW50ZXJpbmcgdGhlc2UgdGVzdCBmYWlsdXJlcyBvbiB0aGF0LCB0aGUgcHJvYmxl
bQo+IG9ubHkgYXBwZWFycyB3aGVuIHRoZSBtb3VudGVkIHBhdGggaXMgZGVsZXRlZCBieSB0ZXN0
Lgo+IAo+IERpZCB5b3UgdGVzdCBhbmQgZ2V0IGFueXRoaW5nIGFibm9ybWFsIG9uIHlvdXIgc2lk
ZT8KUXVpY2sgdXNlIHlvdXIgcGF0Y2ggY2hlY2sgbW91bnQwMi8zLzQgbm8gaXNzdWUgaGFwcGVu
Lgo+IAo+IAo+ID4KPiA+IE1heWJlIHdlIGNhbiBqdXN0IHJlcG9ydCB3YXJuaW5nIGluc3RlYWQg
b2YgZXJyb3I/Cj4gPgo+IAo+IEl0IGlzIFdhcm5pbmcgYnV0IG5vdCBhbiBlcnJvciwgdGhlICdU
RVJSTk8nIGlzIG9ubHkgdXNlIHRvCj4gc2hvdyB0aGUgZXJybm8gZm9yIGJldHRlciBkZWJ1Z2dp
bmcuCj4gCj4gICB0c3RfZGV2aWNlLmM6NDQwOiBUV0FSTjogcmVhbHBhdGgobW50cG9pbnQyKSBm
YWlsZWQ6IEVOT0VOVCAoMikKU29ycnkgaSB0aG91Z2h0IHRoaXMgd2lsbCBnaXZlIGFuIGVycm9y
IDopCj4gCj4gCj4gCj4gPgo+ID4gLS0tIGEvbGliL3RzdF9kZXZpY2UuYwo+ID4gKysrIGIvbGli
L3RzdF9kZXZpY2UuYwo+ID4gQEAgLTQ4MSw3ICs0ODEsNyBAQCBzdGF0aWMgaW50IHRzdF9tb3Vu
dF9oYXNfb3B0KGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0Cj4gPiBjaGFyICpvcHQpCj4gPiAgICAg
ICAgIGNoYXIgYWJzcGF0aFtQQVRIX01BWF07Cj4gPgo+ID4gICAgICAgICBpZiAoIXJlYWxwYXRo
KHBhdGgsIGFic3BhdGgpKSB7Cj4gPiAtICAgICAgICAgICAgICAgdHN0X3Jlc20oVFdBUk4gfCBU
RVJSTk8sICJyZWFscGF0aCglcykgZmFpbGVkIiwgcGF0aCk7Cj4gPiArICAgICAgICAgICAgICAg
dHN0X3Jlc20oVFdBUk4sICJyZWFscGF0aCglcykgZmFpbGVkIiwgcGF0aCk7Cj4gPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7Cj4gPiAgICAgICAgIH0KPiA+Cj4gPiA+Cj4gPiA+IGRpZmYgLS1n
aXQgYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbXFucy9tcW5zXzAzLmMKPiA+IGIvdGVz
dGNhc2VzL2tlcm5lbC9jb250YWluZXJzL21xbnMvbXFuc18wMy5jCj4gPiA+IGluZGV4IDRkM2Jm
YzUyZi4uYWM4MzExNTU5IDEwMDY0NAo+ID4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRh
aW5lcnMvbXFucy9tcW5zXzAzLmMKPiA+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250YWlu
ZXJzL21xbnMvbXFuc18wMy5jCj4gPiA+IEBAIC0xMzAsNyArMTMwLDcgQEAgc3RhdGljIHZvaWQg
Y2xlYW51cCh2b2lkKQo+ID4gPiAgICAgICBpZiAoIWFjY2VzcyhNUVVFVUUyLCBGX09LKSkKPiA+
ID4gICAgICAgICAgICAgICBTQUZFX01RX1VOTElOSyhNUU5BTUUyKTsKPiA+ID4KPiA+ID4gLSAg
ICAgaWYgKHRzdF9pc19tb3VudGVkKERFVkRJUikpCj4gPiA+ICsgICAgIGlmICghYWNjZXNzKERF
VkRJUiwgRl9PSykgJiYgdHN0X2lzX21vdW50ZWQoREVWRElSKSkKPiA+ID4gICAgICAgICAgICAg
ICBTQUZFX1VNT1VOVChERVZESVIpOwo+ID4gPiAgfQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL21xbnMvbXFuc18wNC5jCj4gPiBiL3Rlc3RjYXNl
cy9rZXJuZWwvY29udGFpbmVycy9tcW5zL21xbnNfMDQuYwo+ID4gPiBpbmRleCBkMjhjMzMwYzQu
Ljc5MDYwN2VjZCAxMDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJz
L21xbnMvbXFuc18wNC5jCj4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9t
cW5zL21xbnNfMDQuYwo+ID4gPiBAQCAtMTIzLDcgKzEyMyw3IEBAIHN0YXRpYyB2b2lkIGNsZWFu
dXAodm9pZCkKPiA+ID4gICAgICAgaWYgKCFhY2Nlc3MoTVFVRVVFMiwgRl9PSykpCj4gPiA+ICAg
ICAgICAgICAgICAgU0FGRV9NUV9VTkxJTksoTVFOQU1FMik7Cj4gPiA+Cj4gPiA+IC0gICAgIGlm
ICh0c3RfaXNfbW91bnRlZChERVZESVIpKQo+ID4gPiArICAgICBpZiAoIWFjY2VzcyhERVZESVIs
IEZfT0spICYmIHRzdF9pc19tb3VudGVkKERFVkRJUikpCj4gPiA+ICAgICAgICAgICAgICAgU0FG
RV9VTU9VTlQoREVWRElSKTsKPiA+ID4gIH0KPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwNS5jCj4gPiBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwNS5jCj4gPiA+IGluZGV4IDY2ZTEwMmEzMi4uNTU4NWUy
MzBlIDEwMDY0NAo+ID4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21v
dW50MDUuYwo+ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50
MDUuYwo+ID4gPiBAQCAtMzUsNyArMzUsNyBAQCBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4g
PiA+ICAgICAgIGlmICh0c3RfaXNfbW91bnRlZChNTlRQT0lOVDEpKQo+ID4gPiAgICAgICAgICAg
ICAgIFNBRkVfVU1PVU5UKE1OVFBPSU5UMSk7Cj4gPiA+Cj4gPiA+IC0gICAgIGlmICh0c3RfaXNf
bW91bnRlZChNTlRQT0lOVDIpKQo+ID4gPiArICAgICBpZiAoIWFjY2VzcyhNTlRQT0lOVDIsIEZf
T0spICYmIHRzdF9pc19tb3VudGVkKE1OVFBPSU5UMikpCj4gPiA+ICAgICAgICAgICAgICAgU0FG
RV9VTU9VTlQoTU5UUE9JTlQyKTsKPiA+ID4gIH0KPiA+ID4KPiA+ID4gLS0KPiA+ID4gMi40OS4w
Cj4gPiA+Cj4gPiA+Cj4gPiA+IC0tCj4gPiA+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+ID4KPiA+Cj4gCj4gLS0gCj4gUmVnYXJkcywKPiBM
aSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
