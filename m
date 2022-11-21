Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6E1C433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 16:01:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 796CF3CCBD0
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 17:01:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 749D83C0F12
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 17:01:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF7F41D771A7
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 17:01:15 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AF17521ED8;
 Mon, 21 Nov 2022 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669046474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EYyMSJDDeJwtDdzhir0UcMUIeArFNwysOXbLBOLWWME=;
 b=I/IqgTGQfs7lTPbh54LNMtJajCEfFtgDra25eTTAuXtGiHJAMfsrBAMZpbQicIgWptkmak
 RDcbOHG2/BCOa9oW2hcIJDnaXwSG7FWq3hMRIEo7xhMGsJgFfW9X2rNXxCOCZO/sOMGH8r
 Tv68Nq/R6KCoZXJaqAbqOFIhq9BWwyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669046474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EYyMSJDDeJwtDdzhir0UcMUIeArFNwysOXbLBOLWWME=;
 b=/hrgki+HTCU/p5skRg0ck4lsVKFy6kL4lg5c8K7rY5lynbMYpJunUiBgN5aaopyfHyAy+S
 SNGJxv+qQA30ssDA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7FA622C146;
 Mon, 21 Nov 2022 16:01:14 +0000 (UTC)
References: <20221121144505.1496-1-rpalethorpe@suse.com>
 <Y3uUk6nKsASeFRf7@yuki>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Nov 2022 15:14:21 +0000
Organization: Linux Private Site
In-reply-to: <Y3uUk6nKsASeFRf7@yuki>
Message-ID: <87mt8kfgad.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] config: Explicitly set gnu99
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gd3JpdGVzOgoKPiBIaSEKPj4g
VXNlIHRoZSBHTlUgdmFyaWFudCBvZiB0aGUgQzk5IGxhbmd1YWdlIHRvIHN0b3AgR0NDIDQuOC41
IGRlZmF1bHRpbmcKPj4gdG8gQzkwLgo+PiAKPj4gV2UgY2FuJ3QgdXNlIEM5OSBiZWNhdXNlIExU
UCBpcyBmYXIgZnJvbSBjb21wbGlhbnQuCj4KPiBJIHdvZGVyIGlmIHRoaXMgd291bGQgd29yayB3
aXRoIGRpZmZlcmVudCBjb21waWxlcnMuIEkgc3VwcG9zZSBjbGFuZwo+IGRvZXMgd29yaywgYnV0
IHdoYXQgYWJvdXQgaWNjPwoKQ2xhbmcgaXMgZmluZS4gSSBkb3VidCB0aGF0IGljYyBjb21waWxl
cyBMVFAgYXQgcHJlc2VudCB1bmxlc3MgaXQgZG9lcwpzdXBwb3J0IEdOVSBleHRlbnNpb25zLgoK
Pgo+IEkgc3Vwb3NlIHRoYXQgd2UgZ2V0IHRvbnMgb2YgJ2Nhbid0IGRvIHBvaW50ZXIgYXJpdGht
ZXRpY3Mgb24gdm9pZCoKPiBwb2ludGVycyBhbmQgc3R1ZmYnIHdpdGggcGxhaW4gYzk5LiBNYXli
ZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gY2xlYW4KPiB0aGVzZSBvdXQgaW5zdGVhZC4KCmh0dHBz
Oi8vZ2l0aHViLmNvbS9yaWNoaWVqcC9sdHAvYWN0aW9ucy9ydW5zLzM1MTUxNjU4MDMvam9icy81
ODkwMDgxNzM2CgpTb21lIG9mIHRoaXMgaXMgc29sdmVkIGJ5IC1EX1hPUEVOX1NPVVJDRT03MDAg
b3Igc29tZSBvdGhlciBtYWNybyAod2UKbmVlZCBtdWx0aXBsZSkuIEhvd2V2ZXIgaXQgZG9lc24n
dCBlbmQgdGhlcmU6CgogbWFrZSBTVERDRkxBR1M9Jy1zdGQ9YzJ4IC1EX1hPUEVOX1NPVVJDRT03
MDAnCm1ha2UgLUMgImxpYiIgXAoJLWYgIi9ob21lL3JpY2gvcWEvbHRwL2xpYi9NYWtlZmlsZSIg
YWxsCm1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSAnL2hvbWUvcmljaC9xYS9sdHAvbGliJwpJ
biBmaWxlIGluY2x1ZGVkIGZyb20gLi4vaW5jbHVkZS9vbGQvdGVzdC5oOjM3LAogICAgICAgICAg
ICAgICAgIGZyb20gZ2V0X3BhdGguYzo0MToKZ2V0X3BhdGguYzogSW4gZnVuY3Rpb24g4oCYdHN0
X2dldF9wYXRo4oCZOgouLi9pbmNsdWRlL3RzdF9taW5tYXguaDoxMDo5OiB3YXJuaW5nOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJh0eXBlb2bigJkgWy1XaW1wbGljaXQtZnVu
Y3Rpb24tZGVjbGFyYXRpb25dCiAgIDEwIHwgICAgICAgICB0eXBlb2YoYSkgX2EgPSAoYSk7IFwK
ICAgICAgfCAgICAgICAgIF5+fn5+fgoKV2UgcHJvYmFibHkgYWxzbyB1c2UgJ3ggPzogeScgYW5k
IHN0dWZmIGxpa2UgdGhhdC4KClNvIHRoaXMgb3BlbnMgdXAgYSByYXRzIG5lc3QgYmFzaWNhbGx5
LgoKLS0gClRoYW5rIHlvdSwKUmljaGFyZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
