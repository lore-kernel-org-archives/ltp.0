Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7119AD5B87C
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 07:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765868864; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cecxHRkIZmTWsOJ0z/XaAeAWtwQ1Oa7Ck9QcdE5HvT8=;
 b=HIcr79seYzYMVkG8TTNO0cYsVu8XNJKZMbJ1SuId6PTfxGDyxkrNvVfMgv2Igrz6pz+DX
 kjmLVwsCATV/SSftO1sOV5P0fOx0lWKvFqdcS31Wd8rZHrU9f/1tnCkMbU4W5VHrb3iDvrI
 aWxUfypmFRPOKk2Ge6dL+RY8wruyoao=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5142F3D032A
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 08:07:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F5B83CF7A3
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 08:07:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 313FF60085F
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 08:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765868837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLYTCeFAUeX2Ry+O7vy4HgX6e91XHKZRfb/N8ggVElg=;
 b=U4YvFMGMmH6u1KHkgpPEf3i22ZdYhVSp8gn3WQdLlcug4zrx/JxREFyVvtA6praeZ1cSTs
 TOZ6yaiZnAOHmuO74VW7OAK9RqQARdMIt10JcoNg+8WhM2UI8dEqgIrFmWvykhdZzFbDRy
 YQsLefZiegGHKJUw0cersy14dFaV2qI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-Xz24Sl7JNTGd3mIfUHUxqQ-1; Tue, 16 Dec 2025 02:07:14 -0500
X-MC-Unique: Xz24Sl7JNTGd3mIfUHUxqQ-1
X-Mimecast-MFC-AGG-ID: Xz24Sl7JNTGd3mIfUHUxqQ_1765868834
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b99d6bd6cc9so8850046a12.1
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 23:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765868834; x=1766473634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLYTCeFAUeX2Ry+O7vy4HgX6e91XHKZRfb/N8ggVElg=;
 b=deEJ2G2TDitRJkVGOzWESrxQQBS/Ob26qTBFMvBNx25zRfi/0yMe0+X1BZzsbQNHdT
 VtkV/2dYCtdz+xEYuq0kOsDC/gggytABIPwwvi6WoIwSOWEDz9PKF3XaRt4fllyOOzPx
 +6VsarsYPjpC65vy75ukJ93ltRk9P7N68iZw/f+BJVX+YFTglncYsutriGvhg5xyoOpH
 k8qSb25U78PI3U3alz/zWzqGHNKhv9XnhkZCerCn4LxaXzEWFkVph6UuT8PALMDeFkSz
 yfalvlfMllImohBw5/+oRoi0StVuNoMmWAEOjwedgQD9Xmqn++Twa7IJeZZWuxpxNjgl
 2Zow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCsx/SIkqqf7NJ+zNvQKj6OqXloStlorBIIgLm0of8BSuJKPE/iYKfpWpTcAWSwCSwEtE=@lists.linux.it
X-Gm-Message-State: AOJu0YxQ6O6oQSIkgqb2ha2pzfui+4V3PnOjuNbGIYil044yl4G7MLH3
 xvrfIZViQgEszXrppdqG2PAHfggNein6zbq/xt3yyVCFD0j53y+J0kcUF4f4ByMxXyoThrXjBr0
 5ZvY1+TY0urgSqbdVt3butC+TwQVHzWw91EGJFGUa6z37QdSKxL3+as0eXMre9WuVZx5a/pfq3I
 DzHoMOZ6c2kQkZgunjbCQT8o+nCfM=
X-Gm-Gg: AY/fxX4ruwcUrL2OwaHHluoEf6BkdaRpl3NCbbYefCp/QSDm6f2tkOH3/sI4yZWlII1
 JirOakd+jmJKjoOVuExrfSGhVtvY2vCtLXWarnsf75bnN8W3jnqTpjIwdG23HAXQk4iUwBGbH2v
 ceC0laoxAtPtqjt3E7wJcB9uu9OhTJM4tLg+ZLmtdaLk+h2YU02d9ZT8UR2eNJgXLmlxQ=
X-Received: by 2002:a05:7300:b58b:b0:2a4:3594:d53e with SMTP id
 5a478bee46e88-2ac2f8a69e6mr8848399eec.11.1765868833760; 
 Mon, 15 Dec 2025 23:07:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLz+X7Y8J+2+T8jAvel1jnEUAihthKpC2fLoLFhMUuKzw+8z75sj63ipK1oqc0rM6u5mwGPHzADNbFDhy/QrU=
X-Received: by 2002:a05:7300:b58b:b0:2a4:3594:d53e with SMTP id
 5a478bee46e88-2ac2f8a69e6mr8848380eec.11.1765868833219; Mon, 15 Dec 2025
 23:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
 <20251215143048.GA267467@pevik> <DEYVPI1SEKQ3.1O8WHL9757UD0@suse.com>
In-Reply-To: <DEYVPI1SEKQ3.1O8WHL9757UD0@suse.com>
Date: Tue, 16 Dec 2025 15:07:01 +0800
X-Gm-Features: AQt7F2oPwmIDxmz0xV-uN2Xveb6bGLp8NA5XT2XHIx21LRbupDGFrwxfzUDX0rY
Message-ID: <CAEemH2d7T6-0=i=7gM_-9nBuwaAxUX_O4g94ORK7-sojUqTYPQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hMeEk_ED0QUs7HTBW0sp_oA9CLxO_qwSlJxNqa8lX44_1765868834
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

T24gTW9uLCBEZWMgMTUsIDIwMjUgYXQgMTE6MDHigK9QTSBBbmRyZWEgQ2VydmVzYXRvIDxhbmRy
ZWEuY2VydmVzYXRvQHN1c2UuY29tPgp3cm90ZToKCj4gSGkhCj4KPiBPbiBNb24gRGVjIDE1LCAy
MDI1IGF0IDM6MzAgUE0gQ0VULCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gPiBBbm90aGVyICppbXBv
cnRhbnQqIHJ1bGUgY29uY2VybnMgYXJ0aWZpY2lhbCBpbnRlbGxpZ2VuY2UuIEkndmUgbm90aWNl
ZAo+ID4gPiBzb21lIGJlZ2lubmVycyBzdWJtaXR0aW5nIExUUCBwYXRjaGVzIGRpcmVjdGx5IGdl
bmVyYXRlZCBieSBBSSB0b29scy4KPiA+ID4gVGhpcyBwdXRzIGEgc2lnbmlmaWNhbnQgYnVyZGVu
IG9uIHBhdGNoIHJldmlldywgYXMgQUkgY2FuIHNvbWV0aW1lcwo+ID4gPiBpbnRyb2R1Y2UgYSB3
ZWlyZC91bnJlbGlhYmxlIHBlcnNwZWN0aXZlIGludG8gdGhlIGNvZGUuCj4gPgo+ID4gPiBCZSBj
YXJlZnVsIHdoZW4gdXNpbmcgQUkgdG9vbHMKPiA+ICsxIEkgbGlrZSB0aGlzIHRpdGxlLgo+ID4K
PiA+ID4gPT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiA+IEFJIHRvb2xzIGNhbiBiZSB1c2Vm
dWwgZm9yIGV4ZWN1dGluZywgc3VtbWFyaXppbmcsIG9yIHN1Z2dlc3RpbmcKPiBhcHByb2FjaGVz
LAo+ID4gPiBidXQgdGhleSBjYW4gYWxzbyBiZSBjb25maWRlbnRseSB3cm9uZyBhbmQgZ2l2ZSBh
biBpbGx1c2lvbiBvZgo+IGNvcnJlY3RuZXNzLgo+ID4gPiBUcmVhdCBBSSBvdXRwdXQgYXMgdW50
cnVzdGVkOiB2ZXJpZnkgY2xhaW1zIGFnYWluc3QgdGhlIGNvZGUsCj4gZG9jdW1lbnRhdGlvbiwK
PiA+ID4gYW5kIGFjdHVhbCBiZWhhdmlvciBvbiBhIHJlcHJvZHVjZXIuCj4gPgo+ID4gPiBEbyBu
b3Qgc2VuZCBBSS1nZW5lcmF0ZWQgY2hhbmdlcyBhcyByYXcgcGF0Y2hlcy4gQUktZ2VuZXJhdGVk
IGRpZmZzCj4gb2Z0ZW4KPiA+ID4gY29udGFpbgo+ID4gPiBpcnJlbGV2YW50IGNodXJuLCBpbmNv
cnJlY3QgYXNzdW1wdGlvbnMsIGluY29uc2lzdGVudCBzdHlsZSwgb3Igc3VidGxlCj4gPiA+IGJ1
Z3MsIHdoaWNoCj4gPiA+IGNyZWF0ZXMgYWRkaXRpb25hbCBidXJkZW4gZm9yIG1haW50YWluZXJz
IHRvIHJldmlldyBhbmQgZml4Lgo+ID4KPiA+ID4gQmVzdCBwcmFjdGljZSBpcyB0byB3cml0ZSB5
b3VyIG93biBwYXRjaGVzIGFuZCBoYXZlIHRoZW0gcmV2aWV3ZWQgYnkgQUkKPiA+ID4gYmVmb3Jl
Cj4gPiA+IHN1Ym1pdHRpbmcgdGhlbSwgd2hpY2ggaGVscHMgYWRkIGJlbmVmaWNpYWwgaW1wcm92
ZW1lbnRzIHRvIHlvdXIgd29yay4KPiA+Cj4gPiBIb3BlZnVsbHkgdGhlIGxhc3QgcGFyYWdyYXBo
IHdpbGwgYmUgdW5kZXJzdGFuZCBob3cgaXQgaXMgbWVhbnQuIEJlY2F1c2UKPiB3ZQo+ID4gcmVh
bGx5IGRvbid0IHdhbnQgdG8gZW5jb3VyYWdlIHBlb3BsZSB0byBzZW5kIHNvbWV0aGluZyBnZW5l
cmF0ZWQgYnkgQUkKPiB0aGV5Cj4gPiBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCBhdCBhbGwuIEkn
ZCBjb25zaWRlciBub3Qgc3VnZ2VzdGluZyBhbnkgQUkuCj4gPgo+ID4gSSByZW1lbWJlciBicmll
Zmx5IHJlYWRpbmcga2VybmVsIGZvbGtzIGRpc2N1c3NpbmcgdGhlaXIgcG9saWN5IFsxXToKPiA+
Cj4KPiBUaGVyZSdzIG5vdGhpbmcgd3Jvbmcgd2l0aCBBSSB1c2FnZSBub3dhZGF5cywgc2luY2Ug
aXQncyBwcm92ZW4gdGhhdAo+IHRoZXkgIGNhbiBzaGluZSBvbiBjZXJ0YWluIHNwZWNpZmljIHRh
c2tzLiBJbiBnZW5lcmFsLCBjb2RlIGdlbmVyYXRpb24KPiB3b3JrcyBiYWQsIGVzcGVjaWFsbHkg
aW5zaWRlIHRoZSBrZXJuZWwgZGV2ZWxvcG1lbnQuIEFuZCBpbiBMVFAsCj4gb2J2aW91c2x5Lgo+
Cj4gQnV0IHdoZW4gaXQgY29tZXMgdG8gY29ycmVjdCBjb21taXQgbWVzc2FnZXMsIGxlYXJuaW5n
IHdoYXQgYSBjZXJ0YWluCj4gY29kZSBpcyBkb2luZyBvciB1bmRlcnN0YW5kaW5nIGNvbXBpbGUg
ZXJyb3JzLCB0aGV5IGNhbiBiZSB1c2VmdWwuCj4KCkV4YWN0bHkhCgpVc2luZyBBSSB3aXNlbHkg
Y2FuIHNwZWVkIHVwIGRlYnVnZ2luZyB3b3JrLCBidXQgdXNlciBleHBlcmllbmNlIGlzCnVsdGlt
YXRlbHkgbmVlZGVkIHRvIGRldGVybWluZSBpdHMgY29ycmVjdG5lc3MuCgoKCj4gU2FpZCBzbywg
SSBsaWtlIHRoZSBMaSBhcHByb2FjaCwgYmVjYXVzZSBpdCBnaXZlcyB0byBBSSB0aGUgcmlnaHQg
cGxhY2UsCj4gd2l0aG91dCBleHBhbmRpbmcgaXRzIGJvdW5kYXJpZXMgd2hpY2ggYXJlIHdlbGwg
ZGVmaW5lZCBhbmQgd2VsbCBrbm93bi4KPgoKVGhhbmtzIQoKCi0tIApSZWdhcmRzLApMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
