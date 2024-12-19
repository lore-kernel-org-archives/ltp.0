Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B7CE77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 13:25:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A1873ED421
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:25:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFC9C3ED418
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:25:23 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1A88A61502B
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:25:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2FDB81F44B;
 Thu, 19 Dec 2024 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734614721;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLBJVxdRpJDBaJZTJ6wXm3xOUBopGsmfdVmfb0GTNDw=;
 b=tU6CbpO9un+9w3K37wAWxsKHZMAqJ0nArRuP18jNW/LGQB0zjDHDWLo/mjCBBmrAl+ILmB
 UBt9rcrcxf9YEADGDgWDtsUD9zkkKomnuda2viLtcaOouccxxpoY4Gwgdp8/6n0pDnJinT
 vlhSuYecUcUL/AN/aNDpMgwKzVEzrdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734614721;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLBJVxdRpJDBaJZTJ6wXm3xOUBopGsmfdVmfb0GTNDw=;
 b=TSL8OUoZ88Mc0qtzxwz3cdXJBv6rOlg5SCE8yBLP9MZxuOi8MhRyi/eW+GT27K0TYeKAYI
 NN1al0T6ZRSVXqBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734614721;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLBJVxdRpJDBaJZTJ6wXm3xOUBopGsmfdVmfb0GTNDw=;
 b=tU6CbpO9un+9w3K37wAWxsKHZMAqJ0nArRuP18jNW/LGQB0zjDHDWLo/mjCBBmrAl+ILmB
 UBt9rcrcxf9YEADGDgWDtsUD9zkkKomnuda2viLtcaOouccxxpoY4Gwgdp8/6n0pDnJinT
 vlhSuYecUcUL/AN/aNDpMgwKzVEzrdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734614721;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLBJVxdRpJDBaJZTJ6wXm3xOUBopGsmfdVmfb0GTNDw=;
 b=TSL8OUoZ88Mc0qtzxwz3cdXJBv6rOlg5SCE8yBLP9MZxuOi8MhRyi/eW+GT27K0TYeKAYI
 NN1al0T6ZRSVXqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 035C713A32;
 Thu, 19 Dec 2024 13:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZdS7OsAeZGdkFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 19 Dec 2024 13:25:20 +0000
Date: Thu, 19 Dec 2024 14:25:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241219132515.GB111004@pevik>
References: <20241212060448.204158-1-liwang@redhat.com>
 <b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz>
 <Z2QbRxeekZyxhoCc@yuki.lan>
 <CAEemH2d6_O-JYe1MsDZ4hO5QL+OrDeCESi=GSAYxWVF+1f6J7w@mail.gmail.com>
 <Z2QdUCGAhfPZHDtp@yuki.lan>
 <CAEemH2ci3i+UTziZZegsQR+C-q_+ri9yHbNZyyGPk8ypAZF3KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ci3i+UTziZZegsQR+C-q_+ri9yHbNZyyGPk8ypAZF3KQ@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIERlYyAxOSwgMjAyNCBhdCA5OjE54oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1Ymlz
QHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIQo+ID4gPiA+IFNvdW5kcyBsaWtlIHdlIG5lZWQgdG8g
aGF2ZSB0d28gZGlmZmVyZW50IHJ1bnRpbWUgdmFsdWVzIGluIHRoZSB0ZXN0cywKPiA+ID4gPiBt
YXhfcnVudGltZSB3aGljaCBpcyB0aGUgdGltZW91dCBmb3IgdGhlIHRlc3QgYW5kIGp1c3QgcnVu
dGltZSB3aGljaCBpcwo+ID4gPiA+IGZvciBob3cgbG9uZyB3aWxsIHRoZSB0ZXN0IGxvb3AuCgoK
PiA+ID4gQWdyZWUsIGlmIHdlIGRlZmluZSB0aGUgbG9vcGluZyBydW50aW1lIGluIGEgc2VwYXJh
dGUgdmFsdWUsIHRoYXQgd291bGQKPiA+IGJlCj4gPiA+IGhlbHBmdWwuCgo+ID4gVGhlcmUgd2Fz
IGEgcHJvYmxlbSB3aXRoIGhhdmluZyB0aGUgdHdvIGRpZmZlcmVudCB2YWx1ZXMgaW4gYSBzaW5n
bGUKPiA+IHZhcmlhYmxlIGJlZm9yZSBhcyB3ZWxsLiBXZSBkbyBoYXZlIHRoZSBMVFBfUlVOVElN
RV9NVUwgd2hpY2ggbXVsdGlwbGllZAo+ID4gYm90aCB0aGUgdGltZW91dCBhbmQgcnVudGltZS4g
VGhlc2Ugc2hvdWxkIGJlIHNlcGFyYXRlIG11bHRpcGxpZXJzIGFzCj4gPiB3ZWxsIHdoaWNoIG11
bHRpcGxpZWQgYm90aCB0aGUgdGltZW91dCBhbmQgcnVudGltZS4gVGhlc2Ugc2hvdWxkIGJlCj4g
PiBzZXBhcmF0ZSBtdWx0aXBsaWVycyBhcyB3ZWxsLgoKCj4gSSBub3RpY2VkIHRoYXQgdGVzdHMg
dXNpbmcgbWF4X3J1bnRpbWUgdG8gY29udHJvbCB0aGUgdGVzdCB0aW1lCj4gYWx3YXlzIHVzZSBh
bm90aGVyIGZ1bmN0aW9uIHRzdF9yZW1haW5pbmdfcnVudGltZSgpLCBzbyBtYXliZQo+IHdlIGNh
biB1dGlsaXplIHRoaXMgdG8gYnlwYXNzIHRoYXQuCgo+IExhdGVyIEkgd2lsbCBsb29rIGludG8g
ZGV0YWlscywgbm93IEkgaGF2ZSBhIG1lZXRpbmcgaW4gdGhlIGNvbWluZyAyaC4KCj4gQFBldHIs
IEBNYXJ0aW4sIEZlZWwgZnJlZSB0byByZXZlcnQgdGhlIHR3byBwYXRjaGVzIGlmIHlvdSBuZWVk
ZWQuCj4gMmRhMzBkZjI0ZTY3NmQ1ZjRjZmNmMGIxMTY3NGNiZGYxMWExOWI4YQo+IDY0ZTExZmVj
MDc5NDgwMTc5YWE5NDczYWU1ZTFlOGFkNzhlZjlhYzMKClRoYW5rcy4gT0ssIHdlIGNhbiB3YWl0
IGEgYml0IChmZXcgZGF5cykgdW50aWwgcmV2ZXJ0LiBUaGVyZSB3aWxsIGJlIFhtYXMsIHRodXMK
bm90IG11Y2ggYnVzeSB0aW1lIGZvciB1cy4KCktpbmQgcmVnYXJkcywKUGV0cgoKCj4gPiAtLQo+
ID4gQ3lyaWwgSHJ1YmlzCj4gPiBjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
