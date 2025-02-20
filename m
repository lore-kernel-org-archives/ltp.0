Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AC6C021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 20:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0AEE3C7ABD
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 21:43:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92DCE3C050F
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 21:43:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9CB2264068B
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 21:43:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22D0C21186;
 Thu, 20 Feb 2025 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740084181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ohc1dtz6QTM/m7o74GfWvWUWG6fboHZgR7HGRL6Aygo=;
 b=sM6vC8dhBjKm9s6bQteD0KzP8/S3JJKD7BEBUua2FbJ85JRvAVivtX5F7VHPaGJlYhU1Et
 JdWjUjZ6qd2uRELAgqxjZUvu3wt8M/FZ1vkekW8xmCmcbnjxOHrNRqkoWabKcOwPmevPdv
 W8biJ207ierzL3rzBDM8m5l8GSG0XoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740084181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ohc1dtz6QTM/m7o74GfWvWUWG6fboHZgR7HGRL6Aygo=;
 b=ho2eQRVVAlatpxqPT5XhgYcAzy9jSeuuv4Hj5EzHhsretSv95b36cHIWWENO3jDTXd6q5w
 DFMQoSnr7duoSCCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740084181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ohc1dtz6QTM/m7o74GfWvWUWG6fboHZgR7HGRL6Aygo=;
 b=sM6vC8dhBjKm9s6bQteD0KzP8/S3JJKD7BEBUua2FbJ85JRvAVivtX5F7VHPaGJlYhU1Et
 JdWjUjZ6qd2uRELAgqxjZUvu3wt8M/FZ1vkekW8xmCmcbnjxOHrNRqkoWabKcOwPmevPdv
 W8biJ207ierzL3rzBDM8m5l8GSG0XoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740084181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ohc1dtz6QTM/m7o74GfWvWUWG6fboHZgR7HGRL6Aygo=;
 b=ho2eQRVVAlatpxqPT5XhgYcAzy9jSeuuv4Hj5EzHhsretSv95b36cHIWWENO3jDTXd6q5w
 DFMQoSnr7duoSCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EC7C13A42;
 Thu, 20 Feb 2025 20:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +FE6EtSTt2fVTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 20:43:00 +0000
Date: Thu, 20 Feb 2025 21:42:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250220204253.GA2719924@pevik>
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-4-amir73il@gmail.com>
 <yvpm5aiigldl2ftkatepoddjitxs64r6n2igcatetyukpbp3re@35yc3muudqdf>
 <CAOQ4uxhex0Dz+c-DM9emgqhsYMar08NC4JSuc9TkiDujmN7h6A@mail.gmail.com>
 <20250211190943.GC1911494@pevik>
 <CAOQ4uxg6T+oO-RUcs+AA2W2emC18hboQMec7NUnQ=zFqoNPjbA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg6T+oO-RUcs+AA2W2emC18hboQMec7NUnQ=zFqoNPjbA@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.999]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCPT_COUNT_FIVE(0.00)[5]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] fanotify24: Add test for FAN_PRE_ACCESS and
 FAN_DENY_ERRNO
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
Cc: Martin Doucha <martin.doucha@suse.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIEZlYiAxMSwgMjAyNSBhdCA4OjA54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+ID4gT24gTW9uLCBGZWIgMTAsIDIwMjUgYXQgNDo0M+KAr1BNIEph
biBLYXJhIDxqYWNrQHN1c2UuY3o+IHdyb3RlOgoKPiA+ID4gPiBPbiBNb24gMTAtMDItMjUgMTY6
MTM6MTUsIEFtaXIgR29sZHN0ZWluIHdyb3RlOgo+ID4gPiA+ID4gRm9yayB0aGUgdGVzdCBmYW5v
dGlmeTI0IGZyb20gdGVzdCBmYW5vdGlmeTAzLCByZXBsYWNpbmcgdGhlCj4gPiA+ID4gPiBwZXJt
aXNzaW9uIGV2ZW50IEZBTl9BQ0NFU1NfUEVSTSB3aXRoIHRoZSBuZXcgcHJlLWNvbnRlbnQgZXZl
bnQKPiA+ID4gPiA+IEZBTl9QUkVfQUNDRVNTLgoKPiA+ID4gPiA+IFRoZSB0ZXN0IGlzIGNoYW5n
ZWQgdG8gdXNlIGNsYXNzIEZBTl9DTEFTU19QUkVfQ09OVEVOVCwgd2hpY2ggaXMKPiA+ID4gPiA+
IHJlcXVpcmVkIGZvciBGQU5fUFJFX0FDQ0VTUyBhbmQgdGhpcyBjbGFzcyBhbHNvIGVuYWJsZWQg
dGhlIHJlc3BvbnNlCj4gPiA+ID4gPiB3aXRoIGN1dG9tZXIgZXJyb3IgY29kZSBGQU5fREVOWV9F
UlJOTy4KCj4gPiA+ID4gPiBVbmxpa2UgRkFOX0FDQ0VTU19QRVJNLCBGQU5fUFJFX0FDQ0VTUyBp
cyBhbHNvIGNyZWF0ZWQgb24gd3JpdGUoKQo+ID4gPiA+ID4gc3lzdGVtIGNhbGwuICBUaGUgdGVz
dCBjYXNlIGV4cGVjdGVkIHJlc3VsdHMgYXJlIGFkanVzdGVkIHRvCj4gPiA+ID4gPiByZXNwb25k
IHdpdGggdGhlIGRlZmF1bHQgZXJyb3IgKEVQRVJNKSB0byBvcGVuKCkgYW5kIHdyaXRlKCkgYW5k
Cj4gPiA+ID4gPiB0byByZXNwb25kIHdpdGggY3VzdG9tIGVycm9ycyAoRUlPLCBFQlVTWSkgdG8g
cmVhZCgpIGFuZCBleGVjdmUoKS4KCj4gPiA+ID4gPiBOb3QgYWxsIGZzIHN1cHBvcnQgcHJlLWNv
bnRlbnQgZXZlbnRzLCBzbyBydW4gb24gYWxsIGZpbGVzeXN0ZW1zCj4gPiA+ID4gPiB0byBleGNl
cmNpc2UgRkFOX1BSRV9BQ0NFU1Mgb24gYWxsIHN1cHBvcnRlZCBmaWxlc3lzdGVtcy4KCj4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgoK
PiA+ID4gPiBMb29rcyBnb29kIHRvIG1lLiBJIHdhcyBqdXN0IHdvbmRlcmluZyB3aGV0aGVyIHNv
bWUgYml0cyBsaWtlCj4gPiA+ID4gZ2VuZXJhdGVfZXZlbnRzKCksIG1hcmsgc2V0dXAsIGNoaWxk
IHNldHVwLCBtYWluIHRlc3QgbG9vcCBjb3VsZCBub3QgYmUKPiA+ID4gPiBmYWN0b3JlZCBvdXQg
aW50byBhIGhlbHBlciBmdW5jdGlvbnMgdXNlZCBieSBib3RoIG9sZCBhbmQgbmV3IHRlc3RzPwoK
PiA+ID4gWWVzLCBJIGFncmVlIHRoYXQgZm9ya2luZyB0aGUgdGVzdHMgaXMgYmFkIGFuZCB0aGF0
IHdlIG5lZWQgbXVjaAo+ID4gPiBtb3JlIGNvbW1vbiBoZWxwZXJzLgoKPiA+ID4gSUlVQywgTFRQ
IGRldmVsb3BlcnMgYXJlIGdvaW5nIHRvIHRyeSB0byBjb21lIHVwIHdpdGggc29tZSBwcm9wb3Nh
bHMKPiA+ID4gZm9yIHJlZmFjdG9yaW5nIGhlbHBlcnMgdG8gc3BsaXQgc29tZSBsYXJnZSBmYW5v
dGlmeSB0ZXN0cyBbMV1bMl0uCgo+ID4gPiBNeSBvcGluaW9uIGlzIHRoYXQgZmFjdG9yaW5nIG91
dCBoZWxwZXJzIHRoYXQgYXJlIHVzZWZ1bCBvbmx5IGZvcgo+ID4gPiBmYW5vdGlmeTAzLGZhbm90
aWZ5MjQgaXMgc3Vib3B0aW1hbCBhbmQgd2UgbmVlZCB0byBzZWUgaWYgd2UgY2FuCj4gPiA+IGNy
ZWF0ZSBtdWNoIG1vcmUgZ2VuZXJpYyBoZWxwZXJzIHRoYXQgY291bGQgYmUgc2hhcmVkIGJ5IG1v
cmUgdGVzdHMuCgo+ID4gPiBCVFcsIGlmIHlvdSBsb29rIGNsb3NlciwgeW91IHdpbGwgc2VlIHRo
YXQgZ2VuZXJhdGVfZXZlbnRzKCkgaXMgcXVpdGUKPiA+ID4gZGlmZmVyZW50IGJldHdlZW4gZmFu
b3RpZnkwMyBhbmQgZmFub3RpZnkyNCwgYWx0aG91Z2ggaXQgaXMgdHJ1ZSB0aGF0Cj4gPiA+IGZh
bm90aWZ5MjQgaGFzIGEgbW9yZSBnZW5lcmFsaXplZCB2ZXJzaW9uIHRoYXQgZm9sbG93cyB0aGUg
ZXhwZWN0ZWQKPiA+ID4gZXZlbnRzIG1vcmUgY2xvc2VseS4KCj4gPiA+IEkgZGlkIHN0YXJ0IHdp
dGggZXh0ZW5kaW5nIGZhbm90aWZ5MDMgYmVmb3JlIEkgZm9ya2VkIGl0IGFuZCBiZWZvcmUgdGhl
Cj4gPiA+IGZvcmsgZ2VuZXJhdGVfZXZlbnRzKCkgd2FzIGV2ZW4gbW9yZSBoYXJkIHRvIGZvbGxv
dyBiZWNhdXNlIG9mCj4gPiA+IHRoZSBkaWZmZXJlbmNlIGluIGV4cGVjdGVkIGV2ZW50cyBmb3Ig
d3JpdGUoKSBiZXR3ZWVuIHBlcm1pc3Npb24KPiA+ID4gYW5kIHByZS1jb250ZW50IGV2ZW50cy4K
Cj4gPiBJJ20gbm90IGhhcHB5IHRoYXQgdGVzdHMgYXJlIG5lYXJseSBpZGVudGljYWwsIGJ1dCBh
Z3JlZSB0aGF0IG1lcmdpbmcgdGhlbSB3b3VsZAo+ID4gbWFrZSByZWFkYWJpbGl0eSBldmVuIGhh
cmRlci4gQWxzbyBpZiB0aGVyZSBpcyByZWFsbHkgbm8gdmFsdWUgdG8gcnVuCj4gPiBGQU5fQUND
RVNTX1BFUk0gKGZhbm90aWZ5MDMuYykgb24gYWxsIGZpbGVzeXN0ZW1zIGl0IHdvdWxkIHByb2xv
bmcgdGVzdGluZy4KCj4gPiBUaGUgb25seSBkb3duc2lkZSBvZiBub3QgZmFjdG9yaW5nIG91dCBj
b21tb24gY29kZSBpcyB0aGF0IGZpeCBpbiBvbmUgdGVzdCB3aWxsCj4gPiBub3QgYXBwZWFyIGlu
IHRoZSBvdGhlciB0ZXN0IChpdCBsb29rcyB0byBtZSBmcm9tIHdoYXQgeW91IHdyb3RlIHRoYXQg
eW91Cj4gPiBpbXByb3ZlZCBnZW5lcmF0ZV9ldmVudHMoKSBmb3IgZmFub3RpZnkyNC5jIGJ1dCBu
b3QgZm9yIGZhbm90aWZ5MDMuYy4gQWxzbyBub3cKPiA+IGlzIGZvciBtZSB0byByZW1lbWJlciBy
ZW1vdmUgZWxzZSBpZiAoZXJybm8gPT0gZXhwX2Vycm5vKSBbMV0gYWxzbyBmb3IKPiA+IGZhbm90
aWZ5MjQuYykuCgo+IFBsZWFzZSBkb24ndCByZW1vdmUgdGhlc2UgZWxzZSBmcm9tIGZhbm90aWZ5
MjQuCj4gSSBtZWFudCB0aGF0IHRoZSBlbHNlIGluIGZhbm90aWZ5MDMuYyBhcmUgbm90IG5lZWRl
ZCBiZWNhdXNlIHRoZXkgY2FtZQoKPiBmcm9tIHRoZSBnZW5lcmljIGdlbmVyYXRlX2V2ZW50cygp
IG9mIGZhbm90aWZ5MjQuYyB3aGljaCBzdXBwb3J0cwo+IGRpZmZlcmVudCBleHBlY3RlZCBlcnJu
byB2YWx1ZXMgKEZBTl9ERU5ZX0VSUk5PKHh4eCkpLgo+IGZhbm90aWZ5MDMgZG9lcyBub3QgaGF2
ZSBGQU5fREVOWV9FUlJOTyh4eHgpLCBzbyBjb21wYXJpbmcgZXhwX2Vycm5vCj4gaXMgbm90IG5l
ZWRlZCBpbiBmYW5ib3RpZnkwMy4gSXQgaXMgbmVlZGVkIGluIGZhbm90aWZ5MjQuCgpBaCwgc3Vy
ZSwgSSdsbCBrZWVwIHRoZW0uCgo+ID4gV2UgaGF2ZSBsb25nIGhpc3Rvcnkgb2YgdGhpcyBpbiBM
VFAuICBCdXQgSSdtIGFsc28gbm90IHN1cmUgaWYKPiA+IGl0J3Mgd29ydGggZmFjdG9yaW5nIG91
dCBjb2RlIGp1c3QgZm9yIDIgdGVzdHMuIFdlIG1pZ2h0IHJlY29uc2lkZXIgZmFjdG9yaW5nCj4g
PiBvdXQsIGJ1dCB1bmxlc3MgTWFydGluIG9yIEN5cmlsIG9iamVjdHMgSSB3b3VsZCBrZWVwIGl0
IGZvciBub3cuCgo+ID4gSSB3YXMgbG9va2luZyBicmllZmx5IGZvciBjb2RlIHdoaWNoIGNvdWxk
IGJlIHR1cm5lZCBpbnRvIG1vcmUgZ2VuZXJpYyBoZWxwZXJzLAo+ID4gYnV0IHNvIGZhciBJIGhh
dmVuJ3QgZm91bmQgYW55dGhpbmcuIE1heWJlIHlvdSBoYXZlIGJldHRlciBpZGVhLgoKCj4gSSBk
byBub3QgaGF2ZSBhIGJldHRlciBpZGVhLgo+IGZhbm90aWZ5MDMgYW5kIGZhbm90aWZ5MjQgYXJl
IHN1ZmZpY2llbnRseSBzaW1pbGFyIHRvIGR1cCBhIGxvdCBvZiBjb2RlCj4gYW5kIHN1ZmZpY2ll
bnRseSBkaWZmZXJlbnQgdG8gbWFrZSBjb21tb24gY29kZSBoYXJkIG9yIG1vcmUKPiBjb21wbGV4
LgoKPiBJTU8sIHRoZSBjb2RlIHRoYXQgaXMgcmVsYXRpdmVseSBjb21tb24gdG8gbWFueSBmYW5v
dGlmeSB0ZXN0cyBpcyB0aGUKPiBldmVudCByZWFkIGFuZCBwcm9jZXNzIGxvb3AuCgo+IEkgdGhp
bmsgaXQgc2hvdWxkIGJlIGRvYWJsZSB0byBtYWtlIHRoZXNlIGxvb3BzIHVzZSBjb21tb24gaGVs
cGVycyBmb3IKPiByZWFkaW5nIGFuZCB2ZXJpZnlpbmcgdGhlIGV4cGVjdGVkIGV2ZW50cywgYnV0
IGl0IGlzIG5vdCBhIHNtYWxsIGpvYiB0byBtYWtlCj4gdGhvc2UgaGVscGVycyBnZW5lcmljIGVu
b3VnaCB0byBjYXRlciBhbGwgdGhlIGRpZmZlcmVudCB0ZXN0cyB0aGF0IGNoZWNrCj4gZGlmZmVy
ZW50IGV2ZW50IGZvcm1hdHMuCgpUaGFua3MgZm9yIGEgaGludC4gSSdsbCBzZWUgaWYgSSBmaW5k
IGEgdGltZSBhbmQgY29tZSB1cCB3aXRoIHNvbWV0aGluZyB1c2VmdWwuCgpXZSBicmllZmx5IHRh
bGsgd2l0aCBDeXJpbCBhYm91dCB0aGlzIGFuZCBhZ3JlZSB0aGF0IHdlIGRvbid0IHdhbnQgdG8g
YmxvY2sKdGhpcy4gSSdsbCB3YWl0IGxpdHRsZSBsb25nZXIgaWYgQ3lyaWwgd2FudHMgdG8gYWRk
IHNvbWV0aGluZyBhbmQgbWVyZ2UgZHVyaW5nCnRvbW9ycm93LiBBZ2FpbiwgdGhhbmtzIGEgbG90
IGZvciB1cGRhdGluZyBmYW5vdGlmeSB0ZXN0Y2FzZXMgaW4gTFRQLgoKS2luZCByZWdhcmRzLApQ
ZXRyCgo+IFRoYW5rcywKPiBBbWlyLgoKPiA+IEZZSSB0aGVyZSBpcyBub3Qgb25seSB0ZXN0IGNv
ZGUgYW5kIHRlc3Qgb3V0cHV0IHJlYWRhYmlsaXR5LCBidXQgYWxzbyBhYmlsaXR5IHRvCj4gPiBm
aWx0ZXIgb3V0IGNlcnRhaW4gZml4LiBJZiBwYXJ0aWN1bGFyIGZpeCBpcyBub3QgYmFja3BvcnRl
ZCB0byBlbnRlcnByaXNlIGtlcm5lbAo+ID4gKFdPTlRGSVgpLiBXaXRoIG9uZSBvZiBtYW55IHRl
c3RzIGZhaWxzIHdlIGhhdmUgbm8gd2F5IHRvIGRpc3Rpbmd1aXNoIGl0IGluIHRoZQo+ID4gY3Vy
cmVudCBjb2RlICh0c3Rfa3ZlcmNtcDIoKSBkb2VzIG5vdCBhbHdheXMgaGVscCkuIFRoZXJlZm9y
ZSB3ZSBwcmVmZXIgdG8gaGF2ZQo+ID4gcmVncmVzc2lvbiB0ZXN0cyBpbiBzZXBhcmF0ZSBmaWxl
cyAoZG9uJ3QgbWl4IHRoZW0gd2l0aCB0ZXN0cyBmb3IgYmFzaWMKPiA+IGZ1bmN0aW9uYWxpdHkp
LiBCdXQgdGhhdCB3b3VsZCBwcm9iYWJseSBsZWFkIHRvIGV2ZW4gbW9yZSBjb2RlIGR1cGxpY2l0
eS4KCj4gPiBJIHdhcyB0aGlua2luZyB3aGV0aGVyIHdlIGNvdWxkIHRyeSBhbGxvdyB0byBydW4g
b25seSBzdWJzZXQgb2Ygc3RydWN0IHRjYXNlCj4gPiBpdGVtcywgYmFzZWQgb24gZ2V0b3B0IHBh
cmFtZXRlci4gRS5nLiBydW4gb25seSAiaW5vZGUiIG1hcmtzIChmaXJzdCB0d28gaXRlbXMpLAo+
ID4gb3IgbW91bnQgbWFya3MgKDNyZCBhbmQgNHRoKSwgLi4uICBydW50ZXN0L3N5c2NhbGxzIHdv
dWxkIGdldCBtb3JlIGl0ZW1zIG9mCj4gPiBwYXJ0aWN1bGFyIHRlc3QuIEl0IHdvdWxkIHByb2xv
bmcgdGVzdGluZyAoZm9yIGFsbF9maWxlc3lzdGVtcyBxdWl0ZSBzaWduaWZpY2FudGx5KQo+ID4g
YnV0IGJlc2lkZXMgYmV0dGVyIHRlc3Qgb3V0cHV0IHJlYWRhYmlsaXR5ICsgYWxsb3cgdG8gZmls
dGVyIG91dCBmaXhlcy4KCj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQZXRyCgo+ID4gWzFdIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2x0cC9DQU9RNHV4Z3UxNmRPc1U0dXVxNjZDR3FYdzZ3WThjOGpL
N3NMMVFoZUI4a1RQVT1YK2dAbWFpbC5nbWFpbC5jb20vCgo+ID4gPiBUaGFua3MsCj4gPiA+IEFt
aXIuCgo+ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzcxZDQ0MTRiLTgwMmYt
NDAxOS04NTI3LWU4ODg2ZTJkMWFlYkBzdXNlLmN6Lwo+ID4gPiBbMl0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbHRwLzIwMjUwMTMxMTY0MjE3LkdBMTEzNTY5NEBwZXZpay8KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
