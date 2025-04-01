Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDE8C36010
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743518460; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=OObKBOLMgeuEw3vlHbnyRTYBQv0oMsUXZ7UmDUHBaQA=;
 b=R1evk5VK80sbuEiRemCd9AdpX4WNYeFbtgy7SnqouFC64d4tC+67KPJ8s4PjywBQmVjGD
 2O2knscJ/IejS8fkfDih6oBZeRy13ZNxqKiGlJ3E3pXPMhgbN5Df8spqmoNdVKCgATof/Kk
 q6r2cgiflEgo9c9cGtdAMsAUoLmeGV4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16E1B3CB039
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 16:41:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 13A573C98E7
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 16:40:37 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with UTF8SMTPS id BB62910007B9
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 16:40:36 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2923658f8f.0
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 07:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743518436; x=1744123236;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iMI82zezOzGo5eEWu3JDr2/EvnJm8/HYoam0HpBFRAI=;
 b=gFuJmmF7LIwB76KK3yfwwXdISKQZxN6vuVxlHT8MFlvwPzK08CUDSaHs62ufShI19O
 wZaRuM5U/qns0PtvCrir1Y34mTs94uE+tqjvtwqXPw3DiSP8HHKvewqR5Q9pqHXkKBSD
 I1GFKyJIn/1MHnKTg3VAcvwQr4iDcrjbY3OxDXxJXtxmwIPL8ON/2Mywvx0wjtgj+4TG
 4fadEbdM7xiwWHtWWR5+ouTKvMW1UYrvksB8fXn/DPHYctTe89R9V4sV7lvG24w+UuuQ
 uu8wE8tKPeeBA7taM3NXtGn8EPiDGikdC8XnDhj4wb/O0HHBnTjxJgydqH3bB1sq6i/O
 7t4Q==
X-Gm-Message-State: AOJu0YzEo4XRTH3LG45398zHPEsD+MpmwfJ8jWmbIc+2jQpQnd+XsBDO
 3NEJ5aKl+bSNIYj1iTFO3t9ZgF5Mp6OVa6ZMnjEDHxNKoKoXf6MulOpqD/4wAi0QV+qqlcMMo94
 l
X-Gm-Gg: ASbGncsEIgIrHwch4AE5nWAzhdvb/U6tF4VhrhnG6frK/7V84aGtzvnXyZ/I34W6FTh
 JtAFenGTojOnWb03JsWuF67Hu7vWMP1xsGFvwFzJKkm/y3Z2LMLuWWCc5bFrb5uBnkjlNqRzPEm
 HpwEHRdDLoXf9LbhNk9+JXehYGq02Z0PCMpq3tmimKiIua6Pb/lGad1azRj8OrTXkpDGpjRqMzG
 4cGS7VnCU8/4WkHGHBOBNAGnHJS9S8FWQuDX1MWnymK4aF8OdS2uMnOhcWjNv1GdP3rUM6Kukv2
 0pbyskVppU3bcwy/mXmnb4iE6EC45yyVng==
X-Google-Smtp-Source: AGHT+IGpihWvkjyHgNzdlmONgr8zaYKpOMuuyq19U2YbOkoc4b8nAzorxxHj01dEaKYeGQGKBu9+1Q==
X-Received: by 2002:a05:6000:18a8:b0:390:fb37:1ca with SMTP id
 ffacd0b85a97d-39c12119c94mr10911913f8f.53.1743518436139; 
 Tue, 01 Apr 2025 07:40:36 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f572dsm88699955ad.232.2025.04.01.07.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:40:35 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 01 Apr 2025 11:40:32 -0300
Message-Id: <D8VDPAJS1K5T.191IUUIS2OZBP@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
 <20250327-fix_make_clean-v1-2-8b9ed2a8d96a@suse.com>
 <20250401073830.GD299271@pevik>
In-Reply-To: <20250401073830.GD299271@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] openposix: Makefile: Add the standard
 "maintainer-clean" target
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIEFwciAxLCAyMDI1IGF0IDQ6MzggQU0gLTAzLCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhp
IFJpY2FyZG8sCj4KPj4gVGhlIGluY2x1ZGUvbWsvYXV0b21ha2UubWsgZmlsZSBkZWZpbmUgdGhl
IHN0YW5kYXJkICJtYWludGFpbmVyLWNsZWFuIiBhbmQKPj4gImFjLW1haW50YWluZXItY2xlYW4i
IHRhcmdldHMgYW5kIHRoZXJlaW4gaXQgY2FsbHMgdGhlIHNhbWUgdGFyZ2V0cyB1bmRlcgo+PiBl
YWNoIEFVVE9DT05GRURfU1VCRElSUywgYnV0IGluIHRoZSBjYXNlIG9mIHRoZSBvcGVucG9zaXgg
dGVzdCBzdWl0ZSwgdGhleQo+PiBkb24ndCBleGlzdC4gQWRkIHRoZW0gYW5kIGFsc28gcmVtb3Zl
IHNvbWUgZGFuZ2xpbmcgZmlsZXMgaW4gYWMtY2xlYW4uCj4KPj4gVGhpcyBmaXhlcyB0aGUgZm9s
bG93aW5nIGVycm9yIHdoZW4gY2FsbGluZyBgbWFrZSBtYWludGFpbmVyLWNsZWFuYCBmcm9tCj4+
IHRoZSBwcm9qZWN0J3MgdG9wIGxldmVsIGRpcmVjdG9yeToKPgo+PiBtYWtlWzFdOiBFbnRlcmlu
ZyBkaXJlY3RvcnkgJy4vdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlJwo+PiBtYWtlWzFd
OiAqKiogTm8gcnVsZSB0byBtYWtlIHRhcmdldCAnYWMtbWFpbnRhaW5lci1jbGVhbicuICBTdG9w
Lgo+PiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnLi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90
ZXN0c3VpdGUnCj4+IG1ha2U6ICoqKiBbLi9pbmNsdWRlL21rL2F1dG9tYWtlLm1rOjY4OiBhYy1t
YWludGFpbmVyLWNsZWFuXSBFcnJvciAyCj4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZv
cmVsQHN1c2UuY3o+Cj4KPiBUaGFua3MgZm9yIGZpeGluZyBkYXJrIGNvcm5lcnMgb2YgTFRQIGJ1
aWxkIHN5c3RlbS4KPgo+IFdoYXQgYSBzdHJhbmdlIHRhcmdldCBuYW1lLiBPYnZpb3VzbHkgaXQg
d2FzIG1lYW50IHRvIGJlIHJ1biBiZWZvcmUgcmVsZWFzZQo+IGZpbGUsIGJ1dCBpdCB3YXMgbm90
IGV2ZW4gY2FsbGVkIGluIE1ha2VmaWxlLnJlbGVhc2Ugd2hpY2ggSSByZW1vdmVkIGluCj4gMTA4
OGQ5M2Q5OS4KPgo+IEkgd2FzIHRoaW5raW5nIHdoZXRoZXIgd2UgcmVhbGx5IG5lZWQgdGhpcyB0
YXJnZXQuIE1heWJlIGl0IGNvdWxkIGJlIHBhcnQgb2YKPiBkaXN0Y2xlYW4uCgpTdHJhbmdlIGlu
ZGVlZCwgSSB3YXMgbm90IGF3YXJlIG9mIGl0IHVudGlsIG5vdy4uLiBBcyBJIG1lbnRpb25lZCBp
biB0aGUKY292ZXIgbGV0dGVyLCBpdHMgYSBzdGFuZGFyZCB0YXJnZXQuIEJvdGggYXBwcm9hY2hl
cyBtYWtlIHNlbnNlIHRvIG1lLAplaXRoZXIgd2Uga2VlcCBpdCBvciB1bmlmeSBpdCB3aXRoIGRp
c3RjbGVhbi4gTm90IHN1cmUgd2hhdCBvdGhlcnMKcHJlZmVyLCBidXQgSSB3b3VsZCBsaWtlIHRv
IGhhdmUgYSBwcm9wZXIgY2xlYW4gd2l0aG91dCByZWx5aW5nIG9uIGdpdC4KClRoYW5rIHlvdSwK
LQlSaWNhcmRvLgoKCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4+IFNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4+IC0tLQo+PiAgdGVzdGNhc2Vz
L29wZW5fcG9zaXhfdGVzdHN1aXRlL01ha2VmaWxlIHwgMTAgKysrKysrKysrLQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4+IGRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvTWFrZWZpbGUgYi90ZXN0Y2FzZXMvb3Bl
bl9wb3NpeF90ZXN0c3VpdGUvTWFrZWZpbGUKPj4gaW5kZXggOGI0YzhjMGEyNGI4MzNmYTBmYjIx
Y2UzZTI1MzYyOWYzNThmMTgwMC4uYzBjY2Q0OTliOGI5YzkzZTQ1MTMzZjViM2YxODllZGE3ZDA5
YmViMyAxMDA2NDQKPj4gLS0tIGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL01ha2Vm
aWxlCj4+ICsrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9NYWtlZmlsZQo+PiBA
QCAtMzEsMTEgKzMxLDE2IEBAIEFVVE9HRU5FUkFURURfRklMRVMgPSBpbmNsdWRlL21rL2NvbmZp
Zy5tawo+Cj4+ICAuUEhPTlk6IGFjLWNsZWFuCj4+ICBhYy1jbGVhbjogY2xlYW4KPj4gKwkkKFJN
KSAtcmYgYXV0b200dGUuY2FjaGUKPj4gKwkkKFJNKSAtZiBjb25maWcubG9nIGNvbmZpZy5zdGF0
dXMKPj4gKwo+PiArLlBIT05FOiBhYy1tYWludGFpbmVyLWNsZWFuCj4+ICthYy1tYWludGFpbmVy
LWNsZWFuOgo+PiArCSQoUk0pIC1mIGNvbmZpZ3VyZQo+Cj4+ICAuUEhPTlk6IGNsZWFuCj4+ICBj
bGVhbjoKPj4gIAkkKFJNKSAtZiAkKExPR0ZJTEUpKgo+PiAtCSQoUk0pIC1mIGNvbmZpZy5sb2cg
Y29uZmlnLnN0YXR1cwo+PiAgCUBmb3IgZGlyIGluICQoU1VCRElSUykgdG9vbHM7IGRvIFwKPj4g
IAkJJChNQUtFKSAtQyAkJGRpciBjbGVhbiA+L2Rldi9udWxsOyBcCj4+ICAJZG9uZQo+PiBAQCAt
NTEsNiArNTYsOSBAQCBkaXN0Y2xlYW4tbWFrZWZpbGVzOgo+PiAgCQkkKE1BS0UpIC1DICQkZGly
ICRAOyBcCj4+ICAJZG9uZQo+Cj4+ICsuUEhPTlk6IG1haW50YWluZXItY2xlYW4KPj4gK21haW50
YWluZXItY2xlYW46IGRpc3RjbGVhbi1tYWtlZmlsZXMgYWMtbWFpbnRhaW5lci1jbGVhbgo+PiAr
Cj4+ICAkKEFVVE9HRU5FUkFURURfRklMRVMpOiAkKHRvcF9idWlsZGRpcikvY29uZmlnLnN0YXR1
cwo+PiAgCSQoU0hFTEwpICReCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
