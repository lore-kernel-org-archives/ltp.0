Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973D8D148A3
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 07:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767857263; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=uvqOw+6K0QETpGn5CJOMtkDZA73YgqxyMA70CaFyY4A=;
 b=rgx4KthJEtjnUkX6bTQs/sTPg91Osk0sqcWdSj2puNXbi1TdumGtICnuvPXRrkUoMEboA
 q1JatOZwTueN2Q4oYY0zEqhWOG53jhom5R6xj/pez0wx6J360Gr0DqG8GTgldBH/rFMvNE5
 XwzV6PB+hkghZVtLEWTNrXpoBA9oRoE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9ECAA3C563C
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 08:27:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54D8E3C029D
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 08:27:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96BD910000EA
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 08:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767857238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RKPQ1jrvfXLJZ42aPQ4351auS+hqmExV5iC/DDomGG8=;
 b=Ri1x6m6fgl9fuYYcsY2exrfnDN3gnjT5aa2jK+/zIxnSrMven6dx6gNfLFX7LPE9PE6Wlq
 4OCy09vaOHhigNIswosKqvRDURNN4Jl06FKtyQfre2NdkVuoJlKCTxBllXswBRLvo5W3wG
 kR3zZOmiAROlU4/lYWLIypR7jQRlbVc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-F-G24cnGMEWYltzz9yVn-Q-1; Thu, 08 Jan 2026 02:27:16 -0500
X-MC-Unique: F-G24cnGMEWYltzz9yVn-Q-1
X-Mimecast-MFC-AGG-ID: F-G24cnGMEWYltzz9yVn-Q_1767857236
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775d8428e8so24708155e9.0
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 23:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767857235; x=1768462035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RKPQ1jrvfXLJZ42aPQ4351auS+hqmExV5iC/DDomGG8=;
 b=DBAxpv4G5hzI1PkaqUhDyZQRSFFFk6P92XWvb6NH30i4S6ZN6XXgZwGsTuz4vLb4n5
 kWBR878UR4DaFCFAAolW73aA2GUQpV85HHXD5n0LAQJ4BXp7AcyjW5CVCjp2NoBNlWVq
 V1SUSvE5Z9TCB9AQsuuOzp8vI8DoldH4feV1vCZnJkcirvtSlO4qqR7iBRum4cho7lgJ
 YZizcwQToOfAyX1gayYFf8P3QcjnMDAx9uJUhIb1oj36Ka9qtHTyTF92mMBsvqzh9ie3
 QFy3A9oarcggIc4tCJPYOBbX3+0/QZiKaovK6SnbEONFU6BwsnPM8YXW/3H4lnOAqlrz
 3YFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN7/vL37cEYWqKY8+JXEWoSDyUV2IPwUDzH/Sik3agdB+sJ8d8fGaAyBF2C0akKSEaZqs=@lists.linux.it
X-Gm-Message-State: AOJu0Yzx1KoSkhfQk3MdQhjHJ83pYg/GudjLZ/j9o9VxMNhv0I/ODh2E
 ZpeiXej0i131zJNe1B+wMFCutonRSJqenCdQGgA4lVxWQ5+OE+pmidQ+9ypM+p08A28DDcknRFR
 u9eKXxRXUhtZp6Lw3XV0LnhrUdzKbKOfWQAxLzisjJVvcHR90SabKHrTA1Uk1lrjmNdq7vBUAAD
 A7UNqLlYR5QrXEVZ672gR6JlDLN7U=
X-Gm-Gg: AY/fxX7f0mWx9JJb5JR7N9lbdiYo+KiS2Va1ZtZ3hx7oBr3IZPl6l6cH9Ruh/sShqvD
 423ay4qFWZlRGcq4O+UAY5/8Lap5U5H6U4ziJObpAO85JGim0w8FmTqGa90Q/3Ov2MsRnq+y5aB
 oUOTN+B7KQNPc2vHcK7SG0ma2dSc5is/7V6e2P1Xw5FmQLPogt16yETPmY9kjfV5q3
X-Received: by 2002:a05:600c:4747:b0:47b:da85:b9ef with SMTP id
 5b1f17b1804b1-47d84b18a7dmr72244625e9.16.1767857235573; 
 Wed, 07 Jan 2026 23:27:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiXe2MGKpolOZQ62z4SfH8wjOrW/cVpB/DIioTNQHAsfBjFW/rPme6izJ0CIcx4yOuAV8xhRt0vkurbNdZW9o=
X-Received: by 2002:a05:600c:4747:b0:47b:da85:b9ef with SMTP id
 5b1f17b1804b1-47d84b18a7dmr72244275e9.16.1767857235217; Wed, 07 Jan 2026
 23:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik> <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik> <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
 <20251215165247.GC282302@pevik> <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
 <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
 <aV6DCbns02E4BCTj@yuki.lan> <20260107160656.GB791855@pevik>
 <aV6G0gxYWHSFkls0@yuki.lan>
In-Reply-To: <aV6G0gxYWHSFkls0@yuki.lan>
Date: Thu, 8 Jan 2026 08:26:58 +0100
X-Gm-Features: AQt7F2pc4_2R8LcFomszxIwJ_2NT-rJRw6a2DJySfp5iI3jPqMvzoCi3igUvGh0
Message-ID: <CAASaF6wOSvi+07Pq5O6+f1Hkrq6WWMgpCaooJxWrO9uOvRM3pw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FiI3DI4mdWeVEJxck3zSmAPWNHAIWC468ByNlH9RRQ8_1767857236
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it, Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gNywgMjAyNiBhdCA1OjE14oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4gPiBUaGFua3MgZm9yIHlvdXIgaW5wdXQuIEkgdW5kZXJz
dGFuZCB0aGF0IHlvdSdyZSBmb3IgcmVwbGFjaW5nIGluIGlvY3RsX25zMDYuYzoKPiA+Cj4gPiAg
ICAgICBpbnQgZXhpc3RzID0gYWNjZXNzKCIvcHJvYy9zZWxmL25zL3VzZXIiLCBGX09LKTsKPiA+
Cj4gPiAgICAgICBpZiAoZXhpc3RzIDwgMCkKPiA+ICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09O
RiwgIm5hbWVzcGFjZSBub3QgYXZhaWxhYmxlIik7Cj4gPgo+ID4gd2l0aCAubmVlZHNfa2NvbmZp
Z3M6Cj4gPgo+ID4gICAgICAgLm5lZWRzX2tjb25maWdzID0gKGNvbnN0IGNoYXIgKltdKSB7Cj4g
PiAgICAgICAgICAgICAgICJDT05GSUdfVVNFUl9OUyIsCj4gPiAgICAgICAgICAgICAgIE5VTEwK
PiA+ICAgICAgIH0KPiA+Cj4gPiBCZWNhdXNlIHRoYXQgd2FzIG15IHF1ZXN0aW9uIC0gcmVhbGx5
IGFsd2F5cyBwcmVmZXIga2NvbmZpZyBldmVuIHRoZXJlIGlzIGEKPiA+IHNpbXBsZSBydW50aW1l
IHNvbHV0aW9uPyBJJ2QgbGlrZSB0byBoYXZlIHNvbWUgInJ1bGUiIGxpa2UgY29uY2x1c2lvbiB3
ZSBjYW4KPiA+IHBvaW50IGR1cmluZyByZXZpZXcuCj4KPiBJIHRoaW5rIHRoYXQgZnJvbSBhIGxv
bmcgdGVybSB2aWV3IHRoaXMgaXMgZ29pbmcgdG8gYmUgc2ltcGxlciBzb2x1dGlvbgo+IHRoYW4g
aGF2aW5nIG1hbnkgZGlmZmVyZW50IHR5cGVzIG9mIGNoZWNrcy4gVGhlIGxlc3MgZGl2ZXJzZSB0
aGVzZQo+IGNoZWNrcyBhcmUgdGhlIGVhc2llciB0aGV5IGFyZSB0byByZXZpZXcgYW5kIG1haW50
YWluLiBIZW5jZSBJIGxlYW4KPiB0b3dhcmRzIGtlcm5lbCBjb25maWcgY2hlY2tzIGV2ZW4gdGhv
dWdoIHRoZXkgYXJlIHNsb3dlciAobW9zdGx5Cj4gdW5tZWFzdXJhYmxlIG9uIHRvZGF5J3MgaGFy
d2FyZSkgdGhhbiB0aGUgYWx0ZXJuYXRpdmVzLgoKSSB0aGluayBJIGxlYW4gb3Bwb3NpdGUgd2F5
LCBhbmQgcmF0aGVyIGhhdmUgYSBjaGVjayBmb3IgcmlnaHQKZW52aXJvbm1lbnQgdG8gc3VwcG9y
dCB0aGUgdGVzdC4KWW91IGNhbiBoYXZlIGZlYXR1cmUgWCBlbmFibGVkIGluIGtlcm5lbCBjb25m
aWcsIGJ1dCBzdGlsbCBkaXNhYmxlZApsYXRlciBhdCBib290L3J1bnRpbWUKKGUuZy4gbWF4X3Vz
ZXJfbmFtZXNwYWNlcz0wKSwgb3IgYSBtb2R1bGUgc2ltcGx5IG5vdCBiZWluZyBsb2FkZWQuCgo+
Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
