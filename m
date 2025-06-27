Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76096C77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751020647; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dbZXJ3UvErAiGLypqn5Mb56G0byIaohT5ZdT+JXnL6U=;
 b=iOidQcqgtwwb1szWoYhJcbwvwfHwJAoBc3KXDrDe/TMGc0xiRA17zs9AVNLlCCs9d+aVl
 Mk9d1L1bw4EBQNZhPpdhkjd5bdDeIKKg9eX7I9qRgW8OWUwuTIl34mzNng9mHqj50chIKFr
 ohVdXQhrLfb0DKFaah4KBN+dzOjs4fs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB9E73C7B03
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 12:37:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 452AD3C0939
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:37:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7D1511A002F0
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:37:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751020623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0h2Sf+OuXTZzBoUZZd2bHQ/QPBkAtYA+U35BWtxwI+c=;
 b=epJXW/fp3mjq8nXYDMe3Z4+RKMt2ab3AD0E+4EceVoDAeD9vWm91IjuCvkzVjlC5gzV1Kp
 J+xF32qpEEIgT/Ria/DJU6ja3IkVtoLEk8QJbFMYj5LOPIe7hOKE5fuq7WR9IbhEKnAnE0
 mfsGc3RRIC/9eH7SONqtdnth7x03Zhs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-8tc-FzK1OgqrmZShuqEDBA-1; Fri, 27 Jun 2025 06:37:01 -0400
X-MC-Unique: 8tc-FzK1OgqrmZShuqEDBA-1
X-Mimecast-MFC-AGG-ID: 8tc-FzK1OgqrmZShuqEDBA_1751020620
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so3223701a91.2
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 03:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751020620; x=1751625420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0h2Sf+OuXTZzBoUZZd2bHQ/QPBkAtYA+U35BWtxwI+c=;
 b=gOxd3vop/sX/78BoRdI0wQLpbwBfsH3Whm0++2PubT7j6hzQi48CsCwjAGF3eM7QiT
 2NBhZAkDGm45whFV3t2Mze7ZGC6EEPCq9GX9+ZEJwcFXL9oiEutqv4+YBkjJ4AJ1ia+Y
 ib7kBY9C8qLg1CwNisv4vIwiwNLhciqrS+LNezt1XIMtW8G4Ucb0vUfr1IuHOfM1k1tu
 rXdfAj5FAEB97eFNVUIt5ig9imj/grnFR0ORBD3VX43CiKGj6IBAh0lxt6tGxaeqqFge
 d/6buJP/BhH9Wk5WAk6lg3bG62FJJFIqW3WJKLlIKojw5ioKUwvneZjMC6JYY4gfncFe
 o+BA==
X-Gm-Message-State: AOJu0YxqR6Gi5PwZ7DwVw5jkifBriYdmWgcnkDMM0Xwwkjm2GR4MbJOI
 I3A5jOKVmlz1nsPPgeewjk/M5kD3T0NJNXR64Q47ngjaYzEYvIQZXsLJ8Ifq9TP4W09R9qWW/XZ
 ngZQehtkZXfYbAVIxhes+FIvw5NWASJJ2A21V4qGitjS5v1lWUOQxBe8wVx5GP6O+0sPBGYlTC+
 akvmp3QoPtdGPV3MPqUVOL+pU3L/U=
X-Gm-Gg: ASbGncs8IdNGsxkqmN0XJliUoAka+MFA6CN/jn2HqprZewO1gMYZbe6MQ7o7pIPpuQ5
 wksPi7rCFedysLpPBOvbmTGFNSlGwzvT42kRQ8UaOPe6aIrLvD3YeDfWVCzulVsg9WiFQG5sZoe
 vgsV0+
X-Received: by 2002:a17:90b:2dd0:b0:312:1ac5:c7c7 with SMTP id
 98e67ed59e1d1-318c8ff237bmr4293025a91.2.1751020620347; 
 Fri, 27 Jun 2025 03:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3dNwnuODQmqEyW2MB05NjamRJTYaEEFnEZpvJgHkla73vys4JJ9BdR8ZMRDRs9YiQlMKKiMzKKbOf6wLPisc=
X-Received: by 2002:a17:90b:2dd0:b0:312:1ac5:c7c7 with SMTP id
 98e67ed59e1d1-318c8ff237bmr4292996a91.2.1751020619969; Fri, 27 Jun 2025
 03:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250627102957.4165-1-chrubis@suse.cz>
In-Reply-To: <20250627102957.4165-1-chrubis@suse.cz>
Date: Fri, 27 Jun 2025 18:36:47 +0800
X-Gm-Features: Ac12FXzrj4a2cQqz9cHN4qhl7EwR-vP-rS-TBgdud1vethNxv6-WnbAmQ-9trl4
Message-ID: <CAEemH2d0RgoRRqxdc3pfjAGUaf6ScaskjQFQpMK3oz_9b0cS5w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MuisAXFxeKm20bJHc2gPz-4poEZSK6BW-6Mq4JM62vU_1751020620
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: tst_test: Make IPC magic spells 'LTPM'
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

T24gRnJpLCBKdW4gMjcsIDIwMjUgYXQgNjoyOeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gU2luY2UgdGhlICdMVFBNJyBzdHJpbmcgaXMgZW5jb2RlZCBpbiBh
biBpbnRlZ2VyIHRoZSBvcmRlciBvZiB0aGUKPiBsZXR0ZXJzIGRlcGVuZHMgb24gbWFjaGluZSBl
bmRpYW5pdHkuIE9uIGxpdHRsZSBlbmRpYW4gaXQgd2FzIGFjdHVhbGx5Cj4gc3BlbGxlZCBiYWNr
d2FyZHMgaS5lLiAnTVBUTCcuCj4KPiBUaGlzIHBhdGNoIGZpeGVzIHRoYXQgYnkgbWFraW5nIHN1
cmUgdGhhdCB0aGUgYnl0ZXMgYXJlIGluIHRoZSByaWdodAo+IG9yZGVyLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4KClRoaXMgaXMgY2xlYW5lciB0
aGFuIG15IHBhdGNoc2V0LCB0aGFua3MhCgpGb3IgdHdvIHBhdGNoZXM6CgpBY2tlZC1ieTogTGkg
V2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKLS0tCj4gIGxpYi90c3RfdGVzdC5jIHwgOCArKysr
KysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvbGliL3RzdF90ZXN0LmMgYi9saWIvdHN0X3Rlc3QuYwo+IGluZGV4IDQ5
NWUwMjJmNy4uMTdjZTkxOTMyIDEwMDY0NAo+IC0tLSBhL2xpYi90c3RfdGVzdC5jCj4gKysrIGIv
bGliL3RzdF90ZXN0LmMKPiBAQCAtNTIsNyArNTIsMTMgQEAgY29uc3QgY2hhciAqVENJRCBfX2F0
dHJpYnV0ZV9fKCh3ZWFrKSk7Cj4gICNkZWZpbmUgQ1ZFX0RCX1VSTCAiaHR0cHM6Ly9jdmUubWl0
cmUub3JnL2NnaS1iaW4vY3ZlbmFtZS5jZ2k/bmFtZT1DVkUtIgo+Cj4gICNkZWZpbmUgREVGQVVM
VF9USU1FT1VUIDMwCj4gLSNkZWZpbmUgTFRQX01BR0lDIDB4NEM1NDUwNEQgLyogTWFnaWMgbnVt
YmVyIGlzICJMVFBNIiAqLwo+ICsKPiArLyogTWFnaWMgbnVtYmVyIGlzICJMVFBNIiAqLwo+ICsj
aWYgX19CWVRFX09SREVSX18gPT0gX19PUkRFUl9CSUdfRU5ESUFOX18KPiArIyBkZWZpbmUgTFRQ
X01BR0lDIDB4NEM1NDUwNEQKPiArI2Vsc2UKPiArIyBkZWZpbmUgTFRQX01BR0lDIDB4NEQ1MDU0
NEMKPiArI2VuZGlmCj4KPiAgc3RydWN0IHRzdF90ZXN0ICp0c3RfdGVzdDsKPgo+IC0tCj4gMi40
OS4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
