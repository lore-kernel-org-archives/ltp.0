Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF3110F2867
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 19:00:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 361A03D022F
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 20:00:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26E813CF76D
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 19:59:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1B29600069
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 19:59:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 574CF5BCEA;
 Fri, 27 Mar 2026 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774637997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOSOU35E1lwBBrvj5/zesoolVmpSPw+9m2BNbHBTyW4=;
 b=WHj+C4byQ8ZeXw2w89adq1sOMFGkJFI4E/pIlrK7T0oB+aaz1PcigQN1O+QlsA5w4tyohL
 hmRoW1U9YYR2ndXudoNDo+/s6wE91MPwQWl52ajevNWY+vKwKa7ZdaU0yx7vanJjoqo4ow
 Hut2sTxpKmmSGD37/sKkewSSAHGwgXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774637997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOSOU35E1lwBBrvj5/zesoolVmpSPw+9m2BNbHBTyW4=;
 b=jsgvemEiXSFtcPnvaNi3KUIkg1a5b08Cs6Cgb4kROepuoBQVjjfW/if2+fcD5hOZUrO0Yd
 iWfQUO083mV5BIAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WHj+C4by;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jsgvemEi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774637997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOSOU35E1lwBBrvj5/zesoolVmpSPw+9m2BNbHBTyW4=;
 b=WHj+C4byQ8ZeXw2w89adq1sOMFGkJFI4E/pIlrK7T0oB+aaz1PcigQN1O+QlsA5w4tyohL
 hmRoW1U9YYR2ndXudoNDo+/s6wE91MPwQWl52ajevNWY+vKwKa7ZdaU0yx7vanJjoqo4ow
 Hut2sTxpKmmSGD37/sKkewSSAHGwgXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774637997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOSOU35E1lwBBrvj5/zesoolVmpSPw+9m2BNbHBTyW4=;
 b=jsgvemEiXSFtcPnvaNi3KUIkg1a5b08Cs6Cgb4kROepuoBQVjjfW/if2+fcD5hOZUrO0Yd
 iWfQUO083mV5BIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C0BE4A0A2;
 Fri, 27 Mar 2026 18:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J99+OKzTxmnhYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 18:59:56 +0000
Date: Fri, 27 Mar 2026 19:59:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20260327185951.GA1123044@pevik>
References: <20260327123351.GA1083266@pevik>
 <69c68890.7b0a0220.33fc19.bf70@mx.google.com>
 <20260327174338.GB1097030@pevik>
 <acbLtetvCPGG89-y@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acbLtetvCPGG89-y@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 574CF5BCEA
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting
 rules for LTP
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

PiBPbiBGcmksIE1hciAyNywgMjAyNiBhdCAwNjo0MzozOFBNICswMTAwLCBQZXRyIFZvcmVsIHdy
b3RlOgo+ID4gPiBIaSBQZXRyLAoKPiA+ID4gPiBGWUkgSSBhc2tlZCBmb3IgNCBpbiB2MSBbMV0s
IEphbiBoYWQgb3JpZ2luYWxseSA4IGFuZCBJJ20gb2sgd2l0aCBmb2xsb3dpbmcKPiA+ID4gPiBr
ZXJuZWwuIEl0J3MganVzdCBteSBwZXJzb25hbCBwcmVmZXJlbmNlIHRvIGRpc3BsYXkgdGFiIGFz
IDQgc3BhY2VzIGFuZCBub3QgOAo+ID4gPiA+IChJTUhPIGVkaXRvcmNvbmZpZyBwbHVnaW5zIGRv
bid0IGFsbG93IGNlcnRhaW4gc2V0dXAgdG8gYmUgb3ZlcndyaXR0ZW4pLgoKPiA+ID4gU29ycnkg
SSBtaXNzZWQgdGhhdC4gSSdtIGp1c3Qgd29uZGVyaW5nIGlmIGVkaXRvciBjb25maWd1cmF0aW9u
IGlzIGFwcGxpZWQKPiA+ID4gb25seSBmb3IgdmlzdWFsaXphdGlvbiBvciBhbHNvIGZvciB0eXBp
bmcuIElmIGl0J3MgYXBwbGllZCBmb3IgdHlwaW5nIHRoZW4gd2UKPiA+ID4gY2FuJ3QgdXNlIDQg
Y2hhcnMsIG90aGVyd2lzZSB3ZSB3aWxsIGhhdmUgbWFueSBpc3N1ZXMgd2l0aCBjaGVja3BhdGNo
LnBsIHdoZW4KPiA+ID4gdmVyaWZ5aW5nIHRoZSBzb3VyY2UgY29kZS4KCj4gPiBUbyBiZSBob25l
c3QgSSBkb24ndCBrbm93IChJIGhhdmVuJ3QgaW5zdGFsbGVkIHRoZSBwbHVnaW4gZm9yIG15IGVk
aXRvciB5ZXQpLgo+ID4gQnV0IEknZCBzdXNwZWN0IHRoYXQgb24gaW5kZW50X3N0eWxlID0gdGFi
IGl0IGp1c3QgYWRkcyBhIHRhYiBhbmQgaW5kZW50X3NpemUgPSA4Cj4gPiBpcyBvbmx5IHRoZSBy
ZXByZXNlbnRhdGlvbi4KCj4gPiBodHRwczovL2dpdGh1Yi5jb20vZWRpdG9yY29uZmlnL2VkaXRv
cmNvbmZpZy93aWtpL0VkaXRvckNvbmZpZy1Qcm9wZXJ0aWVzI2luZGVudF9zaXplCgo+ID4gCUlu
ZGVudGF0aW9uIFNpemUgKGluIHNpbmdsZS1zcGFjZWQgY2hhcmFjdGVycykKCj4gPiAJUG9zc2li
bGUgVmFsdWVzCgo+ID4gCQlhbiBpbnRlZ2VyCj4gPiAJCXRhYgoKPiA+IAlJZiBpbmRlbnRfc2l6
ZSBlcXVhbHMgdG8gdGFiLCB0aGUgaW5kZW50X3NpemUgd2lsbCBiZSBzZXQgdG8gdGhlIHRhYiBz
aXplLAo+ID4gCXdoaWNoIHNob3VsZCBiZSB0YWJfd2lkdGggaWYgdGFiX3dpZHRoIGlzIHNwZWNp
ZmllZCwgb3IgdGhlIHRhYiBzaXplIHNldCBieQo+ID4gCWVkaXRvciBpZiB0YWJfd2lkdGggaXMg
bm90IHNwZWNpZmllZC4KCj4gPiBJIHdvbmRlciBpZiBpdCB3b3JrZWQgZm9yIHVzIHRvIHNldCBp
bmRlbnRfc2l6ZSA9IHVuc2V0IGZvciBhbGwgaW5kZW50X3N0eWxlID0gdGFiCj4gPiAob2YgY291
cnNlIG5vdCBmb3IgaW5kZW50X3N0eWxlID0gc3BhY2UpLgoKPiA+IGh0dHBzOi8vZ2l0aHViLmNv
bS9lZGl0b3Jjb25maWcvZWRpdG9yY29uZmlnL3dpa2kvRWRpdG9yQ29uZmlnLVByb3BlcnRpZXMj
Y3VycmVudC11bml2ZXJzYWwtcHJvcGVydGllcwoKPiA+IAlGb3IgYW55IHByb3BlcnR5LCBhIHZh
bHVlIG9mIHVuc2V0IGlzIHRvIHJlbW92ZSB0aGUgZWZmZWN0IG9mIHRoYXQgcHJvcGVydHksCj4g
PiAJZXZlbiBpZiBpdCBoYXMgYmVlbiBzZXQgYmVmb3JlLiBGb3IgZXhhbXBsZSwgYWRkIGluZGVu
dF9zaXplID0gdW5zZXQgdG8gdW5kZWZpbmUKPiA+IAlpbmRlbnRfc2l6ZSBwcm9wZXJ0eSAoYW5k
IHVzZSBlZGl0b3IgZGVmYXVsdCkuCgo+ID4gQEphbj8KCj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQ
ZXRyCj4gSGkgUGV0ciwKCj4gR29vZCBjYXRjaCwgdGhlIEVkaXRvckNvbmZpZyB3aWtpIGlzIGV4
cGxpY2l0IGhlcmU6Cgo+IC0gaW5kZW50X3NpemUgY2FuIGJlIGFuIGludGVnZXIgb3IgdGFiLgo+
IC0gSWYgaW5kZW50X3NpemUgPSB0YWIsIHRoZW4gaW5kZW50X3NpemUgYmVjb21lcyB0aGUgdGFi
IHNpemU6Cj4gICB0YWJfd2lkdGggaWYgc2V0LCBvdGhlcndpc2UgdGhlIGVkaXRvcuKAmXMgZGVm
YXVsdCB0YWIgc2l6ZS4KPiAtIEFueSBwcm9wZXJ0eSBjYW4gYmUgc2V0IHRvIHVuc2V0IHRvIHJl
bW92ZSBpdHMgZWZmZWN0IChzbyB0aGUgZWRpdG9yCj4gICBkZWZhdWx0IGlzIHVzZWQpLgoKPiBT
byB5ZXM6IHdlIGNvdWxkIGRvIGluZGVudF9zdHlsZSA9IHRhYiB0b2dldGhlciB3aXRoCj4gaW5k
ZW50X3NpemUgPSB1bnNldCBpZiB0aGUgZ29hbCBpcyDigJx0YWJzLCBidXQgZG9u4oCZdCBwcmVz
Y3JpYmUgYQo+IHdpZHRo4oCdLgo+IElmIHdlIHdhbnQgY29uc2lzdGVudCB2aXN1YWwgd2lkdGgv
YWxpZ25tZW50IGFjcm9zcyBlZGl0b3JzLCBhIG1vcmUKPiBleHBsaWNpdCBzZXR1cCB3b3VsZCBi
ZSBpbmRlbnRfc2l6ZSA9IHRhYiBwbHVzIHRhYl93aWR0aCA9IDguCgpIb3BlZnVsbHkgYWxsIGVk
aXRvcnMgaGF2ZSBtZWFuaW5nZnVsIGRlZmF1bHQgdGhlcmVmb3JlIEknZCBiZSBmb3Igbm90IHNl
dHRpbmcKaXQuIEJ1dCBub3QgYSBzdHJvbmcgcmVxdWlyZW1lbnQgaWYgb3RoZXJzIHdhbnQgdG8g
aGF2ZSBpdCBzcGVjaWZpZWQuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gS2luZCByZWdhcmRzLAo+
IEphbgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
