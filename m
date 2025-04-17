Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47126C369B2
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 06:55:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C88733CB9E1
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 08:55:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAB6E3C0E7E
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 08:55:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF0F7600B07
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 08:55:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 828A21F457;
 Thu, 17 Apr 2025 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744872929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SeZNObhIlrNt4iJhDxiFSCh03zHMr2Zuzx2GsMY+b8=;
 b=w5HI9Max/AmDQbw5aOAeHdifpIg0a3odIQ/v5LaEbRuXwj1LCE5fsEZpv3DnRwZXR4uAnK
 rxCgRCidKHEBpLuc/PnEUjCOEuPq0250nnpzR54gxQ91HFHD3OfH9b4N04MC1D5lVzuW5p
 pYIH+pmc9wk9LWO5TqAu3NEplkMgc0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744872929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SeZNObhIlrNt4iJhDxiFSCh03zHMr2Zuzx2GsMY+b8=;
 b=U5pgdklyj4+HjMt81hntbpa7uvHkZgfcUalgDB2nJuHohiyi3pSswwCuzIMRdtXUuP8un6
 +tswKsHpaDEvlOBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744872929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SeZNObhIlrNt4iJhDxiFSCh03zHMr2Zuzx2GsMY+b8=;
 b=w5HI9Max/AmDQbw5aOAeHdifpIg0a3odIQ/v5LaEbRuXwj1LCE5fsEZpv3DnRwZXR4uAnK
 rxCgRCidKHEBpLuc/PnEUjCOEuPq0250nnpzR54gxQ91HFHD3OfH9b4N04MC1D5lVzuW5p
 pYIH+pmc9wk9LWO5TqAu3NEplkMgc0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744872929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SeZNObhIlrNt4iJhDxiFSCh03zHMr2Zuzx2GsMY+b8=;
 b=U5pgdklyj4+HjMt81hntbpa7uvHkZgfcUalgDB2nJuHohiyi3pSswwCuzIMRdtXUuP8un6
 +tswKsHpaDEvlOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FD281388F;
 Thu, 17 Apr 2025 06:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eWClFeGlAGgsRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 17 Apr 2025 06:55:29 +0000
Date: Thu, 17 Apr 2025 08:55:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250417065524.GB638986@pevik>
References: <20250415220845.548155-1-pvorel@suse.cz>
 <CAEemH2ciYNmtKLz-ZM+wACTQwAvUA=EcOoJNdQprtRxCMA0azA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ciYNmtKLz-ZM+wACTQwAvUA=EcOoJNdQprtRxCMA0azA@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_cgroup: Add "dmem" cgroup controller
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

SGkgTGksIEF2aW5lc2gsCgo+IEhpIFBldHIsIEF2aW5lc2gsCgo+IE9uIFdlZCwgQXByIDE2LCAy
MDI1IGF0IDY6MDjigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6CgouLi4K
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNncm91cF9maWxlIGRtZW1fY3RybF9maWxlc1tdID0g
ewo+ID4gKyAgICAgICB7ICJkbWVtLmNhcGFjaXR5IiwgTlVMTCwgQ1RSTF9ETUVNIH0sCj4gPiAr
ICAgICAgIHsgImRtZW0uY3VycmVudCIsIE5VTEwsIENUUkxfRE1FTSB9LAoKCj4gSXQgaXMgbm8g
aGFybSB0byBhZGQgbW9yZSBjdHJsX2ZpbGVzIGxpa2UgZG1lbS5tYXgsIGRtZW0ubWluLCBkbWVt
LmxvdywKPiB3aGljaCBtaWdodCBiZSB1c2VmdWwgaW4gdGhlIGZ1dHVyZS4KCkdvb2QgaWRlYSwg
SSBhZGRlZCB0aGVtIGJlZm9yZSBtZXJnZS4KCj4gQW55d2F5LCBsb29rcyBnb29kIHRvIG1lLgoK
VGhhbmsgeW91IGJvdGggZm9yIHlvdXIgcmV2aWV3LgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
