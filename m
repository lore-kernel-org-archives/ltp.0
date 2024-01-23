Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E3CC47DDF
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 15:45:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFF413CE21F
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 16:45:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9A8B3CD71B
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 16:45:41 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A54FC1000484
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 16:45:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72D6F223CD;
 Tue, 23 Jan 2024 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706024739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seFD8FWn6p+iwlVC8IpCrpZR2n1bqF4hcUlS3JgVxyI=;
 b=JgOFN0LrjRD6t4qYCofmxPpP1wIAfnhE1DGdffC9AZuX8EkC+5/8CCXCuMbY15DLG6Ywve
 ZIBiiS3WZhAXIB08c18KuMNNe7gIWwWrKkdwZJq9/VE4cgq7BOqC7A1ji04UedVnIIpYvT
 5Dg/iA2R2W8uahRuUnjANmWSo1/3W7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706024739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seFD8FWn6p+iwlVC8IpCrpZR2n1bqF4hcUlS3JgVxyI=;
 b=gAJd3v1EZKkz2pR0AjeO5KnncjNTC12w7eR+qY17KnltYTH0vleuLQeaI2nyZZH9ZYQXKP
 7O7CSWdsWfuyShDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706024738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seFD8FWn6p+iwlVC8IpCrpZR2n1bqF4hcUlS3JgVxyI=;
 b=TTPfqbupykcWBePylrXkRPWCMsgaiIPQEfi4nTWrCrg4tfysk3coJXiU6crqTeGOCQ6cIS
 0G/jurmYSloNyG+d3/f9wzdmWkxCjx0uxFjgZlDQ5V7iwgYVqGoO4TsYwTwt38VVEbauju
 CpqBxtapO4uf0YJXWr/Q8eS2sSYKy+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706024738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seFD8FWn6p+iwlVC8IpCrpZR2n1bqF4hcUlS3JgVxyI=;
 b=cVYMY7SsWnnwCVtjWqFoQxNogwPH6Hho1wUyvN7MFEs9+j6zBh4Ux6r5lhLlHxVKEUJiGO
 epHBAkxIbS1fqsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BAE8136A4;
 Tue, 23 Jan 2024 15:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id osNgOSHfr2VgfAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 15:45:37 +0000
Date: Tue, 23 Jan 2024 16:45:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240123154536.GB201093@pevik>
References: <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
 <20240122110344.GB95077@pevik>
 <CAEemH2cNn1kyWrnqXHHeOteGT_FQ=PBVc55NFhkZbmkbMOoD=A@mail.gmail.com>
 <20240122202325.GA119341@pevik>
 <CAEemH2dTKjxuiMaHBh0Ky0VV+p2YmDQzH7nvZZjnOVop2E04jQ@mail.gmail.com>
 <CAEemH2cEY=kiJe91Y_kZNefjbh+L-3rikcxErSqVwhQN7mQ=fA@mail.gmail.com>
 <20240123074806.GA144741@pevik>
 <CAEemH2eDZ-Sn0mfH5_pKKLoMe=FXSPA2XRpbs5VmscSZrU4Eng@mail.gmail.com>
 <20240123123121.GB175806@pevik>
 <CAEemH2fFr25_TyGoS2Zf-dkRtH0JzJ93JWfYamYverw5qxA8kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fFr25_TyGoS2Zf-dkRtH0JzJ93JWfYamYverw5qxA8kQ@mail.gmail.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TTPfqbup;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cVYMY7Ss
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.76 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.05)[59.42%]
X-Rspamd-Queue-Id: 72D6F223CD
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

PiBPbiBUdWUsIEphbiAyMywgMjAyNCBhdCA4OjMx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+ID4gT24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgMzo0OOKAr1BNIFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiA+ID4gSGkgTGksCgo+ID4gPiA+
ID4gVjMgaXMgaGVyZTogaHR0cHM6Ly9naXRodWIuY29tL3dhbmdsaTU2NjUvbHRwL2NvbW1pdHMv
bGlic3dhcC12MwoKPiA+ID4gPiBJJ3ZlIGp1c3Qgc2NoZWR1bGVkIG5ldyBydW5zIGZvciBib3Ro
IFR1bWJsZXdlZWQgYW5kIGFsbCBTTEVTIHZlcnNpb25zCj4gPiA+ID4gKHZhcmlvdXMga2VybmVs
IHZlcnNpb25zKS4KCgo+ID4gPiBUaGFua3MgUGV0ciwgYW5kIHNvcnJ5IGZvciBwb3N0aW5nIHRv
IE1MIHNvIGxhdGVyLgo+ID4gPiBJIGRpZCBzb21lIHBvbGlzaGluZyB3b3JrIGFuZCBmaXhlZCBh
IGZldyB0aW55IGlzc3VlcyBiYXNlZCBvbiBhYm92ZSBWMy4KCj4gPiA+IEknbSBub3Qgc3VyZSBp
ZiB0aGUgbGlic3dhcC12MyBicmFuY2ggd2lsbCB0ZXN0IHdlbGwgKHdpdGggdGlueSBpc3N1ZXMp
Lgo+ID4gPiBTbyBJIHB1c2hlZCB0aGUgbGF0ZXN0IHRvIG15IG1haW4gYnJhbmNoOgo+ID4gPiAg
aHR0cHM6Ly9naXRodWIuY29tL3dhbmdsaTU2NjUvbHRwCj4gPiA+IEFuZCwgSSBkZXBsb3llZCBp
dCB3aXRoIGEgZ2VuZXJhbCB0ZXN0IChhZ2FpbnN0IFJIRUwpIGZvciB0aGUgY29taW5nCj4gPiA+
IHJlbGVhc2Ugd29yay4KCj4gPiBUaGFua3MgTGkhCj4gPiBBcyBJIHdyb3RlIHRvIDR0aCBwYXRj
aCBbMV0gdGhlcmUgd2lsbCBiZSB2NCBuZWVkZWQsIGJ1dCBmaXggc2hvdWxkIGJlCj4gPiBlYXN5
LgoKCj4gVGhlIGZpeCBpcyBuZWVkZWQsIGJ1dCBpdCBkb2VzIG5vdCBiZWxvbmcgdG8gbXkgbGli
c3dhcCBwYXRjaCBzZXQuCj4gV2l0aG91dCBhcHBseWluZyB0aGUgZml2ZSBwYXRjaGVzLCBzd2Fw
b2ZmIHN0aWxsIGZhaWxzLCByaWdodD8KTm8sIHRoYXQgd2FzIGludHJvZHVjZWQgYnkgNHRoIHBh
dGNoIHdoaWNoIGFkZGVkIHN1cHBvcnQgZm9yIGJ0cmZzCihiZWZvcmUgaXQgVENPTkYgLSBzd2Fw
IG5vdCBpbXBsZW1lbnRlZCkuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gKGl0IG9yaWdpbmFsbHkg
Y2F1c2VkIGJ5IHRoZSB0c3RfZmlsbF9maWxlKCkgYnV0IG5vdCBvdGhlciB0aGluZykKCj4gSXQg
cHJvYmFibHkgbmVlZHMgdG8gYmUgZml4ZWQgaW4gYSBzZXBhcmF0ZSBwYXRjaCBpbiBmb2xsb3dp
bmcgdXAuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
