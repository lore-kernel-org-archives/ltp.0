Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19359C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 15:45:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A9173C23A8
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 16:45:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D16153C2298
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 16:44:55 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 18A101011746
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 16:44:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4DFE1F399;
 Mon, 20 Jan 2025 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737387893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBqV7kxgpm9HpKVxEI87dlKeiX4PsGWW9ec7GB5b2Y0=;
 b=x6yyjAKi5iK5u+hVFgV9P3UZ6uEqRmQaKAjgi200s1A/nR9TkEHa8tP45DSx5tHYoOUCmt
 irvYtooHUOsO8nX57JuMAzwlJcBUhsz0xDQFV+2WvPVqEzBFZhvVDUT0kSFxYDOdxOz6YM
 fVQ4+nQHZikASeneAMWP95G91QmaOrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737387893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBqV7kxgpm9HpKVxEI87dlKeiX4PsGWW9ec7GB5b2Y0=;
 b=FZmEjnAJTQKnvirPUh+4yJJ+kgHtj9Im9NtVtM44KhmOr8CwBj1UlwKLZvFLDI/Tumnqmm
 OYKvAzVkLQ7txfDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737387892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBqV7kxgpm9HpKVxEI87dlKeiX4PsGWW9ec7GB5b2Y0=;
 b=DugeN7xmh8jv4Ej7DIiVW9BhaL0pcgAfWahoPmdpFz9ktTrxRGeFc0UyCnUwp4AbAydNZO
 TQvrwNcU/4sZcQvD6kOZynepruXjTIu25G+VqvJhRV36dsH94p9OocdnudVR3Or3q07qMV
 sdm4v82Q4KalOjAoAgmHIzcprcouC5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737387892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBqV7kxgpm9HpKVxEI87dlKeiX4PsGWW9ec7GB5b2Y0=;
 b=2ymeQ6Vnmx296KXKBS6czTgMub7TSt56a3nyyqwvfFE5QE3gZ10/ELw2VSnWCefnGIONq2
 juyrRJjx+ip7spAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F1BE139D2;
 Mon, 20 Jan 2025 15:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NtZrG3RvjmdBYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Jan 2025 15:44:52 +0000
Date: Mon, 20 Jan 2025 16:44:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
Message-ID: <20250120154450.GB812655@pevik>
References: <20250110083915.538855-1-maxj.fnst@fujitsu.com>
 <Z4D4ILGMgC7U6sOk@yuki.lan>
 <TYWPR01MB12085B661943F6DDAB5582130E61C2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TYWPR01MB12085B661943F6DDAB5582130E61C2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 
 =?utf-8?b?5Zue5aSNOiBbaXNzdWVdIGN2ZS0yMDE1LTMyOTA6IGZhaWwg?=
 =?utf-8?q?to_compile?=
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiA+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0KPiA+IOWPkeS7tuS6ujogbHRwIDxs
dHAtYm91bmNlcytjaGVuaHguZm5zdD1mdWppdHN1LmNvbUBsaXN0cy5saW51eC5pdD4g5Luj6KGo
IEN5cmlsCj4gPiBIcnViaXMKPiA+IOWPkemAgeaXtumXtDogMjAyNeW5tDHmnIgxMOaXpSAxODoz
Ngo+ID4g5pS25Lu25Lq6OiBNYSwgWGluamlhbjxtYXhqLmZuc3RAZnVqaXRzdS5jb20+Cj4gPiDm
ioTpgIE6IGx0cEBsaXN0cy5saW51eC5pdAo+ID4g5Li76aKYOiBSZTogW0xUUF0gW2lzc3VlXSBj
dmUtMjAxNS0zMjkwOiBmYWlsIHRvIGNvbXBpbGUKCj4gPiBIaSEKPiA+ID4gV2hlbiBJIGNvbXBp
bGUgbHRwIG9uIENlbnRvczEwLCBpdCBmYWlsZWQgYXQgY3ZlLTIwMTUtMzI5MC5jLgo+ID4gPiBJ
ZiBhbnlvbmUgY291bGQgcHJvdmlkZSBzb21lIGFkdmljZSwgSSB3b3VsZCBncmVhdGx5IGFwcHJl
Y2lhdGUgaXQuCgo+ID4gPiBFcnJvciBpbmZvOgo+ID4gPiBjdmUtMjAxNS0zMjkwLmM6IEluIGZ1
bmN0aW9uIOKAmGNoaWxkX3RocmVhZOKAmToKPiA+ID4gY3ZlLTIwMTUtMzI5MC5jOjQzNzoxOiBl
cnJvcjogYnAgY2Fubm90IGJlIHVzZWQgaW4g4oCYYXNt4oCZIGhlcmUKPiA+ID4gICA0MzcgfCB9
Cj4gPiA+ICAgICAgIHwgXgo+ID4gPiBtYWtlWzJdOiAqKiogWy4uLy4uL2luY2x1ZGUvbWsvcnVs
ZXMubWs6NDU6IGN2ZS0yMDE1LTMyOTBdIEVycm9yIDEKPiA+ID4gbWFrZVsxXTogKioqIFsuLi9p
bmNsdWRlL21rL2dlbmVyaWNfdHJ1bmtfdGFyZ2V0LmluYzoxMDg6IGFsbF0gRXJyb3IgMgo+ID4g
PiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL3Jvb3QvbHRwL3Rlc3RjYXNlcycKPiA+ID4g
bWFrZTogKioqIFtNYWtlZmlsZTo4NTogdGVzdGNhc2VzLWFsbF0gRXJyb3IgMgoKPiA+IFRoYXQg
bG9va3MgbGlrZToKCj4gPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0
cC9pc3N1ZXMvMzEzCgo+ID4gQnV0IHRoYXQgaXMgc3VwcG9zZWRseSBmaXhlZCBieToKCj4gPiBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9jb21taXQvY2JmYWQzYmEw
NzE1NWNmODJlYTRiOGVmYQo+ID4gMDM5MDc4N2FmODE3MzIzCgoKPiBNeSB0d28gY2VudHM6Cgo+
IEluIHRoZSBlYXJseSB2ZXJzaW9uIG9mIENlbnRPUyAxMCBzdHJlYW0sIHdpdGggZ2NjLTE0LjEu
MS01LmVsMTAueDg2XzY0LCB0aGVyZSBpcyBubyBjb21waWxlIGVycm9yIGZvciBjdmUtMjAxNS0z
MjkwLmMKCj4gQnV0IHdoZW4gSSB1cGRhdGUgZ2NjIHRvIGdjYy0xNC4yLjEtNi5lbDEwLng4Nl82
NCwgSSBoaXQgdGhlIHNhbWUgaXNzdWUgYXMgTWEuCgo+IFNlYW0gbGlrZSBjb21taXQgY2JmYWQz
YmEgQ0ZMQUcgLWZvbWl0LWZyYW1lLXBvaW50ZXIgZG9lcyBub3Qgd29ya3MgYXQgYWxsLgoKPiBJ
IHNlZSBzb21lIGFydGljbGVzIGRlc2NyaWJlIGFib3V0IGZyYW1lIHBvaW50ZXJzWzFdLCAtZm9t
aXQtZnJhbWUtcG9pbnRlciBzaG91bGQgd29yay4uLgoKPiBEb2VzIHRoaXMgaXNzdWUgYSBHQ0Mg
YnVnIG9yIGEgbmV3IGZlYXR1cmUgd2hpY2ggZGVwcmVjYXRlZCBzb21ldGhpbmc/IAoKRllJIEkg
dGVzdGVkIGNvbXBpbGF0aW9uIHdpdGggY2xhbmcgMTQuMC42IG9uIERlYmlhbiBib29rd29ybSAo
c3RhYmxlKSBwb2RtYW4KY29udGFpbmVyIGFuZCBldmVyeXRoaW5nIHdvcmtzIGFzIGV4cGVjdGVk
OgoKJCBtYWtlIGN2ZS0yMDE1LTMyOTAgVj0xOyBlY2hvICQ/CnJlbW92ZWQgJ2N2ZS0yMDE1LTMy
OTAnCmNsYW5nIC1EX0ZPUlRJRllfU09VUkNFPTIgLUkuLi8uLi9pbmNsdWRlIC1JLi4vLi4vaW5j
bHVkZSAtSS4uLy4uL2luY2x1ZGUvb2xkLyAtZyAtTzIgLWcgLU8yIC1mbm8tc3RyaWN0LWFsaWFz
aW5nIC1waXBlIC1XYWxsIC1XIC1Xb2xkLXN0eWxlLWRlZmluaXRpb24gLXN0ZD1nbnU5OSAtRF9H
TlVfU09VUkNFIC1wdGhyZWFkIC1mb21pdC1mcmFtZS1wb2ludGVyIC1MLi4vLi4vbGliIGN2ZS0y
MDE1LTMyOTAuYyAgLWxsdHAgLW8gY3ZlLTIwMTUtMzI5MAowCgpLaW5kIHJlZ2FyZHMsClBldHIK
Cj4gUmVnYXJkcywKPiAtIENoZW4KCgo+IFsxXQo+IGh0dHBzOi8vd3d3LmJyZW5kYW5ncmVnZy5j
b20vYmxvZy8yMDI0LTAzLTE3L3RoZS1yZXR1cm4tb2YtdGhlLWZyYW1lLXBvaW50ZXJzLmh0bWwK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
