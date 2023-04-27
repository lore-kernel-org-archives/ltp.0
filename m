Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5655EC77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 17:47:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 548D23CE4C8
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 19:47:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FC633CB1F5
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:47:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 82BEF200258
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:47:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7730121B06;
 Thu, 27 Apr 2023 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682617651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTF4saND0muxvYy+MJa8psGKGumuQETowLZVf/zHlBM=;
 b=o7JU5Mo3QgX+NXYwK6Gaa2lC1OS/5omtHNsEcu9dD1beL83AFw7vxpkH5l+ymNEn1BvJbF
 HpjR2T41BdKIdNiZd3QjhB+OQmaHbdVi4C0f4+4BhAhTZbigoGWzQRlXe6mqURswqHp+qi
 cnW4oZUAaJjF4czL/9lhVgcmtSaxuH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682617651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTF4saND0muxvYy+MJa8psGKGumuQETowLZVf/zHlBM=;
 b=/+heyN7bWY8/C8ZsO3m81N79CLsB+3SprbyU1a519oCUJMZ/eckg8GyAIVUNvWN0hedg1x
 /l7cozP4FWw7CkDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 047F8138F9;
 Thu, 27 Apr 2023 17:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LozoODK1SmRZfgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 27 Apr 2023 17:47:30 +0000
Date: Thu, 27 Apr 2023 19:47:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230427174736.GA3142007@pevik>
References: <20230427002905.1354207-1-edliaw@google.com>
 <20230427002905.1354207-2-edliaw@google.com>
 <20230427093531.GA3127067@pevik>
 <CAG4es9VFfgMQZWO+YLW3YFKTfpDdT2RybHJ5o9TtJr-0dUeF9w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9VFfgMQZWO+YLW3YFKTfpDdT2RybHJ5o9TtJr-0dUeF9w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] fcntl{34,
 36}: Only use fcntl64 with 32bit abi
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
Cc: kernel-team@android.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIEFwciAyNywgMjAyMyBhdCAyOjM14oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEVkd2FyZCwKCj4gPiA+IEZpeGVzOiA3NjQzMTE1YWFhY2Ig
KCJmY250bHszNCwzNn06IEFsd2F5cyB1c2UgNjQtYml0IGZsb2NrIHN0cnVjdCB0byBhdm9pZCBF
SU5WQUwiKQoKPiA+ID4gT24gQW5kcm9pZCBhcm02NCwgdHN0X2tlcm5lbF9iaXRzIGlzIGRpc3Jl
Z2FyZGluZyB0aGUgYWJpLCBzbyBjb21waWxpbmcKPiA+IFdoYXQgZXhhY3RseSBkbyB5b3UgbWVh
biBieSAiZGlzcmVnYXJkaW5nIHRoZSBhYmkiPyBXaHkgaXMgYWFyY2g2NCBkaWZmZXJlbnQ/Cgo+
IEluIHg4Ni9lbnRyeS9zeXNjYWxscy9zeXNjYWxsXzMyLnRibCwgYSA2NGJpdCBrZXJuZWwgdXNl
cwo+IGNvbXBhdF9zeXNfZmNudGw2NCwgd2hpY2ggaXMgZmxvY2s2NCBjb21wYXRpYmxlOyB3aGVy
ZWFzIGluCj4gYXJtL3Rvb2xzL3N5c2NhbGwudGJsIGl0IHVzZXMgc3lzX2ZjbnRsLCB3aGljaCBp
cyBub3QgZmxvY2s2NAo+IGNvbXBhdGlibGUuClRoYW5rcyBmb3IgaW5mbyEgQWxzbyB0aGFua3Mg
eW91IHVwZGF0ZWQgdGhlIGRlc2NyaXB0aW9uIGluIHYyLgoKS2luZCByZWdhcmRzLApQZXRyCgo+
ID4gT25jZSB3ZSByZW1vdmVkIHRzdF9rZXJuZWxfYml0cygpLCB0aGVyZSBpcyBubyBuZWVkIHRv
IHBhc3MgImZjbnRsNjQiIGFzICVzLAo+ID4gdGh1cyBpdCBzaG91bGQgYmU6Cgo+ID4gICAgICAg
ICAgICAgICAgICAiZmNudGw2NCglZCwgJXMsIHsgJWQsICVkLCAlIlBSSWQ2NCIsICUiUFJJZDY0
IiwgJWQgfSkiLAo+ID4gICAgICAgICAgICAgICAgICBmZCwgY21kX25hbWUsIGw2NC5sX3R5cGUs
IGw2NC5sX3doZW5jZSwgbDY0Lmxfc3RhcnQsIGw2NC5sX2xlbiwKPiA+ICAgICAgICAgICAgICAg
ICAgbDY0LmxfcGlkKTsKCj4gPiBPdGhlcndpc2UgTEdUTS4KCj4gU291bmRzIGdvb2QsIEkgd2ls
bCBzZW5kIGEgdjIuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
