Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFF606A32E
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgF4yz26
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03AB03EAC8E
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 16:46:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E9753CA9FE
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 16:39:01 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2487E600A09
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 16:39:01 +0100 (CET)
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-5364648ae07so28758291cf.1
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 07:39:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794411540; cv=none;
 d=google.com; s=arc-20260327;
 b=U1iC4ttOIcbijTHBeCmwuEv0Y22mmihYNoz8VCNQ6akD3+uFbW1P3J7QKeh4+5haYW
 QsQfUDOl6/BGjjvGQ/kktkc1dCo6Hgm3XeQAgYwu24qr5FEGp7yg+ZllqL8XMwsxWahO
 hnTsV/fa+6B4tlHkGYN0+93Mc1Z8qx+WkXjVvcOKfA7rhe3JHb1/iyVPEhz/fpXC/CGx
 kFUwTFrHvWFFzBpdk7hpQJrjhFn8EbN9rm5oorbyi1v4kE03VhYvnEJHmcBp6u0w7qz+
 X55dKsXL+yyyWOJyDzrww2dsZHUdrL8Hop39cVK7bwM2NOnS/kN56H15Gq5L+u0Uc/DV
 DcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=6VHdvmYGZqxtEI+jqNSBdQwN9Gur1iwn4HGPETeN3Hw=;
 fh=zU8f1xnuhXQEVfByqB/ZzFMf+GuUkfEIU5FNyKHWN/Q=;
 b=meo/gOifVCRbITiZabXVnpabzZuidaK3FHI1kCfFV9oNWLdfclrqs8M+/Yp5ytt6/e
 aPkaE3CA+e5yNIb/T1hZFOSWYbYmDaDzoH6BAVSWH2DBuxkXxIWaZlkcI019D7QCZYWk
 KgWY2SOMHbAzHOEKtR//1OvPAxAKkCixjfKvCJogBIt2WB7eD86jcWP0jNN/25xhggtf
 6JFjXN7YeFwpU+mySHN/HFuFQ1U1xK7vsMhV/X7EMFFWHCcYjSWTJiwtkvd7rT6Fht5N
 4C6Pm8R+VuB8QB4cygRfJY3Xw+B114MBjl/JacF5pAbOlg5GDDH5ErrCzQta8sNMxsE8
 l+wA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794411540; x=1795016340; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:references:in-reply-to:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6VHdvmYGZqxtEI+jqNSBdQwN9Gur1iwn4HGPETeN3Hw=;
 b=QgF4yz26S89e0LpTQKO+aWLvS+VZX1jRVZtU32ZSrKGg9j0G5mtZN+YFFH6ECMD9JW
 YyqfVerGMLbbnhuGK0KH5bN5MNguRkRwQF4l0CjW7HPP0wGzETwuSrwGJHmiNLFl5JtN
 B+UA2mqE3bNoZC+UajVN59yrKx0M/TwaMh/2qxy9UYxd4TdX/7QcwR+1IcD5ya8mTMk1
 FtysAhcqycd3/5u1YWpm5BoiSxz2MyM4DH+UJ5DXSQY7uHHz2JUJW9x1AbzYGk2Zhnlk
 NOKaxZsR3L/F17X/+8v0HUfTkmrMglDHcn5R1aUSq6msWfwmqDDxN2QoWgkduSZmtUVr
 gSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794411540; x=1795016340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:references:in-reply-to:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6VHdvmYGZqxtEI+jqNSBdQwN9Gur1iwn4HGPETeN3Hw=;
 b=PQu9+Ku/u0DN8ll6zzAmavfFXA/SRH82E36KulliBWpr8vlBzobIkJMz9Fnl4tYh/C
 4W1SkNqZfCnDoTYLroYZQDPyz08Dt+Xz+foEiB+aOCuFTC7sz7M6HzUMzsldS9f93tIJ
 KAfmdLN+/03U8a0u4s2FephazoBBMF6urVqy7xFiR41TvIrO+ccz9NUMZtnyYnMXrmUn
 Wo9eS9Rh4Pv4YV9nmrt7wVrMIlhvDcyw2mdteAuQRPpgqyYssjOgHCdl+7b9FBsfr7d0
 3WRH3Lhez/H/gfomhDMLmLvl8a+WH31vQ4wMtuOP3fNr4+AGauujW/Bb+wVfHdSt8ZUN
 4P5Q==
X-Gm-Message-State: APuU4Z8qhOU7AK4EjR/YwW4NeKfB3oOdFbfrDuUH80gYaHeHt+Yg0dzk
 Pv7CNJxfxtbe//DPDcETnO8muS1u4j7FlmNTVVN6aZRlWA3qW/d9o/p30xi1oTeEoWn3BJECO0U
 x0u+0NO1urqbm+Nn1c+du3+Z41i99HKTRagVUqrogPQ==
X-Gm-Gg: AYBFou0XYkfoVsjy7KR+vd9zqBH0UJhQRTsYEjjk9ZIUHLMIZ0/uNO3UaVWGcLXY5t7
 Ll0d6pFtSfjQTMdMheCcRPqYlX2E6YoA20qgRgGl5F5cDoFvKkYllUtYQce3cQOlt8esAQUzgmM
 zjHvohbJbpIVERn5N0ssPwIDUCTBiEXfj/85kXDJmu0N4QTS9/ITBwJ/on9QlT0ROXPLPVZ8qF5
 anruum9uDunbh+RpZTne/Wi7YYLQyRFKNx/5N92ou0lDg1+diOm4rJ8f4H8QaYEBGd5RmgxSiqW
 rViRYbMVDDX5YmTxIt3KVHc8Sz+nOCOsigkAjfy3mM8lSiTMPOPfcUfvtzpGnlo0z71Gf0CsNsS
 wzinzh/QPWMG7mDNNbckpPynaZ2hzaEma1uU=
X-Received: by 2002:a05:622a:407:b0:535:19f5:e9da with SMTP id
 d75a77b69052e-556c04f4577mr39919981cf.30.1794411539884; Wed, 11 Nov 2026
 07:38:59 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 11 Nov 2026 07:38:58 -0800
In-Reply-To: <20261111143555.GA763965@pevik>
References: <CAO7_G+wYCDjBpia5UbAJc52v1Rn9uRKoLn=UHhg_U4bs=UYeDA@mail.gmail.com>
 <20261111143555.GA763965@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Hristos Nenkov <nenkov2004@gmail.com>
Date: Wed, 11 Nov 2026 07:38:58 -0800
X-Gm-Features: AclHuK-8ovDDTnKSu0AgfD-ISoSHi4JC16XBvqdp23RPdB4jNAIt3pXHM2dauy0
Message-ID: <CAO7_G+x9gxLtQmOaZkE2V3PDW+P4NKaQbdKZQH2yrbWhUrkuvg@mail.gmail.com>
To: pvorel@suse.cz
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 11 Nov 2026 16:45:35 +0100
Subject: Re: [LTP] [RFC] Proposed scope for replacing FTP/HTTP stress tests
 (#1207)
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClRoYW5rIHlvdSwgdGhhdCBoZWxwcy4KCknigJlsbCBwcm9jZWVkIHdpdGggdGhl
IG5ldHN0cmVzcy5jIGRpcmVjdGlvbiBmaXJzdCBhbmQga2VlcCB0aGUgY2hhbmdlCmFzIHNtYWxs
IGFuZCBzZXBhcmFibGUgYXMgcG9zc2libGUuIEnigJlsbCBwcmVzZXJ2ZSB0aGUgZXhpc3RpbmcK
Y292ZXJhZ2UgZ29hbHMgKGJvdGggdHJhbnNmZXIgZGlyZWN0aW9ucywgbGFyZ2UgdHJhbnNmZXIs
IGJvdW5kZWQKY29uY3VycmVudCB0cmFuc2ZlcnMsIElQdjQvSVB2NikgcmF0aGVyIHRoYW4gdHJl
YXRpbmcgdGhlIHNtYWxsCnJlcGx5LXZhbGlkYXRpb24gcHJvdG90eXBlIGFzIHRoZSBmdWxsICMx
MjA3IHNvbHV0aW9uLgoKQmVmb3JlIHBvc3RpbmcgYW55IHBhdGNoIHRvIExUUCwgSeKAmWxsIGhh
dmUgdGhlIGZpbmFsIGRpZmYgYW5kIHRlc3QKcmVzdWx0cyByZXZpZXdlZCBtYW51YWxseSBhbmQg
d2lsbCBvbmx5IHNlbmQgY2xhaW1zIHRoYXQgYXJlIGJhY2tlZCBieQp0aGF0IHZhbGlkYXRpb24u
CgpLaW5kIHJlZ2FyZHMsCkhyaXN0b3MKCk9uIFdlZCwgMTEgTm92IDIwMjYgMTU6MzU6NTUgKzAx
MDAsIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPiBIaSBIcmlzdG9zLAo+Cj4g
PiBIZWxsbywKPgo+ID4gSSB3b3VsZCBsaWtlIHRvIGNvbnRyaWJ1dGUgYSByZXBsYWNlbWVudCBm
b3IgdGhlIEZUUC9IVFRQIHN0cmVzcyB0ZXN0cwo+ID4gZGVzY3JpYmVkIGluIGlzc3VlICMxMjA3
Ogo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvaXNzdWVzLzEy
MDcKPgo+ID4gQmVmb3JlIGltcGxlbWVudGluZyB0aGUgZnVsbCByZXBsYWNlbWVudCwgY291bGQg
eW91IGNvbmZpcm0gd2hldGhlcgo+ID4gc29tZW9uZSBpcyBhbHJlYWR5IHdvcmtpbmcgb24gaXQs
IGFuZCB3aGV0aGVyIHRoZSBmb2xsb3dpbmcgZGlyZWN0aW9uCj4gPiBpcyBhcHByb3ByaWF0ZT8K
Pgo+IElNSE8gbm9ib2R5IGlzIHdvcmtpbmcgb24gaXQgQVRNLgo+Cj4gPiBJIHByb3Bvc2UgYSBz
ZXBhcmF0ZSBUQ1AgYnVsay10cmFuc2ZlciB0b29sIGludGVncmF0ZWQgd2l0aCB0aGUKPiA+IGN1
cnJlbnQgTFRQIEFQSSBhbmQgdHN0X25ldC5zaCwgY292ZXJpbmcgdXBsb2FkIGFuZCBkb3dubG9h
ZCwgYSBsYXJnZQo+ID4gc2luZ2xlIHRyYW5zZmVyLCBhbmQgYm91bmRlZCBjb25jdXJyZW50IHRy
YW5zZmVycyBmb3IgYSBjb25maWd1cmFibGUKPiA+IGR1cmF0aW9uLiBEYXRhIHdvdWxkIGJlIGdl
bmVyYXRlZCBhbmQgY2hlY2tlZCBpbiBmaXhlZC1zaXplIGJ1ZmZlcnMKPiA+IHVzaW5nIHBvc2l0
aW9uLWRlcGVuZGVudCBwYXR0ZXJucywgd2l0aG91dCBjcmVhdGluZyBtdWx0aS1naWdhYnl0ZQo+
ID4gZmlsZXMuIEJvdGggSVB2NCBhbmQgSVB2NiwgcGFydGlhbCBJL08sIGRlYWRsaW5lcyBhbmQg
b3duZWQtcHJvY2Vzcwo+ID4gY2xlYW51cCB3b3VsZCBiZSBjb3ZlcmVkLiBMZWdhY3kgdGVzdCBy
ZW1vdmFsIHdvdWxkIGZvbGxvdyBvbmx5IGFmdGVyCj4gPiB0aGUgcmVwbGFjZW1lbnQgY292ZXJh
Z2UgaXMgZGVtb25zdHJhdGVkLgo+Cj4gPiBXb3VsZCB5b3UgcHJlZmVyIHRoaXMgc3RhbmRhbG9u
ZSBhcHByb2FjaCwgYXMgc3VnZ2VzdGVkIGluIHRoZSBlYXJsaWVyCj4gPiBkaXNjdXNzaW9uLCBv
ciBleHRlbmRpbmcgbmV0c3RyZXNzIGluc3RlYWQ/IEFyZSB0aGUgZXhpc3RpbmcKPiA+IHRyYW5z
ZmVyLXNpemUgYW5kIGR1cmF0aW9uIHNldHRpbmdzIGltcG9ydGFudCBjb21wYXRpYmlsaXR5Cj4g
PiByZXF1aXJlbWVudHM/Cj4KPiBJZiB0aGUgZGlmZiB3b3VsZCBiZSByZWFzb25hYmx5IHNtYWxs
IGl0J2QgYmUgYmV0dGVyIGV4dGVuZCBuZXRzdHJlc3MuYy4KPiBCdXQgSSdtIG5vdCBzdXJlIGlm
IHRoZXJlIGlzIG11Y2ggY29kZSB0byBiZSByZXVzZWQuCj4KPiA+IFNlcGFyYXRlbHksIEkgaGF2
ZSBhbiBBSS1hc3Npc3RlZCBsb2NhbCBwcm90b3R5cGUgYWRkaW5nIG9wdC1pbiBUQ1AKPiA+IHJl
cGx5IHZhbGlkYXRpb24gdG8gbmV0c3RyZXNzLiBJdCBoYXMgYnVpbHQgb24gVWJ1bnR1L1dTTCBh
bmQgcGFzc2VkCj4gPiAxMSBpc29sYXRlZCByZWNlaXZlIGNoZWNrcyBhbmQgOCBsb29wYmFjayBj
bGllbnQgY2hlY2tzIGFjcm9zcwo+ID4gSVB2NC9JUHY2LiBUaG9zZSByZXN1bHRzIGFwcGx5IG9u
bHkgdG8gdGhhdCBwcm90b3R5cGUsIG5vdCB0aGUKPiA+IHByb3Bvc2VkIGJ1bGstdHJhbnNmZXIg
cmVwbGFjZW1lbnQuIE5vIHBhdGNoIGlzIGF0dGFjaGVkOyBJIGhhdmUgcmVhZAo+ID4gdGhlIHBy
b2plY3QncyBndWlkYW5jZSBvbiBBSS1nZW5lcmF0ZWQgY2hhbmdlcyBhbmQgdW5kZXJzdGFuZCB0
aGF0Cj4gPiBpbmRlcGVuZGVudCByZXZpZXcgYW5kIHZhbGlkYXRpb24gYXJlIHJlcXVpcmVkIGJl
Zm9yZSBhbnkgc3VibWlzc2lvbi4KPgo+IFllcywgaHVtYW4gcmV2aWV3IGJlZm9yZSBzZW5kaW5n
IHRvIExUUCB3b3VsZCBiZSBuaWNlLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ID4gVGhh
bmsgeW91LAo+ID4gSHJpc3RvcyBOZW5rb3YKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
