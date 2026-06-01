Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CDECD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 09:40:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDD733E56CF
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 11:40:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06F673CC5FB
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:39:49 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A4877200756
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:39:48 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-516d78df76aso102094021cf.3
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 02:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780306787; x=1780911587; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6emkyLWuMxbtSzmywOJLlZmmi6UEbThXx4ug/bD0fEo=;
 b=tCLYKNzPLZnzHz376cZ4R/MH5CdT1SPNOOEB04rujaJpB8bcSbUIYsAvBUFXq65tjp
 f2ghZltURkFSdrs7rupTSNHX4YGcg6p6Mm027PnVnWmZImw2hOtwSabWQ6Ohn5LcGdTs
 TSpCdlIrEK8p5abrTP5lvcER+vylM/riGKa3FU1tnWbf1+O0OJGCcyyas3o9WR2N/59i
 qOHSiNIkcG2pAXMV5k8NxtV/jsdM626YfN72KJ2sJeQBg9hV4rm4hpmpdF9AXaqSOTdr
 y51Ziv4oTKhctw+CNHI+MlNwipr6bk3ATIZNAtPui1O80fKysvT3bYgVQkKzGUcYrnFf
 xeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306787; x=1780911587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6emkyLWuMxbtSzmywOJLlZmmi6UEbThXx4ug/bD0fEo=;
 b=p65nexbimVmpAIYFl8VvLHpFv4CQxAbVem1LuMBtQ5XeAbXtflFrSQ3vd1PJVuHqEg
 wxrSzPa5oLpdOPnvb+1CJdmPZEI+tEzaii6NlV9uFEpF1zkXxNs4MT6xkr+XA9l/k+zC
 Wxc8mfBybhpZx2vx0KA3Kp5vceD8mGksZbKgJFKBxLYWetZCJ4yS5e6TTWsnDVgKvKwb
 CnV3OHYy8STsf4gw8+FRtlJY0D7w0CJFP7ioztIJAufQHsK/VPjLjdSicUe2O6WiNhTX
 PdV7/pqCF+koPAtCWeJACulMb+NWJJ7xwyU30bkl3D5Okz9MytZhWEe1rNV9Y9TCRRmJ
 aCMw==
X-Gm-Message-State: AOJu0Yy+MSJoLkSmzyKrhliFhol1m5V7WRFoQijeOb0j3qt5yd+Imz1v
 oukm2jKY1qMgK+vmFoI0a93UZgVbNIRe/EOZuXngr2F+gH5ULaRlIZCA
X-Gm-Gg: Acq92OE50NVeQklorz57LEOT/2F28qP9Wex5zz4Nr+/ZgVQN4TWZoBhl2x+0XHkiyDc
 hwzSEIKjLeNAgLO7sRSTfKO55j7Gx/zXFFcwK4/2A78nRXZ3ax95b4Q5w99xSb0Qg7ajynlgrXP
 rUghKrPezvM4dxfcEcTqt8XdcIOmuqZ4vdbb6tPVaHGw9mGoqpLaj7BN2jNjw+w6/qg+oZkmKq9
 TbfNb96Os98cpkchdpCOkMZ9w7jwfaB5zWRqKnw8V1HOs+bqY3mUCqv1sQGBzSNdS4CS7S2ujkV
 Vgdnwr0qOSaBwhtizpszIIbKc2YQ0QdpnC3Pm+/5+xltdQbnDH+MwAL1TJ6hbJxi+8KQd+B9JiJ
 ValsvxTPPx9FQc5YraaGGg4FkXJDgKM0biH45sGFqhNKQJJwo9sHzwzL6MWysKZz4Zyu3UnncJ4
 5kwwoUxIzgnVAg1USRUXXBhuzh9g3pTtThox3puNb4Wsm0r4mwCNXvUuy3vJcNrP5dqLpWVpWNM
 8idYiVBOOkRf9nqKnRWsr+H0JnnKjG/RDvxuClz6NyEUjccr/HKCERHqUTr
X-Received: by 2002:a05:622a:a902:b0:517:28fe:d700 with SMTP id
 d75a77b69052e-5173a79c9c5mr126324661cf.8.1780306787253; 
 Mon, 01 Jun 2026 02:39:47 -0700 (PDT)
Received: from
 runnervm3jyl0.alcvuz05nmmujijktqojz2jv5b.bx.internal.cloudapp.net
 ([20.55.118.116]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517519dfdbcsm26829431cf.7.2026.06.01.02.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:39:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  1 Jun 2026 09:39:46 +0000
Message-ID: <20260601093946.4671-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601-gitignore_ltp_agent-v3-1-b39af1578972@suse.com>
References: <20260601-gitignore_ltp_agent-v3-1-b39af1578972@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] gitignore: ignore ltp-agent setup files
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
Cc: LTP AI Reviewer <ltp-ai@ltp.example.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKT24gTW9uLCAwMSBKdW4gMjAyNiAwODo0NjoxMCArMDIwMCwgQW5kcmVhIENl
cnZlc2F0byB3cm90ZToKPiBnaXRpZ25vcmU6IGlnbm9yZSBsdHAtYWdlbnQgc2V0dXAgZmlsZXMK
CkluZnJhc3RydWN0dXJlLW9ubHkgcGF0Y2ggKGAuZ2l0aWdub3JlYCBvbmx5KSDigJQgY29kZSBy
ZXZpZXcgY2hlY2tsaXN0CnNraXBwZWQgcGVyIHByb3RvY29sLgoKQ09NTUlUIE1FU1NBR0UKLS0t
LS0tLS0tLS0tLS0KVGhlIHN1YmplY3QgZm9sbG93cyA8YXJlYT46IDxkZXNjcmlwdGlvbj4gZm9y
bWF0IHdpdGggaW1wZXJhdGl2ZSBtb29kLgoKVGhlIGJvZHkgYWNjdXJhdGVseSBlbnVtZXJhdGVz
IHRoZSBpbmplY3RlZCBhcnRlZmFjdHM6IEFHRU5UUy5tZCwgR0VNSU5JLm1kLAouYWdlbnRzLCAu
Y2xhdWRlLCBhbmQgdGhlIGFnZW50cy8sIGxpbnRlci8sIHNraWxscy8gc3ltbGlua3MuCgpUaGUg
cmF0aW9uYWxlIGZvciByb290LWFuY2hvcmluZyAvYWdlbnRzLCAvbGludGVyLCBhbmQgL3NraWxs
cyB3aXRoIGEKbGVhZGluZyAnLycgYW5kIG5vIHRyYWlsaW5nIHNsYXNoIGlzIGNvcnJlY3Q6CiAg
LSBMZWFkaW5nICcvJyBwcmV2ZW50cyBzaGFkb3dpbmcgc2FtZS1uYW1lZCBzdWJkaXJlY3Rvcmll
cyBkZWVwZXIgaW4gdGhlCiAgICB0cmVlIChlLmcuIGEgaHlwb3RoZXRpY2FsIHRlc3RjYXNlcy9m
b28vYWdlbnRzLykuCiAgLSBPbWl0dGluZyB0aGUgdHJhaWxpbmcgc2xhc2ggaXMgbmVjZXNzYXJ5
IGJlY2F1c2UgdGhlc2UgYXJlIHN5bWxpbmtzOyBhCiAgICB0cmFpbGluZyBzbGFzaCBpbiAuZ2l0
aWdub3JlIG9ubHkgbWF0Y2hlcyByZWFsIGRpcmVjdG9yaWVzLCBub3Qgc3ltbGlua3MsCiAgICBz
byB0aGUgZW50cmllcyB3b3VsZCBzaWxlbnRseSBmYWlsIHRvIHN1cHByZXNzIHRoZW0gd2l0aG91
dCBpdC4KCi8ucGkvIGNvcnJlY3RseSB1c2VzIGJvdGggYSByb290IGFuY2hvciBhbmQgYSB0cmFp
bGluZyBzbGFzaCAoYWN0dWFsCmRpcmVjdG9yeSwgbm90IGEgc3ltbGluaykuCgpQQVRDSCBDT1JS
RUNUTkVTUwotLS0tLS0tLS0tLS0tLS0tLQpBbGwgbmluZSBhZGRlZCBlbnRyaWVzIG1hcCAxOjEg
dG8gdGhlIGFydGVmYWN0cyBkZXNjcmliZWQgaW4gdGhlIGJvZHkuClRoZSB0d28gY29tbWVudCBo
ZWFkZXJzICgiIyBsdHAtYWdlbnQgc2V0dXAiIGFuZCAiIyBhZ2VudHMgZmlsZXMiKSBjbGVhbmx5
CnNlcGFyYXRlIHRoZSBpbmplY3RlZCBydW50aW1lIGFydGVmYWN0cyBmcm9tIHRoZSBzY3JhdGNo
IHdvcmtpbmcgZmlsZXMuCgpUaGUgdW5hbmNob3JlZCBlbnRyaWVzICguYWdlbnRzLCAuY2xhdWRl
LCByZXZpZXctaW5saW5lLnR4dCwgQUdFTlRTLm1kLApHRU1JTkkubWQpIGxhY2sgYSBsZWFkaW5n
ICcvJy4gVGhpcyBtYWtlcyB0aGVtIG1hdGNoIGFueXdoZXJlIGluIHRoZSB0cmVlLApub3QganVz
dCBhdCB0aGUgcm9vdC4gRm9yIC5hZ2VudHMgYW5kIC5jbGF1ZGUgdGhpcyBpcyBhIHNsaWdodCBv
dmVyc2hvb3QKY29tcGFyZWQgdG8gdGhlIGFuY2hvcmVkIHRyZWF0bWVudCBvZiAvYWdlbnRzLCAv
bGludGVyLCAvc2tpbGxzLCBidXQgdGhlCmNvbW1pdCBib2R5IGRvZXMgbm90IGNsYWltIHRoZXNl
IGFyZSBhbmNob3JlZC4gSW4gcHJhY3RpY2UsIG5vIHRlc3QgY29kZQpjcmVhdGVzIC5hZ2VudHMg
b3IgLmNsYXVkZSBzdWJkaXJlY3Rvcmllcywgc28gbm8gZmFsc2Ugc3VwcHJlc3Npb24gaXMKZXhw
ZWN0ZWQuIFRoaXMgaXMgbm90ZWQgZm9yIGNvbXBsZXRlbmVzcyBidXQgZG9lcyBub3QgcmVxdWly
ZSBhIGZpeC4KClZlcmRpY3Q6IFJldmlld2VkIOKckwoKUmV2aWV3ZWQtYnk6IExUUCBBSSBSZXZp
ZXdlciA8bHRwLWFpQGx0cC5leGFtcGxlLmNvbT4KCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
