Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE530D46BF8
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 20:51:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A9083CB3D4
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 21:51:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05D823CAF20
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 21:50:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2B2B51400217
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 21:50:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23A145BCDC;
 Wed, 28 Jan 2026 20:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769633452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5UlLhRFR8bUR4W0UwhAi/wwSoAydLsdsGWgKsbsFdQ=;
 b=b7/T3OqkGxZ/5G/h/zXoOgvcf/PayUdTQRVo/aGIdu2BjElyzjNfhtUSVpAVDTVHUREKSw
 v5IhlmHh+jkNElPo0MkemGqC3ds0jq5iIfMXS6iRDuaqr9YIIkRZguU0Z1+vM1KgkHo4j5
 RL1SvggFm/BnXR//E7/ne2MCqJ1j9mI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769633452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5UlLhRFR8bUR4W0UwhAi/wwSoAydLsdsGWgKsbsFdQ=;
 b=3H8Zopg7IvWY5fEZuxlTgzcTOSsCVg7HAUHEjYXQpG2a3WAEyLG8u3bC+IY8J8GyOwian7
 RNPvjrUxt2PCL7BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769633451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5UlLhRFR8bUR4W0UwhAi/wwSoAydLsdsGWgKsbsFdQ=;
 b=2pw/1t7uzMi+bLR1M6dgr4RWGQZ8z33EQ4DRX8MLeiFqIKu6Cm55puHYOJAEF17+kTujWg
 8FclHvxaGtHIZURm/H2Rmqt5BCF7ImCJo3mBN+4D2614ZkHZ71ImAof8UsByF5RDfIABbF
 y4s/uN6VYUtK0/oOyD9yqCQ9SXnz6M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769633451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5UlLhRFR8bUR4W0UwhAi/wwSoAydLsdsGWgKsbsFdQ=;
 b=HZ9jkjtuU8SQZIXQ7+TMPKRsNXNk8JznidC+QWA+cO8T8MOqp22gyzFkvbkGmyaZfaUjgj
 /q4gYD8aBQwKfHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E0A73EA61;
 Wed, 28 Jan 2026 20:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AO6wFqp2emmLbAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 20:50:50 +0000
Date: Wed, 28 Jan 2026 21:50:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260128205044.GA58055@pevik>
References: <20260128080121.18878-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260128080121.18878-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/ground_rules: Add Kernel features check
 rules
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiBCYXNl
ZCBvbiBhIGRpc2N1c3Npb24gdmFyaW91cyBkaXNjdXNzaW9uczoKPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sdHAvMjAyNjAxMjMxMjI1NDUuR0ExMjIzMzFAcGV2aWsvCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbHRwLzIwMjYwMTI4MDcyNDQ1LkdCMTM0OTVAcGV2aWsvCgo+IEtpbmQgcmVn
YXJkcywKPiBQZXRyCgo+ICBkb2MvZGV2ZWxvcGVycy9ncm91bmRfcnVsZXMucnN0IHwgMTcgKysr
KysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCj4gZGlm
ZiAtLWdpdCBhL2RvYy9kZXZlbG9wZXJzL2dyb3VuZF9ydWxlcy5yc3QgYi9kb2MvZGV2ZWxvcGVy
cy9ncm91bmRfcnVsZXMucnN0Cj4gaW5kZXggMDVlNDczY2FkNS4uOTBmZTdhNjRlZSAxMDA2NDQK
PiAtLS0gYS9kb2MvZGV2ZWxvcGVycy9ncm91bmRfcnVsZXMucnN0Cj4gKysrIGIvZG9jL2RldmVs
b3BlcnMvZ3JvdW5kX3J1bGVzLnJzdAo+IEBAIC0xNzQsMyArMTc0LDIwIEBAIFRoZXNlIHBhdGNo
ZXMgc2hvdWxkIGFsc28gYWRkIGEgW1NUQUdJTkddIGtleXdvcmQgaW50byB0aGUgcGF0Y2ggc3Vi
amVjdCwgZS5nLgo+ICBJbiBhIGNhc2UgdGhhdCBhIHRlc3QgZm9yIHVucmVsZWFzZWQga2VybmVs
IGlzIHJlYWxseSBuZWVkZWQgdG8gYmUgbWVyZ2VkIHdlIGRvCj4gIG5vdCBhZGQgaXQgdG8gdGhl
IGxpc3Qgb2YgdGVzdCBleGVjdXRlZCBieSBkZWZhdWx0IGFuZCBrZWVwIGl0IGluCj4gIDptYXN0
ZXI6YHJ1bnRlc3Qvc3RhZ2luZ2AgZmlsZSB1bnRpbCB0aGUga2VybmVsIGNvZGUgaXMgZmluYWxp
emVkLgo+ICsKPiArS2VybmVsIGZlYXR1cmVzIGNoZWNrCj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+ICsKPiArV2UgcHJlZmVyIHRvIHVzZSA6Yzp0eXBlOmAubmVlZHNfa2NvbmZpZ3MgPHRzdF90
ZXN0PmAgKGtlcm5lbCBrY29uZmlnIGNoZWNrKS4KPiArQnV0IGRvICpub3QqIHVzZSBpdCB3aGVu
IHRoZXJlIGlzIGFub3RoZXIgd2F5IHRvIGRldGVjdCB0aGUgZnVuY3Rpb25hbGl0eSAoZS5nLgo+
ICt2aWEgZGV0ZWN0aW5nIGZ1bmN0aW9uYWxpdHkgdmlhIGBgL3Byb2N8c3lzYGApICphbmQqIGFu
eSBvZiB0aGVzZSBydWxlcyBhcHBsaWVzOgo+ICsKPiArLSBLZXJuZWwgYWxsb3dzIHRvIGRpc2Fi
bGUgZnVuY3Rpb25hbGl0eSB2aWEgYGtlcm5lbOKAmXMgY29tbWFuZC1saW5lIHBhcmFtZXRlcgo+
ICsgIDxodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9hZG1pbi1ndWlkZS9r
ZXJuZWwtcGFyYW1ldGVycy5odG1sPmBfCj4gKyAgKGl0IGNhbiBiZSBkaXNhYmxlZCBpbiBydW50
aW1lKS4KPiArLSBJdCdzIGEgY2hlY2sgZm9yIGEgZnVuY3Rpb25hbGl0eSB3aGljaCBjYW4gYmUg
Y29tcGlsZWQgYXMgbW9kdWxlCj4gKyAgKGB0cmlzdGF0ZQo+ICsgIDxodHRwczovL2RvY3Mua2Vy
bmVsLm9yZy9rYnVpbGQva2NvbmZpZy1sYW5ndWFnZS5odG1sI21lbnUtYXR0cmlidXRlcz5gXywK
PiArICBtb2R1bCBtaWdodCBub3QgYmUgYXZhaWxhYmxlKS4KPiArLSBOZXcga2VybmVsIGZ1bmN0
aW9uYWxpdHkgd2hpY2ggaXMgdW5saWtlbHkgdG8gYmUgYmFja3BvcnRlZCAodXNlCj4gKyAgOmM6
dHlwZTpgLm1pbl9rdmVyIDx0c3RfdGVzdD5gIGluc3RlYWQpLgoKSSB3b25kZXIgaG93IGFib3V0
IC5uZWVkc19rY29uZmlncyB2cy4gbmVlZHNfZHJpdmVycy4gRG8gd2UgcHJlZmVyIGFueSBvZiB0
aGVzZT8KSSBzdXBwb3NlIHRoZSBydWxlIGNvdWxkIGJlIC5uZWVkc19kcml2ZXJzIHdoZW4gbm90
aGluZyBzcGVjaWZpYyBmcm9tIG1vZHVsZSBpcwpuZWVkZWQsIC5uZWVkc19rY29uZmlncyBvdGhl
cndpc2UuCgpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwL3BhdGNoLzIw
MjYwMTIyMTUwNjUyLjIyNzM0Mi0xLWt1c2hhbGthdGFyaWE1QGdtYWlsLmNvbS8KCktpbmQgcmVn
YXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
