Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCC0C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 13:41:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16B463D1C58
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:41:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 551223D0895
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:41:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 863011016B8D
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:41:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 71F9A1F7A2;
 Wed, 24 Jul 2024 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721828464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oF8NrLyChxXEqrKCqkwsehaiS5MrSWEtnljmAdvgBk=;
 b=2Bp8QV6nsaOjdmk124GWsasAsaJTybNV1pPekfOxUr2XB6SBHn+On0eQNL0j1e1GzPezS5
 IWPnjTac5HmN5KnlzKIjCSCqqfKSN6qXOqKivcL3s2qeVf/ayGsp2Fs1XK8sJnKPfp0CXp
 dY3kJRMShWI+b+LQwOETibOCmBW/Bz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721828464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oF8NrLyChxXEqrKCqkwsehaiS5MrSWEtnljmAdvgBk=;
 b=2zcoQBuDDjOlYXtPW6qOA76HKSeMMdCVuJ7pbM3WhlAewVFPnie7F8o8rtTa594rNUFZ9m
 sfRY157FZsly8xDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721828463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oF8NrLyChxXEqrKCqkwsehaiS5MrSWEtnljmAdvgBk=;
 b=kC94YCjXSsfTSUyXvuPy1JVR0KwEvXPdTR8s3psSfbQZo9fSb+4q8/+Bau9ntu0TwqipoL
 rfo4s5U8yNeJfL8EVYyCK7ZPoq8Ii+AxewHmMAf2/3qJmAdR8pqPm8UzrROX29BLDQ44Gx
 KTyA2j8QIyzMOBwJzicXUYbDB0JFNCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721828463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oF8NrLyChxXEqrKCqkwsehaiS5MrSWEtnljmAdvgBk=;
 b=EPyXMn1iVZyBfk+Y41yXM+vWvk79+oafwkWVWoDKnwv+NbjSnh69a5NagAXPgsREbpPPzf
 6cJaG/olw3fM8qBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B89B1324F;
 Wed, 24 Jul 2024 13:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id anRsEG8EoWbuGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jul 2024 13:41:03 +0000
Date: Wed, 24 Jul 2024 15:41:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240724134100.GC950793@pevik>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-9-c7b0e9edf9b0@suse.com>
 <20240716172725.GC549165@pevik>
 <CAEemH2fP9eGdHs1Wb5JLhS-H-XXxKB=73n8WAXqj3ZNxw9xDVA@mail.gmail.com>
 <20240724133003.GB950793@pevik>
 <CAEemH2c5r=AaiSGPfdvXSZ9G=iTa2c2eSRHd-WLL9hL_wHvK7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c5r=AaiSGPfdvXSZ9G=iTa2c2eSRHd-WLL9hL_wHvK7w@mail.gmail.com>
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto,huawei.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/11] Add landlock04 test
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
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBXZWQsIEp1bCAyNCwgMjAyNCBhdCA5OjMw4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLCBBbmRyZWEsCgo+ID4gPiBIaSBQZXRyLCBBbmRyZWEs
Cj4gPiAuLi4KPiA+ID4gPiAuLi4KPiA+ID4gPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6OTc6
IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgdG1wZnMKPiA+ID4gPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5
cGVzLmM6NDk6IFRJTkZPOiBta2ZzIGlzIG5vdCBuZWVkZWQgZm9yIHRtcGZzCj4gPiA+ID4gdHN0
X3Rlc3QuYzoxNzQ2OiBUSU5GTzogPT09IFRlc3Rpbmcgb24gZXh0MiA9PT0KPiA+ID4gPiB0c3Rf
dGVzdC5jOjExMTE6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDEgd2l0aCBleHQyIG9wdHM9
JycgZXh0cmEKPiA+ID4gPiBvcHRzPScnCj4gPiA+ID4gbWtlMmZzIDEuNDcuMCAoNS1GZWItMjAy
MykKPiA+ID4gPiB0c3RfdGVzdC5jOjExMjM6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AxIHRv
Cj4gPiAvdG1wL0xUUF9sYW50NldiS0ovc2FuZGJveAo+ID4gPiA+IGZzdHlwPWV4dDIgZmxhZ3M9
MAo+ID4gPiA+IGxhbmRsb2NrX2NvbW1vbi5oOjMwOiBUSU5GTzogTGFuZGxvY2sgQUJJIHYzCj4g
PiA+ID4gbGFuZGxvY2swNC5jOjE1MTogVElORk86IFRlc3RpbmcgTEFORExPQ0tfQUNDRVNTX0ZT
X0VYRUNVVEUKPiA+ID4gPiBsYW5kbG9jazA0LmM6MTIzOiBUSU5GTzogRW5hYmxlIHJlYWQvZXhl
YyBwZXJtaXNzaW9ucyBmb3IKPiA+ID4gPiAvdXNyL2xpYi9pMzg2LWxpbnV4LWdudS9saWJjLnNv
LjYKPiA+ID4gPiBsYW5kbG9jazA0LmM6MTMxOiBUQlJPSzogbGFuZGxvY2tfYWRkX3J1bGUoMywg
MSwgMHhmN2YxM2ZmNCwgMCk6IEVJTlZBTAo+ID4gPiA+ICgyMikKCgo+ID4gPiBQb3NzaWJseSB0
aGF0J3MgYmVjYXVzZSB0aGUgJ0xBTkRMT0NLX1JVTEVfUEFUSF9CRU5FQVRIJyAgd2FzCj4gPiA+
IHJlZmFjdG9yZWQgZnJvbSB0aGUgdjYuNyBtYWlubGluZSBrZXJuZWwsIHNvIGl0IGNhbid0IGFk
ZCB0aGUgcnVsZQo+ID4gY29ycmVjdGx5Cj4gPiA+IHdpdGggb2xkZXIga2VybmVscy4KCj4gPiA+
IGNvbW1pdCAwZTBmYzdlOGViNGExMWJkOWY4OWE5Yzc0YmM3YzBlMTQ0YzU2MjAzCj4gPiA+IEF1
dGhvcjogS29uc3RhbnRpbiBNZXNraGlkemUgPGtvbnN0YW50aW4ubWVza2hpZHplQGh1YXdlaS5j
b20+Cj4gPiA+IERhdGU6ICAgVGh1IE9jdCAyNiAwOTo0Nzo0NiAyMDIzICswODAwCgo+ID4gPiAg
ICAgbGFuZGxvY2s6IFJlZmFjdG9yIGxhbmRsb2NrX2FkZF9ydWxlKCkgc3lzY2FsbAoKPiA+ID4g
QnV0IHRoaXMgaXMgbXkgZ3Vlc3MgKHRocm91Z2ggcmVhZGluZyB0aGUgY29kZSksIEkgZGlkbid0
IGRvIG1vcmUgdG8KPiA+ID4gdmVyaWZ5IHRoYXQgYnkgaW5zdGFsbGluZyBzdWNoIGEga2VybmVs
LgoKPiA+IFRoYW5rcywgTGksICBmb3IgYSBoaW50LiBRdWljayB0ZXN0IHNob3dzIHRoYXQgaXQn
cyB3b3JraW5nIG9uIDYuOS45LCBidXQKPiA+IGJyb2tlbgo+ID4gd2l0aCB3aXRoIDYuNi54IG9y
IDYuNS54LCBhbHNvIHJlcHJvZHVjZWQgb24gbW9yZSBkaXN0cm9zLiBJJ2xsIHZlcmlmeSB0aGlz
Cj4gPiBzcGVjaWZpYyBjb21taXQsIEkgc3VwcG9zZSB3ZSBzaG91bGQgcmVxdWlyZSA2LjcsIHJp
Z2h0PwoKCj4gSSB0aGluayBZRVMsIDYuNyBpbmNsdWRlcyBzb21lIHZpdGFsIGltcHJvdmVtZW50
IG9uIHRoZSBsYW5kbG9jayBzeXNjYWxsLgoKT0ssIEknbSBmb3IgbWVyZ2luZyB3aXRoIC5taW5f
a3ZlciA9ICI2LjciLgoKV2hhdCBibG9ja2luZyBtZSB0byBtZXJnZSBpcyB0aGUgZmFjdCBsYW5k
bG9jazAzIG5lZWRzIHRvIGZpeCBmb3IgLWkyLgpCdXQgbGV0J3MgZGlzY3VzcyBpdCB0aGVyZS4K
CktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
