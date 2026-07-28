Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2041BC53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 21:09:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DD353E1B18
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 23:09:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7E383C0039
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 23:09:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EBB2420025A
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 23:09:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD0647C58E;
 Tue, 28 Jul 2026 21:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785272963;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXZv5d3yBn+bPnYbVxbfI7yEZvwIHpFD8gF7hcSSj/Q=;
 b=emahZNjWqOTGVHNlaeHrEmhJjiX3CF2Gall4aqA/rEwGdXoQC/gIxdViYVnygHzfuj6U4r
 1Fb6YLtQFFr/Ba62cIKB966BP9aoRUoCbarkEROw4upBG5gxiZWEiqP2icM/8dDtnvp4sS
 VL4fVgIiyfCBpe2S3vktg9Cj1CPeRMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785272963;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXZv5d3yBn+bPnYbVxbfI7yEZvwIHpFD8gF7hcSSj/Q=;
 b=IdJ/MSpncg9HE25meCLdWZlljoICidhUe+sDMbJpijdyMT+IUR8ljhZ5NwNgRkdfZ0ZoA3
 +KA8faAlBmd5XAAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ao737Owp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1yIochTh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785272958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXZv5d3yBn+bPnYbVxbfI7yEZvwIHpFD8gF7hcSSj/Q=;
 b=ao737Owp/OaTHJAZqenvpVDZTx6LwxmJxny+ZCML34b/7PIyPwi/tAimWy6AvGwD8UuwBu
 6W3A1WqiIRFsZNPz9dYAdM8235VoCfkedeyvXwwcfmk7mvAxJlyJFE8j3p7moLVLTTuMJ6
 8idmj1pJO7/+gYGx5n6QPTlZD46OdwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785272958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXZv5d3yBn+bPnYbVxbfI7yEZvwIHpFD8gF7hcSSj/Q=;
 b=1yIochThV2Dt75zjuku5J97gY+7TJclwc39AJnjezNmOI6aZq/nwm+Tt+6GKBAuxdeCcXh
 tyi0rlHlovGFbWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79579779B3;
 Tue, 28 Jul 2026 21:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wYE2HH4aaWrPEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Jul 2026 21:09:18 +0000
Date: Tue, 28 Jul 2026 23:09:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260728210911.GC114518@pevik>
References: <20260722192052.3975-1-linuxtestproject.agent@gmail.com>
 <20260722212646.2340340-1-bgrech@redhat.com>
 <20260727082240.GA1010349@pevik>
 <CAA835F7iF91Hrb099kbpG0+CR3WOBCH34C7tiB-4uJfNWjva8w@mail.gmail.com>
 <20260728131601.GA1065673@pevik>
 <CAASaF6xWz9LxH-=wUveuSt0UBmUs9L7Os1OdWQ5VdpSy3UUTkg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xWz9LxH-=wUveuSt0UBmUs9L7Os1OdWQ5VdpSy3UUTkg@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CD0647C58E
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cve/icmp_rate_limit01: Lower icmp_msgs_per_sec
 for debug kernel reliability
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

PiBPbiBUdWUsIEp1bCAyOCwgMjAyNiBhdCAzOjE24oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEJyaWFuLAoKPiA+ID4gSGkgUGV0ciwKCj4gPiA+IEhhcHB5
IHRvIGNvbnRyaWJ1dGUhCj4gPiBXZSBhcmUgaGFwcHkgdG8gZ2V0IG5ldyBjb250cmlidXRvcnMg
OikuCgo+ID4gPiBUaGFuayB5b3UgZm9yIGxldHRpbmcgbWUga25vdywgdGhhdCBpcyBzdHJhbmdl
LiBPbiBteSBzeXN0ZW0gaXQncwo+ID4gPiBjb25maWd1cmVkIGNvcnJlY3RseS4gRGlnZ2luZyBh
IGxpdHRsZSBkZWVwZXIsIEkgdGhpbmsgaXQgbWlnaHQgYmUgYQo+ID4gPiBjb3Jwb3JhdGUgc210
cCBpc3N1ZS4KCj4gPiBGWUkgaXQncyBtYW5nbGVkICJGcm9tOiIgbWFpbCBoZWFkZXIgWzFdOiAi
RnJvbTogQnJpYW4gR3JlY2ggdmlhIGx0cAo+ID4gPGx0cEBsaXN0cy5saW51eC5pdD4iLiBJdCdz
IHByb2JhYmx5IERNQVJDICsgTWFpbG1hbiByZWxhdGVkLgoKPiA+IEJUVyBJIHRob3VnaHQgaXQg
c2hvdWxkIG5vdCBiZSBvbiByZWRoYXQuY29tIHNpZGUsIGJlY2F1c2UgSmFuIFN0YW5jZWsgZG9l
cyBub3QKPiA+IGhhdmUgdGhhdCBwcm9ibGVtLCBidXQgYWN0dWFsbHkgaGUgZG9lcyBoYXZlIHRo
YXQgcHJvYmxlbSBhcyB3ZWxsIFszXSAiRnJvbTogSmFuCj4gPiBTdGFuY2VrIHZpYSBsdHAgPGx0
cEBsaXN0cy5saW51eC5pdD4iLiBJdCdzIGp1c3QgaGUgcHJvYmFibHkgZG9lcyBtZXJnZSB0aGVz
ZQo+ID4gcGF0Y2hlcyBkaXJlY3RseSB3aXRob3V0IGZpcnN0IGRvd25sb2FkaW5nIHRoZW0gZnJv
bSB0aGUgbWFpbGluZyBsaXN0LgoKPiA+IEFueXdheSwgdmVyeSBtaW5vciBwcm9ibGVtLCBidXQg
aXQnZCBiZSBuaWNlIHRvIGdldCBpdCBmaXhlZC4gT3VyIGxpc3QgaGFzCj4gPiBzZXR1cDogZnJv
bV9pc19saXN0ID0gbm8uIEkgc3VwcG9zZSB0aGlzIGlzIGNvcnJlY3QgKGxvb2tpbmcgYXQgdGhl
IGRvY3MgWzRdIGFuZAo+ID4gYWxzbyBjaGVjayBvdGhlciBwcm9qZWN0cyBzZXR1cCBbNV0pLgoK
PiBDYW4geW91IHNlZSBhbHNvIHRoZXNlIHR3byBpbiBvdXIgY29uZmlnPwo+IGRtYXJjX21vZGVy
YXRpb25fYWN0aW9uID0gQWNjZXB0CgpXZSBoYXZlIGRtYXJjX21vZGVyYXRpb25fYWN0aW9uID0g
TXVuZ2UgRnJvbSAoaW4gcHJpdmFjeS9zZW5kZXIvZG1hcmNfbW9kZXJhdGlvbl9hY3Rpb24pCgo+
IGRtYXJjX3F1YXJhbnRpbmVfbW9kZXJhdGlvbl9hY3Rpb24gPSBObwoKV2UgaGF2ZSBkbWFyY19x
dWFyYW50aW5lX21vZGVyYXRpb25fYWN0aW9uID0geWVzCmRtYXJjX25vbmVfbW9kZXJhdGlvbl9h
Y3Rpb24gPSBObwoKVG9vIGxhdGUgdG8gcmVhZCB0aGUgZG9jcywgSSdsbCBkbyBpdCB0b21vcnJv
dy4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiBb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjYwNzIyMjEyNjQ2LjIzNDAzNDAtMS1i
Z3JlY2hAcmVkaGF0LmNvbS9yYXcKPiA+IFsyXSBodHRwczovL3dpa2kubGlzdC5vcmcvREVWL0RN
QVJDCj4gPiBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzA4Yzg1Y2Y2NGQ3MDNkZmFi
YTMxMzk4YWI5ZDliNDgwNDg4ZmUzMzguMTc0NzIyNzQ4MS5naXQuanN0YW5jZWtAcmVkaGF0LmNv
bS9yYXcKPiA+IFs0XSBodHRwczovL2xpc3Qub3JnL21haWxtYW4tYWRtaW4udHh0Cj4gPiBbNV0g
aHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9waXBlcm1haWwvYmludXRpbHMvMjAyMy1PY3RvYmVyLzEy
OTg1Mi5odG1sCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
