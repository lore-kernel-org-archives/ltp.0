Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EC8C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787211634; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sl2WbWDvcshwkXIpcJCcrq7KOuWGl9qH5ft50Zsiqis=;
 b=B/y7ztuSSYX/589/hVA922DVLeiX5EH9kyr+I9YPlYBW2OWwtevgtEOOvpiJLsLHEITq6
 iDNFYjC/SW4b2tYI+JX2IvA4wFdhlDgCgnLicFx6m6GVR3lBRviPqfPzsfu29qkBxPJV3Td
 wDG6iBcSoqnRMy+eIKUO7a/CJnTTQLg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12BF93CE1C1
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:40:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FB6C3C23B2
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:40:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF6C21400205
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787211610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T1kdh3m43t2MTidCD2vUJ6HN7QUOlGnB/HLODcOssZ8=;
 b=WMLmQlmp44jOeronoeIU4XOjfiY7mBjcNC/3tlk83BuNXPrYva4yavEqsDXVD0+qGTwUm2
 B8QQ3IiWwtFR45GmDtiaoyfx4HrqiAhNmeTN9IytHSxC30mQcWkNP7/ZVP76cQWMzT6rll
 STQqbwGu5RNjZ6Vym6WNVlBhgpRalxg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-ogX-mO8jPBW69mDME-fGTg-1; Thu, 20 Aug 2026 03:40:07 -0400
X-MC-Unique: ogX-mO8jPBW69mDME-fGTg-1
X-Mimecast-MFC-AGG-ID: ogX-mO8jPBW69mDME-fGTg_1787211606
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a10378df3bso8824471fa.1
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 00:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787211605; x=1787816405;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T1kdh3m43t2MTidCD2vUJ6HN7QUOlGnB/HLODcOssZ8=;
 b=B4NuBU0dcO9hPUcCmo7aSkcBv4LMSeQjb61YXv2eEmM2gVobCa//NlA+ISjMRDpjI3
 K2NwmBWrsbWjxj5ckhUbs/ZDEpopuSZLXz0khcRe/W55udVaqLa6hJBkwZd9kGBMbC0X
 H5zl9O6z23XEuLdygp17Xp3t6ZD4HOKIjXYsS+AOwrQWY0XQKTxAnsRfdEgnxV5eJVue
 //u+Qu9cLDqfBsLYB7gLF6msLDMZu3KakOijzrXrzyOxbiALZMen2Wtx+PS0Z06sXXul
 iC+YGi6ZrhsT2G+T7NerTe/i1MnlJFxx3CdFn7QrKbUmuRROiw6snlNR7GgQnXn2UvbT
 KshQ==
X-Gm-Message-State: AOJu0Yxq41VfLNKxaHYp/Ne+2HPo3bTvkXmpZeuWAoxS+/cKQWlZScaT
 U1isI0ETTxp2aP58jWLzMrRi8PHUYec3Goktopm27GarrmRGt4/04R3B6uYTJVE0NdOmnOaq2bn
 z17xL4YbcX55D9dco971eOFodSBYbsoduVULuEB0TzokHhY6hVe4V5BpVGrPk+uLZ+EKP6RQM5+
 i1Sn8datoIplJeBZCzgemy8boH/co=
X-Gm-Gg: AR+sD10KaGVKXVig1Vd978IN8b1XON7FaaUqTedwr5TFB60ceiG2OC5KaQYBwsTnyqt
 xiCb4B3k4VlbvX6pOEiUCDW1uYUoTs8b6usmAqi9W8ZDrQX2/EF95JEHHDlUiR4sSJ2xSt6gLlG
 KLrxKEANpNKV5GsZ6hG8PBPeDBECoMjiK8eHlsqk8Q7gaCmIzXOBT6Aooc6A==
X-Received: by 2002:a2e:a811:0:b0:3a1:980f:58e9 with SMTP id
 38308e7fff4ca-3a1980f6418mr8948211fa.1.1787211605610; 
 Thu, 20 Aug 2026 00:40:05 -0700 (PDT)
X-Received: by 2002:a2e:a811:0:b0:3a1:980f:58e9 with SMTP id
 38308e7fff4ca-3a1980f6418mr8913101fa.1.1787211549310; Thu, 20 Aug 2026
 00:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHGiOXcygSrBCwc6AfoTiG--t6TOu2wCpYiHBYusiLEO8MNMyQ@mail.gmail.com>
 <6a84051d.3ddf1959.26ce36.5668@mx.google.com>
In-Reply-To: <6a84051d.3ddf1959.26ce36.5668@mx.google.com>
Date: Thu, 20 Aug 2026 10:38:52 +0300
X-Gm-Features: AcwNN1W1rx2C4-6b_E-QJPU38pKJW_22JV2M2Fvo67c4TvamRUVxAZ-qKsp6Cjs
Message-ID: <CAHGiOXfhYy3b+m49hR73TtV4MjFhSjCb2yp-RHR3CjAdjKqYXw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uGZz9fVRXeLQqzj-5Vvp-GQRQ4vhyrE2MQ34aAfVnuQ_1787211606
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC] kirk/json2logs: "warn" treated as failure +
 robustness improvements
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Cc: Michael Menasherov via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ICBIaSBBbmRyZWEsCgogIEkgb3BlbmVkIGEgUFIgaW4gdGhlIGtpcmsgcmVwbyBhcyB5b3Ugc3Vn
Z2VzdGVkICwgbGluawo8aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9raXJr
L3B1bGwvMTA2PgoKICBJdCBhZGRyZXNzZXMgdGhlIHdhcm4gc3RhdHVzIGhhbmRsaW5nLCBmaWxl
bmFtZSBzYW5pdGl6YXRpb24sIGFuZCB0aGUKZW1wdHkgZmFpbHMubG9nIGlzc3VlIEkgZGVzY3Jp
YmVkLiBMZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkKICBmZWVkYmFjayBvciBpZiB5b3UnZCBs
aWtlIG1lIHRvIGFkanVzdCBhbnl0aGluZy4KCiAgVGhhbmtzLAoKT24gVHVlLCBBdWcgMTgsIDIw
MjYgYXQgMTA6MDnigK9BTSBBbmRyZWEgQ2VydmVzYXRvIHZpYSBsdHAgPApsdHBAbGlzdHMubGlu
dXguaXQ+IHdyb3RlOgoKPiBIaSBNaWNoYWVsLAo+Cj4gaWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rp
b24sIHBsZWFzZSBzZW5kIGEgUFIgdG8gdGhlIGtpcmsgcmVwbywgSSB3aWxsCj4gdGFrZSBhIGxv
b2sgYW5kIGRpc2N1c3MgaXQgdGhlcmUuCj4KPiBSZWdhcmRzLAo+IC0tCj4gQW5kcmVhIENlcnZl
c2F0bwo+IFNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eAo+IGFuZHJlYS5jZXJ2ZXNh
dG9Ac3VzZS5jb20KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gCgpNaWNoYWVsIE1lbmFzaGVyb3YKClNvZnR3YXJl
IFF1YWxpdHkgRW5naW5lZXIgLSBBdXRvbW90aXZlIEtlcm5lbAoKUmVkIEhhdCA8aHR0cHM6Ly93
d3cucmVkaGF0LmNvbS8+CjxodHRwczovL3d3dy5yZWRoYXQuY29tLz4KCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
