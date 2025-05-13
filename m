Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E96C3ABC3
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747140203; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2ZC/MUhsCpC9WvTDsOP/BtkYKFqD47eIt8Fu8b50NG8=;
 b=Vb6K6EQVNYzAvhFXjnD4yBIqn4AShU1Bkd6bQ+hhUKPy2LK6VbeRutfpimuj5pM5jKfYK
 lqcZ2uuIVwpr7IQ8QdzxuQu+PptwhLqt1kgvtJwfrSB27qVR4zrlOJ3XLRDE0dF/OLB0m+m
 UciR6UsnkZtRqGJJfhkQZ/LfxVu5mE8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3110E3CC33C
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 14:43:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 392DD3CA312
 for <ltp@lists.linux.it>; Tue, 13 May 2025 14:43:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 334AA1400DB0
 for <ltp@lists.linux.it>; Tue, 13 May 2025 14:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747140179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDRCKdbr77f9Ef659aSMF79VhNn9SZYsXw30Vro1Bi4=;
 b=Aaqi3MZBTtw3OYO/sjouEJGhrn1dLBJV39Qf/WQbQekyTpIZAisxqhRYwZGn06Fh9H8fYM
 2QoWmkMKU4cjxeH4qurncmyJcfNgDAax6M5YdV56bwOzADWRNA2YENEY5puC86r2YdxwJ2
 E8TKhN+/har5K/f2aJpAItkaRNxKpD4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-u1GiMjl0PL6tTsJXej2_Cg-1; Tue, 13 May 2025 08:42:57 -0400
X-MC-Unique: u1GiMjl0PL6tTsJXej2_Cg-1
X-Mimecast-MFC-AGG-ID: u1GiMjl0PL6tTsJXej2_Cg_1747140176
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22fc829046fso46294035ad.2
 for <ltp@lists.linux.it>; Tue, 13 May 2025 05:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747140176; x=1747744976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDRCKdbr77f9Ef659aSMF79VhNn9SZYsXw30Vro1Bi4=;
 b=sqGqTruxW6m4uwgtxInYhdlW7rKvPRG9ED6jvuQguyb5ae7Jp1WmMRc4p4I8rb9/Dz
 ahoJt8GP5ptHuz4LfVF4C+gGkdTxFUaYIvDZGD28J54oNpPO7eWQhrQZFd3g1e127ooh
 u+Ptdg4OJu7w4SCn62Q6dN4RQ4FYw6jr288x/30nizCyyjYvSJO7setK4KXHwJRLXbfS
 SbL3q+sd+oChQ2tuoeMchEjjnUxv9cRMhsqXBZeAHqlRArTxxQKWVGOWMgnuQXBsbVvl
 BXCKIO7t4iD7+IvdUmzRzygeabkmatShq4XxOkSTtKuzZ7IptUMsxrE+LEFFFARMYYXW
 a2Hg==
X-Gm-Message-State: AOJu0Yz245rsfjpqbGKwP91DnJDrdALzNQPf5KjcUbxwfpIOkFBd/L10
 XmzF8bG8c/Gg67w6P0bgJf7KkA501do+fs3Z1gJhcaSqIfNQ0nH6U3LSQFMqLsC579NHINlmMwb
 GQyy1zZObso2HTwFUzxVGP/xKGTMrUH1LxH622oXL7od3PFVE0QtAqZZEl/sHTz6WStdA/QWmjq
 ytammNcWUj0NbmH+hBkAu8Kpw=
X-Gm-Gg: ASbGncvn9e9VNWm4lDDRaQZtAWYquvuKPXLoEfwaEO0FuyrtVbE35FSIBD8Bt8poElH
 bXyTRBteM6//6kN5uctJJgS+r/zMhKcaPe9IxVBLAOckRz4CC1w8hpefi9SR9WmWpWtygWg==
X-Received: by 2002:a17:902:e84d:b0:22e:17ee:aa69 with SMTP id
 d9443c01a7336-22fc91a8871mr239665295ad.50.1747140176431; 
 Tue, 13 May 2025 05:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXMblKo5hUcKmd/kITQq89LNQaPAZtC82Ygx1DaRocBJP7ub81+/59PBciw7d0E2jlOQsTuVJtBk8MV26hDAQ=
X-Received: by 2002:a17:902:e84d:b0:22e:17ee:aa69 with SMTP id
 d9443c01a7336-22fc91a8871mr239664945ad.50.1747140176055; Tue, 13 May 2025
 05:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250513050530.47541-1-liwang@redhat.com>
 <aCM2PrCrCdPqNIGc@yuki.lan>
In-Reply-To: <aCM2PrCrCdPqNIGc@yuki.lan>
Date: Tue, 13 May 2025 20:42:43 +0800
X-Gm-Features: AX0GCFt9wEZ2lFn7g5JufL0ObZ9hqgGX5CCVA3Rbsb-ec1RmXl75bvtcLe2myzw
Message-ID: <CAEemH2cP78yxJEWi-Z_v=EuXWP+6XDQBNnGMVHKq3pYLiGQRdw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AySAmH5ais7qwD1D70osBdeTpim2ZS8yOxElRDFu1g8_1747140176
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
 setup_ipc
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

T24gVHVlLCBNYXkgMTMsIDIwMjUgYXQgODowOOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gVG8gZ2V0IHJpZCBvZiBmYWlsdXJlIGZyb20gZ2l0
aHViIENJLgo+ID4KPiA+IENJIFRlc3QgSm9iOiBodHRwczovL2dpdGh1Yi5jb20vd2FuZ2xpNTY2
NS9sdHAvYWN0aW9ucy9ydW5zLzE0OTg4NTMwMjA1Cj4gPgo+ID4gRm9sbG93LXVwLWZpeDogY29t
bWl0IGI5ODdiOGFjNSAoImxpYjogY2hpbGQgcHJvY2VzcyBleGl0IHdpdGggZXJyb3IgZHVlIHRv
IHVuaW5pdGlhbGl6ZWQgbGliX3BpZCIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIGxpYi90c3RfdGVzdC5jIHwgMTUgKysrKysrKyst
LS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF90ZXN0LmMgYi9saWIvdHN0X3Rlc3QuYwo+
ID4gaW5kZXggYjY2NjcxNWI5Li45ZjExYzFjNDcgMTAwNjQ0Cj4gPiAtLS0gYS9saWIvdHN0X3Rl
c3QuYwo+ID4gKysrIGIvbGliL3RzdF90ZXN0LmMKPiA+IEBAIC01OSw3ICs1OSw2IEBAIHN0YXRp
YyBjb25zdCBjaGFyICp0aWQ7Cj4gPiAgc3RhdGljIGludCBpdGVyYXRpb25zID0gMTsKPiA+ICBz
dGF0aWMgZmxvYXQgZHVyYXRpb24gPSAtMTsKPiA+ICBzdGF0aWMgZmxvYXQgdGltZW91dF9tdWwg
PSAtMTsKPiA+IC1zdGF0aWMgcGlkX3QgbGliX3BpZDsKPiA+ICBzdGF0aWMgaW50IG1udHBvaW50
X21vdW50ZWQ7Cj4gPiAgc3RhdGljIGludCBvdmxfbW91bnRlZDsKPiA+ICBzdGF0aWMgc3RydWN0
IHRpbWVzcGVjIHRzdF9zdGFydF90aW1lOyAvKiB2YWxpZCBvbmx5IGZvciB0ZXN0IHBpZCAqLwo+
ID4gQEAgLTE0Myw3ICsxNDIsOSBAQCBzdGF0aWMgdm9pZCBzZXR1cF9pcGModm9pZCkKPiA+ICAg
ICAgICAgICAgICAgdHN0X2Z1dGV4ZXMgPSAoY2hhciAqKXJlc3VsdHMgKyBzaXplb2Yoc3RydWN0
IHJlc3VsdHMpOwo+ID4gICAgICAgICAgICAgICB0c3RfbWF4X2Z1dGV4ZXMgPSAoc2l6ZSAtIHNp
emVvZihzdHJ1Y3QgcmVzdWx0cykpL3NpemVvZihmdXRleF90KTsKPiA+ICAgICAgIH0KPiA+IC0g
ICAgIHJlc3VsdHMtPmxpYl9waWQgPSBsaWJfcGlkOwo+ID4gKwo+ID4gKyAgICAgcmVzdWx0cy0+
bGliX3BpZCA9IDA7Cj4gPiArICAgICByZXN1bHRzLT5tYWluX3BpZCA9IDA7Cj4gPiAgfQo+ID4K
PiA+ICBzdGF0aWMgdm9pZCBjbGVhbnVwX2lwYyh2b2lkKQo+ID4gQEAgLTM5NCw3ICszOTUsNyBA
QCB2b2lkIHRzdF92YnJrXyhjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCBpbnQg
dHR5cGUsIGNvbnN0IGNoYXIgKmZtdCwKPiA+ICAgICAgICAqIElmIHRzdF9icmsoKSBpcyBjYWxs
ZWQgZnJvbSBzb21lIG9mIHRoZSBDIGhlbHBlcnMgZXZlbiBiZWZvcmUgdGhlCj4gPiAgICAgICAg
KiBsaWJyYXJ5IHdhcyBpbml0aWFsaXplZCwganVzdCBleGl0Lgo+ID4gICAgICAgICovCj4gPiAt
ICAgICBpZiAoIXJlc3VsdHMtPmxpYl9waWQpCj4gPiArICAgICBpZiAoIXJlc3VsdHMgfHwgIXJl
c3VsdHMtPmxpYl9waWQpCj4gPiAgICAgICAgICAgICAgIGV4aXQoVFRZUEVfUkVTVUxUKHR0eXBl
KSk7Cj4gPgo+ID4gICAgICAgdXBkYXRlX3Jlc3VsdHMoVFRZUEVfUkVTVUxUKHR0eXBlKSk7Cj4g
PiBAQCAtMTMzNCw2ICsxMzM1LDggQEAgc3RhdGljIHZvaWQgZG9fc2V0dXAoaW50IGFyZ2MsIGNo
YXIgKmFyZ3ZbXSkKPiA+ICAgICAgICAgICAgICAgdHN0X3Rlc3QtPmZvcmtzX2NoaWxkID0gMTsK
PiA+ICAgICAgIH0KPiA+Cj4gPiArICAgICBzZXR1cF9pcGMoKTsKPiA+ICsKPiA+ICAgICAgIGlm
ICh0c3RfdGVzdC0+bmVlZHNfa2NvbmZpZ3MgJiYgdHN0X2tjb25maWdfY2hlY2sodHN0X3Rlc3Qt
Pm5lZWRzX2tjb25maWdzKSkKPiA+ICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIkFib3J0
aW5nIGR1ZSB0byB1bnN1aXRhYmxlIGtlcm5lbCBjb25maWcsIHNlZSBhYm92ZSEiKTsKPiA+Cj4g
PiBAQCAtMTM5Myw4ICsxMzk2LDYgQEAgc3RhdGljIHZvaWQgZG9fc2V0dXAoaW50IGFyZ2MsIGNo
YXIgKmFyZ3ZbXSkKPiA+ICAgICAgIGlmICh0c3RfdGVzdC0+aHVnZXBhZ2VzLm51bWJlcikKPiA+
ICAgICAgICAgICAgICAgdHN0X3Jlc2VydmVfaHVnZXBhZ2VzKCZ0c3RfdGVzdC0+aHVnZXBhZ2Vz
KTsKPiA+Cj4gPiAtICAgICBzZXR1cF9pcGMoKTsKPiA+IC0KPgo+IEkgc3VwcG9zZSB0aGF0IHRo
aXMgaGFzIHRvIGdvIGJlZm9yZSB0aGUgdHN0X3Jlc2VydmVfaHVnZXBhZ2VzKCkgc28gdGhhdAo+
IHdlIGhhdmUgcmVzdWx0cy0+bGliX3BpZCBkZWZpbmVkIGFuZCBwcm9wZXJseSBjbGVhbiB1cCBh
ZnRlciB0aGUKPiBodWdlcGFnZXMuIEhvd2V2ZXIgZm9yIHRoYXQgdG8gd29yayB3ZSBoYXZlIHRv
IHNldCB0aGUKPiByZXN1bHRzLT5saWJfcGlkIGRpcmVjdGx5IGluIHRoZSBzZXR1cF9pcGMoKS4K
CkluIHRoaXMgcGF0Y2gsIHNldHVwX2lwYygpIGlzIGFscmVhZHkgbW92ZWQgdXAgYmVmb3JlIHRo
ZQp0c3RfcmVzZXJ2ZV9odWdwYWdlcygpLiBJIHBhcnRpY3VsYXJseSBwdXQgaXQgYWZ0ZXIgdHN0
X3Rlc3QtPnJ1bnNfc2NyaXB0cywKd2hpY2ggaXMgbWFuZGF0b3J5IHRvIGhhdmUgLmNoaWxkX25l
ZWRzX3JlaW5pdCBpbml0aWFsaXplZCBmaXJzdC4KCkFuZCB0aGUgaHVncGFnZXMgY2xlYW51cCB3
b3JrIGlzIGNvbXBsZXRlZCBpbiB0c3Rfc3lzX2NvbmZfcmVzdG9yZSgwKQppbiB0aGUgZG9fY2xl
YW51cCwgc28gdGhhdCBtaWdodCBub3QgYmUgYSBwcm9ibGVtLgpJIGhhdmUgdmFsaWRhdGVkIHRo
YXQgYWxsIGh1Z2V0bGIgdGVzdHMgd29yayB3ZWxsLgoKQWxzbywKCk9yLCBkaWQgSSBtaXNzIGFu
eXRoaW5nPwoKPgo+ID4gICAgICAgaWYgKHRzdF90ZXN0LT5idWZzKQo+ID4gICAgICAgICAgICAg
ICB0c3RfYnVmZmVyc19hbGxvYyh0c3RfdGVzdC0+YnVmcyk7Cj4gPgo+ID4gQEAgLTE5MjksMTAg
KzE5MzAsMTEgQEAgdm9pZCB0c3RfcnVuX3RjYXNlcyhpbnQgYXJnYywgY2hhciAqYXJndltdLCBz
dHJ1Y3QgdHN0X3Rlc3QgKnNlbGYpCj4gPiAgICAgICB1bnNpZ25lZCBpbnQgdGVzdF92YXJpYW50
cyA9IDE7Cj4gPiAgICAgICBzdHJ1Y3QgdXRzbmFtZSB1dmFsOwo+ID4KPiA+IC0gICAgIGxpYl9w
aWQgPSBnZXRwaWQoKTsKPiA+ICAgICAgIHRzdF90ZXN0ID0gc2VsZjsKPiA+Cj4gPiAgICAgICBk
b19zZXR1cChhcmdjLCBhcmd2KTsKPiA+ICsKPiA+ICsgICAgIHJlc3VsdHMtPmxpYl9waWQgPSBn
ZXRwaWQoKTsKPgo+IFNldHRpbmcgaXQgaGVyZSBpcyB0b28gbGF0ZS4KClNpbmNlIEkgYWRkZWQg
cmVzdWx0cyBleGlzdHMgY2hlY2sgaW4gdHN0X3ZicmtfKCksIHNvIGl0IHNob3VsZCBiZSBzYWZl
CmVub3VnaCB0byBzZXQgbGliX3BpZCBqdXN0IGFmdGVyIHNldHVwX2lwYygpIHdoYXRldmVyIHRo
ZSBjbGVhbnVwIHdvcmsKaGFwcGVuIGVhcmx5IG9yIGxhdGVyIGluIHRlc3QgbGliLgoKaWYgKCFy
ZXN1bHRzIHx8ICFyZXN1bHRzLT5saWJfcGlkKQogICAgZXhpdChUVFlQRV9SRVNVTFQodHR5cGUp
KTsKCgo+Cj4gT3RoZXIgdGhhbiB0aGF0IHRoZSBwYXRjaCBsb29rcyBnb29kIHRvIG1lLgo+Cj4g
LS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKCi0tIApSZWdhcmRzLApMaSBX
YW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
