Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5732C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:18:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B88E3C7B64
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 13:18:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07D3B3C217E
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:17:53 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8406F641D8E
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:17:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC5DA1F38F;
 Wed, 15 Jan 2025 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736943471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6uW4Wl1DysOqfyufVt1ThrPSnj66PpUwv4YWnp0q3I=;
 b=VD1r3WpvnNE/s05hILSmVNunmoHg1MW+XJKNNpISx480sdBRw6yGK7EBeU9V+znPNcqHU7
 Wj5VCWmjnC7GsZDlbYgv9U1OUTTLbPY9/ndVhaLUsBGHc4nctx51E4MtCEpIsWXSwVxc6f
 chsnjK40lK5+JwILo7DCaIzvVX8dAOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736943471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6uW4Wl1DysOqfyufVt1ThrPSnj66PpUwv4YWnp0q3I=;
 b=AXxniPBp949V6J8/zK08mJECl5fx4H29IhR0Er7w+61RRDRSwf+2rW4xaab5fbe/EI6Jj4
 Y3TURpLUoQYnUeDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736943471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6uW4Wl1DysOqfyufVt1ThrPSnj66PpUwv4YWnp0q3I=;
 b=VD1r3WpvnNE/s05hILSmVNunmoHg1MW+XJKNNpISx480sdBRw6yGK7EBeU9V+znPNcqHU7
 Wj5VCWmjnC7GsZDlbYgv9U1OUTTLbPY9/ndVhaLUsBGHc4nctx51E4MtCEpIsWXSwVxc6f
 chsnjK40lK5+JwILo7DCaIzvVX8dAOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736943471;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6uW4Wl1DysOqfyufVt1ThrPSnj66PpUwv4YWnp0q3I=;
 b=AXxniPBp949V6J8/zK08mJECl5fx4H29IhR0Er7w+61RRDRSwf+2rW4xaab5fbe/EI6Jj4
 Y3TURpLUoQYnUeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFA62139CB;
 Wed, 15 Jan 2025 12:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tPs5OG6nh2f2SQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 Jan 2025 12:17:50 +0000
Date: Wed, 15 Jan 2025 13:17:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250115121744.GA648257@pevik>
References: <5a87594f-9066-4ee1-8bc7-5f9f2d71829a.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYSmAjFQTbt98AZj-CRFSWT-dMc-3dAd5mQ=S6rDEYq+Sw@mail.gmail.com>
 <CAEemH2eMPDjSf0ShgsQc-4=Pg5M_9z6HnUMJRDM8OONkydDndg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eMPDjSf0ShgsQc-4=Pg5M_9z6HnUMJRDM8OONkydDndg@mail.gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.com,lists.linux.it,suse.cz];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: Michal =?iso-8859-2?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksIEppbiBHdW9qaWUgYWxsLAoKPiBPbiBXZWQsIEphbiAxNSwgMjAyNSBhdCAyOjMz4oCv
UE0gSmluIEd1b2ppZSA8Z3VvamllLmppbkBnbWFpbC5jb20+IHdyb3RlOgoKSmluIEd1b2ppZSwg
dGhhbmtzIGZvciBoYW5kbGluZyB0aGlzIQoKPiA+IFYzOgo+ID4gKiBGaXggaW5pdGlhbGl6YXRp
b24gb2Ygcm9vdC0+bWVtb3J5X3JlY3Vyc2l2ZXByb3QKPiA+ICogVGhlIHVzZSBvZiB0c3RfY2df
bWVtb3J5X3JlY3Vyc2l2ZXByb3QobGVhZl9jZ1tGXSkgaXMgY2hhbmdlZCB0byBzYWZlCj4gPiBj
aGVjawo+ID4gKiBUaGUgdHlwZSBvZiBtZW1vcnlfcmVjdXJzaXZlcHJvdCBpcyBjaGFuZ2VkIHRv
IHVuc2lnbmVkIGludAo+ID4gKiBSZWJhc2UgdGhlIGNvZGUgdG8gdGhlIGxhdGVzdCBicmFuY2gK
bml0OiBpZiB5b3UgYWRkIG5vdGVzIGxpa2UgdmVyc2lvbiBjaGFuZ2Vsb2cgKG9yIG90aGVyIG5v
dGVzIHdoaWNoIHNob3VsZCBub3QgYmUKcGFydCBvZiB0aGUgZmluYWwgY29tbWl0IG1lc3NhZ2Up
IGJlbG93IC0tLSAoYWJvdmUgb2YgdGhlIGxpc3Qgb2YgY2hhbmdlZApmaWxlcykgd2Ugd2lsbCBz
ZWUgdGhlbSBpbiBNTCwgYnV0IGl0IHdpbGwgbm90IGJlIGluIGdpdCBjb21taXQgbWVzc2FnZS4K
Cj4gVGhhbmtzIGZvciByZWZpbmluZyB0aGlzLCBjb2RlIGxvb2tzIGdvb2QgdG8gbWUsIGJ1dCBh
cyBJIHBvaW50ZWQgb3V0Cj4gY2FuIHlvdSByZWJhc2UgdGhlIHBhdGNoIG9uIHRoZSBsYXRlc3Qg
YnJhbmNoPyBPdGhlcndpc2UsIG1haW50YWluZXIKPiBnZXRzIGEgY29uZmxpY3Qgd2hlbiBhcHBs
eWluZyB5b3VyIHBhdGNoLgoKPiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+CgpBY2tlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpJIGFsc28gdXBkYXRl
ZCBwYXRjaHdvcmsgc3RhdGVzIGZvciBhbGwgdmVyc2lvbnMgb2YgdGhpcy4KCj4gQEN5cmlsLCBA
UGV0ciwgSSB2b3RlIHRvIG1lcmdlIHRoaXMgb25lIGJlZm9yZSB0aGUgcmVsZWFzZSwgYW5kIEkg
YWxzbyB0aGluawoKKzEKCj4gd2UgbmVlZCBhbiBhZGRpdGlvbmFsIHRpbnkgZml4IGxpa2UgYmVs
b3c6CgorMSwgTGksIGNvdWxkIHlvdSBwbGVhc2Ugc2VuZCBhIHJlZ3VsYXIgcGF0Y2ggZm9yIGl0
PwoKS2luZCByZWdhcmRzLApQZXRyCgo+IC0tLSBhL2xpYi90c3RfY2dyb3VwLmMKPiArKysgYi9s
aWIvdHN0X2Nncm91cC5jCj4gQEAgLTQ0LDcgKzQ0LDcgQEAgc3RydWN0IGNncm91cF9kaXIgewo+
ICAgICAgICAgICovCj4gICAgICAgICBpbnQgZGlyX2ZkOwoKPiAtICAgICAgIGludCB3ZV9jcmVh
dGVkX2l0OjE7Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgd2VfY3JlYXRlZF9pdDoxOwo+ICB9OwoK
PiAgLyogVGhlIHJvb3Qgb2YgYSBDR3JvdXAgaGllcmFyY2h5L3RyZWUgKi8KPiBAQCAtNzEsMTIg
KzcxLDEyIEBAIHN0cnVjdCBjZ3JvdXBfcm9vdCB7Cj4gICAgICAgICAvKiBDR3JvdXAgZm9yIGN1
cnJlbnQgdGVzdC4gV2hpY2ggbWF5IGhhdmUgY2hpbGRyZW4uICovCj4gICAgICAgICBzdHJ1Y3Qg
Y2dyb3VwX2RpciB0ZXN0X2RpcjsKCj4gLSAgICAgICBpbnQgbnNkZWxlZ2F0ZToxOwo+IC0gICAg
ICAgaW50IG1lbW9yeV9yZWN1cnNpdmVwcm90OjE7Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgbnNk
ZWxlZ2F0ZToxOwo+ICsgICAgICAgdW5zaWduZWQgaW50IG1lbW9yeV9yZWN1cnNpdmVwcm90OjE7
Cgo+IC0gICAgICAgaW50IHdlX21vdW50ZWRfaXQ6MTsKPiArICAgICAgIHVuc2lnbmVkIGludCB3
ZV9tb3VudGVkX2l0OjE7Cj4gICAgICAgICAvKiBjcHVzZXQgaXMgaW4gY29tcGF0YWJpbGl0eSBt
b2RlICovCj4gLSAgICAgICBpbnQgbm9fY3B1c2V0X3ByZWZpeDoxOwo+ICsgICAgICAgdW5zaWdu
ZWQgaW50IG5vX2NwdXNldF9wcmVmaXg6MTsKPiAgfTsKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
