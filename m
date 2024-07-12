Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE092C2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 07:08:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37E643D16C3
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 09:08:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDF423C2220
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:08:06 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76F7B2005FB
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:08:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D147F1FB68;
 Fri, 12 Jul 2024 07:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720768084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xmh/vSsIqlVPdO+pegTNydOo2CjYkwyN4dXBSdN6UsQ=;
 b=oqIlnhYZEf/jHAbL91d1d/yTtGYANDvYizOO095BSOCMP4UuZkKnq2UtN6J6KqRAMpk9x3
 NQihmfjkgyhyTMPFIyhHmLc1vO7BJrgbcv3rKu4Oj3JKo3u8EP1u5hrcgfmZax2LXkF75C
 AYe6cyKmKIqTx36qU0Ih9U58Tg3JDrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720768084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xmh/vSsIqlVPdO+pegTNydOo2CjYkwyN4dXBSdN6UsQ=;
 b=W7QJx5/f7Th1nalkZgZuZHNuscI0TvAblS8j8alQM4IS1aGNNeMBFsK8pfDYlVYmQ0OrmB
 3wZ9i+I3LtEd5eBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720768083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xmh/vSsIqlVPdO+pegTNydOo2CjYkwyN4dXBSdN6UsQ=;
 b=pgt4YLkqqNwhzxtYZt8JGlwze0eGIhnotZ0v1dG5Pn3EHtZtI9s2AY02CpEIb7cCmoQ7I+
 JNQH0fr9QgrwHCMEVgkGZWyzpK7NTqw6dBlmqEXbY9+t7e8eKfCosG8T0t433Ig8ouHBxQ
 GxPDUIRs/E5dkGB+xM1SaTY5RVLzpK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720768083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xmh/vSsIqlVPdO+pegTNydOo2CjYkwyN4dXBSdN6UsQ=;
 b=T9qxk675DI/YwdEWMhDe/3RbFQV5oS2k2FxEsERrFz0KR1zQRjhI650zltqWWBzx9LIhtm
 GxWi70mBziowp1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD46A13686;
 Fri, 12 Jul 2024 07:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9KzJKFPWkGYabAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Jul 2024 07:08:03 +0000
Date: Fri, 12 Jul 2024 09:07:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240712070757.GA103986@pevik>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-5-c7b0e9edf9b0@suse.com>
 <20240711204007.GC85696@pevik>
 <CAEemH2fdFsQqN3a8sZ7+oeU7w3j+X7HdnGa=zC4H4+iXO9YUAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fdFsQqN3a8sZ7+oeU7w3j+X7HdnGa=zC4H4+iXO9YUAw@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; REPLY(-4.00)[];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 05/11] Add landlock01 test
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

SGkgTGksIEFuZHJlYSwKCj4gSGkgUGV0ciwKCj4gT24gRnJpLCBKdWwgMTIsIDIwMjQgYXQgNDo0
MOKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiBIaSBBbmRyZWEs
Cgo+ID4gYWdhaW4sIExHVE0sIDIgdGhpbmdzOgoKPiA+IEZpcnN0LCB0aGlzIGZhaWxzIGF0IGxl
YXN0IG9uIHZhcmlvdXMga2VybmVsIHZlcnNpb25zICh0ZXN0ZWQ6IFR1bWJsZXdlZWQKPiA+IDYu
MTAuMC1yYzctMy5nOTJhYmMxMC1kZWZhdWx0LCBhbmQgU0xFMTUtU1A0IDUuMTQuMjEgd2l0aCBs
c209bGFuZGxvY2sgYW5kCj4gPiBEZWJpYW4gNi42LjE1LWFtZDY0KToKCj4gPiBsYW5kbG9jazAx
LmM6NDk6IFRGQUlMOiBTaXplIGlzIHRvbyBzbWFsbCBleHBlY3RlZCBFSU5WQUw6IEVOT01TRyAo
NDIpCgo+ID4gSXMgaXQgYSBrZXJuZWwgYnVnIG9yIGEgdGVzdCBidWc/CgoKPiBZb3UgcHJvYmFi
bHkgbmVlZCB0byBjaGVjayB0aGUgYC91c3IvaW5jbHVkZS9saW51eC9sYW5kbG9jay5oYCBoZWFk
ZXIgZmlsZQo+IGV4aXN0LAo+IGFuZCB0byBzZWUgaWYgJ3N0cnVjdCBsYW5kbG9ja19ydWxlc2V0
X2F0dHInIGNvbnRhaW5zIHRoZSBuZXcgZmllbGQKPiAnaGFuZGxlZF9hY2Nlc3NfbmV0Jy4KCj4g
SWYgbm90IGV4aXN0IG9yIGRvZXMgbm90IGNvbnRhaW4gdGhhdCwgdGhlIHRlc3QgZGVmaW5lcyAn
c3RydWN0Cj4gbGFuZGxvY2tfcnVsZXNldF9hdHRyJwo+IGluIGxhcGkvbGFuZGxvY2suaCB3aGlj
aCBjb250YWlucyBoYW5kbGVkX2FjY2Vzc19uZXQgZGlyZWN0bHksIHRoaXMgaXMKPiBsaWtlbHkg
dGhlCj4gcm9vdCBjYXVzZSBsZWFkIHRlc3QgZmFpbGVkIG9uIHlvdXIgYm94LgoKSSdtIHNvcnJ5
IGZvciBhIG5vaXNlLCBteSBiYWQuIEJhc2ljIGVycm9yIC0gSSBmb3JnZXQgdG8gcnVuCm1ha2Ug
YXV0b3Rvb2xzICYmIC4vY29uZmlndXJlCgpUaGFua3MsIHBhdGNoIG1lcmdlZC4KCktpbmQgcmVn
YXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
