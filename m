Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DF5CA0EDC
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755215866; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cerhdn8ohf3DEP6DKY2QeEtxcHFByPxwmRFb++1S0JA=;
 b=Xg3hqw3TayJKB/QQRgFuwmp+UcPclgAVKTGUzwBpUO0pJ64Oz5LmA+kv9wgrB5SjfCd2q
 6YWQaKTCl7ygizHCTZmj89NShTlvePSTi+CGvOr1LI1QN8G6eHB6bsbr0UfqufMbB7BohPj
 z6QrYfHyR7aKfbSJP1iL0hTJTJ21JIE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67B7B3CBDF0
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 01:57:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CD723CA46D
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 01:57:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2114560029D
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 01:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755215842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GL+vjokp9FCTU49RF/MZstClYa6R78oXTeQHbwIF6zM=;
 b=Gsd+Qo061W+b2GlhwZf5FC+/GF7AF2O+Ongta14kPjrBc+adO7vDAFiT8DIzq0aMC/r5Pm
 tO4bRy9dsfokF0PtlsLcz3wOhKxzwlvBUfNmAxnatpEWjWBftvgd1fA68HmWaDkx/yO6wu
 fy3iYbD3OkR3Exeh+twz2WybAAWKwG4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-U3jqfsZ_OTe2Svzzjr6zMw-1; Thu, 14 Aug 2025 19:57:21 -0400
X-MC-Unique: U3jqfsZ_OTe2Svzzjr6zMw-1
X-Mimecast-MFC-AGG-ID: U3jqfsZ_OTe2Svzzjr6zMw_1755215840
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-244581950a1so17036695ad.2
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 16:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755215840; x=1755820640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GL+vjokp9FCTU49RF/MZstClYa6R78oXTeQHbwIF6zM=;
 b=Y8AZTmdBT6ttDQGC+ljvnNVbCrKjrZUrBLQv/q/zrCGjIUKOK/PiirtylFFThXZm6O
 WkgXF69rzeoLNOF4PnMC2/949Rwh1yqBo83RdKkGkB5SjwuGSBPj6wlvfkrcqQmJjqUk
 1hJBoDBcTdjUBXFux8CLM0hILYqeumiyP0U6TFC3Suxhj9HMWddhDmRmAOmoRk5Of1hf
 VW3FCgCps/c7tt5NVmXM+6pscB7p3+yF1XCAz2D7mJLt+B/mldcHbSpIgjz5rSxnzKW6
 n7hVSnR+MuG+FWU507U0ExXPB0zraAyeVseaRjFnB1AvXii4IO2QDwm0zrWG18bACecs
 qehg==
X-Gm-Message-State: AOJu0Yzs029CkHyPMCCX67/YERA7AJbB1OMvCgDv0uYXr3JFca+FNK0D
 mx6D8upBEfshLz92of5cZaaztOeaoYggfH3Wg4iLNlRZmlX3RPDNfrOfWmbE61cCnzkJCnfmuCf
 5nuOAnaq8Z1DbentzkamAUwIgVQ0QO9aL6Z578mR4CxeZXzdGOmIKPkXjCdSNKLDkQTDt6jzoLY
 81ifKOIFvp298mdfq0KFgWWlDReLQ=
X-Gm-Gg: ASbGnctR2jkZdsrHbGZLUE9208YSRVvVOSQZU8bvJ+lsPXG7o3mFc6LtveOKDLJaAAO
 CDJhwWklQMxVft5Zl+7gQ5CJzfISwhA4WogAN1CruegJeCWdAHaBhJO6kni0hZrOLe4CKLx8CFk
 vZ85A4D8JcVWQLNThrUvdwGg==
X-Received: by 2002:a17:902:ef02:b0:244:6b77:5b10 with SMTP id
 d9443c01a7336-2446d89d221mr698305ad.36.1755215840179; 
 Thu, 14 Aug 2025 16:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlP/6sEx7OnJtA4trymsvk3/U75eHuFdW43OTcKJK89NLveyLSm0ARbglZ35bPZNIQQqiJBAxKC8kxbMPh6y4=
X-Received: by 2002:a17:902:ef02:b0:244:6b77:5b10 with SMTP id
 d9443c01a7336-2446d89d221mr698035ad.36.1755215839685; Thu, 14 Aug 2025
 16:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250807062941.348971-1-pvorel@suse.cz>
 <20250807062941.348971-2-pvorel@suse.cz>
 <CAEemH2e1CbqCv8Bq4dJgBoRU2hJ72fPTsHJDYV8oLXRgs7SdAw@mail.gmail.com>
 <20250814131857.GB575710@pevik>
In-Reply-To: <20250814131857.GB575710@pevik>
Date: Fri, 15 Aug 2025 07:57:08 +0800
X-Gm-Features: Ac12FXwYfM6pP1I5voJuGXAeLTs1M33rCB680CjyDdN0odAk9iCh_KeDQs91dDA
Message-ID: <CAEemH2cLYOrZkHxj=EYcC3MYvB2cAEUhwF+jL9v6KZi2YvysNQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Aljcn3FZp9oVF3r_L8XYDLHAklGKz4lwH0aPwjiqT8s_1755215840
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
 error
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

T24gVGh1LCBBdWcgMTQsIDIwMjUgYXQgOToxOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIExpLAo+Cj4gPiBIaSBQZXRyLAo+Cj4gPiBJIGFtIHN0aWxsIHRy
eWluZyB0byBtYWtlIHN1cmUgbXkgdW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0IG9uCj4gPiAnRk9S
Q0VfTU9EVUxFUz0xJywKPiA+IHdoaWNoIG9uZSBiZWxvdyBkbyB5b3UgbWVhbjoKPgo+ID4gICAx
LiBJZiBhIHN1YmRpcmVjdG9yeSBmYWlscywgaXQgc3RvcHMgZm9yIHRoYXQgc3ViZGlyZWN0b3J5
IGJ1dCB0aGUKPiA+IHRvcC1sZXZlbCBtYWtlCj4gPiAgICAgICBjb250aW51ZXMgd2l0aCB0aGUg
bmV4dCBkaXJlY3RvcnkgaW4gdGhlIGxpc3QuCj4KPiA+ICAgMi4gVGhlIHRvcC1sZXZlbCBidWls
ZCBzaG91bGQgc3RvcCBpbW1lZGlhdGVseSB3aGVuIGFueSBzdWJkaXJlY3RvcnkKPiA+IGZhaWxz
Lgo+Cj4gPiBJZiB0aGUgYW5zd2VyIGlzICgxKSwgSSBiZWxpZXZlIG91ciBjdXJyZW50IHBhdGNo
IGlzIGNvcnJlY3QgKGZlZWwgZnJlZSB0bwo+ID4gYWRkIG15IFJCVCkuCj4gPiBIb3dldmVyLCBp
ZiB0aGUgaW50ZW5kZWQgYmVoYXZpb3IgaXMgKDIpLCB3ZSB3aWxsIG5lZWQgdG8gYW1lbmQgdGhl
Cj4gPiB0b3AtbGV2ZWwgTWFrZWZpbGUKPiA+IHRvIGVuc3VyZSB0aGUgYnVpbGQgc3RvcHMgYXQg
dGhlIGZpcnN0IGZhaWx1cmUuCj4KPiBJIGludGVuZGVkIDEuLCBidXQgZXhpdCBhZnRlcndhcmRz
IG5vbi16ZXJvIG9uIGVycm9yLiBCdXQgdGhpcyBhY3R1YWxseSBpcyBub3QKPiB0cnVlLiAgPT4g
djUgaXMgbmVlZGVkLgo+Cj4gVGhlIHJlYXNvbiBmb3IgMS4gd2FzIHRvIHNlZSB3aGljaCBtb2R1
bGVzIGZhaWxlZCAoYWxsIG9mIHRoZW0pLgo+IE1heWJlIGl0J2QgYmUgZW5vdWdoIHRvIGltcGxl
bWVudCAyLgoKWWVzLCBidXQgRk9SQ0VfTU9EVUxFUz0xIGlzIHN0aWxsIG1ha2Ugc2Vuc2UsIHBl
b3BsZSBtYXkgbm90IGxpa2UKdG8gc2VlIHRoZSBtb2R1bGUncyBlcnJvciBzdG9wIHRoZSBidWls
ZCBldmVyeSB0aW1lLgoKPgo+IFRoaXMgd29ya3MgZm9yIG1lIChzZW5kaW5nIHY1IHRvZGF5KToK
PiAtICAgICAgICAgICAgICAgJChNQUtFKSAtQyAkKGFic19zcmNkaXIpLyQoZGlyKTsgXAo+ICsg
ICAgICAgICAgICAgICAkKE1BS0UpIC1DICQoYWJzX3NyY2RpcikvJChkaXIpOyBbICQkPyAtZXEg
MCBdIHx8IGV4aXQgZXhpdCAkJD87IFwKCldoeSBub3Q6CiAgICAkKE1BS0UpIC1DICQoYWJzX3Ny
Y2RpcikvJChkaXIpIHx8IGV4aXQgJCQ/OyBcCgo+Cj4gSSB3b25kZXIgaWYgaXQncyBlbm91Z2gg
dG8gYWRkIHRoZSBjaGFuZ2Ugb25seSB0byAnbW9kdWxlcycgdGFyZ2V0IG9yIHdoZXRoZXIgSQo+
IHNob3VsZCBhZGQgaXQgdG8gdGhlIG90aGVycyAobW9kdWxlcy1jbGVhbiwgbW9kdWxlcy1pbnN0
YWxsKSBhcyB3ZWxsLgoKVG8gZW5zdXJlcyBjb25zaXN0ZW50IGFuZCBjb3JyZWN0IGVycm9yIGhh
bmRsaW5nLCB3ZSBwcm9iYWJseSBuZWVkIHRvCnRha2UgY2FyZSBhbGwuCgpOb3JtYWxseSwgd2Ug
d291bGRuJ3QgZW5jb3VudGVyIGNsZWFudXAvaW5zdGFsbGF0aW9uIGVycm9ycywgYnV0IGltYWdp
bmUgaWYKbW9kdWxlcy1jbGVhbiBmYWlsZWQgaW4gYSBzdWJkaXJlY3RvcnkgYnV0IGNvbnRpbnVl
ZCBzaWxlbnRseS4gV2UgbWlnaHQgdGhpbmsKZXZlcnl0aGluZyB3YXMgY2xlYW5lZCwgYnV0IG91
dGRhdGVkIC5rbyBvciAubyBmaWxlcyBtaWdodCByZW1haW4uCgpGb3IgbW9kdWxlcy1pbnN0YWxs
OiBmYWlsIGZhc3QgYnkgZGVmYXVsdCB0byBhdm9pZCBhIHBhcnRpYWxseQppbnN0YWxsZWQgdHJl
ZSBpcyBuZWNlc3NhcnkuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
