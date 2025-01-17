Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1715FC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:44:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A067A3C7C2C
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:44:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FDF63C796A
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:43:59 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2AF94257326
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:43:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18BE82117F;
 Fri, 17 Jan 2025 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737103438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+AeEXZRjqyCgH8TZEdkbNaiOBAK0Hsl/Ok9dk9kE+M=;
 b=D0+7ncSmETYgbhGudIJN2PzHkHTEIk8cV4s2gO5tRgsG7u90zgmWm760YbSj2/ppog6Rlw
 Y0voSvjdbj4CWt4bgm0CuGXXkkMQrV8u+vjkAF+dgui1zKYJAfDc6DPMF+OQzNWTY4MJXB
 8Swkqqx9hMuUUuG6usuM30iF8zoMEYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737103438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+AeEXZRjqyCgH8TZEdkbNaiOBAK0Hsl/Ok9dk9kE+M=;
 b=tG/mR1lNbAUa/oAggQ8K53Zx2f5YvQb6zVITmAu7m3/EMwmKs54AnSqePiIhCSvuvT+EpK
 hZyVqxLGkBmbc5Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D0+7ncSm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="tG/mR1lN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737103438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+AeEXZRjqyCgH8TZEdkbNaiOBAK0Hsl/Ok9dk9kE+M=;
 b=D0+7ncSmETYgbhGudIJN2PzHkHTEIk8cV4s2gO5tRgsG7u90zgmWm760YbSj2/ppog6Rlw
 Y0voSvjdbj4CWt4bgm0CuGXXkkMQrV8u+vjkAF+dgui1zKYJAfDc6DPMF+OQzNWTY4MJXB
 8Swkqqx9hMuUUuG6usuM30iF8zoMEYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737103438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+AeEXZRjqyCgH8TZEdkbNaiOBAK0Hsl/Ok9dk9kE+M=;
 b=tG/mR1lNbAUa/oAggQ8K53Zx2f5YvQb6zVITmAu7m3/EMwmKs54AnSqePiIhCSvuvT+EpK
 hZyVqxLGkBmbc5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E939E13332;
 Fri, 17 Jan 2025 08:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U022N00YimdHBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 08:43:57 +0000
Date: Fri, 17 Jan 2025 09:43:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250117084352.GB733756@pevik>
References: <20250117071758.120366-1-liwang@redhat.com>
 <95cf0806-4600-4949-8ed7-a31cacf2c8a5@suse.com>
 <CAEemH2f4DoH4Lggpncbh9OmCcu0AQBc8Fp_yczE5EG2C=MLn+w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f4DoH4Lggpncbh9OmCcu0AQBc8Fp_yczE5EG2C=MLn+w@mail.gmail.com>
X-Rspamd-Queue-Id: 18BE82117F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: add TST_NO_SLOW_KCONFIG_CHECK macro for
 testcase tools
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

SGkgYWxsLAoKPiBPbiBGcmksIEphbiAxNywgMjAyNSBhdCAzOjQ54oCvUE0gQW5kcmVhIENlcnZl
c2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPiB3cm90ZToKCj4gPiBIaSBMaSwKCj4g
PiB0aGUgZmVhdHVyZSBpcyBpbnRlcmVzdGluZywgYnV0IEkgaGF2ZSB0aGUgZmVlbGluZyB0aGlz
IHNob3VsZCBiZSBhZGRlZAo+ID4gdG8gdHN0X3Rlc3Qgc3RydWN0IHJhdGhlciB0aGFuIHVzaW5n
IGEgZmxhZyBhdCBjb21waWxlIHRpbWUuCj4gPiBGb3IgZXhhbXBsZSwgYnkgYWRkaW5nIHRvIHRz
dF90ZXN0IGEgc2xvd19rY29uZmlnIGF0dHJpYnV0ZS4KCgo+IFRoYW5rcy4gQnV0IHNvdW5kcyBh
IGxpdHRsZSBiaXQgdW5uZWNlc3NhcnkgdG8gYWRkIG5ldyBmaWVsZCBpbiB0c3RfdGVzdAo+IHN0
cnVjdC4KCj4gV2hhdCBhYm91dCB1c2luZyBhbiBnbG9iYWwgdmFyaWFibGUgbGlrZSB0c3Rfbm9f
c2xvd19rY29maWdfY2hlY2sgPwoKVGhpcyBjb3VsZCB3b3JrLgoKSSBzZW50IGEgcGF0Y2ggd2hp
Y2ggdGFrZXMgeWV0IGFub3RoZXIgb3B0aW9uOiBzdGF0aWMgaW5saW5lIGZ1bmN0aW9uIHdoaWNo
CmRpZmZlcnMgYmFzZWQgb24gZXhpc3RpbmcgVFNUX05PX0RFRkFVTFRfTUFJTi4gVGhhdCBrZWVw
cyB0aGUgZnVuY3Rpb25hbGl0eSBmb3IKdGVzdHMgb25seSwgYXZvaWQgaXQgZm9yIGxpYnJhcmll
cy4KCkFjdHVhbGx5IHNpbWlsYXIgYXBwcm9hY2ggTGkgZGlkLCBidXQgbW92ZWQgdG8gaGVhZGVy
IChpdCBjYW5ub3QgYmUgaW4gQyBmaWxlKS4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiA+IEFuZHJl
YQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
