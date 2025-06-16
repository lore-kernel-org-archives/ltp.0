Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC65C71136
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750085395; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=DIPNNOQYVLDPJyZH8dZcSZEW4hNY9IqIOAWPPCcrSjk=;
 b=FVWyLJRv69SKdJQnsK9W1DMar8PdXwEVR8zQ0JWj5P0S7TDwoyVrvFiTnyTgsgAJCvlIK
 RUXGZczPD8qmzbOTKztFTBWWN1jvQOAJiDAsswZuhSZMMuJdtwqaY6atqKT+ZGevIc4CT8d
 JmrJnLxvEfZkChjGA2e0qhLlFMlm1Gg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 341913CC0D3
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 16:49:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B13F43CC01F
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:49:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9DE181400B82
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750085371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4hzhk+i13UC+gW2/xoBeBAfNZ0wmKyYim4ct3B5r49M=;
 b=jVlHznQKvmc+FFbSeqfygwo3cCcK6xPHHJmFKqduYVE/loX9pLMrW8LaB0FycfCSfslZpe
 egjg/crlskoU30ZkjRY+XMKDB+0LSpMYDhB164phCkTz1lcKU51y9QvpHGQkfU0YMW4ol7
 46Z8pravStXB/MVi4qeZdi39OZ3E4XU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-1R00-Ju8MGGODX3zSgeeTQ-1; Mon, 16 Jun 2025 10:49:30 -0400
X-MC-Unique: 1R00-Ju8MGGODX3zSgeeTQ-1
X-Mimecast-MFC-AGG-ID: 1R00-Ju8MGGODX3zSgeeTQ_1750085369
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3132e7266d3so4778775a91.2
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 07:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750085368; x=1750690168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4hzhk+i13UC+gW2/xoBeBAfNZ0wmKyYim4ct3B5r49M=;
 b=LfDSoSfhEekwYtCF9If1QvNdDXcvBbNrL9TlDsSm7eDQcl6c5jJSiAYuo67GSTUg02
 xd7vBgq0wy+9ko5SJw5M0ynGU8k8CZcAT4/QoqsEqsfJJ3R1cZDmNhctv7xjKise8CV8
 9KWssL0Nl8YVMmbTB3ScUpnCwZtnQwOu5cuVHUCdHELGRj/C7fGyoC+lUCn7A5Da5Do0
 WHYG4xn+ahnFMx+8b0v72vnE0iLqvii2BmFyPZndJyDdwEU/BWMpbqR36nuN1J1YQ8Wj
 RANplsk+FQibz/d5oRzdplyWvY3DkZXzc/y2FtuqOkWnX/8rdkNPybWtGTHwk4CHuhTI
 +FkQ==
X-Gm-Message-State: AOJu0YyyR6ACCeuzzk4U3iY5RwXPnIbFT8Is3crsG8XtloMYKdZ4J0o/
 42PAbz1T8ma28y2XewOwuQXmDwsDloTG1dmfku84fhc6/GcC5WENbGo5t9NIypRKCNIW0jDyDC4
 oOHavKSmbO8lLknhXvtyMiiRqVsmZ1jnqngIuuogtaoKC1ZUG0r62EaCvluT3lCUWVIGuAne3xv
 PfZz15HBs81jUALcSFI7pES8t08bG69ogMnT0=
X-Gm-Gg: ASbGncvbNo9/mqcg/OSuJsvurLlOsZ6gXjDgvhO/pKYePuglCHh/DKgpnRFmqcsjb2P
 8/DzgUVqmpC+pIc25T5JQBL3hDvNo/le1clXws3zy6XzQxSMpkC4WKq2v/oDbSRml5kgJTkKEVg
 0+Sz88
X-Received: by 2002:a17:90b:3e43:b0:312:1d2d:18e1 with SMTP id
 98e67ed59e1d1-313f1d52d85mr13474857a91.22.1750085368220; 
 Mon, 16 Jun 2025 07:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUTFOMXo/tzGkOLAq1fIkswQMAYrQKcFgHH5aMck7a0kDzn12nlzxH4mm7sgKb7XXCidiL1TtqLZmO6JeLV+M=
X-Received: by 2002:a17:90b:3e43:b0:312:1d2d:18e1 with SMTP id
 98e67ed59e1d1-313f1d52d85mr13474819a91.22.1750085367656; Mon, 16 Jun 2025
 07:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250611-conversions-kill-v1-1-a5d7312df7fe@suse.com>
 <CAEemH2d1JwuFBVVTLTji172qZHss0AgK6n6-uEH1v+Xz_P7P-Q@mail.gmail.com>
 <DANWNAKXH7UY.11MJ8Q7L3MWG@suse.com>
 <CAEemH2fM82gZitSh5wjcp34N6GoTd=EtSh-AVtxSm_+qAh1suA@mail.gmail.com>
 <DAO0MWF8LETA.1PY8DUWS4A6W7@suse.com>
 <CAEemH2dKfFdCv3C7pEjjivs2Z=6cyC=WvifyEF9mrse0FCiYSg@mail.gmail.com>
 <DAO1EAF66R6D.2C6FDIWYBQHNN@suse.com>
In-Reply-To: <DAO1EAF66R6D.2C6FDIWYBQHNN@suse.com>
Date: Mon, 16 Jun 2025 22:49:15 +0800
X-Gm-Features: AX0GCFslKKA7x5RPDJGsIqUaxTSVoIZay8rGYhvDOtl57vBiDnNNeqkLtcirhJ0
Message-ID: <CAEemH2dn+tCrAmkbbXp2UKNMEZgPg21WV2+p3w40Cob+_A8sqA@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0yKC5BN1MkJJYfh-FLCfzt6f3XReu_Gt6aqScXCwgAA_1750085369
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls: kill: Remove kill07
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMTYsIDIwMjUgYXQgMTA6NDXigK9QTSBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8
cmJtQHN1c2UuY29tPiB3cm90ZToKCj4gT24gTW9uIEp1biAxNiwgMjAyNSBhdCAxMToxOCBBTSAt
MDMsIExpIFdhbmcgd3JvdGU6Cj4gPiBPbiBNb24sIEp1biAxNiwgMjAyNSBhdCAxMDowOeKAr1BN
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gd3JvdGU6Cj4gPgo+ID4+IE9u
IE1vbiBKdW4gMTYsIDIwMjUgYXQgMTE6MDggQU0gLTAzLCBMaSBXYW5nIHdyb3RlOgo+ID4+ID4g
T24gTW9uLCBKdW4gMTYsIDIwMjUgYXQgNzowMuKAr1BNIFJpY2FyZG8gQi4gTWFybGnDqHJlIDxy
Ym1Ac3VzZS5jb20+Cj4gPj4gd3JvdGU6Cj4gPj4gPgo+ID4+ID4+IE9uIFdlZCBKdW4gMTEsIDIw
MjUgYXQgMTA6NTIgUE0gLTAzLCBMaSBXYW5nIHdyb3RlOgo+ID4+ID4+ID4gUmljYXJkbyBCLiBN
YXJsacOocmUgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiA+PiA+PiA+Cj4g
Pj4gPj4gPiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+ID4+ID4+
ID4+Cj4gPj4gPj4gPj4gVGhlIHRlc3QgY2FzZSBkZXNjcmlwdGlvbiByZWFkczoKPiA+PiA+PiA+
Pgo+ID4+ID4+ID4+ICJUZXN0IGNhc2UgdG8gY2hlY2sgdGhhdCBTSUdLSUxMIGNhbiBub3QgYmUg
Y2F1Z2h0LiIKPiA+PiA+PiA+Pgo+ID4+ID4+ID4+IEl0IG1ha2VzIHVzZSBvZiBzaWdhY3Rpb24o
KSB0byBzZXQgdXAgYSBoYW5kbGVyIGZvciBTSUdLSUxMLCBidXQKPiA+PiA+PiA+PiBhY2NvcmRp
bmcgdG8gaXRzIG1hbnVhbCBwYWdlOgo+ID4+ID4+ID4+Cj4gPj4gPj4gPj4gIkVJTlZBTCBBbiBp
bnZhbGlkIHNpZ25hbCB3YXMgc3BlY2lmaWVkLiAgVGhpcyB3aWxsIGFsc28gYmUKPiBnZW5lcmF0
ZWQKPiA+PiA+PiBpZiBhbgo+ID4+ID4+ID4+IGF0dGVtcHQgaXMgbWFkZSB0byBjaGFuZ2UgdGhl
IGFjdGlvbiBmb3IgU0lHS0lMTCBvciBTSUdTVE9QLCB3aGljaAo+ID4+ID4+IGNhbm5vdAo+ID4+
ID4+ID4+IGJlIGNhdWdodCBvciBpZ25vcmVkLiIKPiA+PiA+PiA+Pgo+ID4+ID4+ID4KPiA+PiA+
PiA+IE9yIGNvdWxkIHdlIHJlZmFjdG9yIGtpbGwwNyB0byB2YWxpZGF0ZSB0aGUgRUlOVkFMIHdo
ZW4gY2hhbmdpbmcKPiA+PiBhY3Rpb24KPiA+PiA+PiBvbgo+ID4+ID4+ID4gU0lHS0lMTC9TSUdT
VE9QPwo+ID4+ID4+Cj4gPj4gPj4gQnV0IHRoZW4gd2Ugd291bGQgYmUgdGVzdGluZyBzaWdhY3Rp
b24oKS4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGU/Cj4gPj4gPj4KPiA+PiA+Cj4gPj4gPiBZ
b3UncmUgcmlnaHQsIGlmIHdlIHRlc3Qgc2lnYWN0aW9uKCksIHRoZW4gdGhlIGNvZGUgc2hvdWxk
IGJlIHB1dCBpbnRvCj4gPj4gPiBrZXJuZWwvc3lzY2FsbHMvc2lnYWN0aW9uL3NpZ2FjdGlvbjAz
LmMuCj4gPj4gPgo+ID4+ID4gTWF5YmUgd2UgY2FuIHRyeToKPiA+Pgo+ID4+IFN1cmUhIEJ1dCBp
biBhbnkgY2FzZSBraWxsMDcgc2hvdWxkIHN0aWxsIGJlIHJlbW92ZWQgSU1ITy4KPiA+Pgo+ID4K
PiA+IEFncmVlZC4gSWYgeW91IHBsYW4gdG8gYWRkIHNpZ2FjdGlvbjAzLmMgc2VwYXJhdGVseSwg
dGhpcyBvbmUgc2hvdWxkIGJlCj4gPiBnb29kLgo+Cj4gSSB0aGluayB0aGlzIGlzIGFscmVhZHkg
Y292ZXJlZCBpbiBzaWdhY3Rpb24wMi5jOgo+Cj4KPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgt
dGVzdC1wcm9qZWN0L2x0cC9ibG9iLzc2NTFiYjIyZDcxNTU1OGM4YTZkODczMmVmOTgyZTIxNDYw
NTBiMTAvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zaWdhY3Rpb24vc2lnYWN0aW9uMDIuYyNM
MjkKCgpPaCwgeWVzLCBJIHdhc24ndCBhd2FyZSBvZiB0aGF0LiBUaGFua3MgZm9yIHBvaW50aW5n
IHRoYXQgb3V0LgpUaGlzIHBhdGNoIG1lcmdlZCEKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
