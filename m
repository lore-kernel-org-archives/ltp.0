Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE77310F2865
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 18:26:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 539393D0E80
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 19:26:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82B063CF76D
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 19:25:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 41495600F8C
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 19:25:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 719E74D32D;
 Fri, 27 Mar 2026 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774635954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFIWNyqUNmi7cOlIVyhi0/MQEFLObFV61/vqG75fwCg=;
 b=ae5hhREuPSpo7lgXvXPGrqFsBW0AZasW8i8FLkC8QPRrGtfQloJgSeIHpI/+5V9x3dGPgR
 qOizduouNGp9BqQcGW7jlCKW9JqNcIPBWGE6ZzdQRAvjODYE5bjdM3FilZgIPQwSEc6kjb
 yqks0gkn2hDHP40zscE4xTBjas7wXXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774635954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFIWNyqUNmi7cOlIVyhi0/MQEFLObFV61/vqG75fwCg=;
 b=CT5fY3aT82QSQASzTNSvSGwQAPUcb44tDhK2i99JJ5d9lZP0DdOtyXhjDuT4niO7Zs5pj3
 6RVczfY3e76YyIDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ae5hhREu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CT5fY3aT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774635954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFIWNyqUNmi7cOlIVyhi0/MQEFLObFV61/vqG75fwCg=;
 b=ae5hhREuPSpo7lgXvXPGrqFsBW0AZasW8i8FLkC8QPRrGtfQloJgSeIHpI/+5V9x3dGPgR
 qOizduouNGp9BqQcGW7jlCKW9JqNcIPBWGE6ZzdQRAvjODYE5bjdM3FilZgIPQwSEc6kjb
 yqks0gkn2hDHP40zscE4xTBjas7wXXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774635954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFIWNyqUNmi7cOlIVyhi0/MQEFLObFV61/vqG75fwCg=;
 b=CT5fY3aT82QSQASzTNSvSGwQAPUcb44tDhK2i99JJ5d9lZP0DdOtyXhjDuT4niO7Zs5pj3
 6RVczfY3e76YyIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F2B44A0A2;
 Fri, 27 Mar 2026 18:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tr+tNLHLxmkpQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 18:25:53 +0000
Date: Fri, 27 Mar 2026 19:25:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20260327182548.GA1120166@pevik>
References: <20260316130320.138328-1-japo@linux.ibm.com>
 <69c66196.5d0a0220.2a94f1.b1f7@mx.google.com>
 <20260327152952.GB1092845@pevik>
 <acbEef_Kk8OMpHAI@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acbEef_Kk8OMpHAI@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 719E74D32D
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

Li4uCj4gPiBXb3VsZCBpdCB3b3JrIGlmIGtpcmsgaGFzIGl0J3Mgb3duIC5lZGl0b3Jjb25maWc/
IEkgbWVhbiwgaXQgc2hvdWxkIGhhdmUgYW55d2F5LAo+ID4gYnV0IGlmIGl0IHdpbGwgYmUgYXBw
bGllZCBvbiBpdCBhcyBhIHN1Ym1vZHVsZS4KCj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQZXRyCj4g
SGkgUGV0ciwKCj4gSW4gdXBzdHJlYW0gTFRQLCBraXJrIGlzIGFjdHVhbGx5IGluY2x1ZGVkIGFz
IGEgZ2l0IHN1Ym1vZHVsZSBhdAo+IGB0b29scy9raXJrYCAoc2VlIGAuZ2l0bW9kdWxlc2ApLCBz
byBoYXZpbmcga2lyayBjYXJyeSBpdHMgb3duCj4gYC5lZGl0b3Jjb25maWdgIGlzIGEgbmF0dXJh
bCBmaXQuCgo+IEVkaXRvckNvbmZpZyBpcyBkaXJlY3RvcnktaGllcmFyY2hpY2FsOiBlZGl0b3Jz
IGxvb2sgZm9yIGAuZWRpdG9yY29uZmlnYAo+IGZpbGVzIGZyb20gdGhlIGZpbGXigJlzIGRpcmVj
dG9yeSB1cHdhcmRzLCBhbmQgdGhlIGNsb3Nlc3QgbWF0Y2hpbmcKPiBzZXR0aW5ncyBvdmVycmlk
ZSBwYXJlbnQgb25lcy4gSWYga2lya+KAmXMgYC5lZGl0b3Jjb25maWdgIHNldHMgYHJvb3QgPQo+
IHRydWVgLCB0aGUgbG9va3VwIHN0b3BzIGF0IHRoZSBzdWJtb2R1bGUgcm9vdCwgc28gTFRQ4oCZ
cyB0b3AtbGV2ZWwgcnVsZXMKPiB3b27igJl0IGFmZmVjdCBmaWxlcyBpbnNpZGUgYHRvb2xzL2tp
cmtgLgoKKzEgKHRoaXMgd2FzIG15IHF1ZXN0aW9uKSwgdGhhbmtzIGZvciBpbmZvLiBIb3BlZnVs
bHkgdGhpcyBpcyB3aWRlbHkgc3VwcG9ydGVkCmZlYXR1cmUgKEkgaGF2ZW4ndCBmb3VuZCBpdCBv
biB0aGUgd2lraSkuCgo+IEFsdGVybmF0aXZlbHksIGlmIG9uZSBwcmVmZXIgYSBzaW5nbGUgcG9s
aWN5IGZpbGUsIG9uZSBjb3VsZCBrZWVwCj4gZXZlcnl0aGluZyBpbiBMVFDigJlzIHRvcC1sZXZl
bCBgLmVkaXRvcmNvbmZpZ2AgYW5kIGFkZCBhIGRlZGljYXRlZAo+IG92ZXJyaWRlIHNlY3Rpb24g
bGlrZSBgW3Rvb2xzL2tpcmsvKipdYC4KClRoYW5rcyBmb3IgaW5mby4gVGhhdCB3b3VsZCBub3Qg
d29yayBiZWNhdXNlIHRoZSBwcmltYXJ5IGRldmVsb3BtZW50IGlzIGluIGtpcmsKcmVwbywgbGV0
J3MgaGF2ZSB0aGUgY29uZmlnIHRoZXJlLgoKS2luZCByZWdhcmRzLApQZXRyCgo+IEtpbmQgcmVn
YXJkcywKPiBKYW4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
