Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9E7C43217
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 09:00:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32C663CB041
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 11:00:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97FE63CAA6E
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 11:00:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5B7C6000E1
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 11:00:19 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 21990207CA
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666083619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQp3kPuIQfOV9xL6Of/MbtwO1XUsSHtD99Cdbpr7v2g=;
 b=uh9eIRvBnGS+hUVTMeG9gRZoGYP40NwCjztBI29bd3XP+55m9hQF3nH0z07qVmDN3+x9HS
 HCcWBexK0CWvwl4ucQjybe/OXEqVz7PZC5ylIET1xRKidjogOfbOgAvswii80Z4905nxpk
 ezRFVu8ViUOFCcUq+CeYhGJyKJgcUJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666083619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQp3kPuIQfOV9xL6Of/MbtwO1XUsSHtD99Cdbpr7v2g=;
 b=/lGtw78cR6WsGIzNM2Vj6YuyUBj/23FPqRPRKebJUd3Z+AvDcjiergLBTWxpOX/AjrIR+h
 QpHy2YLjescZMIBg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2D4882C143;
 Tue, 18 Oct 2022 09:00:18 +0000 (UTC)
References: <20221004120653.23237-1-pvorel@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Oct 2022 09:59:12 +0100
In-reply-to: <20221004120653.23237-1-pvorel@suse.cz>
Message-ID: <877d0xmrq7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: LTP C And Shell Test API Comparison
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JpdGVzOgoKPiBEZWxpYmVyYXRl
bHkgcHV0IG5kYXNoICjigJMpIGluc3RlYWQgb2YgVE9ETyBvbiBtaXNzaW5nIGZlYXR1cmVzLAo+
IGJlY2F1c2Ugbm90IGV2ZXJ5dGhpbmcgbmVlZHMgdG8gYmUgaW1wbGVtZW50ZWQuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KClJldmlld2VkLWJ5OiBSaWNo
YXJkIFBhbGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1c2UuY29tPgoKPiAtLS0KPiBEbyB5b3UgY29u
c2lkZXIgdGhpcyB1c2VmdWw/Cj4gSWYgeWVzLCBzaG91bGQgdGhlcmUgYmUgbGlua3MgdG8gdGhl
IGRvYyBzZWN0aW9uPwoKWWVzLCBJIHRoaW5rIHNvLgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRy
Cj4KPiAgZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dCB8IDY0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQo+
Cj4gZGlmZiAtLWdpdCBhL2RvYy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQgYi9kb2MvdGVz
dC13cml0aW5nLWd1aWRlbGluZXMudHh0Cj4gaW5kZXggNDIwYWU5YzQzLi43MDQzYzM5MDIgMTAw
NjQ0Cj4gLS0tIGEvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dAo+ICsrKyBiL2RvYy90
ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQKPiBAQCAtMzQ0LDMgKzM0NCw2NyBAQCBvZiB0aGUg
c3RhYmxlIGtlcm5lbCBBQkkgdGhlIGFzc29jaWF0ZWQgdGVzdCBtdXN0IGJlIG1vdmVkIG91dCBv
ZiBzdGFnaW5nLgo+ICAKPiAgVGhpcyBpcyBwcmltYXJpbHkgdG8gaGVscCB0ZXN0IGtlcm5lbCBS
Q3MgYnkgYXZvaWRpbmcgdGhlIG5lZWQgdG8gZG93bmxvYWQKPiAgc2VwYXJhdGUgTFRQIHBhdGNo
c2V0cy4KPiArCj4gKzggTFRQIEMgQW5kIFNoZWxsIFRlc3QgQVBJIENvbXBhcmlzb24KPiArLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICsKPiArQ29tcGFyaXNvbiBvZgo+
ICtodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC93aWtpL0MtVGVzdC1B
UElbQyBUZXN0IEFQSV0gYW5kCj4gK2h0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2pl
Y3QvbHRwL3dpa2kvU2hlbGwtVGVzdC1BUElbU2hlbGwgVGVzdCBBUEldLgo+ICsKPiArW29wdGlv
bnM9ImhlYWRlciJdCj4gK3w9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ICt8ICBDIEFQSSAoJ3N0
cnVjdCB0c3RfdGVzdCcgbWVtYmVycykgfCBzaGVsbCBBUEkgKCckVFNUXyonIGVudmlyb25tZW50
IHZhcmlhYmxlcykKPiArfCAnLmFsbF9maWxlc3lzdGVtcycgfCAnVFNUX0FMTF9GSUxFU1lTVEVN
UycKPiArfCAnLmJ1ZnMnIHwg4oCTCj4gK3wgJy5jYXBzJyB8IOKAkwo+ICt8ICcuY2hpbGRfbmVl
ZHNfcmVpbml0JyB8IG5vdCBhcHBsaWNhYmxlCj4gK3wgJy5jbGVhbnVwJyB8ICdUU1RfQ0xFQU5V
UCcKPiArfCAnLmRldl9leHRyYV9vcHRzJyB8ICdUU1RfREVWX0VYVFJBX09QVFMnCj4gK3wgJy5k
ZXZfZnNfb3B0cycgfCAnVFNUX0RFVl9GU19PUFRTJwo+ICt8ICcuZGV2X2ZzX3R5cGUnIHwgJ1RT
VF9GU19UWVBFJwo+ICt8ICcuZGV2X21pbl9zaXplJyB8IG5vdCBhcHBsaWNhYmxlCj4gK3wgJy5m
b3JtYXRfZGV2aWNlJyB8ICdUU1RfRk9STUFUX0RFVklDRScKPiArfCAnLm1heF9ydW50aW1lJyB8
IOKAkwo+ICt8ICcubWluX2NwdXMnIHwgbm90IGFwcGxpY2FibGUKPiArfCAnLm1pbl9rdmVyJyB8
ICdUU1RfTUlOX0tWRVInCj4gK3wgJy5taW5fbWVtX2F2YWlsJyB8IG5vdCBhcHBsaWNhYmxlCj4g
K3wgJy5tbnRfZmxhZ3MnIHwgJ1RTVF9NTlRfUEFSQU1TJwo+ICt8ICcubW50cG9pbnQnLCAnLm1u
dF9kYXRhJyB8ICdUU1RfTU5UUE9JTlQnCj4gK3wgJy5tb3VudF9kZXZpY2UnIHwgJ1RTVF9NT1VO
VF9ERVZJQ0UnCj4gK3wgJy5uZWVkc19jZ3JvdXBfY3RybHMnIHwg4oCTCj4gK3wgJy5uZWVkc19j
aGVja3BvaW50cycgfCAnTkVFRFNfQ0hFQ0tQT0lOVFMnCj4gK3wgJy5uZWVkc19jbWRzJyB8ICdU
U1RfTkVFRFNfQ01EUycKPiArfCAnLm5lZWRzX2RldmZzJyB8IOKAkwo+ICt8ICcubmVlZHNfZGV2
aWNlJyB8ICdUU1RfTkVFRFNfREVWSUNFJwo+ICt8ICcubmVlZHNfZHJpdmVycycgfCAnVFNUX05F
RURTX0RSSVZFUlMnCj4gK3wgJy5uZWVkc19rY29uZmlncycgfCAnVFNUX05FRURTX0tDT05GSUdT
Jwo+ICt8ICcubmVlZHNfb3ZlcmxheScgfAo+ICt8ICcubmVlZHNfcm9mcycgfCDigJMKPiArfCAn
Lm5lZWRzX3Jvb3QnIHwgJ1RTVF9ORUVEU19ST09UJwo+ICt8ICcubmVlZHNfdG1wZGlyJyB8ICdU
U1RfTkVFRFNfVE1QRElSJwo+ICt8ICcub3B0aW9ucycgfCAnVFNUX1BBUlNFX0FSR1MnLCAnVFNU
X09QVFMnCj4gK3wgJy5yZXNvdXJjZV9maWxlcycgfCDigJMKPiArfCAnLnJlc3RvcmVfd2FsbGNs
b2NrJyB8IG5vdCBhcHBsaWNhYmxlCj4gK3wgJy5zYW1wbGUnIHwg4oCTCj4gK3wgJy5zYXZlX3Jl
c3RvcmUnIHwg4oCTCj4gK3wgJy5zY2FsbCcgfCBub3QgYXBwbGljYWJsZQo+ICt8ICcuc2V0dXAn
IHwgJ1RTVF9TRVRVUCcKPiArfCAnLnNraXBfZmlsZXN5c3RlbXMnIHwgJ1RTVF9TS0lQX0ZJTEVT
WVNURU1TJwo+ICt8ICcuc2tpcF9pbl9jb21wYXQnIHwg4oCTCj4gK3wgJy5za2lwX2luX2xvY2tk
b3duJyB8IOKAkwo+ICt8ICcuc3VwcG9ydGVkX2FyY2hzJyB8IG5vdCBhcHBsaWNhYmxlCj4gK3wg
Jy50YWdzJyB8IOKAkwo+ICt8ICcudGFpbnRfY2hlY2snIHwg4oCTCj4gK3wgJy50Y250JyB8ICdU
U1RfQ05UJwo+ICt8ICcudGNvbmZfbXNnJyB8IG5vdCBhcHBsaWNhYmxlCj4gK3wgJy50ZXN0Jywg
Jy50ZXN0X2FsbCcgfCAnVFNUX1RFU1RGVU5DJwo+ICt8ICcudGVzdF92YXJpYW50cycgfCDigJMK
PiArfCAnLnRpbWVvdXQnIHwgJ1RTVF9USU1FT1VUJwo+ICt8ICcudHN0X2h1Z2VwYWdlJyB8IG5v
dCBhcHBsaWNhYmxlCj4gK3wgLmZvcm1hdF9kZXZpY2UgfCAnVFNUX0RFVklDRScKPiArfCBub3Qg
YXBwbGljYWJsZSB8ICdUU1RfTkVFRFNfS0NPTkZJR1NfSUZTJwo+ICt8IG5vdCBhcHBsaWNhYmxl
IHwgJ1RTVF9ORUVEU19NT0RVTEUnCj4gK3wgbm90IGFwcGxpY2FibGUgfCAnVFNUX1BPU19BUkdT
Jwo+ICt8IG5vdCBhcHBsaWNhYmxlIHwgJ1RTVF9VU0FHRScKPiArfD09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Cj4gLS0gCj4gMi4zNy4zCgoKLS0gClRoYW5rIHlvdSwKUmljaGFyZC4KCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
