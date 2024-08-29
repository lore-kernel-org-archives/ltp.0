Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C756ACA0EC2
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 20:50:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8137D3D27F7
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 22:50:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29B873D27F7
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 22:50:13 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1261600B55
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 22:50:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBC7D1F74A;
 Thu, 29 Aug 2024 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724964610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dS4l68JY1A472PZOI+7zIEvqRsxk68kPRheJ00e6y6c=;
 b=p6bbkvjLudRyQSDzoDSRHUy2X2whabJMJtBf0WWE50nvMXbKA1Sb/+EfjlHB4+28CWAVBc
 wgHh1hxhbnTx+Z6zY1jQ/1sqZiz1HUy4k756iAIX+mEWaR8IfYZsH5Xto1rOIfbClV5aBo
 20HPM4uBZRaWOkM2H2olLkNHK6JlXB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724964610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dS4l68JY1A472PZOI+7zIEvqRsxk68kPRheJ00e6y6c=;
 b=XLC3Ym1OFVXWlwJT2Melt44JY/ytIXy+pj5WBEUoFA81lZTqFVN5v2l1CkzKfiQc8JUbV8
 60ED2w9gRddhi9DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jA3bRyO2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="nBN/CS0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724964608;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dS4l68JY1A472PZOI+7zIEvqRsxk68kPRheJ00e6y6c=;
 b=jA3bRyO2XrcmHppc/tY98/r6PQZ1yYDAKOwZjtj+u+kU4dBtwkivsLWT0QsGbAbyJbZbRP
 os2OzV4YU9kHAl+r1jSk/eUEMDMXp10ZuSIAcUAq+gZNYZCe0IMRhVwrcCXyJ1g5q4pRiR
 oauboNkOsFhCiQuoLiNATeOhkzbIBtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724964608;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dS4l68JY1A472PZOI+7zIEvqRsxk68kPRheJ00e6y6c=;
 b=nBN/CS0oGv6Suh/qan0A1PiaXKwXOmQN1t4OvUQ5pQwzZ1Ch9qaUcGFWYOzUiZu7sN/7b1
 PnJnkAMtjZFLv0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF490139B0;
 Thu, 29 Aug 2024 20:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5YBgMQDf0Gb6PwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 29 Aug 2024 20:50:08 +0000
Date: Thu, 29 Aug 2024 22:50:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Message-ID: <20240829205007.GA29837@pevik>
References: <5295D578-7B15-4613-A1FA-41A425E992FA@oracle.com>
 <20240828224850.GA1773775@pevik>
 <51DBF795-A185-4E38-993F-E3CAEC37EC83@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51DBF795-A185-4E38-993F-E3CAEC37EC83@oracle.com>
X-Rspamd-Queue-Id: EBC7D1F74A
X-Spamd-Result: default: False [-2.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; SUBJECT_ENDS_QUESTION(1.00)[];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_EQ_ADDR_SOME(0.00)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ltp build broken on Fedora 40?
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

Cgo+ID4gT24gQXVnIDI4LCAyMDI0LCBhdCA2OjQ44oCvUE0sIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToKCj4gPiBIaSBDaHVjaywKCj4gPj4gSGktCgo+ID4+IEknbSBmaW5kaW5n
IHRoYXQgbHRwIDIwMjQwNTI0IGRvZXMgbm90IGJ1aWxkIG9uIEZlZG9yYSA0MCBkdWUKPiA+PiB0
byBhIG1pc3NpbmcgaGVhZGVyOgoKPiA+IEkgZ3Vlc3MgeW91IG5lZWQgdG8gYmFja3BvcnQgZ2Nj
LTE0IGZpeCBiMGFlMWVlMjM5ICgicnBjX3N2Y18xOiBGaXggaW5jb21wYXRpYmxlCj4gPiBwb2lu
dGVyIHR5cGUgZXJyb3IiKSBbMV0gKG9yIGJ1aWxkIHdpdGggb2xkZXIgZ2NjKS4KCj4gPj4gbHRw
L3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvdGJpby90YmlvX2tlcm5lbC9sdHBfdGJp
by5jOjQ2OjEwOiBmYXRhbCBlcnJvcjogbGludXgvZ2VuaGQuaDogTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeQo+ID4+ICAgNDYgfCAjaW5jbHVkZSA8bGludXgvZ2VuaGQuaD4KPiA+PiAgICAgIHwg
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+Cj4gPj4gY29tcGlsYXRpb24gdGVybWluYXRlZC4KCj4g
QnVpbGRpbmcgbHRwIG9uIGNvbW1pdCBiMGFlMWVlMjM5IGluZGVlZCBmaXhlZCB0aGUgcHJvYmxl
bSBvbiBGZWRvcmEgNDAuCj4gSSBndWVzcyB0aGUgImdlbmhkLmgiIGVycm9yIG1pc2RpcmVjdGVk
IG1lLiBUaGFua3MsIFBldHIhCgpZb3UncmUgd2VsY29tZSAod2UgYXBwcmVjaWF0ZSB3aGVuIGtl
cm5lbCBtYWludGFpbmVycyBsb29rIGludG8gTFRQKSwKZmVlbCBmcmVlIHRvIGFzayBpZiB5b3Ug
ZW5jb3VudGVyIG1vcmUgcHJvYmxlbXMuCgpJIHdvdWxkIHNheSBtb3N0bHkgdGhlIGN1cnJlbnQg
bWFzdGVyIGJyYW5jaCBpcyB0aGUgYmVzdCBMVFAsIEkgd291bGQgZmFsbGJhY2sKdG8gdGhlIGxh
dGVzdCBzdGFibGUgcmVsZWFzZSBvbmx5IHdoZW4gbWFzdGVyIGRvZXMgbm90IGJ1aWxkLgoKQWxz
bywgaW4geW91ciBjYXNlLCBmb3IgTkZTIHRlc3RpbmcgeW91IG5lZWQganVzdCB0byBjb21waWxl
CnRlc3RjYXNlcy9uZXR3b3JrL25mc3ssdjR9IGRpcmVjdG9yaWVzIGFuZCB0aGVpciBkZXBlbmRl
bmNpZXMKKHRlc3RjYXNlcy9saWIvIHRlc3RjYXNlcy9uZXR3b3JrL25ldHN0cmVzcy8pLgoKS2lu
ZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
