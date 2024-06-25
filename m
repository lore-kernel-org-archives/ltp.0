Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDCDC2BD09
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 00:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719273941; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fVEL0lOqE+jWuJqcw4RF7NrvKZAXkdfS4hI5mAR43iw=;
 b=aa3wVWw+auhKpWKgbxgvj9k3wOJU94v9Mpyr2166ZMh9E9YlbGt6oBgJumqpvhGJl+Ffx
 NXvyMXdTISlFZLcyypUEDYrBcB0HgdPY+R4rRjADC5FTqJr0jRzXOO57IAhdM0oLKarzlpB
 oxo7kl67dVk07r/Bwzw+aztbRCGdzhU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09D4E3D0FAD
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 02:05:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A5B13CD84E
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 02:05:20 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E0263200C24
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 02:05:19 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a16f4b8bfso3241a12.0
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 17:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719273919; x=1719878719; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maEixEpMIszpZojCGb7/SzxWtQUcDEXPItrSMw28LjE=;
 b=hybzgis5d4cOiP/p1JC6NkhpK6ITXZ1lEK1ErULFGZ47r7PHafU1wyvsthWc7/5Ho3
 N2quRZ/t2Qw6eugYyBBlBycT4WWNBdbyQJk7mKJgPS9JAtUGbP0BnbHyC1a2PMOggoX2
 6DjNr+iOXoFuTxHsS4hhF6IuKt520FLuNx+rgyH/DJOtJhbjfjR7Cp6uzu5h9Eu4VpBY
 dDf3jiSJhQMBs7xx0aK6cvztIXp5RZ4ZFEVDnhQCuwrT5I9NAae02KWiWvLpdrJb8WDq
 az2OLRaRrgPSCV6eDZu1vFo6RnSaekV2cQdvq92Jv+dMXSmmptLGnwIDX0d00iscgOOJ
 jRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719273919; x=1719878719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maEixEpMIszpZojCGb7/SzxWtQUcDEXPItrSMw28LjE=;
 b=VwapJqnk5LnhPi/cxJLoXAVMRQAaFgKMTz51p9ojOEcEgGo0ll07zFzv9vWI0QiaRt
 YjfNHJY+M0OL0bhh3kwNV3SrxOVRgj8O28+OaABkVrgNzMRIMWAoxzMZ/ArZ7nHWjnQv
 JCVhPho3BdwAbMJapulW/qzr7FFbESGfXF3al1EnedXYAW90n0/LnPUAFDH9NwJrTCn2
 OFilMDzWE92P5M1VoJqkisvnL+tg8/PlZl5rfiI4yRfj936QNl+lO7WPbGzoS3QoXJJ5
 TV/By8PhxlIFRdANZTCBOuZuoAUnDIfow2NUR7WYU5cbMAUWtGUzWVN+93wLQ5Xm/lvn
 XiZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIKBzcCjjBSJ5Lj6KC5nfiRvJZ8URnzRNPMu/mgfOXPHEqSnlndn3g4kJi9YastEcoLD3fevxBjvHiMdYuF8rULQo=
X-Gm-Message-State: AOJu0YwsYcZkI50zuh9a0aXOi90We0LRTE4NKLjQzGEgw7IVgYcysKy7
 MD7Hjg1V3S+K8RqsjJmSoZzhty8S8DNVpbxpE7ttf1F0wDRK8xX6qMe5gWA+CE7XyNr4IizDc+q
 YWDxCYAMROy7+jBGFCwLEzl9YFH+ZRGIQr24=
X-Google-Smtp-Source: AGHT+IHJL/9fO7VOsIM7Eb5nC4S2jvrGZ+qnTNNqDx9bS9JUN8AkMpL5Qmwy+iV6ktSZ5BpDZGlg7S2ld7GyKRhxNnQ=
X-Received: by 2002:a05:6402:524b:b0:57d:3d3b:f62f with SMTP id
 4fb4d7f45d1cf-57e97d18cecmr46549a12.1.1719273918946; Mon, 24 Jun 2024
 17:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-3-jstultz@google.com>
 <Zi9jL1jycx6oo37g@yuki>
 <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki> <ZnlORS6RGTAA4UhS@yuki>
In-Reply-To: <ZnlORS6RGTAA4UhS@yuki>
Date: Mon, 24 Jun 2024 17:05:06 -0700
Message-ID: <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it,
 Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMjQsIDIwMjQgYXQgMzo0NeKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+IEZZSSB0aGUgcGF0Y2ggdGhhdCByZW1vdmVzIHRoZSBh
dXRvdG9vbHMgZnJvbSB0aGUgdGVzdGNhc2VzL3JlYWx0aW1lIGhhcwo+IGJlZW4gbWVyZ2VkLCBp
dCBzaG91bGQgYmUgcG9zc2libGUgdG8gdXNlIHRoZSBpbmNsdWRlL3RzdF9hdG9taWMuaCBhbmQK
PiBvdGhlciBoZWFkZXJzIHdpdGhvdXQgY29uZmxpY3RzIG5vdy4KCkhleSBDeXJpbCEKCkkgd2Vu
dCB0byB0YWtlIGEgc3RhYiBhdCB0aGlzLCBidXQgdGhlIG1hc3RlciBicmFuY2ggb24KaHR0cHM6
Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAuZ2l0IGRvZXNuJ3Qgc2VlbSB0byBi
dWlsZDoKICAkIC4vY29uZmlndXJlIC0td2l0aC1yZWFsdGltZS10ZXN0c3VpdGUKICAkIG1ha2Ug
LWogPiAvZGV2L251bGwKbWFrZVszXTogKioqIE5vIHJ1bGUgdG8gbWFrZSB0YXJnZXQgJ01ha2Vm
aWxlLmFtJywgbmVlZGVkIGJ5CidNYWtlZmlsZS5pbicuICBTdG9wLgptYWtlWzJdOiAqKiogWy4u
Ly4uL2luY2x1ZGUvbWsvZ2VuZXJpY190cnVua190YXJnZXQuaW5jOjEwODogYWxsXSBFcnJvciAy
Cm1ha2VbMV06ICoqKiBbLi4vaW5jbHVkZS9tay9nZW5lcmljX3RydW5rX3RhcmdldC5pbmM6MTA4
OiBhbGxdIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZTo4NTogdGVzdGNhc2VzLWFsbF0gRXJy
b3IgMgoKQmlzZWN0aW5nIHBvaW50cyB0byBjb21taXQgYTA1Mjk4ZWM0NDk0ICgidGVzdGNhc2Vz
OiByZWFsdGltZTogR2V0IHJpZApvZiBhdXRvdG9vbHMiKQoKSSdtIHVuZm9ydHVuYXRlbHkgbm90
IHNhdnZ5IGVub3VnaCB3aXRoIGJ1aWxkIHN5c3RlbXMgdG8gaGF2ZSBtdWNoIG9mCmFuIGlkZWEg
b2Ygd2hhdCBpcyBuZWVkZWQgaGVyZS4KCkFueSBzdWdnZXN0aW9ucz8KCnRoYW5rcwotam9obgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
