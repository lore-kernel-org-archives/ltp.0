Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977DCC5475B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 09:16:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5D633CED6B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 10:16:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38F7D3CA0AE
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 10:16:32 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B3E486012A4
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 10:16:31 +0100 (CET)
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7dac7d534e4so882094241.0
 for <ltp@lists.linux.it>; Fri, 01 Mar 2024 01:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709284590; x=1709889390; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVQg79szUnUgLwzBfjY+GDgKbCedKiHLD91e4nfuyc0=;
 b=L5ZQERMHxivmFtLjMudJTRlAt8oOGOEf+TzElN4s5iUN1iIry4LImZC2RCvHCizV2f
 WAmw6k5l+MWUjaXFQf7Wv0ZX8nib10qAsqWtgPPTXubYq6qJDMbQw7+4IO94E/45fQt1
 yy0em2bLJ7+5VfvWxJg9K7cImtInC0Fz5pRjpsNVpnCKxzKKTPAphnPP8xDkeOdiJtEK
 fVb0lDo77MNX9dqS5bWsmwgtEoEUTUPJletwvYqcZsfqK0L4kVlO4P+6xCiWqYT0ajRu
 XdG6jGGLzXRfHcBLSF2OA4gyFDI1TUxmE2tItNlIAvs0L0MgsbqcX1dc8yb7ZRlsg5Oc
 ak3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709284590; x=1709889390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVQg79szUnUgLwzBfjY+GDgKbCedKiHLD91e4nfuyc0=;
 b=AQL48Bf4UDsGgpJ8lBg7w/gKkn2XNPw7GJUpjU3FyvRxD1twh/yUKf4dqLO2q8LxXY
 7YN4ZaMHxXk433oMP9I/d411KOeZGBuyC1CALLZIgNvOIehojnxiT9om7bmNpDbgo1Kn
 HZKViVzoNK1fRdoyeJwz8tnMYeShu2HwiTT1ldjQ+t9kphYfOpRvzwPVndGCTTLybYJB
 tBlBwyH5DZx1mgb9tjPvQFidQsTUNP09ZEVmtUgsz16pEj67RnaoKUm+tPs/hKpay8PV
 vbCNs9oEQdENVtD7MeH7aN2OyVZhW877cH4bxxMwiy2I71FXkh2QduHhMrhTX4HlToCH
 gzEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwZJWOeR3kJrrwiN8tfIxtqi7QTztkzmDpe8oT2TAzS615L1B6XFtmXNwqvqIXSxgW3e0YOLiCr2M0BkarYebuUe0=
X-Gm-Message-State: AOJu0YzOX4EF7ond7sCwNq/mCpHH8o/qoPOS2+hSgqQzmBDMHzsJ0Ibx
 uzOKB1RFsNEmIpsaxAssUPsBpKDeI7UuIwB4tdj0k285xbc9dyH/H1I4poYxd6g/oCCoJHWediM
 7swk2BrolarTG/KdeYd6ig6YyzwQ=
X-Google-Smtp-Source: AGHT+IF+10mb99AVN+K/xOJm0xsyXGe/8f0L+Iakr3Yg322DUCVeTgI6bI+D8KFK/398B1XVygKcHbIIfGNpSnLMsPQ=
X-Received: by 2002:a05:6102:3bee:b0:472:8d0d:1708 with SMTP id
 be14-20020a0561023bee00b004728d0d1708mr789068vsb.19.1709284590574; Fri, 01
 Mar 2024 01:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20240214170949.793338-1-pvorel@suse.cz>
 <20240214170949.793338-4-pvorel@suse.cz>
 <CAEemH2cuq7P_eK8fFR37ZgAF+w84Fkcat_BRM9nmXpmoODkuYg@mail.gmail.com>
 <20240301085916.GA1661970@pevik>
In-Reply-To: <20240301085916.GA1661970@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 1 Mar 2024 11:16:19 +0200
Message-ID: <CAOQ4uxguhb-yRexA=aLCTxzA=mP3T_M7mR+WS4vZuHK8L_XmUw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] tree: Relicense GPL-2.0 (v2 only) =>
 GPL-2.0-or-later
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMSwgMjAyNCBhdCAxMDo1OeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIExpLAo+Cj4gPiBIaSBQZXRyLAo+Cj4gPiBBbGwgbG9va3MgZ29v
ZCB0byBtZS4gRmVlbCBmcmVlIHRvIG1lcmdlIHRoaXMgcGF0Y2hzZXQuCj4KPiBUaGFuayB5b3Uh
IEZZSSBJJ20gc3RpbGwgd2FpdGluZyBmb3IgQW1pcidzIGFjay4KPgoKQWNrZWQtYnk6IEFtaXIg
R29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+CgpUaGFua3MsCkFtaXIuCgo+IEkgZ3Vlc3Mg
d2UgY291bGQgcmVsaWNlbnNlIFJpY2hpZSdzIHdvcmsgd2l0aG91dCBoaXMgYWNrIChTVVNFIHdv
cmsgYWN0dWFsbHkpLAo+IGJ1dCBhdCBsZWFzdCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Ns
b3NlX3JhbmdlL2Nsb3NlX3JhbmdlMDEuYyBpcyBmcm9tCj4ga3NlbGZ0ZXN0ICh0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9jb3JlL2Nsb3NlX3JhbmdlX3Rlc3QuYyksIHdoaWNoIGlzIEdQTCB2Mgo+
IG9ubHksIEkgc3VwcG9zZSBJIHNob3VsZCB1c2UgR1BMLTIuMC1vbmx5IGZvciB0aGlzIG9uZS4K
PiBJIGhhdmVuJ3QgZm91bmQgYSByZWNvcmQgdGhhdCBvdGhlciB0d28gZnJvbSBSaWNoaWUgd291
bGQgYmUgZnJvbSBrc2VsZnRlc3QsCj4gdGh1cyBJJ2xsIHVzZSBHUEwtMi4wLW9yLWxhdGVyIGZv
ciB0aGVtLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
