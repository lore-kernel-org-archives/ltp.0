Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A5FC021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 13:52:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 833093C995D
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 14:52:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DA4E3C9944
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 14:52:09 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7F18B142F1F9
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 14:52:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7CCC1F397;
 Mon, 24 Feb 2025 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740405125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQST+dNXCzpuEhMWsbadA7VdoVTo4R7ZAl6UEv/HEuI=;
 b=z9rcO3TPW+YyqV23gpH7ClVcu0PPHj8q22GGt+np3pYbQcvildiQyA9FXBoh6ya+y0dkod
 clKXp121aO+mnm413wdhkxUZd/1+wlLHUTQP/Cc9wvRz/xL60uW95Pj91iPx3RJ9jlnYhe
 558dV7WBh9zsGe4y5K4D8VvdoZ7O3sI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740405125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQST+dNXCzpuEhMWsbadA7VdoVTo4R7ZAl6UEv/HEuI=;
 b=uEikG0KTHRWuKjn0mx44+YlUK2n0gWhb6Ln0wGQp8O/+ZHmGOnO8dMLbK4fQPLG43rY0Q4
 MqwMzn/Uqo01FcAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z9rcO3TP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uEikG0KT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740405125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQST+dNXCzpuEhMWsbadA7VdoVTo4R7ZAl6UEv/HEuI=;
 b=z9rcO3TPW+YyqV23gpH7ClVcu0PPHj8q22GGt+np3pYbQcvildiQyA9FXBoh6ya+y0dkod
 clKXp121aO+mnm413wdhkxUZd/1+wlLHUTQP/Cc9wvRz/xL60uW95Pj91iPx3RJ9jlnYhe
 558dV7WBh9zsGe4y5K4D8VvdoZ7O3sI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740405125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQST+dNXCzpuEhMWsbadA7VdoVTo4R7ZAl6UEv/HEuI=;
 b=uEikG0KTHRWuKjn0mx44+YlUK2n0gWhb6Ln0wGQp8O/+ZHmGOnO8dMLbK4fQPLG43rY0Q4
 MqwMzn/Uqo01FcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB60513707;
 Mon, 24 Feb 2025 13:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /ysAKYV5vGd5OQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 24 Feb 2025 13:52:05 +0000
Date: Mon, 24 Feb 2025 14:52:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250224135204.GA2872167@pevik>
References: <20250224100016.2857704-1-pvorel@suse.cz>
 <CAEemH2d=xOZCjNhMoavCE9hXB-9+efxWWDc6_pp_BFMkBZvZuQ@mail.gmail.com>
 <20250224102143.GA2858881@pevik>
 <CAEemH2dhxvwghPV-f9eWSoNfCFWvaFeqwnMNXZy239dfdDCgxg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dhxvwghPV-f9eWSoNfCFWvaFeqwnMNXZy239dfdDCgxg@mail.gmail.com>
X-Rspamd-Queue-Id: C7CCC1F397
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
 variant
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

PiBPbiBNb24sIEZlYiAyNCwgMjAyNSBhdCA2OjIx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLAoKPiA+ID4gPiBIaSBhbGwsCgo+ID4gPiA+IEFuZHJl
YSB3YW50ZWQgdG8gcnVuIG9ubHkgc2luZ2xlIHZhcmlhbnQuCgo+ID4gPiBDb3VsZCB5b3UgdGVs
bCBtZSB3aGF0IHRoZSBiZW5lZml0IGlzPyB3aHkgZG8gd2UgbmVlZCB0aGlzPwoKPiA+IEBBbmRy
ZWEgXgoKPiA+IElNSE8gc2ltaWxhciB0byBMVFBfU0lOR0xFX0ZTX1RZUEUgLSBzcGVlZHVwLiBB
bHRob3VnaCBJIGFkbWl0Cj4gPiBMVFBfU0lOR0xFX0ZTX1RZUEUgYWxsb3dzIG11Y2ggYmlnZ2Vy
IGNsZWFudXAuCgo+ID4gPiBBbmQgYmFjayB0byB0aGUgcGF0Y2ggaXRzZWxmLCBpZiBMVFBfU0lO
R0xFX0lURVJBVElPTiBpcyB1c2VkLCB3aGljaAo+ID4gPiB2YXJpYW50IHdpbGwgYmUgY2hvc2Vu
IHRvIHJ1biBieSBkZWZhdWx0PyBJcyB0aGF0IGV4cGVjdGVkPwoKPiA+IEJ5IGRlZmF1bHQgYWxs
IHZhcmlhbnRzIGFyZSB0ZXN0ZWQuCgoKPiBTb3JyeSwgaGVyZSBJIHdhbnRlZCB0byBhc2s6Cj4g
IFdoaWNoIHZhcmlhbnQgd2lsbCBiZSBzZWxlY3RlZCB3aGVuIExUUF9TSU5HTEVfVkFSSUFOVCBp
cyBzZXQ/Cj4gIElzIHRoZSBzZWxlY3RlZCB2YXJpYW50IHRoZSBleHBlY3RlZCBvbmU/CgpXZWxs
LCB0ZXN0IHZhcmlhbnQgY2FuIG1lYW4gYW55dGhpbmcuIEl0IHN0YXJ0ZWQgYXMgbGliYyB2YXJp
YW50IG9yIHJhdyBzeXNjYWxsLApidXQgZ2V0ZGVudHMuaCBoYXMgNCB2YXJpYW50cyAocmF3IHN5
c2NhbGwgU1lTX2dldGRlbnRzLCByYXcgc3lzY2FsbApTWVNfZ2V0ZGVudHM2NCwgbGliYyBnZXRk
ZW50cygpIGFuZCBsaWJjIGdldGRlbnRzNjQoKSksIGZ1dGV4X3V0aWxzLmggaGFzIDIKY29uZGl0
aW9uYWwgdmFyaWFudHMgdmFyaWFudHMgc3lzY2FsbCB3aXRoIG9sZCBrZXJuZWwgc3BlYyBhbmQg
c3lzY2FsbCB0aW1lNjQKd2l0aCBrZXJuZWwgc3BlYyAob2Z0ZW4gb25seSBvbmUgdmFyaWFudCB3
aWxsIGJlIHNldCksIHRlc3RzIHdoaWNoIGFyZSB1c2UKc2VsZWN0X3Zhci5oIGhhdmUgNSB2YXJp
YW50cywgLi4uCgoKPiBTaW5jZSB0aGUgb3JkZXIgb2YgdGVzdCB2YXJpYW50cyBpcyBub3Qgc3Rh
bmRhcmRpemVkIGFuZCBpcyBkZXRlcm1pbmVkCj4gYnkgdGhlIGF1dGhvciB3aGlsZSB0ZXN0IHdy
aXRpbmcuIE9uY2Ugd2UgdXNlZCBMVFBfU0lOR0xFX1ZBUklBTlQKPiBpdCBzdGlsbCBkb2VzIG5v
dCBndWFyYW50ZWUgdGhlIGV4ZWN1dGVkIHZhcmlhbnQgaXMgdGhlIHNhbWUgZm9yIGFsbCB0ZXN0
cy4KPiBVbmxlc3MgcGVvcGxlIG9ubHkgdXNlIGl0IGluIG1hbnVhbCBkZWJ1Z2dpbmcgbW9kZS4K
CkFzIEFuZHJlYSB3cm90ZSwgdGhlIGdvYWwgaXMgdG8gdXNlIGl0IGZvciBkZWJ1Z2dpbmcgb2Yg
YSBwYXJ0aWN1bGFyIHRlc3QuClllcywgaXQgd2lsbCBub3QgYmUgdXNlZnVsIHRvIHJ1biB3aG9s
ZSBzeXNjYWxscyB3aXRoIGl0IGRlZmluZWQuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
