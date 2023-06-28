Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CFCEB64DC
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 06:34:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81A023CC8A2
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 08:34:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEDF13C99A3
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 08:33:56 +0200 (CEST)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C4DD41A00989
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 08:33:55 +0200 (CEST)
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-78f32e233a0so1721751241.0
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687934034; x=1690526034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=je3nqrlzOYYQ8SVlBpkmEhHGojppwdW1wOCRKFhydq8=;
 b=aycDb80iFvlZO5zfAexdg8PD9A5Ie5nzLbT9MkcLVji0Psembj+nTTGTcVqNNigMsM
 zwio5/Qpa974Tfb1Q+dixxViDW0cL+dH7EtgM64Te1u200F6qI8tQXDH8SlcrmIo8dQn
 Nxy+Z1CCQBKR0epGBPrWssNDe2Y/X9aSFFOkMGiUV5d6+7HAt32ZDmUmRp7ybbekDL7R
 0kEKqh6RsrRNVcRH93m867k5iZbkbRkWukWWp0fMuIOheAiC1U2tkn1a/JyPQ7aEdawz
 K1D7qmBiyW2IrfNhaywmHwTr731J+AKIRzxeKRnEWb+cLxSgT/u8L0T36hcnrBRv3Oyn
 51lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687934034; x=1690526034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=je3nqrlzOYYQ8SVlBpkmEhHGojppwdW1wOCRKFhydq8=;
 b=V2J2YujFFRdNqnpljRwqCyhEHnWgDujihJPrRInjjRaHGPIXucT1YLi0qINwjs09Vm
 Fk0peMsWzduMBSdObno5Aa4AES/CaeNzAnJgc7Tb/lLCwoEsIDfpHkYmxma7S1jot/QC
 STAg6LN7YgC1TCBbuExIfm1etN94E0N1f39IRE1+/wB1neEiY9HK3+pMxj+lLmcMrLPv
 paPNLps3kdzaIe/45qRwDAJSogZgOAdn3NV4FwxPrJR/I7ZEX2LHgXd5hlHj+PxPGv5y
 DJwmPU0HzLYHbkJZOJMgfIOQgVixImxwu1HJeiTTXzCoPt+ehRT5eOwRD0702x6JCRHR
 3lkg==
X-Gm-Message-State: AC+VfDx1bL6jgn6M+aFnzNYAa6ntvAyxU0oSlgNlStY6jmGfSARfOqa+
 X8lLkk1crUi0GfBeeb71VhBUzDkJP1UbenxOqBU=
X-Google-Smtp-Source: ACHHUZ4JN7p6ItoNPYh7eS98JRlbu/gVY84GPPJWjXmp/ureK/2segLM+RbikIgw2h1/OPGJRrQjuXLmOsfcGV7BKag=
X-Received: by 2002:a05:6102:142:b0:440:e0ef:4cd0 with SMTP id
 a2-20020a056102014200b00440e0ef4cd0mr9541101vsr.27.1687934034587; Tue, 27 Jun
 2023 23:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Jun 2023 09:33:43 +0300
Message-ID: <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Chung-Chiang Cheng <cccheng@synology.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgMTE6NTDigK9QTSBBaGVsZW5pYSBaaWVtaWHFhHNrYQo8
bmFiaWphY3psZXdlbGlAbmFiaWphY3psZXdlbGkueHl6PiB3cm90ZToKPgo+IFRoZSBjdXJyZW50
IGJlaGF2aW91ciBjYXVzZWQgYW4gYXN5bW1ldHJ5IHdoZXJlIHNvbWUgd3JpdGUgQVBJcwo+ICh3
cml0ZSwgc2VuZGZpbGUpIHdvdWxkIG5vdGlmeSB0aGUgd3JpdHRlbi10by9yZWFkLWZyb20gb2Jq
ZWN0cywKPiBidXQgc3BsaWNlIHdvdWxkbid0Lgo+Cj4gVGhpcyBhZmZlY3RlZCB1c2Vyc3BhY2Ug
d2hpY2ggdXNlcyBpbm90aWZ5LCBtb3N0IG5vdGFibHkgY29yZXV0aWxzCj4gdGFpbCAtZiwgdG8g
bW9uaXRvciBwaXBlcy4KPiBJZiB0aGUgcGlwZSBidWZmZXIgaGFkIGJlZW4gZmlsbGVkIGJ5IGEg
c3BsaWNlLWZhbWlseSBmdW5jdGlvbjoKPiAgICogdGFpbCB3b3VsZG4ndCBrbm93IGFuZCB0aHVz
IHdvdWxkbid0IHNlcnZpY2UgdGhlIHBpcGUsIGFuZAo+ICAgKiBhbGwgd3JpdGVzIHRvIHRoZSBw
aXBlIHdvdWxkIGJsb2NrIGJlY2F1c2UgaXQncyBmdWxsLAo+IHRodXMgc2VydmljZSB3YXMgZGVu
aWVkLgo+IChGb3IgdGhlIHBhcnRpY3VsYXIgY2FzZSBvZiB0YWlsIC1mIHRoaXMgY291bGQgYmUg
d29ya2VkIGFyb3VuZAo+ICB3aXRoIC0tLWRpc2FibGUtaW5vdGlmeS4pCj4KCklzIG15IHVuZGVy
c3RhbmRpbmcgb2YgdGhlIHRhaWwgY29kZSB3cm9uZz8KTXkgdW5kZXJzdGFuZGluZyB3YXMgdGhh
dCB0YWlsX2ZvcmV2ZXJfaW5vdGlmeSgpIGlzIG5vdCBjYWxsZWQgZm9yCnBpcGVzLCBvciBpcyBp
dCBiZWluZyBjYWxsZWQgd2hlbiB0YWlsaW5nIGEgbWl4ZWQgY29sbGVjdGlvbiBvZiBwaXBlcwph
bmQgcmVndWxhciBmaWxlcz8gSWYgdGhlcmUgYXJlIHN1YnRsZXRpZXMgbGlrZSB0aG9zZSB5b3Ug
bmVlZCB0bwptZW50aW9uIHRoZW0gLCBvdGhlcndpc2UgcGVvcGxlIHdpbGwgbm90IGJlIGFibGUg
dG8gcmVwcm9kdWNlIHRoZQpwcm9ibGVtIHRoYXQgeW91IGFyZSBkZXNjcmliaW5nLgoKSSBuZWVk
IHRvIHdhcm4geW91IGFib3V0IHNvbWV0aGluZyByZWdhcmRpbmcgdGhpcyBwYXRjaCAtCm9mdGVu
IHRoZXJlIGFyZSBjb2xsaWRpbmcgaW50ZXJlc3RzIGFtb25nIGRpZmZlcmVudCBrZXJuZWwgdXNl
cnMgLQpmc25vdGlmeSB1c2UgY2FzZXMgcXVpdGUgb2Z0ZW4gY29sbGlkZSB3aXRoIHRoZSBpbnRl
cmVzdCBvZiB1c2VycyB0cmFja2luZwpwZXJmb3JtYW5jZSByZWdyZXNzaW9ucyBhbmQgSU5fQUND
RVNTL0lOX01PRElGWSBvbiBhbm9ueW1vdXMgcGlwZXMKc3BlY2lmaWNhbGx5IGhhdmUgYmVlbiB0
aGUgc291cmNlIG9mIHNldmVyYWwgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiByZXBvcnRzCmluIHRo
ZSBwYXN0IGFuZCBoYXZlIGRyaXZlbiBvcHRpbWl6YXRpb25zIGxpa2U6Cgo3MWQ3MzQxMDNlZGYg
KCJmc25vdGlmeTogUmVhcnJhbmdlIGZhc3QgcGF0aCB0byBtaW5pbWlzZSBvdmVyaGVhZAp3aGVu
IHRoZXJlIGlzIG5vIHdhdGNoZXIiKQplNDNkZTdmMDg2MmIgKCJmc25vdGlmeTogb3B0aW1pemUg
dGhlIGNhc2Ugb2Ygbm8gbWFya3Mgb2YgYW55IHR5cGUiKQoKVGhlIG1vcmFsIG9mIHRoaXMgc3Rv
cnkgaXM6IGV2ZW4gaWYgeW91ciBwYXRjaGVzIGFyZSBhY2NlcHRlZCBieSBmc25vdGlmeQpyZXZp
ZXdlcnMsIG9uY2UgdGhleSBhcmUgc3RhZ2VkIGZvciBtZXJnaW5nIHRoZXkgd2lsbCBiZSBzdWJq
ZWN0IHRvCnBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gdGVzdHMgYW5kIEkgY2FuIHRlbGwgeW91IHdp
dGggY2VydGFpbnR5IHRoYXQKcGVyZm9ybWFuY2UgcmVncmVzc2lvbiB3aWxsIG5vdCBiZSB0b2xl
cmF0ZWQgZm9yIHRoZSB0YWlsIC1mIHVzZSBjYXNlLgpJIHdpbGwgcHVzaCB5b3VyIHY0IHBhdGNo
ZXMgdG8gYSBicmFuY2ggaW4gbXkgZ2l0aHViLCB0byBsZXQgdGhlIGtlcm5lbAp0ZXN0IGJvdHMg
cnVuIHRoZSBwZXJmb3JtYW5jZSByZWdyZXNzaW9ucyBvbiBpdCB3aGVuZXZlciB0aGV5IGdldCB0
byBpdC4KCk1vcmVvdmVyLCBpZiBjb3JldXRpbHMgd2lsbCBjaGFuZ2UgdGFpbCAtZiB0byBzdGFy
dCBzZXR0aW5nIGlub3RpZnkgd2F0Y2hlcwpvbiBhbm9ueW1vdXMgcGlwZXMgKG15IHVuZGVyc3Rh
bmRpbmcgaXMgdGhhdCBjdXJyZW50bHkgZG9lcyBub3Q/KSwKdGhlbiBhbnkgdGFpbCAtZiBvbiBh
bm9ueW1vdXMgcGlwZSBjYW4gY3JpcHBsZSB0aGUgIm5vIG1hcmtzIG9uIHNiIgpwZXJmb3JtYW5j
ZSBvcHRpbWl6YXRpb24gZm9yIGFsbCBhbm9ueW1vdXMgcGlwZXMgYW5kIHRoYXQgd291bGQgYmUK
YSAqdmVyeSogdW5mb3J0dW5hdGUgb3V0Y29tZS4KCkkgdGhpbmsgd2UgbmVlZCB0byBhZGQgYSBy
dWxlIHRvIGZhbm90aWZ5X2V2ZW50c19zdXBwb3J0ZWQoKSB0byBiYW4Kc2IvbW91bnQgbWFya3Mg
b24gU0JfS0VSTk1PVU5UIGFuZCBiYWNrcG9ydCB0aGlzCmZpeCB0byBMVFMga2VybmVscyAoSSB3
aWxsIGxvb2sgaW50byBpdCkgYW5kIHRoZW4gd2UgY2FuIGZpbmUgdHVuZQp0aGUgc19mc25vdGlm
eV9jb25uZWN0b3JzIG9wdGltaXphdGlvbiBpbiBmc25vdGlmeV9wYXJlbnQoKSBmb3IKdGhlIFNC
X0tFUk5NT1VOVCBzcGVjaWFsIGNhc2UuClRoaXMgbWF5IGJlIGFibGUgdG8gc2F2ZSB5b3VyIHBh
dGNoIGZvciB0aGUgZmFpdGggb2YgTkFDS2VkCmZvciBwZXJmb3JtYW5jZSByZWdyZXNzaW9uLgoK
PiBHZW5lcmF0ZSBtb2RpZnkgb3V0IGJlZm9yZSBhY2Nlc3MgaW4gdG8gbGV0IGlub3RpZnkgbWVy
Z2UgdGhlCj4gbW9kaWZ5IG91dCBldmVudHMgaW4gdGhyIGlwaXBlIGNhc2UuCgpUaGlzIGNvbW1l
bnQgaXMgbm90IGNsZWFyIGFuZCBkb2VzIG5vdCBiZWxvbmcgaW4gdGhpcyBjb250ZXh0LApidXQg
aXQgdmVyeSBtdWNoIGJlbG9uZ3MgbmVhciB0aGUgY29kZSBpbiBxdWVzdGlvbi4KClBsZWFzZSB3
YWl0IHRvIGNvbGxlY3QgbW9yZSBmZWVkYmFjayBhbmQgc3BlY2lmaWNhbGx5CnRvIGhlYXIgd2hh
dCBKYW4gaGFzIHRvIHNheSBhYm91dCB0aGlzIGhhY2sgYmVmb3JlIHBvc3RpbmcgdjUhCgpGWUks
IHdlIGFyZSBub3cgaW4gdGhlIGJlZ2lubmluZyBvZiB0aGUgNi41ICJtZXJnZSB3aW5kb3ciLAp3
aGljaCBtZWFucyB0aGF0IG1haW50YWluZXJzIG1heSBiZSBsZXNzIHJlc3BvbnNpdmUgZm9yIHRo
ZQpuZXh0IHR3byB3ZWVrcyB0byBub24tY3JpdGljYWwgcGF0Y2hlcyBhcyB0aGlzIG9uZSwgd2hp
Y2ggYXJlCm5vdCB0YXJnZXRlZCBmb3IgdGhlIDYuNSBrZXJuZWwgcmVsZWFzZS4KClRoYW5rcywK
QW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
