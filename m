Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793BDE9A04C
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 08:19:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38C2B3D0719
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 09:19:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA31C3CB063
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 09:19:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 47783100046D
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 09:19:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F5CD3E6ED;
 Thu, 19 Feb 2026 08:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771489160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MLZe1fDA0d+4IArpjJPBWoFkPsCVpxDXG71FAT557s=;
 b=q1pwBEcF8kjGhYxHJwDXw4ref+6a7TSW65HCMxyhSBNeCm8LXXSMZZb8T4HvY6o2S8Giwp
 o/FtXDcAGPKUPtJOnBwkAlGcYH9Ush3R5yp7YppFh/W6BNay8y/FVV39QZI237d7zvywRk
 JvYLJn5UJnFaY/PiZQzDVc/w7AwY8tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771489160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MLZe1fDA0d+4IArpjJPBWoFkPsCVpxDXG71FAT557s=;
 b=2I5V9ud3T33SC5zRDJlTh7rLUB42hMP6aXwBc6KLYWZuY5q9kPYrsapE8cf+HnAmWATSls
 1fqABKhi3VvaafDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771489160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MLZe1fDA0d+4IArpjJPBWoFkPsCVpxDXG71FAT557s=;
 b=q1pwBEcF8kjGhYxHJwDXw4ref+6a7TSW65HCMxyhSBNeCm8LXXSMZZb8T4HvY6o2S8Giwp
 o/FtXDcAGPKUPtJOnBwkAlGcYH9Ush3R5yp7YppFh/W6BNay8y/FVV39QZI237d7zvywRk
 JvYLJn5UJnFaY/PiZQzDVc/w7AwY8tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771489160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MLZe1fDA0d+4IArpjJPBWoFkPsCVpxDXG71FAT557s=;
 b=2I5V9ud3T33SC5zRDJlTh7rLUB42hMP6aXwBc6KLYWZuY5q9kPYrsapE8cf+HnAmWATSls
 1fqABKhi3VvaafDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 448F73EA65;
 Thu, 19 Feb 2026 08:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nM6+D4jHlmn2YQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 19 Feb 2026 08:19:20 +0000
Date: Thu, 19 Feb 2026 09:19:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20260219081914.GA309124@pevik>
References: <20260218190230.53759-1-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260218190230.53759-1-japo@linux.ibm.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,msgid.link:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] ioctl_pidfd06: expect EREMOTE for
 PIDFD_GET_INFO across pidns
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmFuLAoKPiBLZXJuZWwgY2hhbmdlZCBQSURGRF9HRVRfSU5GTyBzZW1hbnRpY3Mgd2hlbiB0
aGUgcGlkZmQgcmVmZXJzIHRvIGEgdGFzawo+IHRoYXQgaGFzIG5vIFBJRCBpbiB0aGUgY2FsbGVy
J3MgY3VycmVudCBwaWQgbmFtZXNwYWNlOiByZXR1cm4gLUVSRU1PVEUKPiBpbnN0ZWFkIG9mIC1F
U1JDSCwgYWxsb3dpbmcgdXNlcnNwYWNlIHRvIGRpc3Rpbmd1aXNoIOKAnGRpZmZlcmVudCBwaWRu
c+KAnQo+IGZyb20g4oCccHJvY2VzcyBleGl0ZWTigJ0uCgpHb29kIGNhdGNoLCB0aGFuayB5b3Uu
IFRoaXMgaXMgYWxyZWFkeSBpbiBMaW51cycgdHJlZSBmb3IgdXBjb21pbmcgdjcuMC4KCj4gVXBk
YXRlIGlvY3RsX3BpZGZkMDYgdG8gZXhwZWN0IEVSRU1PVEUgaW4gdGhhdCBjYXNlLgoKPiBMaW5r
OiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1mc2RldmVsL21zZzMyNjY5OS5o
dG1sCgpDb3VsZCB5b3UgcGxlYXNlIG5leHQgdGltZSB1c2UgbG9yZT8gV2h5PyAxKSBpdCBoYWQg
c29tZSBwcm9ibGVtcyBpbiB0aGUgcGFzdCBbMV06Cglsa21sLm9yZyB3YXMgZGl0Y2hlZCBzb21l
IHRpbWUgYWdvIGJ5IGtlcm5lbCBkZXZzLiBJdCBoYWQgb2Z0ZW4gaXNzdWVzLCBpcwoJY3JvcHBp
bmcgbWVzc2FnZXMsIGhhcyBubyBleHBvcnQgZnVuY3Rpb24sIGhhcyBzb21ldGltZXMgZXZlbiBh
ZHMgb24gdGhlCglzaXRlLiBUaGF0J3Mgd2h5IGtlcm5lbC5vcmcgZm9sa3MgcnVuIG5vdyB0aGVp
ciBvd24gcmVsaWFibGUgYXJjaGl2ZS4KClRoZXJlZm9yZSBpdCB3YXMgcmVwbGFjZWQgaW4gdGhl
IGxpbnV4IGtlcm5lbCBbMl06CgoJUmVwbGFjZSB0aGUgbGttbC5vcmcgbGlua3Mgd2l0aCBsb3Jl
IHRvIGJldHRlciB1c2UgYSBzaW5nbGUgc291cmNlCgl0aGF0J3MgbW9yZSBsaWtlbHkgdG8gc3Rh
eSBhdmFpbGFibGUgbG9uZy10ZXJtLgoKVGhlcmVmb3JlOgpMaW5rOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjYwMTI3MjI1MjA5LjIyOTMzNDItMS1sdWNhLmJvY2Nh
c3NpQGdtYWlsLmNvbS8KClRoZSBjb21taXQgaW4gdXBjb21pbmcgdjcuMCBpczoKYWI4OTA2MGZi
YzkyZSAoInBpZGZzOiByZXR1cm4gLUVSRU1PVEUgd2hlbiBQSURGRF9HRVRfSU5GTyBpcyBjYWxs
ZWQgb24gYW5vdGhlciBucyIpCk1heWJlIGl0J2QgYmUgd29ydGggdG8gdXNlIGl0IGluc3RlYWQg
b2YgbGlua3MgdG8gbG9yZS4KCkFsc28gbWlub3Igbm90ZSBhYm91dCB1c2luZyAnTGluazonLiBJ
IHVzZSBpdCB0aGUgc2FtZSB3YXkgYXMga2VybmVsIG1haW50YWluZXJzCi0gaXQgY29udGFpbnMg
YSBsaW5rIHRvIHRoZSBwYXRjaGVzIGluIGxvcmUgKG9yIHRvIHBhdGNoLm1zZ2lkLmxpbmsgd2hp
Y2gKcmVkaXJlY3QgdG8gbG9yZSk6IEknbGwgYWRkOgpMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sdHAvMjAyNjAyMTgxOTAyMzAuNTM3NTktMS1qYXBvQGxpbnV4LmlibS5jb20vCgpUaGF0
J3Mgd2h5IEkgdGVuZCB0byB1c2UgWzFdIGZvciBvdGhlciBsaW5rIHRvIG5vdCBtaXggbGluayB0
byB0aGUgcGF0Y2ggd2l0aApvdGhlciBsaW5rcy4KCj4gTGluazogaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMjYvMi8xNi82MDgKQWxzbyB0aGlzIG1lc3NhZ2Ugd291bGQgYmUgYmV0dGVyIHRvIHRh
a2UgZnJvbSBsb3JlLiBCdXQgZG8gd2UgbmVlZCBhIGxpbmsgdG8KdGhlIHB1bGwgcmVxdWVzdCBp
dHNlbGY/IElNSE8gbm90LgoKPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYw
MjE0MDEwMjQ1LjM2NzE5MDctMzQtc2FzaGFsQGtlcm5lbC5vcmcKVGhpcyBpcyBsaW5rIGlzIG5v
dCByZWxhdGVkIGF0IGFsbCAoYSBkaWZmZXJlbnQgY29tbWl0KS4gQW5kIGl0IGNvbnRhaW5zClsg
VXBzdHJlYW0gY29tbWl0IDk4NzdhODY1ZDYyYzljM2UwZjRjYzM2OWRjOWNhOWY3ZjI0ZjVlZTkg
XQp3aGljaCBtZWFucyB0aGF0IHRoaXMgZGlmZmVyZW50IGNvbW1pdCBpcyBhbHNvIGEgYmFja3Bv
cnQgdG8gdGhlIHN0YWJsZSwgbm90CnBhdGNoIGZvciBtYWlubGluZS4KCj4gU2lnbmVkLW9mZi1i
eTogSmFuIFBvbGVuc2t5IDxqYXBvQGxpbnV4LmlibS5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxfcGlkZmQwNi5jIHwgMiArLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCj4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxfcGlkZmQwNi5jIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9waWRmZDA2LmMKPiBpbmRleCA3NTEyODFiYWNiNzQu
LjgxMjA1YWZiNzJhNiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lv
Y3RsL2lvY3RsX3BpZGZkMDYuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9j
dGwvaW9jdGxfcGlkZmQwNi5jCj4gQEAgLTQxLDcgKzQxLDcgQEAgc3RhdGljIHZvaWQgcnVuKHZv
aWQpCj4gIAlhcmdzLT5leGl0X3NpZ25hbCA9IFNJR0NITEQ7Cgo+ICAJaWYgKCFTQUZFX0NMT05F
KGFyZ3MpKSB7Cj4gLQkJVFNUX0VYUF9GQUlMKGlvY3RsKHBpZGZkLCBQSURGRF9HRVRfSU5GTywg
aW5mbyksIEVTUkNIKTsKPiArCQlUU1RfRVhQX0ZBSUwoaW9jdGwocGlkZmQsIFBJREZEX0dFVF9J
TkZPLCBpbmZvKSwgRVJFTU9URSk7CgpXZSBhcmUgdXN1YWxseSBub3QgdGhhdCBzdHJpY3QgYW5k
IGFjY2VwdCBib3RoIGVycm5vcyAoaS5lLiB1c2luZwpUU1RfRVhQX0ZBSUxfQVJSKCkpIHdpdGhv
dXQgYm90aGVyaW5nIGtlcm5lbCB2ZXJzaW9uIGNoZWNraW5nIGlmIGl0J3Mga2luZCBvZgpuZXcg
ZmVhdHVyZS4gU29tZXRpbWVzIGl0J3MgZXZlbiBjb21wbGljYXRlZCB0byBjaGVjayB0aGUga2Vy
bmVsIHZlcnNpb24sCnNlZSBhMmFiMzc0NTlhIGluIGJpbmQwMy5jIChGWUkgaWYgaXQncyByZXF1
aXJlZCB0byBjaGVjayBrZXJuZWwgdmVyc2lvbiwKd2UgdXN1YWxseSBkZXRlY3QgaXQgaW4gdGhl
IHNldHVwLCBlLmcuIDJkMDY2ZWFkM2QpLgoKWW91ciBhcHByb2FjaCAoc2luZ2xlIGVycm5vKSBp
cyB1c2VkIGlmIHRoZSBjaGFuZ2UgaXMgYSByZWFsIGZpeCwgd2hpY2ggaXMKKmludGVuZGVkKiB0
byBiZSBiYWNrcG9ydGVkIHRvIHRoZSBzdGFibGUga2VybmVscyAocGF0Y2ggdXN1YWxseSBoYXMg
Q2M6IHN0YWJsZQp2ZXJzaW9uLCB1bmxpa2Ugb3RoZXIgY29tbWl0cyBiYWNrcG9ydGVkIHRvIHN0
YWJsZSBkdWUgRml4ZXM6KS4gQnV0IGluIHRoaXMgY2FzZQppdCBzaG91bGQgdXNlICJsaW51eC1n
aXQiIHRhZyByZWNvcmQgWzNdLgoKCS50YWdzID0gKGNvbnN0IHN0cnVjdCB0c3RfdGFnW10pIHsK
CQl7ImxpbnV4LWdpdCIsICJhYjg5MDYwZmJjOTJlIn0sCgkJe30KCX0KCkhlcmUgSSdtIG5vdCBz
dXJlIG15c2VsZiBob3cgc2V2ZXJlIGl0IGlzLiBJIHN1cHBvc2UgaXQgd2lsbCBiZSBiYWNrcG9y
dGVkIHRvCnN0YWJsZSBhcyBhIGZpeCwgbWF5YmUgcmVhbGx5IGp1c3QgYWRkIGxpbnV4LWdpdC4K
CktpbmQgcmVnYXJkcywKUGV0cgoKWzFdIGh0dHBzOi8vbmV3cy55Y29tYmluYXRvci5jb20vaXRl
bT9pZD0zNDk3OTU5MQpbMl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9MDVhNWY1MWNhNTY2ClszXSBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rlci9kb2Mv
b2xkL0MtVGVzdC1BUEkuYXNjaWlkb2MjMTQwLXRlc3QtdGFncwoKPiAgCQlleGl0KDApOwo+ICAJ
fQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
