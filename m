Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E587FC0219D
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 15:11:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 764FD3C9A94
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 16:11:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FD493C010E
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 16:11:06 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9BD601036E3E
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 16:11:05 +0100 (CET)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-308e92c3779so22047631fa.0
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 07:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739459465; x=1740064265; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lV+7sWO3ccm5XTOkrmkz6Uik6fKOsmUgYvNbnBGVtdQ=;
 b=g+qCoocPd28U5hTDJ3dinddNeGXGHHXYVmp0C+/4zrCvS/ySsWL4O860HTMQPMjV4M
 t7pkqtbmcJisut9CE+pdNllFHnQe5GMJeUt+1z2bD/qP2A51p4RXGjIjZHQJRjkzr+0j
 v0hA7tjEGdV/MnQHS1dJ+6sCKHGj5cQg5btm5Yk9x0E5311yUVqKGJkXgz9L8EV9TDj2
 kG09fO5meQL7ZLSJPNzE+tdrcvJXlUPVZPbApVtLRhX+unmyspvxsW+6WLtLolaeh+03
 jYUlxxZc96rh6j782KJA0q+yj//OKHDVID3Zl+StZZhO9r1y0v1DU4qKCy07YFGwOseu
 V8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739459465; x=1740064265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lV+7sWO3ccm5XTOkrmkz6Uik6fKOsmUgYvNbnBGVtdQ=;
 b=fQi4NthW3Q+Elu0b2JGNy+Lo4Ry0bPJg9+mLnAtvy3FltZytOD+dR87DWO1XU4OCno
 NVKxA9ZQf9hgFQHhbvs8/nuiutdEeLVN1tuHSCgZSGWX5avnJN9YhAwuPAoXOaYh0xC/
 lr/zsMDJ+W/cMi4Ok5bfXD9ipPofJq/fUQb2+DDsr52srYyptQ1U6QKFLqGfv3Eod68T
 h8XxwbtDzocVcRPF2kdowz20cf/+mT91PmZxo4Y2qcVsGY0lN3ZEHFgMWFP57wZCBpnr
 1ea/ohUXKfRE5ddeLHp3kWeF9wPOySkpztOLPyJsbogd5i4btEEbdDRew/gVM7M7Ateg
 lhBg==
X-Gm-Message-State: AOJu0Yyag/Rf/Ja0xyJMkdouzNtqvtzjKEMNkdghrJ/m1eIB+hkySjWu
 vJiyLPqLpIkj7awHOrUCaSiwpi4gBsg1zVzRJvUp+xpNFuTX7cD0rRP78ExSgMHJGgiiuGlI9U5
 ynXGOyA2V+GUxXKqsCola3hHgyGg=
X-Gm-Gg: ASbGncsu3zL2S1ckPn0MSRXKndmE0RVAc0nQpI1RXt2YdoFYcdqXn7qDNen/cDzxxHW
 gGMZRnrgfoqo9cbpzDLuUsjC4u+Oq/phuXz26FsoBJl7GGZWQqTDYycm+wQz6jp6W2MIN/kuC
X-Google-Smtp-Source: AGHT+IGtDHx9KzemwxhoqsJIxwD7YHRmEWVKOtTLTGzFWTuO1PC1YRbfP26nSHuvLb545qjuzKoCHmDXqb/oi+xKthA=
X-Received: by 2002:a05:6512:401e:b0:545:649:d4fb with SMTP id
 2adb3069b0e04-5451dfdbff2mr864296e87.13.1739459462536; Thu, 13 Feb 2025
 07:11:02 -0800 (PST)
MIME-Version: 1.0
References: <CADJHv_v7BZORM+E6fMBD_TX_+uym7GuykqbpAaLqmCvqymOgCQ@mail.gmail.com>
 <CAOQ4uxhxeihXm_AsztvZ4v3bw=y8aQWpGvhEO1ONOXNM03pwdw@mail.gmail.com>
 <CADJHv_t_tSqeUqhgbS-LxH72EwuKZhTgdVCzo0AmqppJPJ-Bfg@mail.gmail.com>
In-Reply-To: <CADJHv_t_tSqeUqhgbS-LxH72EwuKZhTgdVCzo0AmqppJPJ-Bfg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Feb 2025 16:10:51 +0100
X-Gm-Features: AWEUYZnNK1FD3RoCq8CxeC58A7JvgJvD4gC9PD9vEzKxCve1kZI7405TFrgWfVs
Message-ID: <CAOQ4uxjupgRvBhUEbHZzXTnjmGbk5H14ytQiRX=n5yPifvtbsA@mail.gmail.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP/fanotify01 corner case
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMjEsIDIwMjQgYXQgMzowMuKAr0FNIE11cnBoeSBaaG91IDxqZW5jY2Uua2Vy
bmVsQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gV2VkLCBNYXkgMTUsIDIwMjQgYXQgMjoz
N+KAr0FNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBP
biBUdWUsIE1heSAxNCwgMjAyNCBhdCAxOjIx4oCvQU0gTXVycGh5IFpob3UgPGplbmNjZS5rZXJu
ZWxAZ21haWwuY29tPiB3cm90ZToKPj4gPgo+PiA+IEhpIEFtaXIsCj4+ID4KPj4gPiBXaGVuIFRN
UERJUiBpcyBvbiBORlMsIGZhbm90aWZ5MDEgZ2V0IEVOT0RFViB3aGVuIHRlc3RpbmcgaWYgaXQg
c3VwcG9ydHMgcmVwb3J0aW5nIGV2ZW50cyB3aXRoIGZpZCBmcm9tIG11bHRpIGZzIGluIHNldHVw
KCk6Cj4+ID4KPj4gPj4gICAgICAgICBpZiAoZmFub3RpZnlfZmxhZ3Nfc3VwcG9ydGVkX29uX2Zz
KEZBTl9SRVBPUlRfRklELCBGQU5fTUFSS19NT1VOVCwgRkFOX09QRU4sICIuIikpIHsKPj4gPj4g
ICAgICAgICAgICAgICAgIGlub2RlX21hcmtfZmlkX3hkZXYgPSBlcnJubzsKPj4gPj4gICAgICAg
ICAgICAgICAgIHRzdF9yZXMoVElORk8sICJUTVBESVIgZG9lcyBub3Qgc3VwcG9ydCByZXBvcnRp
bmcgZXZlbnRzIHdpdGggZmlkIGZyb20gbXVsdGkgZnMiKTsKPj4gPj4gICAgICAgICB9Cj4+ID4K
Pj4gPgo+PiA+IGxhdGVyIGluIHRlc3RfZmFub3RpZnkoKSwgZmRfbm90aWZ5IGZpcnN0bHkgZ2V0
cyBhZGRlZCBhIG1hcmsgZm9yIHRoZSBmcyBtb3VudGVkIHdpdGhpbiB0aGUgTkZTIFRNUERJUiwK
Pj4gPgo+PiA+IGFuZCB0aGVuIGF0IHRoZSBlbmQgb2YgdGVzdF9mYW5vdGlmeSgpLCBhZGRlZCBh
bm90aGVyIG1hcmsgZm9yIHRoZSBUTVBESVIgd2hpY2ggaXMgTkZTIGluIHRoaXMgY2FzZSwgYW5k
IGNoZWNrIG9uIHRoZSBlcnJubzoKPj4gPgo+PiA+PiAgICAgICAgIHJldCA9IHJlcG9ydF9maWQg
PyBpbm9kZV9tYXJrX2ZpZF94ZGV2IDogMDsKPj4gPj4gICAgICAgICBUU1RfRVhQX0ZEX09SX0ZB
SUwoZmFub3RpZnlfbWFyayhmZF9ub3RpZnksIEZBTl9NQVJLX0FERCwgRkFOX0NMT1NFX1dSSVRF
LAo+PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFUX0ZEQ1dE
LCAiLiIpLCByZXQpOwo+PiA+Cj4+ID4KPj4gPgo+PiA+IEl0IHdvcmtlZCBmaW5lIHRpbGwKPj4g
Pgo+PiA+PiBjb21taXQgMzBhZDE5MzgzMjZiZjkzMDNjYTM4MDkwMzM5ZDk0ODk3NWE2MjZmNQo+
PiA+PiBBdXRob3I6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4+ID4+IERh
dGU6ICAgVGh1IE5vdiAzMCAxODo1NjoxOSAyMDIzICswMjAwCj4+ID4+Cj4+ID4+ICAgICBmYW5v
dGlmeTogYWxsb3cgIndlYWsiIGZzaWQgd2hlbiB3YXRjaGluZyBhIHNpbmdsZSBmaWxlc3lzdGVt
Cj4+ID4KPj4gPgo+PiA+IEFmdGVyIHRoaXMgY29tbWl0IHdhcyBtZXJnZWQsIHRoZSBmaXJzdCBj
aGVjayBnb3QgRU5PREVWIGFuZCB0aGUgc2Vjb25kIGNoZWNrIGdvdCBFWERFVi4KPj4gPgo+PiA+
IFRoZSBib3RoIHZhbHVlcyBtYWtlIHNlbnNlIGluIHRoZWlyIHNpdHVhdGlvbiwgYnV0IGl0IHNl
ZW1zIGxpa2UgdXNpbmcgb25lIHZhbHVlIGFzIGV4cGVjdGVkIHZhbHVlIGZvciBhbm90aGVyIHNl
ZW1zIG5vdCBhY2N1cmF0ZSBoZXJlIGZvciBtZS4gSSBkb24ndCBrbm93IG11Y2ggaGVyZSwgeW91
ciBoZWxwIGlzIG11Y2ggYXBwcmVjaWF0ZWQuCj4+Cj4+IFlvdXIgYW5hbHlzaXMgaXMgZXhhY3Qg
YW5kIGNvcnJlY3QuCj4+Cj4+IFRoZSBjb21taXQgYWJvdmUgY2F1c2VkIGEgYmVoYXZpb3IgY2hh
bmdlIGluIHRoYXQgY2FzZSBtb3ZpbmcgZnJvbSBvbmUKPj4gZXJyb3IgdGhhdCBtYWtlcyBzZW5z
ZSB0byBhbm90aGVyIGVycm9yIHRoYXQgbWFrZXMgc2Vuc2UgYW5kIHRoZSB0ZXN0Cj4+IHNob3Vs
ZCBjb3BlIHdpdGggdGhhdC4KPj4KPj4gVGhlIGVhc2llc3Qgd291bGQgYmUgdG8gb3BlbiBjb2Rl
IFRTVF9FWFBfRkRfT1JfRkFJTCgpCj4+IGhlbHBlciBhbmQgY2hlY2sgZm9yIGVpdGhlcgo+PiBl
cnJubyA9PSBpbm9kZV9tYXJrX2ZpZF94ZGV2IHx8IGVycm5vID09IEVYREVWLgo+PiBub3Qgc3Vy
ZSBpZiB0aGVyZSBpcyBhbiBMVFAgaGVscGVyIGZvciB0aGlzIHBhdHRlcm4uCj4KPgoKVGhpcyBp
c3N1ZSBjYW1lIHVwIGFnYWluLgpQbGVhc2Ugc2VlIGFub3RoZXIgcHJvcG9zZWQgc29sdXRpb246
CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvQ0FPUTR1eGczd0FyN0Jyc2U5eE9Sc1BwMFhx
Q0tUeE1tbmNfRFJXdVEyYlZaVVNaUnBRQG1haWwuZ21haWwuY29tLwoKVGhhbmtzLApBbWlyLgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
