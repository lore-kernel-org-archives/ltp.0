Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF0BC02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 13:38:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 002CD3C2CA1
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 14:38:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 888D93C2B94
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:37:53 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 001421BC918D
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:37:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BA1E2111F;
 Mon, 27 Jan 2025 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737985071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwauYqlsxalvWcJAGzQ3FUT614nQkWmYGbS82VcLYoA=;
 b=dxq4bzZGIY4q6RbM4EH3wsCrR0JZ2MukIA6/QnED1vza3AZavKnfr9yTsVQse9RlyXJonb
 6qNqkq5xNTwxk4AB/yi6n9QRstFw1LtZeTzamAIZPs2aWqL7aE0QIO2ImJ7N83kSLAyHHn
 17dY32xeK2CY0QIFOrGjPI4eJmj4MOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737985071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwauYqlsxalvWcJAGzQ3FUT614nQkWmYGbS82VcLYoA=;
 b=7sp68Ppi/HotRct+z7r/sL64q7Pt7VQEh14FohFRPShCVybDFEVYS3pujj7yUMYTP3kAMV
 n66wlUVHkDt2yIDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737985071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwauYqlsxalvWcJAGzQ3FUT614nQkWmYGbS82VcLYoA=;
 b=dxq4bzZGIY4q6RbM4EH3wsCrR0JZ2MukIA6/QnED1vza3AZavKnfr9yTsVQse9RlyXJonb
 6qNqkq5xNTwxk4AB/yi6n9QRstFw1LtZeTzamAIZPs2aWqL7aE0QIO2ImJ7N83kSLAyHHn
 17dY32xeK2CY0QIFOrGjPI4eJmj4MOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737985071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwauYqlsxalvWcJAGzQ3FUT614nQkWmYGbS82VcLYoA=;
 b=7sp68Ppi/HotRct+z7r/sL64q7Pt7VQEh14FohFRPShCVybDFEVYS3pujj7yUMYTP3kAMV
 n66wlUVHkDt2yIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E815E137C0;
 Mon, 27 Jan 2025 13:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zBqVNy6Ml2eMJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 Jan 2025 13:37:50 +0000
Date: Mon, 27 Jan 2025 14:37:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alessandro Carminati <acarmina@redhat.com>
Message-ID: <20250127133745.GC265345@pevik>
References: <20250127083227.77560-1-acarmina@redhat.com>
 <20250127093929.GA268709@pevik>
 <CAGegRW4RNff_nukrmBW-iab4yCddaoh0wcsOF5pUkYQOBCUcyA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGegRW4RNff_nukrmBW-iab4yCddaoh0wcsOF5pUkYQOBCUcyA@mail.gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,redhat.com,lists.linux.it,gmx.de,suse.com];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cfs-scheduler/starvation.c: Skip test on
 realtime kernels
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
Cc: Mike Galbraith <efault@gmx.de>,
 Alessandro Carminati <alessandro.carminati@gmail.com>,
 Mel Gorman <mgorman@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBQZXRyLAoKPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4KCj4gT24gTW9uLCBKYW4gMjcs
IDIwMjUgYXQgMTA6MznigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+
ID4gPiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIGEgY2hlY2sgaW4gdGhlIHN0YXJ2YXRpb24gdGVz
dCBjYXNlIHRvIGRldGVjdCBhbmQKPiA+ID4gc2tpcCBleGVjdXRpb24gb24gcmVhbHRpbWUga2Vy
bmVscy4gVGhlIHRlc3QgaXMgZGVzaWduZWQgZm9yIHVzZSB3aXRoIHRoZQo+ID4gPiBDb21wbGV0
ZWx5IEZhaXIgU2NoZWR1bGVyIGFuZCBwcm9kdWNlcyBtZWFuaW5nbGVzcyByZXN1bHRzIHdoZW4g
cnVuIG9uCj4gPiA+IHJlYWx0aW1lIGtlcm5lbHMuCgo+ID4gPiBCeSBza2lwcGluZyB0aGUgdGVz
dCBvbiByZWFsdGltZSBrZXJuZWxzLCB3ZSBhdm9pZCBjb25mdXNpb24gY2F1c2VkIGJ5Cj4gPiA+
IG1pc2xlYWRpbmcgcmVzdWx0cy4KCj4gPiBUaGFua3MgYSBsb3QgZm9yIGZpeGluZyAtMSBpbiB2
My4gSSB3YXMgdGhpbmtpbmcgdG8gbWVyZ2UgdjIgYW5kIGZpeCAtMQo+ID4gbWFudWFsbHksIGJ1
dCBJJ20gcmVhbGx5IG5vdCBzdXJlIGlmIHRoZSB0ZXN0IGlzIG1lYW5pbmdsZXNzIGZvciByZWFs
dGltZS4KPiA+IFdhcyB0aGUgdGVzdCByZWFsbHkgd3JpdHRlbiBmb3IgQ0ZTPyBJdCB3b3VsZCBi
ZSBuaWNlIHRvIGdldCBhY2sgZnJvbSBhbnkKPiA+IHJlYWx0aW1lIGRldmVsb3Blci4KCj4gPiBC
VFcgdGVzdCBpcyB3b3JraW5nIHdlbGwgb24geDg2XzY0IFNMRVMgcmVhbHRpbWUga2VybmVsIG9u
IFZNLCBpLmUuIGJvdGggeW91Cj4gPiB3YW50IHRvIHNraXAgKFJUKSBvciB3YXJuIGFib3V0IHVu
cmVsaWFibGUgcmVzdWx0cyAoVk0pLiBUaGF0IG9mIGNvdXJzZQo+ID4gZG9lcyBub3QgbWVhbiBp
dCdzIHJlbGV2YW50IGZvciBSVCBrZXJuZWwuCgo+IEhlcmUncyB3aGF0IEkgb2JzZXJ2ZWQ6Cj4g
KiBJbiBvdXIgQ0kgcGlwZWxpbmUsIHRoZSB0ZXN0IGNvbnNpc3RlbnRseSBmYWlscyBvbiBvdXIg
UlQga2VybmVsIHJ1bm5pbmcKPiAgIG9uIEFBUkNINjQgYm9hcmRzLgo+ICogVXBvbiBpbnZlc3Rp
Z2F0aW5nIGFuZCByZWFkaW5nIHRocm91Z2ggdGhlIGNvZGUsIEkgbm90aWNlZCB0aGF0IHRoZSB0
ZXN0Cj4gICBzZWVtcyB0byByZWx5IG9uIGFuIGVxdWFsIG51bWJlciBvZiB0aW1lcyB0aGUgY2hp
bGQgYW5kIHBhcmVudCB0YXNrcyBnZXQKPiAgIHNjaGVkdWxlZC4gVGhpcyBiZWhhdmlvciBhbGln
bnMgd2l0aCBob3cgQ0ZTIHdvcmtzLi4uIGxlc3Mgd2l0aCBSVC4KPiAqIFRoYXQgc2FpZCwgdGhl
cmUgYXJlIHNjZW5hcmlvcyB3aGVyZSBDRlMgYW5kIFJUIG1pZ2h0IG1ha2Ugc2ltaWxhcgo+ICAg
c2NoZWR1bGluZyBkZWNpc2lvbnMsIHBhcnRpY3VsYXJseSBpbiBSVCB3aGVuIGFsbCB0YXNrcyBz
aGFyZSB0aGUgc2FtZQo+ICAgcHJpb3JpdHkuCj4gKiBGaW5hbGx5LCBhcyBhIGhpbnQsIEkgbm90
aWNlZCB0aGF0IHRoZSB0ZXN0IGlzIGN1cnJlbnRseSBwbGFjZWQgaW4gdGhlCj4gICBjZnMtc2No
ZWR1bGVyIGRpcmVjdG9yeS4gSSBpbnRlcnByZXQgdGhpcyBhcyBhIHN0cm9uZyBzdWdnZXN0aW9u
IGZyb20gdGhlCj4gICBhdXRob3IgdGhhdCB0aGUgdGVzdCB3YXMgaW50ZW5kZWQgZm9yIHRoZSBD
RlMgc2NoZWR1bGVyLgoKT29wcywgSSBjb21wbGV0ZWx5IG1pc3NlZCB0aGUgZGlyZWN0b3J5LiBB
bmQgYWxsIHRoZSBhYm92ZSBzb3VuZHMgcmlnaHQuCkFsc28gcmVwcm9kdWNlciB3YXMgcG9zdGVk
IGZvciBFRVZERiwgd2hpY2ggaXMgQ0ZTIHJlcGxhY2VtZW50LgoKT1RPSCBjZnNfYmFuZHdpZHRo
MDEuYywgd2hpY2ggcmVxdWlyZXMgQ09ORklHX0NGU19CQU5EV0lEVEggd29ya3Mgb24gUlQga2Vy
bmVsCndlbGwsIGFsc28gdmVyeSBvbGQgaGFja2JlbmNoLmMgKHdoaWNoIG5lZWRzIHRvIGJlIHJl
d3JpdHRlbikuCgpBbnl3YXkgSSB3YW50ZWQgdG8gaGF2ZSBhY2sgb2Ygc29tZWJvZHkgd2hvIGFj
dHVhbGx5IHVuZGVyc3RhbmRzIHRoZSBrZXJuZWwKY29kZS4gSSBnb3QgYSBjb25maXJtYXRpb24g
ZnJvbSBNaWtlIEdhbGJyYWl0aCB0aGF0ICJ0aGUgdGVzdCBpcyBhYm91dCBmYWlyIGNsYXNzCnZz
IGZhaXIgY2xhc3Mgd2FrZXVwIGxhdGVuY3ksIGhhcyBsaXR0bGUgcmVsZXZhbmNlIHRvIFJULiBJ
dCBkb2VzIGJhbmcgb24gbG9ja3MKaW4gdGhlIHdha2V1cCBwYXRoLCBidXQgbm8gbW9yZSB0aGFu
IGFib3V0IGEgemlsbGlvbiBvdGhlciB0aGluZ3MuIiB0aGVyZWZvcmUKSSdtIGdvaW5nIHRvIG1l
cmdlLgoKS2luZCByZWdhcmRzLApQZXRyCgo+ID4gS2luZCByZWdhcmRzLAo+ID4gUGV0cgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
