Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C980F8D763
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 18:06:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7053E3E7527
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 20:06:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DA013E1BDF
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:06:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB0D31A00689
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:06:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43B3E6A801;
 Thu, 16 Apr 2026 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776362777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADzo27bpC43ZLZjZx/vV1h07flotCpsrQZs4mVLWAEA=;
 b=ZjTAtdFpN4FDr+YMwHd/7ATssW7t4DbqcZoWP1uN/J479gsm+GqxMudhgHp/ivKRVGn1Eq
 GCKDF+5PLmNhPZQKbiUKnC2PJ4l39vU4QdeNL0bfT/2kWbxn/LEwMB/S0vkxcoIRBlgpdR
 IPw8kxwsKKwKQBd/6pnCIJeY056oxTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776362777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADzo27bpC43ZLZjZx/vV1h07flotCpsrQZs4mVLWAEA=;
 b=1Tf4FXUHcd8zRiahmIS0mTVq/xI3oEyj6MtbFviy4GJE7iXFdfebZ+TP5RxlaGCsKSDCdA
 lcqm1ZOVkeBrL/Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B+eTB3Wy;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=66qElluU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776362776;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADzo27bpC43ZLZjZx/vV1h07flotCpsrQZs4mVLWAEA=;
 b=B+eTB3Wyv6rqyEimourx76tDzKHuuAG0V5j+Vv15phaoYDxLbXMxqxXc2KBGVqP2GNitBl
 cdt3PVeFmBejzeZ7RvNye4edhWl0ZAT+D9mv7t4s04fu/yO7U+VQnZ3KC7WGd1JBVcSGt9
 2jxTwvQBDqmoArhS9cifgf+V+PFOWBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776362776;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADzo27bpC43ZLZjZx/vV1h07flotCpsrQZs4mVLWAEA=;
 b=66qElluUdCthrBfpR51ZifDK+SrRzzImGEsrsI3VjpqJ2nT61F2udrTXd8LdcOpSTcUY6/
 2BxG+r9FzVOy9JCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDE04593A3;
 Thu, 16 Apr 2026 18:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fRdWMRcl4WnxaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Apr 2026 18:06:15 +0000
Date: Thu, 16 Apr 2026 20:05:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <wangli.ahau@gmail.com>
Message-ID: <20260416180559.GA303991@pevik>
References: <20260410175031.16921-1-always.starving0@gmail.com>
 <20260413212007.GA164377@pevik>
 <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,generic_trunk_target.mk:url,generate_arch.sh:url,generate_syscalls.sh:url];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[generate_arch.sh:url,generate_syscalls.sh:url,generic_trunk_target.mk:url,suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.cz];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 43B3E6A801
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/lapi: add leaf Makefile
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

SGkgTGksCgpbIENjIEN5cmlsIGlmIGhlIHdhbnRzIHRvIGFkZCBoaXMgMiBjZW50cyBdCgo+IE9u
IFR1ZSwgQXByIDE0LCAyMDI2IGF0IDU6MjDigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5j
ej4gd3JvdGU6Cgo+ID4gSGkgSmluc2VvaywKCj4gPiBUaGFua3MgZm9yIGZpeGluZyB0aGlzIQoK
PiA+ID4gRml4ZXMgOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9p
c3N1ZXMvMTI2MgoKPiA+IG5pdDogUGxlYXNlIG5leHQgdGltZSBhdm9pZCBzcGFjZSBiZWZvcmUg
JzonLgoKPiA+IEZpeGVzOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0
cC9pc3N1ZXMvMTI2MgoKPiA+ID4gaW5jbHVkZS9sYXBpIGFuZCBpbmNsdWRlL2xhcGkvc3lzY2Fs
bHMgbGFjayBNYWtlZmlsZXMsIHNvICdtYWtlIGNoZWNrJwo+ID4gPiBkb2VzIG5vdCB3b3JrIGlu
IHRoZXNlIGRpcmVjdG9yaWVzLiBBZGQgbWluaW1hbCBsZWFmIE1ha2VmaWxlcy4KCj4gPiBuaXQ6
IEFsc28gaXQnZCBnbyBoZXJlLgoKPiA+ID4gU2lnbmVkLW9mZi1ieTogSmluc2VvayBLaW0gPGFs
d2F5cy5zdGFydmluZzBAZ21haWwuY29tPgo+ID4gPiAtLS0KPiA+ID4gIGluY2x1ZGUvbGFwaS9N
YWtlZmlsZSAgICAgICAgICB8IDggKysrKysrKysKPiA+ID4gIGluY2x1ZGUvbGFwaS9zeXNjYWxs
cy9NYWtlZmlsZSB8IDggKysrKysrKysKPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGFwaS9NYWtlZmlsZQo+
ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGFwaS9zeXNjYWxscy9NYWtlZmlsZQoK
PiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9NYWtlZmlsZSBiL2luY2x1ZGUvbGFwaS9N
YWtlZmlsZQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gPiBpbmRleCAwMDAwMDAwMDAu
LjgzZWY4NWM3Nwo+ID4gPiAtLS0gL2Rldi9udWxsCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGFwaS9N
YWtlZmlsZQo+ID4gPiBAQCAtMCwwICsxLDggQEAKPiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiA+ID4gKyMgQ29weXJpZ2h0IChDKSAyMDI2IEppbnNl
b2sgS2ltIDxhbHdheXMuc3RhcnZpbmcwQGdtYWlsLmNvbT4KPiA+ID4gKwo+ID4gPiArdG9wX3Ny
Y2RpciAgICAgICAgICAgICAgPz0gLi4vLi4vCj4gPiA+ICsKPiA+ID4gK2luY2x1ZGUgJCh0b3Bf
c3JjZGlyKS9pbmNsdWRlL21rL2Vudl9wcmUubWsKPiA+ID4gKwo+ID4gPiAraW5jbHVkZSAkKHRv
cF9zcmNkaXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3RhcmdldC5tawo+ID4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9sYXBpL3N5c2NhbGxzL01ha2VmaWxlIGIvaW5jbHVkZS9sYXBpL3N5c2Nh
bGxzL01ha2VmaWxlCgo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gPiBpbmRleCAwMDAw
MDAwMDAuLmU0NmM5MGVmNQo+ID4gPiAtLS0gL2Rldi9udWxsCj4gPiA+ICsrKyBiL2luY2x1ZGUv
bGFwaS9zeXNjYWxscy9NYWtlZmlsZQo+ID4gPiBAQCAtMCwwICsxLDggQEAKPiA+ID4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiA+ID4gKyMgQ29weXJpZ2h0
IChDKSAyMDI2IEppbnNlb2sgS2ltIDxhbHdheXMuc3RhcnZpbmcwQGdtYWlsLmNvbT4KPiA+ID4g
Kwo+ID4gPiArdG9wX3NyY2RpciAgICAgICAgICAgICAgPz0gLi4vLi4vLi4vCj4gPiA+ICsKPiA+
ID4gK2luY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2Vudl9wcmUubWsKPiA+ID4gKwo+
ID4gPiAraW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3Rhcmdl
dC5tawoKPiA+IFdoeSBkbyB3ZSBuZWVkIHRoaXMgZmlsZT8gVGhpcyBvbmUgc2hvdWxkIGJlIGRl
bGV0ZWQuIEFsc28sIGJlY2F1c2UgbWFrZSBpbnN0YWxsCj4gPiB3b3JrcyBmb3IgaW5jbHVkZSBk
aXJlY3RvcnksIGl0IHNob3VsZCB3b3JrIGhlcmUgYXMgd2VsbC4KPiA+IEkgd291bGQganVzdCBj
b3B5IHRoYXQgaGVhZGVyLCB1cGRhdGUgdG9wX3NyY2RpciBsb2NhdGlvbiBhbmQgYWxzbyBpbmNs
dWRlCj4gPiBnZW5lcmljX3RydW5rX3RhcmdldC5tayB0byBpbmNsdWRlL01ha2VmaWxlLgoKPiA+
IEkgdGhpbmsgdGhpcyBpcyBhIGJldHRlciB2ZXJzaW9uLgoKPiBZZXMsIHRoaXMgc29sdXRpb24g
bG9va3Mgc21hcnRlciwgYnV0IHRpbnkgcXVlcmllcyBiZWxvdy4KCj4gPiAuLi4KPiA+ICBpbmNs
dWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9lbnZfcHJlLm1rCgo+ID4gK0lOU1RBTExfRElS
ICAgICAgICAgICAgOj0gJChpbmNsdWRlZGlyKS9sYXBpCgo+IEknbSBkb3VidGluZyBzaG91bGQg
d2UgaW5zdGFsbCB0aGUgaW5jbHVkZS9sYXBpLyBsb2NhbCBoZWFkZXIgZmlsZXMgdG8KPiB0aGUg
L29wdC9sdHAvaW5jbHVkZT8KCkRvIHlvdSBxdWVzdGlvbiAqd2hldGhlciogaW5zdGFsbCBsYXBp
LyouaCBvciAqd2hlcmUqIHRvIGluc3RhbGwgdGhlbT8KV2UgaW5zdGFsbCBpbmNsdWRlLyouaCBm
aWxlcy4gV2hhdCBpcyBhIGRpZmZlcmVuY2Ugd2l0aCBpbmNsdWRlL2xhcGkvPwoKSSdkIHNheSBl
aXRoZXIgaW5zdGFsbCBib3RoIG9yIG5vbmUuIEkgd291bGQgcHJlZmVyIHRvIG5vdCBpbnN0YWxs
IGFueSwKTFRQIGxpYnJhcnkgaXMgbm90IHNlcGFyYXRlZCBhbnl3YXkgKHRoZXJlIGlzIGFuIG9s
ZCBBbmRyZWEncyBlZmZvcnQsIGJ1dCB0aGF0CnVzZXMgbWVzb24gYW55d2F5KS4gSW5zdGFsbGF0
aW9uIHdhcyBhZGRlZCBpbiAyMDA4IGFuZCBJIGRvdWJ0IGFueWJvZHkgaXMgdXNpbmcKaXQuCgo+
ID4gLi4uCj4gPiAtLS0gaW5jbHVkZS9sYXBpL3N5c2NhbGxzL01ha2VmaWxlCj4gPiArKysgL2Rl
di9udWxsCgo+IERvZXMgdGhlIGBtYWtlIGNoZWNrYCBzdGlsbCB3b3JrIChpbnNpZGUgaW5jbHVk
ZS9sYXBpL3N5c2NhbGxzLykKPiB3aXRob3V0IHRoaXMgTWFrZWZpbGU/CgpTdXJlIG5vdC4gRG8g
d2UgcmVhbGx5IHdhbnQgdG8gY2hlY2sgZ2VuZXJhdGVfYXJjaC5zaCBhbmQgZ2VuZXJhdGVfc3lz
Y2FsbHMuc2gKaW4gYXJjaD8gSWYgeWVzLCBzdXJlIGl0IG5lZWRzIHRvIGJlIGFkZGVkLCBidXQg
dGhhdCB3YXMgbm90IG15IGludGVudGlvbiB3aGVuCmNyZWF0aW5nICMxMjYyLiBJIHJlYWxseSB3
YW50ZWQgdG8gY2hlY2sgQyAoYW5kIHNoZWxsKSBsaWJyYXJ5IGFuZCB0ZXN0cyBjb2RlLgoKS2lu
ZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
