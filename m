Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD818C021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 13:15:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 701D13CA044
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 14:15:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FD543C1840
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:15:39 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B423E648709
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741094136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6i0dd9MuFRc6/llWiwUPpo3o4S7wdnrFWoyw71YsN4w=;
 b=UDQZUFqwEoKgE264DlVEiLxHaMGpiJRfMqySgOLZ1bqHXTCythkyjtqyR3pgmt8JjllR/8
 NKlXWoNWJjBNBjLaXZPox5MlUOSuEyTPgRIztuorYwdy3yO5NTckkCxaobu06AHsiyImye
 /lEfmX3QcVaRLjERMceefgyU5h+iQDc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-rJUs109oNqCG1Sd2DlCnuw-1; Tue, 04 Mar 2025 08:15:30 -0500
X-MC-Unique: rJUs109oNqCG1Sd2DlCnuw-1
X-Mimecast-MFC-AGG-ID: rJUs109oNqCG1Sd2DlCnuw_1741094129
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fe870bc003so11208210a91.1
 for <ltp@lists.linux.it>; Tue, 04 Mar 2025 05:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741094127; x=1741698927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6i0dd9MuFRc6/llWiwUPpo3o4S7wdnrFWoyw71YsN4w=;
 b=lh1YG1ATYwf4pQp03a/fK3xkhaMuSn1gG5vS15ZPvnhJN+f6VqLcefuxlYDzmlPDEn
 Vggjv/BH9sNkFFK1p8wWWgcb9AHLLL0Ej1LTGg7Hz64/N9w9h3Wu/ZKxz5Jbm/1OROdQ
 tJFQo7td3RjiAY2aWjcaLW46e27UIGtX+PZ1uzDIHYNhrvjT8ocDyiCaMvmfMTl4brCK
 9omHPizYxquaulnZADTWaHqV9w1msvZa5Juwg37WcM+5G1cqq6l0CumwxjxFpBXEAHHG
 oWYUUb5yDrjTZ5q0rAPkZZeB8ZnKLvcwtKzX0+NwrXG10q8vo+Jv/NUyPRCLsABFnwR/
 +W8w==
X-Gm-Message-State: AOJu0YwL2jAa+bWr7L9ma+8coDbJqB3nCM5ZnymLzIZQuxjYGz8BY+KK
 /ZHZG3PNA0i1wdSjDt4uNeF6oHh3aygHrTKT/U3jZ379/AerLja+nMCpWl5o7AGxmnfyRzQis73
 yUywGJuTb0xuMEUgoffBrmYRBcl5XaFOQ597FTMmhM52foxR2TmL0nRrlnaxoMYJJWHts+f9r7K
 my2uWsbwsJAhAgAG2GF+fBPggGlccC1Uz4MNfs
X-Gm-Gg: ASbGncu0mp2ihMCvJEfad7TcGl1cFC2QCheuZaevtmaksevqhTD5WDvtOYTdGy4z6Wm
 LqOVMBxmXWZ/Xl3KcrwUjfCyety+4IPkoqORTPEQs4+f5He/QXOkNw5P7Okg9dNdJm08OP/NvCA
 ==
X-Received: by 2002:a17:90b:2e06:b0:2fa:3b6b:3370 with SMTP id
 98e67ed59e1d1-2ff33c223f4mr5057878a91.16.1741094127393; 
 Tue, 04 Mar 2025 05:15:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOon46ahWkNDT3pUYg+FT/2rjNkVR7ZlJAUIyRFYWXMT50b9ytwM+hyg7vlZb+9gmbHDXuy9ddwL59zMpJXzs=
X-Received: by 2002:a17:90b:2e06:b0:2fa:3b6b:3370 with SMTP id
 98e67ed59e1d1-2ff33c223f4mr5057848a91.16.1741094127084; Tue, 04 Mar 2025
 05:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-2-pvorel@suse.cz>
 <CAEemH2eBJ5AeTKgbDAbCpZKLA7DZMWhpEcrSUJAdJuNU5yULOA@mail.gmail.com>
 <20250304130833.GB81126@pevik>
In-Reply-To: <20250304130833.GB81126@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 4 Mar 2025 21:15:15 +0800
X-Gm-Features: AQ5f1JrhO9QTLxrqp0W_uyIJCvzB8hjljdic5bOYUcpD7KZ5qe7LdtnpEazXbO4
Message-ID: <CAEemH2ejsGmgKmqtWTFG6ZPnUySN9NkVhEbOk3ge1MaB_2TGXg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AHnNif3JWcPw-TCluzMU11iBKA34PYaDqJ9T8sXI9l8_1741094129
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/5] shell lib: Add support for test cleanup
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

T24gVHVlLCBNYXIgNCwgMjAyNSBhdCA5OjA44oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+IC4uLgo+ID4gPiArKysgYi90ZXN0Y2FzZXMvbGliL3J1
bl90ZXN0cy5zaAo+ID4gPiBAQCAtOSw2ICs5LDcgQEAgc2hlbGxfbG9hZGVyX2ZpbGVzeXN0ZW1z
LnNoCj4gPiA+ICBzaGVsbF9sb2FkZXJfa2NvbmZpZ3Muc2gKPiA+ID4gIHNoZWxsX2xvYWRlcl9z
dXBwb3J0ZWRfYXJjaHMuc2gKPiA+ID4gIHNoZWxsX2xvYWRlcl90Y250LnNoCj4gPiA+ICtzaGVs
bF9sb2FkZXJfY2xlYW51cC5zaAo+ID4gPiAgc2hlbGxfdGVzdDAxCj4gPiA+ICBzaGVsbF90ZXN0
MDIKPiA+ID4gIHNoZWxsX3Rlc3QwMwo+ID4gPiBAQCAtMjEsNyArMjIsOCBAQCBURVNUU19UQlJP
Sz0iCj4gPiA+ICBzaGVsbF9sb2FkZXJfaW52YWxpZF9ibG9jay5zaAo+ID4gPiAgc2hlbGxfbG9h
ZGVyX2ludmFsaWRfbWV0YWRhdGEuc2gKPiA+ID4gIHNoZWxsX2xvYWRlcl9ub19tZXRhZGF0YS5z
aAo+ID4gPiAtc2hlbGxfbG9hZGVyX3dyb25nX21ldGFkYXRhLnNoIgo+ID4gPiArc2hlbGxfbG9h
ZGVyX3dyb25nX21ldGFkYXRhLnNoCj4KPiA+IEl0IHNlZW1zIHRoZSBzaGVsbF9sb2FkZXJfd3Jv
bmdfbWV0YWRhdGEuc2ggaXMgYSBkdXBsaWNhdGUgb2YKPiA+IHNoZWxsX2xvYWRlcl9pbnZhbGlk
X21ldGFkYXRhLiBNYXliZSB3ZSBjYW4gcmVtb3ZlIG9uZSBvZiB0aGVtLgo+Cj4gR29vZCBjYXRj
aC4gQnV0IEkgdGhpbmsgdGhlcmUgYXJlIHRlc3RpbmcgYSBkaWZmZXJlbnQgdGhpbmc6CgoKPiBz
aGVsbF9sb2FkZXJfd3JvbmdfbWV0YWRhdGEuc2ggSU1ITyBoYXMgdG9vIGhpZ2ggaW50IHZhbHVl
Cj4gKCJXcm9uZyAnbmVlZHNfdG1wZGlyJyB0eXBlIGV4cGVjdGVkIGJvb2xlYW4iIGVycm9yKToK
PgoKQWggaW5kZWVkLCBJIGhhZG4ndCBub3RpY2VkIHRoYXQsIHRoYW5rIHlvdSEKCgoKPiAibmVl
ZHNfdG1wZGlyIjogNDIsCj4KPiAjIFBBVEg9IiRQV0Q6JFBXRC90ZXN0czokUEFUSCIgc2hlbGxf
bG9hZGVyX3dyb25nX21ldGFkYXRhLnNoCj4gUGFyc2UgZXJyb3IgYXQgbGluZSAwMDIKPgo+IDAw
MTogewo+IDAwMjogICJuZWVkc190bXBkaXIiOiA0MiwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBeCj4gV3JvbmcgJ25lZWRzX3RtcGRpcicgdHlwZSBleHBlY3RlZCBib29sZWFuCj4gdHN0X3J1
bl9zaGVsbC5jOjUwODogVEJST0s6IEludmFsaWQgbWV0YWRhdGEKPgo+IHNoZWxsX2xvYWRlcl9p
bnZhbGlkX21ldGFkYXRhLnNoIElNSE8gaGFzIGludmFsaWQgSlNPTgo+ICgiRXhwZWN0ZWQgSUQg
c3RyaW5nIiBlcnJvcik6Cj4KPiB7Im5lZWRzX3RtcGRpciI6IDQyLAo+Cj4gIyBQQVRIPSIkUFdE
OiRQV0QvdGVzdHM6JFBBVEgiIHNoZWxsX2xvYWRlcl9pbnZhbGlkX21ldGFkYXRhLnNoCj4gUGFy
c2UgZXJyb3IgYXQgbGluZSAwMDIKPgo+IDAwMTogewo+IDAwMjogIHsibmVlZHNfdG1wZGlyIjog
NDIsCj4gICAgICAgXgo+IEV4cGVjdGVkIElEIHN0cmluZwo+IHRzdF9ydW5fc2hlbGwuYzo1MDg6
IFRCUk9LOiBJbnZhbGlkIG1ldGFkYXRhCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4KCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
