Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D224E65298
	for <ltp@archiver.kernel.org>; Sun,  1 Feb 2026 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769990018; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CCG0/xSOgPGgS+iMocr+mdDhxULHwMSzQ7BI+Jl6w6c=;
 b=GqRbyCWhGuK+3OxMvE/vX7GDXeJVkunS0s6Z1nt7Vt8kpC7FOIgstGZgfAlNcw8Fo9jji
 RCydrLgVN0NyHujGz0z/sJBp5phkVNzS6OTf0ENYl1r4/OuwTXjtaUbQI2BjdosAAnrZqME
 y174m5ceKOg9aMUv6WBjIxqvEZXtGOg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D8153CCD55
	for <ltp@archiver.kernel.org>; Mon,  2 Feb 2026 00:53:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D6563CC814
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 00:53:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 918D020090C
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 00:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769989992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9d4ralEO8HIjWAiDGROfN2V6sCAsOCd8OlwSzkQzs9w=;
 b=Sky6xOZqICG6IvEX6gSrL1MvJZzW4+vmZfc7evnnA+D2DEFag0T0PHcL8t4VUQ4EYvatcI
 7t8dno4iPJfr15eTwTTVANdnNZ4kxn5bRakjQjEaVrwmsjN+Wrsb3aiFeuMb8xL0HsRRRx
 ee6o/ghfiW49+kctB+IGOSBXa0/LeNU=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-FNM4ad5RMsSdBLoxwO-3Pw-1; Sun, 01 Feb 2026 18:53:10 -0500
X-MC-Unique: FNM4ad5RMsSdBLoxwO-3Pw-1
X-Mimecast-MFC-AGG-ID: FNM4ad5RMsSdBLoxwO-3Pw_1769989989
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-124ac76ea5bso31518739c88.0
 for <ltp@lists.linux.it>; Sun, 01 Feb 2026 15:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769989989; x=1770594789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d4ralEO8HIjWAiDGROfN2V6sCAsOCd8OlwSzkQzs9w=;
 b=qZfN3LThZKolgDANf2CeOzZwipw6z3lO6mhHg6shkYZn0eJiDtnidBH2jno6CEif1T
 HUQ4bGXdnFgxgxX1DxTAKEOMp6C2MqGX9w5RUA6OQlVuXlZ2DOGQaS25oG4iQDl/hPMn
 rLWPymFFWTG3TwK7UHk/quGBE65URTRyqOB3h7vvKwAPskr7xuX8YZyh4zPrhAGPQl2J
 Q32eLcOu3EegCxYiYiqzssFTpby9NBl1mrqxPkYSRkLAl4xUxLrodXbt88JqdFNg899u
 cwyAiZTSAtETkl4ZEXEOnLHWXBlagspq+Lp5xK9QQ9Rgp3HyXIq7u2OuyXQLdveEG6T+
 cQkw==
X-Gm-Message-State: AOJu0Yy3pyP61stB+1OdTXdLhfGSvuCHQJdx4qYld70ogRq3wd6WkxFE
 1dBrbxXpTf1PjslZwtjlBcldifXRHvl3d+Q/DZqUVM2Roa9RkxLobVtbanZEci+1n2a9xEPOh23
 mpunqH90z4yg6jI163uhyeiuoqnrQV/4T6kQoj54bt+muDCEpZOzLzmefW56R1DWcSI5+AR2LsI
 Xnxl52SBo/0fM4JCItC8DUktiZwkE=
X-Gm-Gg: AZuq6aL7HUY8vSGSuOJ/cjMxSF8Y2KsCRn7ouT/Nbm4oedpynq4EPWyvmX1T41Rd+73
 yhXEund+aKll8RoXaNEzJ8ZfFVk9RIu1T1SLl+d3A1uE7F/XOkgzV+31RSJKeZeoeflVZwkOgvj
 mLoc45U3zVbh2TBtONMGFlVARfWBaNK1NtMOO+OfgYvW33jghoJ9zTAzTJYuPz8BA6ttU=
X-Received: by 2002:a05:7022:6b94:b0:125:be41:db5b with SMTP id
 a92af1059eb24-125c10153admr4973505c88.42.1769989989361; 
 Sun, 01 Feb 2026 15:53:09 -0800 (PST)
X-Received: by 2002:a05:7022:6b94:b0:125:be41:db5b with SMTP id
 a92af1059eb24-125c10153admr4973494c88.42.1769989988944; Sun, 01 Feb 2026
 15:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20260116022507.204549-1-liwang@redhat.com>
 <20260116022507.204549-2-liwang@redhat.com>
 <20260128212207.GA60105@pevik>
 <CAEemH2fkn3C4ov0YL9sx5SiBMuWEOoNfrwAzEsOwCZZDTtuEwA@mail.gmail.com>
 <20260128232616.GA69843@pevik>
In-Reply-To: <20260128232616.GA69843@pevik>
Date: Mon, 2 Feb 2026 07:52:56 +0800
X-Gm-Features: AZwV_QgdJzsdTaOCcP08edSwLXIhP5OIXecEitsbS6Vw4I2_jVkC4GED3xWRqec
Message-ID: <CAEemH2fj4JWWyKgr024EtkyG0t2TyEDcy2NVsOus4cFj+o32hg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZngRxwwn2PgDcsb5HcR7bZQQ_ta4pjS2QqG_a9iZX64_1769989989
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] include/old: rename legacy headers to
 tso_* namespace
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

T24gVGh1LCBKYW4gMjksIDIwMjYgYXQgNzoyNuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIGFsbCwKPgo+ID4gPiBBcyBJIHdyb3RlLCBJIGRvbid0IGxp
a2UgdGhlIHdob2xlIHJlbmFtZSBidXQgSSB3aWxsIG5vdCBibG9jayBpdC4KPiA+ID4gSSBndWVz
cyBpdCB3aWxsIGJlIG1lcmdlZCBhZnRlciB0aGUgcmVsZWFzZSwganVzdCBub3QgdG8gYnJlYWsK
PiBhbnl0aGluZy4KPgo+ID4gPiBCdXQgaXMgaXQgd29ydGggdG8gcmVuYW1lIHdob2xlIG9sZCBB
UEkgc291cmNlcyBhbmQgaGVhZGVycz8gSXNuJ3QgaXQKPiA+ID4gZW5vdWdoCj4gPiA+IGp1c3Qg
dG8ga25vdyB0aGF0ICd0c3RfJyBvciAndHNlXycgYXJlIG5ldyBBUEksIHRoZSByZXN0IGlzIHRo
ZSBvbGQKPiBBUEkgb3IKPiA+ID4gbm8KPiA+ID4gQVBJPyBFYWNoIHJlbmFtZSBtZWFucyB0aGF0
ICdnaXQgbG9nJyByZXF1aXJlcyAnLS0nIGJlY2F1c2UgdGhlIHJlbmFtZS4KPgo+Cj4gPiBXZWxs
LCB5ZXMsIHRoYXQncyBteSBoZXNpdGF0aW9uIHRvby4KPgo+ID4gSG93ZXZlciwgSSBiZWxpZXZl
IHRoZSBvbGQgQVBJcyBtYXkgcGVyc2lzdCBmb3IgYSBsb25nIHRpbWUuIFRoZXJlZm9yZSwKPiA+
IHVzaW5nIGNvbnNpc3RlbnQgbmFtaW5nIGNvbnZlbnRpb25zIGZvciBhbGwgQVBJcyB3aWxsIG1h
a2UgaXQgZWFzaWVyIGZvcgo+ID4gTFRQIGJlZ2lubmVycyB0byB1bmRlcnN0YW5kIHRoZSBjb2Rl
IGxvZ2ljLgo+Cj4gT0suIEFjayBmb3IgYm90aCBjb21taXRzLgo+IEFja2VkLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKQm90aCBtZXJnZWQsIHRoYW5rIHlvdS4KCgotLSAKUmVn
YXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
