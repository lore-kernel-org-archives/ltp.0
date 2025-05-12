Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D43C3ABCB
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747061980; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WFlGCUDxL6/DViyx2eXjyZkvL9Dvv+X29LP6+T/aMHY=;
 b=ZoG3Rp9lz4GRqvdt8iETKttxB6ZOOE3e776Qzd3aO34JFmq/71CBaRNopTlRpiE+Ae9mK
 UmnXakDhU3tnP5KH/B/HwGKS1Og6Pkrlp42K2+VmZ14ziX9YJE1yDwl8iUJVk7VAtBN89Pj
 fAZ55JmkJCej3OQQc1qScjmNQbPSY64=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39C133CC2CD
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 16:59:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 267593CC2AD
 for <ltp@lists.linux.it>; Mon, 12 May 2025 16:59:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E519B10008E0
 for <ltp@lists.linux.it>; Mon, 12 May 2025 16:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747061956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=smyDcU9cyGIj+FiKFPd27lwHeIECWqLCyWFnCQWzlVg=;
 b=EMj/u2OUgMoCeHecI5GPyQS1sJrG4BRXttmuzuG5CTKlZ8r+CqlhSi5mNMg4E54c3QroLn
 mE7Wy0tdHzjwS/geqEg2lRaR7WdKhGMJ50eyUQ1eTsb/0vxN0Ru1oc15ItDPiE457W9fEG
 YsetBWda5XEpzk4k9jo5xA/Qgzobioo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-vRKyn3H6MNuwt2f7yikwmQ-1; Mon, 12 May 2025 10:59:14 -0400
X-MC-Unique: vRKyn3H6MNuwt2f7yikwmQ-1
X-Mimecast-MFC-AGG-ID: vRKyn3H6MNuwt2f7yikwmQ_1747061953
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22fc829046fso35535795ad.2
 for <ltp@lists.linux.it>; Mon, 12 May 2025 07:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747061953; x=1747666753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smyDcU9cyGIj+FiKFPd27lwHeIECWqLCyWFnCQWzlVg=;
 b=oogy1JuQIgclgle6Pl0QdT3RroiYyDxN7pqkySu4Hhf/4CUaELPTbw3SNOjz3HCyOh
 paqnXAgnbeAKycY1es5A+JTthZ0CSGkTZpiTmUlLzyViqytnfD5h1Qj0ZVazIh+F+wxb
 P4EjzSN3YZDh/FK1kW8LAy6LllyvK0/IYIm87ysYau2Ub0gxbZzX7aexlWs71nWDD58A
 gOtdRKllnAPKyHTa0f0/564jWtDH3j4UBu3izM4+gu2tcHPATNbKrNl0u1Yl2I7z2aZo
 xjcQ7VwzGK+h7Mqxc7XiqX8k0rn6XCAMb4JtciO+16DjKnRPJ/o7fnUUKX9AL5oB5Vrk
 faOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3f3pFr2H0wTWDKcjyY9jiHdpkqDoJCpq9bOJiOihZmY3kI5WhauJxLYIh2YskQy6XEwk=@lists.linux.it
X-Gm-Message-State: AOJu0YxHk5RM6efgfKrdQlTVbjCnYiDk5E1/Kfe7dPjDPo0lHD9ISB9g
 ncO1+pKrjpV7G8OKLsvvyrOZZgAtWKkSGsl+y/8CLhFSas/y2daB+mbsc5BpLDirZUbH3+oTwjo
 JKihTtghrzIPc51akmsuOnfLpr4rZl6hKG92cjYOcOtPdYz1vm9IO+uhjPhfWMzAVUo+gQjZRKC
 AIE0zlGdRGQdjKngtd5LMkLBc=
X-Gm-Gg: ASbGncuLlaNs2tWr9sH/PV4Nlj8kEuHv5MFQBFzD9g6xUlQ3BU8DVQarPSDSiIIz9rR
 mXmcHy3pHxdYLZihVH6yEgCxPnH1NY0vJrnfOKxnp5N3d/1GlbIEX4TExgDFBF5dZqFwlmg==
X-Received: by 2002:a17:902:e84d:b0:22e:17ee:aa69 with SMTP id
 d9443c01a7336-22fc91a8871mr192170965ad.50.1747061952911; 
 Mon, 12 May 2025 07:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW1O8JZmQRaR2ydvx67PahwHljnq+tryp3Fm8Jhaqa1/vv/l8ACtHVpEyJ+u+KOSiyRbtkyunKWzeCQfPye4s=
X-Received: by 2002:a17:902:e84d:b0:22e:17ee:aa69 with SMTP id
 d9443c01a7336-22fc91a8871mr192170625ad.50.1747061952558; Mon, 12 May 2025
 07:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250510205326.1353857-1-wegao@suse.com>
 <CAEemH2cJHz3aLRi0HeSvJWy=XvPMfJ_nv0F7=L7P2ubn8-zv5A@mail.gmail.com>
 <20250512063346.GA290759@pevik>
In-Reply-To: <20250512063346.GA290759@pevik>
Date: Mon, 12 May 2025 22:58:59 +0800
X-Gm-Features: AX0GCFsALrXfTLMOjZJMyaKa4ecdjidbV_G5AT8Sg65PmSdzsoo_JGW0I_E6WYk
Message-ID: <CAEemH2d3_0Ep--e7yrMPihPWTU9Akgyxch5BdMJoNa8Aghkjdg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aepc9-ex7IZxV5_Eo-9eUCnSqzhNtZQxk1zwBDWvKik_1747061953
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] Fix: dirtyc0w_shmem child process exit with
 error due to uninitialized lib_pid
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

T24gTW9uLCBNYXkgMTIsIDIwMjUgYXQgMjozNOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBPbiBTYXQsIE1heSAxMCwgMjAyNSBhdCA0OjU04oCvUE0gV2VpIEdh
byB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+Cj4gd3JvdGU6Cj4KPiA+ID4gVGhlIGRpcnR5
YzB3X3NobWVtIHRlc3Qgc3Bhd25zIGEgY2hpbGQgcHJvY2VzcyB1c2luZyBleGVjbHAuIFRoaXMK
PiBjaGlsZCBwcm9jZXNzIHRoZW4gY2FsbHMgdHN0X2JyaygpLCB3aGljaCBleGl0cyBlYXJseQo+
ID4gPiB3aXRoIGEgbm9uLXplcm8gc3RhdHVzIGJlY2F1c2UgZXhlY2xwIGRvZXMgbm90IGluaGVy
aXQgdGhlIHBhcmVudCdzCj4gbGliX3BpZCB2YXJpYWJsZS4gQ29uc2VxdWVudGx5LCB0aGUgcGFy
ZW50IHByb2Nlc3MKPiA+ID4gaW5jb3JyZWN0bHkgcmVwb3J0cyBhbiAiSW52YWxpZCBjaGlsZCBl
eGl0IHZhbHVlIi4KPgo+ID4gPiBUaGlzIGNvbW1pdCBhZGRyZXNzZXMgdGhpcyBieSBlbnN1cmlu
ZyB0aGUgY2hpbGQgcHJvY2VzcyBoYXMgYWNjZXNzIHRvCj4gdGhlIG5lY2Vzc2FyeSBsaWJfcGlk
IGFuZCBtYWluX3BpZCBieSBwYXNzaW5nCj4gPiA+IHRoZW0gdGhyb3VnaCBhIHNoYXJlZCByZXN1
bHRzIHN0cnVjdHVyZS4gVGhpcyBwcmV2ZW50cyB0aGUgcHJlbWF0dXJlCj4gZXhpdCBpbiB0aGUg
Y2hpbGQgYW5kIHRoZSBzdWJzZXF1ZW50IGVycm9yIHJlcG9ydAo+ID4gPiBpbiB0aGUgcGFyZW50
Lgo+Cj4gPiA+IFJlbGF0ZWQgY29tbWl0Ogo+ID4gPiBjb21taXQgYTFmODI3MDRjMjhkOWUwMjdj
YTg5OWY1Y2EyODQxZTdmZTQ5ZGU3Mgo+ID4gPiBsaWIvdHN0X3Rlc3QuYzogRml4IHRzdF9icmso
KSBoYW5kbGluZwo+Cj4gPiA+IERldGFpbCBmYWlsdXJlIGxvZzoKPiA+ID4gdHN0X3RtcGRpci5j
OjMxNzogVElORk86IFVzaW5nIC90bXAvTFRQX2RpclNPR1ZCQyBhcyB0bXBkaXIgKGJ0cmZzCj4g
ZmlsZXN5c3RlbSkKPiA+ID4gdHN0X3Rlc3QuYzoxOTM4OiBUSU5GTzogTFRQIHZlcnNpb246IDIw
MjUwNTA3LjRhMGUzYThmYQo+ID4gPiB0c3RfdGVzdC5jOjE5NDI6IFRJTkZPOiBUZXN0ZWQga2Vy
bmVsOiA2LjQuMC0xNTA3MDAuNTEtZGVmYXVsdCAjMSBTTVAKPiBXZWQgQXByIDMwIDIxOjM1OjQz
IFVUQyAyMDI1ICg2OTMwNjExKSBzMzkweAo+ID4gPiB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzog
UGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4gPiA+IHRzdF9rY29uZmln
LmM6Njc4OiBUSU5GTzogQ09ORklHX0ZBVUxUX0lOSkVDVElPTiBrZXJuZWwgb3B0aW9uCj4gZGV0
ZWN0ZWQgd2hpY2ggbWlnaHQgc2xvdyB0aGUgZXhlY3V0aW9uCj4gPiA+IHRzdF90ZXN0LmM6MTc2
MDogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlzIDBoIDA0bSAwMHMKPiA+ID4gZGly
dHljMHdfc2htZW0uYzo1NDogVElORk86IE1vdW50aW5nIHRtcF9kaXJ0eWMwd19zaG1lbSB0bwo+
IC90bXAvTFRQX2RpclNPR1ZCQy90bXBfZGlydHljMHdfc2htZW0gZnN0eXA9dG1wZnMgZmxhZ3M9
MAo+ID4gPiBkaXJ0eWMwd19zaG1lbV9jaGlsZC5jOjE2MDogVENPTkY6IFN5c3RlbSBkb2VzIG5v
dCBoYXZlIHVzZXJmYXVsdGZkCj4gbWlub3IgZmF1bHQgc3VwcG9ydCBmb3Igc2htZW0gPDw8PDw8
PDw8PCAxCj4gPiA+IHRzdF90ZXN0LmM6NDgxOiBUQlJPSzogSW52YWxpZCBjaGlsZCAoODE2Mykg
ZXhpdCB2YWx1ZSAzMiA8PDw8PDw8PCAyCj4gPiA+IGRpcnR5YzB3X3NobWVtLmM6MTAyOiBUSU5G
TzogVW1vdW50aW5nCj4gL3RtcC9MVFBfZGlyU09HVkJDL3RtcF9kaXJ0eWMwd19zaG1lbQo+Cj4g
PiA+IHRtcF9kaXJ0eWMwd19zaG1lbS5jIGNhbGwgZXhlY2xwIHRvIGNyZWF0ZSBuZXcgcHJvY2Vz
cyBydW4KPiBkaXJ0eWMwd19zaG1lbV9jaGlsZCBiaW4uCj4KPiA+ID4gU0FGRV9FWEVDTFAoImRp
cnR5YzB3X3NobWVtX2NoaWxkIiwgImRpcnR5YzB3X3NobWVtX2NoaWxkIiwgTlVMTCkKPgo+ID4g
PiBXaXRoaW4gZGlydHljMHdfc2htZW1fY2hpbGQuYyB0cmlnZ2VyCj4KPiA+ID4gdHN0X2JyayhU
Q09ORiwgIlN5c3RlbSBkb2VzIG5vdCBoYXZlIHVzZXJmYXVsdGZkIG1pbm9yIGZhdWx0IHN1cHBv
cnQKPiBmb3Igc2htZW0iKQo+Cj4gPiA+IFNpbmNlIGV4ZWNscCBkb2VzIG5vdCBpbmhlcml0IHRo
ZSBwYXJlbnQgcHJvY2VzcydzIHZhcmlhYmxlcyBsaWJfcGlkLAo+IHNvIGl0IHdpbGwgcmV0dXJu
IFRDT05GKDMyKSBkaXJlY3RseS4KPgo+ID4gPiB2b2lkIHRzdF92YnJrXyhjb25zdCBjaGFyICpm
aWxlLCBjb25zdCBpbnQgbGluZW5vLCBpbnQgdHR5cGUsIGNvbnN0Cj4gY2hhciAqZm10LAo+ID4g
PiAgICAgICAgICAgICAgICB2YV9saXN0IHZhKQo+ID4gPiB7Cj4gPiA+IC4uLgo+ID4gPiAgICAg
ICAgIGlmICghbGliX3BpZCkKPiA+ID4gICAgICAgICAgICAgICAgIGV4aXQoVFRZUEVfUkVTVUxU
KHR0eXBlKSk7ICAgPDw8PDwKPiA+ID4gLi4uCj4gPiA+IH0KPgo+ID4gPiBTbyBmaW5hbGx5IGNh
cHR1cmVkIGJ5IGNoZWNrX2NoaWxkX3N0YXR1cyByZXBvcnQgYW4gZXJyb3IuCj4KPiA+ID4gc3Rh
dGljIHZvaWQgY2hlY2tfY2hpbGRfc3RhdHVzKHBpZF90IHBpZCwgaW50IHN0YXR1cykKPiA+ID4g
ewo+ID4gPiAuLi4KPiA+ID4gICAgICAgICBpZiAoV0VYSVRTVEFUVVMoc3RhdHVzKSkKPiA+ID4g
ICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJJbnZhbGlkIGNoaWxkICglaSkgZXhpdCB2
YWx1ZSAlaSIsCj4gcGlkLCBXRVhJVFNUQVRVUyhzdGF0dXMpKTsgIDw8PDwKPiA+ID4gfQo+Cj4g
PiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+ID4gPiAtLS0KPiA+
ID4gIGxpYi90c3RfdGVzdC5jIHwgMjUgKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Cj4gPiA+
IGRpZmYgLS1naXQgYS9saWIvdHN0X3Rlc3QuYyBiL2xpYi90c3RfdGVzdC5jCj4gPiA+IGluZGV4
IDJiYjQ1MTlkZC4uYjY2NjcxNWI5IDEwMDY0NAo+ID4gPiAtLS0gYS9saWIvdHN0X3Rlc3QuYwo+
ID4gPiArKysgYi9saWIvdHN0X3Rlc3QuYwo+ID4gPiBAQCAtNTksNyArNTksNyBAQCBzdGF0aWMg
Y29uc3QgY2hhciAqdGlkOwo+ID4gPiAgc3RhdGljIGludCBpdGVyYXRpb25zID0gMTsKPiA+ID4g
IHN0YXRpYyBmbG9hdCBkdXJhdGlvbiA9IC0xOwo+ID4gPiAgc3RhdGljIGZsb2F0IHRpbWVvdXRf
bXVsID0gLTE7Cj4gPiA+IC1zdGF0aWMgcGlkX3QgbWFpbl9waWQsIGxpYl9waWQ7Cj4gPiA+ICtz
dGF0aWMgcGlkX3QgbGliX3BpZDsKPgo+IFdlaSwgeW91IHByb2JhYmx5IG5vdGljZWQgdGVzdHMg
ZmFpbCAodGhhbmtzIHRvIEFuZHJlYSdzIENJIGltcHJvdmVtZW50cykuCj4gSXQgYnJva2UgYXQg
bGVhc3QgdHN0X25lZWRzX2NtZHMwMi5jIEkgZ3Vlc3MgZHVlIG1pc3NpbmcgbWFpbl9waWQ6Cj4K
PiAkIGdkYiAuL3RzdF9uZWVkc19jbWRzMDIKPiAuLi4KPiAoZ2RiKSBydW4KPiAuLi4KPiB0c3Rf
Y21kLmM6MjY4OiBUQ09ORjogQ291bGRuJ3QgZmluZCAnbWtmcy5leHQ0NScgaW4gJFBBVEgKCgo+
IFByb2dyYW0gcmVjZWl2ZWQgc2lnbmFsIFNJR1NFR1YsIFNlZ21lbnRhdGlvbiBmYXVsdC4KPiAw
eDAwMDA1NTU1NTU1NWJlYTQgaW4gdHN0X3ZicmtfIChmaWxlPTxvcHRpbWl6ZWQgb3V0PiwgbGlu
ZW5vPTxvcHRpbWl6ZWQKPiBvdXQ+LCB0dHlwZT08b3B0aW1pemVkIG91dD4sIGZtdD08b3B0aW1p
emVkIG91dD4sIHZhPTxvcHRpbWl6ZWQgb3V0PikgYXQKPiB0c3RfdGVzdC5jOjM5Nwo+IDM5NyAg
ICAgICAgICAgICBpZiAoIXJlc3VsdHMtPmxpYl9waWQpCj4gKGdkYikgYnQKPiAjMCAgMHgwMDAw
NTU1NTU1NTViZWE0IGluIHRzdF92YnJrXyAoZmlsZT08b3B0aW1pemVkIG91dD4sCj4gbGluZW5v
PTxvcHRpbWl6ZWQgb3V0PiwgdHR5cGU9PG9wdGltaXplZCBvdXQ+LCBmbXQ9PG9wdGltaXplZCBv
dXQ+LAo+IHZhPTxvcHRpbWl6ZWQgb3V0PikgYXQgdHN0X3Rlc3QuYzozOTcKPiAjMSAgMHgwMDAw
NTU1NTU1NTViNWJlIGluIHRzdF9icmtfIChmaWxlPWZpbGVAZW50cnk9MHg1NTU1NTU1N2RlMWMK
PiAidHN0X2NtZC5jIiwgbGluZW5vPWxpbmVub0BlbnRyeT0yNjgsIHR0eXBlPXR0eXBlQGVudHJ5
PTMyLCBmbXQ9Zm10QGVudHJ5PTB4NTU1NTU1NTdkZWVkCj4gIkNvdWxkbid0IGZpbmQgJyVzJyBp
biAkUEFUSCIpCj4gICAgIGF0IHRzdF90ZXN0LmM6NDYwCj4gIzIgIDB4MDAwMDU1NTU1NTU2YmM1
NyBpbiB0c3RfY2hlY2tfY21kIChjbWQ9MHg1NTU1NTU1N2M2NDMgIm1rZnMuZXh0NDUgPj0KPiAx
LjQzLjAiLCBicmtfbm9zdXBwPWJya19ub3N1cHBAZW50cnk9MSkgYXQgdHN0X2NtZC5jOjI2OAo+
ICMzICAweDAwMDA1NTU1NTU1NWU2NDEgaW4gZG9fc2V0dXAgKGFyZ2M9MSwgYXJndj0weDdmZmZm
ZmZmY2FhOCkgYXQKPiB0c3RfdGVzdC5jOjEzNjMKPiAjNCAgdHN0X3J1bl90Y2FzZXMgKGFyZ2M9
MSwgYXJndj0weDdmZmZmZmZmY2FhOCwgc2VsZj1zZWxmQGVudHJ5PTB4NTU1NTU1NThhNzIwCj4g
PHRlc3Q+KSBhdCB0c3RfdGVzdC5jOjE5MzUKPiAjNSAgMHgwMDAwNTU1NTU1NTViMDQ0IGluIG1h
aW4gKGFyZ2M9PG9wdGltaXplZCBvdXQ+LCBhcmd2PTxvcHRpbWl6ZWQKPiBvdXQ+KSBhdCAuLi8u
Li9pbmNsdWRlL3RzdF90ZXN0Lmg6NzI5Cj4KCk9vcHMsIEkgbmVnbGVjdGVkIHRoYXQgY29tbWVu
dCBiZWZvcmUgbWVyZ2luZywgYW5kIGl0IGNhdXNlZCBDSSB0byBmYWlsLgpObyB0aW1lIHRvIGZp
eCBpdCB0b2RheSB0aG91Z2ggKHRvbyBsYXRlKS4gSSdsbCB0cnkgdG8gbG9vayBhdCB0aGUgZGV0
YWlscwp0b21vcnJvdy4KCkJ1dCBob3BlZnVsbHkgaXQnbGwgYmUgZml4ZWQgYnkgdGhlIHRpbWUg
SSB3YWtlIHVwIHRvbW9ycm93IDopLgoKU29ycnkgZm9yIHRoZSBjYXJlbGVzcyBwdXNoLgoKCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
