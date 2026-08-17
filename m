Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342A9C5B572
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786993356; h=mime-version :
 date : message-id : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=n40RdizYHx69KZOZL3FjVbud/nbiUG7itbrSo4Bc7vg=;
 b=o83headRkK2vquUX5e0O8VXApvWWZNpSZ9a3sUpXG1a+8eO0pFtHPQUVipzNnZJk/3jrz
 0zDfz60HCebFh6Mjg9AhFGxH0Tl23kOf+riB4kn/0FkQGsW/UKoftJCXhteDmbHpBK1PRmJ
 KsFM1SCloDUMxX3u9Vb/6Fa8tkL7FkU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B34A3CBF5E
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 21:02:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D2CC3CB761
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 21:02:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B151A600796
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 21:02:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786993334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=W8GI1hbvSFHKG2ZNYw+4KY0Mav74UxN1VixbJcyviAo=;
 b=T7TSpAnH+YknG7jOSbISa2ijK6JR38MeU/NqzHWPYJKFklBn2UOuBEsGbK2YYr/q+f5J6/
 QAbMtPqVzxEBSmKhIfwdER6KC4L0hiA3GxK+JXoT268pmElgxNRmti7GeCAtfOf/tobjwD
 q4Dv3qll7CqE9Ws3Wryd9vwixOBXC28=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-sfcZU1mVMjSWKMDEpgWKaQ-1; Mon, 17 Aug 2026 15:02:06 -0400
X-MC-Unique: sfcZU1mVMjSWKMDEpgWKaQ-1
X-Mimecast-MFC-AGG-ID: sfcZU1mVMjSWKMDEpgWKaQ_1786993325
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-39b1a8b8bb1so16940071fa.2
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 12:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993325; x=1787598125;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W8GI1hbvSFHKG2ZNYw+4KY0Mav74UxN1VixbJcyviAo=;
 b=BXl/FUe4k/9fQvX+j76ONcB1HXx3LW/Ifv0i5lwWpri1HvIFA8x/zblBmBE10Z8oyZ
 UiSt2UKgR4pvwxeLz890qkPr4837hYp96oN5tk8XBFLH4HfKSQQwrCy4WXodMS4E/Z6x
 SN09W6A6i7okloz5V9mlfhwtItHOBqguBkhi0OfVWvOqMat2n5mGlIN57XpRf9rQcom2
 QOlFO1Tu6eM2UOneG7eAWI+DpldUp2pZ79bNbK122BRSzdUYVZ8oa9tbibllvVqP6eXI
 vUCpRiuVNdyHQrUURp52C/AdgsrOpNysulL7TiCHwBECA3JruwFWmcd6NbFxpAdJ7Cq1
 rOqw==
X-Gm-Message-State: AOJu0YxfUMIk9bx1733tx9o8GlGHGJGIA7Le8KxQk6xiI4y8crlPJCof
 h3PnWPIV08SOkXD+23A8TWz0gX9xN+RqL8E0yhvOeSF/SmS/qY9KErSy024t7FeAFjXQB8CObqv
 ZOjbOiB0xRMQIpQxd0ksZI5apsOz/0OQomzydsi6JcE87uKH/KYbXFaFNRU+yQT5C86YgLDRpwW
 gpNrZeJd5Qlmm3tm8ubdKecNsnImWMqq2idtOlxg==
X-Gm-Gg: AR+sD11SotCKixcaJCAYNEAVj9nBSJ3X7jDOYGIGuDgIHQR/vDFNZBJCsLioDcTv1P/
 6WKPOLRLg2QDNpiR2ThUXJDtARvDKwBWW6xvxGPSKqYZ0d35ZVmZfVMfExIHGXpI8hbCN/mVcSf
 xgI12t9z3B6KTtk58TjNU4nlK8CsYGXlZKfa0QnBO2WLuJ9UDmY6VgH2ylNg==
X-Received: by 2002:a05:6512:8059:b0:5b0:177f:beab with SMTP id
 2adb3069b0e04-5b45914168amr3353434e87.44.1786993325102; 
 Mon, 17 Aug 2026 12:02:05 -0700 (PDT)
X-Received: by 2002:a05:6512:8059:b0:5b0:177f:beab with SMTP id
 2adb3069b0e04-5b45914168amr3353423e87.44.1786993324572; Mon, 17 Aug 2026
 12:02:04 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 22:01:48 +0300
X-Gm-Features: AcwNN1WJKDvJoBM4_K0IfNJGdYBVnwu7BRy6pcKz6_GA1KKM_wimiHSIdN3K5kM
Message-ID: <CAHGiOXcygSrBCwc6AfoTiG--t6TOu2wCpYiHBYusiLEO8MNMyQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HnybSlAbBrZ3IJlCviXugDi-tAqLmJ6LshI-OusS3kI_1786993325
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [RFC] kirk/json2logs: "warn" treated as failure + robustness
 improvements
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ICBIaSwKCiAgV2hpbGUgaW52ZXN0aWdhdGluZyB0ZXN0IHJlc3VsdHMgcmVwb3J0ZWQgYXMgZmFp
bHVyZXMsIEkgZm91bmQgdGhhdAogIHRvb2xzL2tpcmsva2lyay1zcmMvdXRpbHMvanNvbjJsb2dz
LnB5IHRyZWF0cyBhbnkgdGVzdCBzdGF0dXMgdGhhdAogIGlzIG5vdCAicGFzcyIgb3IgImNvbmYi
IGFzIGEgZmFpbHVyZS4gVGhpcyBpbmNsdWRlcyAid2FybiIgKFRXQVJOKSwKICB3aGljaCBnZW5l
cmF0ZXMgLmZhaWwubG9nIGZpbGVzIGFuZCBhcHBlbmRzIHRvIGZhaWxzLmxvZy4KCiAgVFdBUk4g
dHlwaWNhbGx5IGluZGljYXRlcyBhIG5vbi1jcml0aWNhbCBpc3N1ZSAoZS5nLiwgY2xlYW51cCB3
YXJuaW5nKSwKICBub3QgYSB0ZXN0IGZhaWx1cmUuIEkgdGhpbmsgdGhpcyBpcyBhbiBpc3N1ZSBi
ZWNhdXNlIGl0IGNyZWF0ZXMgbm9pc2UKICBpbiBmYWlsdXJlIHJlcG9ydHMgYW5kIGNhbiBtYXNr
IHJlYWwgZmFpbHVyZXMuCgogIEJleW9uZCB0aGUgbWlzc2luZyAid2FybiIgZXhjbHVzaW9uLCBJ
IHRoaW5rIHRoZXJlIGFyZSBhIGZldyBvdGhlcgogIGlzc3VlcyBpbiB0aGUgc2NyaXB0OgoKICAx
LiBGcmFnaWxlIGZhaWx1cmUgbG9naWMgKGxpbmUgNDYpOiB0aGUgY2hlY2sgdXNlcyBhIGJsb2Nr
bGlzdAogIChub3QgaW4gKCJwYXNzIiwgImNvbmYiKSkgaW5zdGVhZCBvZiBhbiBhbGxvd2xpc3Qu
IEkgdGhpbmsgdGhpcwogIGlzIGFuIGlzc3VlIGJlY2F1c2UgYW55IG5ldyBzdGF0dXMga2lyayBh
ZGRzIGluIHRoZSBmdXR1cmUgd291bGQKICBzaWxlbnRseSBiZWNvbWUgYSAiZmFpbHVyZSIuIEFu
IGV4cGxpY2l0IGFsbG93bGlzdCB3b3VsZCBiZSBzYWZlcjoKCiAgY3VycmVudCAoYmxvY2tsaXN0
KToKCiAgMS4gaWYgc3RhdHVzIG5vdCBpbiAoInBhc3MiLCAiY29uZiIpOgoKICBwcm9wb3NlZCAo
YWxsb3dsaXN0KToKCiAgMS4gaWYgc3RhdHVzIGluICgiZmFpbCIsICJicm9rIik6CiAgMi4gUGF0
aCBpbmplY3Rpb24gaW4gb3V0cHV0IGZpbGVuYW1lIChsaW5lIDQ4KTogdGhlIHRlc3QgRlFOIGlz
CiAgdXNlZCBkaXJlY3RseSBpbiBmIntmcW59LmZhaWwubG9nIi4gSSB0aGluayB0aGlzIGlzIGFu
IGlzc3VlCiAgYmVjYXVzZSBpZiB0aGUgRlFOIGNvbnRhaW5zICIvIiwgdGhlIGZpbGUgaXMgd3Jp
dHRlbiB0byBhbgogIHVuZXhwZWN0ZWQgZGlyZWN0b3J5LgogIDMuIEVtcHR5IGZhaWxzLmxvZyBh
bHdheXMgY3JlYXRlZCAobGluZSA3NCk6IGV2ZW4gd2hlbiBhbGwgdGVzdHMKICBwYXNzLCBhbiBl
bXB0eSBmYWlscy5sb2cgaXMgd3JpdHRlbi4gSSB0aGluayB0aGlzIGlzIGFuIGlzc3VlCiAgYmVj
YXVzZSBkb3duc3RyZWFtIHRvb2xpbmcgdGhhdCBjaGVja3MgZm9yIHRoZSBmaWxlJ3MgZXhpc3Rl
bmNlCiAgY291bGQgaW50ZXJwcmV0IHRoaXMgYXMgImZhaWx1cmVzIG9jY3VycmVkIi4KCiAgUXVl
c3Rpb25zOgoKICAtIElzIHRyZWF0aW5nICJ3YXJuIiBhcyBmYWlsdXJlIGludGVudGlvbmFsIOKA
lCB0byBlbnN1cmUgd2FybiByZXN1bHRzCiAgZ2V0IHZpc2liaWxpdHkg4oCUIG9yIGEgYnVnPwog
IC0gU2hvdWxkIHRoZSB0ZXN0cyBwcm9kdWNpbmcgVFdBUk4gYmUgaW52ZXN0aWdhdGVkIGFzIHdl
bGwsIG9yIGlzCiAgZml4aW5nIHRoZSByZXBvcnRlciBzdWZmaWNpZW50PwogIC0gV291bGQgeW91
IGFjY2VwdCBhIHBhdGNoIHNlcmllcyBhZGRyZXNzaW5nIGFsbCB0aHJlZSBpc3N1ZXMsIG9yCiAg
cHJlZmVyIHRoZSAid2FybiIgZml4IGFsb25lIGZpcnN0PwoKICBUaGFua3MsCiAgTWljaGFlbCBN
ZW5hc2hlcm92CgotLSAKCk1pY2hhZWwgTWVuYXNoZXJvdgoKU29mdHdhcmUgUXVhbGl0eSBFbmdp
bmVlciAtIEF1dG9tb3RpdmUgS2VybmVsCgpSZWQgSGF0IDxodHRwczovL3d3dy5yZWRoYXQuY29t
Lz4KPGh0dHBzOi8vd3d3LnJlZGhhdC5jb20vPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
