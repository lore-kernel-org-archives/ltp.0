Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165A2FF885A
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 11:27:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95C203E61F8
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 13:27:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2546D3E2C5D
 for <ltp@lists.linux.it>; Tue,  5 May 2026 13:27:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D16160070C
 for <ltp@lists.linux.it>; Tue,  5 May 2026 13:27:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 208D86AD6E;
 Tue,  5 May 2026 11:27:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5CBA593A3;
 Tue,  5 May 2026 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KsUiNRvU+WkSUAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Tue, 05 May 2026 11:27:23 +0000
Message-ID: <f834cba1-003e-4751-9a84-ddb6a21c282e@suse.de>
Date: Tue, 5 May 2026 13:27:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260411092452.211540-1-rbranco@suse.de>
 <20260415080623.164440-1-rbranco@suse.de> <afjANI7jr23hP4IJ@yuki.lan>
 <bc75c487-59db-47a8-a2f3-db860919b35b@suse.de> <afjb4yWvM8Abh98q@yuki.lan>
Content-Language: en-US
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <afjb4yWvM8Abh98q@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 208D86AD6E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Use two-step handshake to probe
 features
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiA1LzQvMjYgNzo0OCBQTSwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+IEhpIQo+Pj4+ICsJdWZm
ZCA9IFNBRkVfVVNFUkZBVUxURkQoT19DTE9FWEVDIHwgT19OT05CTE9DSywgZmFsc2UpOwo+Pj4+
ICsJdWZmZGlvX2FwaS5hcGkgPSBVRkZEX0FQSTsKPj4+PiArCVNBRkVfSU9DVEwodWZmZCwgVUZG
RElPX0FQSSwgJnVmZmRpb19hcGkpOwo+Pj4+ICsJaWYgKCEodWZmZGlvX2FwaS5mZWF0dXJlcyAm
IFVGRkRfRkVBVFVSRV9QQUdFRkFVTFRfRkxBR19XUCkpCj4+Pj4gKwkJdHN0X2JyayhUQ09ORiwg
IlVGRkRfRkVBVFVSRV9QQUdFRkFVTFRfRkxBR19XUCBub3Qgc3VwcG9ydGVkIik7Cj4+Pj4gKwlT
QUZFX0NMT1NFKHVmZmQpOwo+Pj4gSSBkbyBub3QgZ2V0IHdoeSBhcmUgd2UgYWRkaW5nIHRoaXMg
Y29kZSB3aGVuIHdlIGRvIHRoZSBzYW1lIGp1c3QgYSBmZXcKPj4+IGxpbmVzIGJlbG93LiBTaG91
bGRuJ3QganVzdCB0aGlzIHN1ZmZpY2U/Cj4+IFRoYXQncyB3aHkgdGhlIGNvbW1lbnQgaXMgbmVl
ZGVkIGJlY2F1c2UgaXQgaXNuJ3Qgb2J2aW91cy4KPj4KPj4gV2UgbmVlZCB0byBkbyB0aGUgMiBz
dGVwIGhhbmRzaGFrZSwgZmlyc3Qgd2l0aCB1ZmZkaW9fYXBpLmZlYXR1cmVzIHNldAo+PiB0byB6
ZXJvLCB0aGVuIGFnYWluIHdpdGggdGhlIGRlc2lyZWQgZmVhdHVyZXMuCj4gVGhlIG9idmlvdXNs
eSB0aGUgY29tbWVudCBpcyBub3QgdXNlZnVsIGJlY2F1c2UgaXQgZG9lcyBub3QgZXhwbGFpbgo+
IGFueXRoaW5nIDotKS4KPgo+IExvb2tpbmcgYXQgdGhlIGtlcm5lbCBjb2RlLCBpdCBzZWVtcyB0
byBzZXQgdGhlIG91dHB1dCBmbGFncwo+IHVuY29kaXRpb25hbGx5IHNvIHdlIGNhbiB1c2UgdGhh
dC4KPgo+IE9yIGNoZWNrIGZvciBFSU5WQUwgd2hlbiB3ZSBwYXNzIHVuc3VwcG9ydGVkIGZsYWdz
Lgo+Cj4gSG93ZXZlciBJIHdvdWxkIHB1dCB0aGlzIGNvZGUgaW50byBhIGNvbW1vbiBoZWFkZXIg
YW5kIGNhbGwgaXQgb25seSBpbgo+IHRoZSB0ZXN0IHNldHVwIChzbyB0aGF0IGl0J3Mgbm90IGV4
ZWN1dGVkIG9uIGVhY2ggdGVzdCBpdGVyYXRpb24pLgo+Cj4gI2RlZmluZSBDSEVDS19VRkZEX0ZM
QUcoZmxhZykgZG8geyBcCj4gICAgICAgICAgLi4uIFwKPiAJaWYgKCEodWZmZGlvX2FwaS5mZWF0
dXJlcyAmIChmbGFnKSkpIFwKPiAJCXRzdF9icmsoVENPTkYsICNmbGFnICIgbm90IHN1cHBvcnRl
ZCIpOyBcCj4gCS4uLiBcCj4gfSB3aGlsZSAoMCkKPgoKV2lsbCBhZGQgdGhpcyBtYWNyby7CoCBM
ZXQncyBrZWVwIGRvaW5nIHRoZSAyIHN0ZXAgaGFuZHNoYWtlIHRob3VnaC4KCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
