Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163F0E77361
	for <ltp@archiver.kernel.org>; Wed, 24 Dec 2025 15:06:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FB793D0F2C
	for <ltp@archiver.kernel.org>; Wed, 24 Dec 2025 16:06:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DFF63CF41A
 for <ltp@lists.linux.it>; Wed, 24 Dec 2025 16:06:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 739C510006CF
 for <ltp@lists.linux.it>; Wed, 24 Dec 2025 16:06:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B7CE336E0;
 Wed, 24 Dec 2025 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766588788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iW6yRdOxSxzmWXjZ9mz48WrH1KdrPZc4iJsfaVJyCYo=;
 b=FCBFDUhKydQGUKo7Q8jqcEuZdY32scnGjqUw3CN6lt5tAsB5Tvw5QyzAtLFn1rmmb9NqQD
 QkODXJERdm+WVd7IweHB9p9XEHR5YPYqdZ9PN8CDkta8REViteSfVHyh0yBpL0YlY4waVU
 aKgFrbH1TOcfrMkzJr76RdNozxkMB08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766588788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iW6yRdOxSxzmWXjZ9mz48WrH1KdrPZc4iJsfaVJyCYo=;
 b=bJqqLR4tp0jV9o0LT2hpXpxzAwX8e/Kigq0IqjkjGL/h87hVOxlCwkoHWbLHH+M6ghzqV+
 PYaN3iGof7Eun4DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FCBFDUhK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bJqqLR4t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766588788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iW6yRdOxSxzmWXjZ9mz48WrH1KdrPZc4iJsfaVJyCYo=;
 b=FCBFDUhKydQGUKo7Q8jqcEuZdY32scnGjqUw3CN6lt5tAsB5Tvw5QyzAtLFn1rmmb9NqQD
 QkODXJERdm+WVd7IweHB9p9XEHR5YPYqdZ9PN8CDkta8REViteSfVHyh0yBpL0YlY4waVU
 aKgFrbH1TOcfrMkzJr76RdNozxkMB08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766588788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iW6yRdOxSxzmWXjZ9mz48WrH1KdrPZc4iJsfaVJyCYo=;
 b=bJqqLR4tp0jV9o0LT2hpXpxzAwX8e/Kigq0IqjkjGL/h87hVOxlCwkoHWbLHH+M6ghzqV+
 PYaN3iGof7Eun4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 289E23EA63;
 Wed, 24 Dec 2025 15:06:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z0e2BHQBTGmwdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Dec 2025 15:06:28 +0000
Date: Wed, 24 Dec 2025 16:06:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Vasileios Almpanis <vasileios.ampanis@virtuozzo.com>
Message-ID: <20251224150622.GA400176@pevik>
References: <20251219212717.GA15539@pevik>
 <20251222141331.121827-1-vasileios.almpanis@virtuozzo.com>
 <20251223205823.GB141917@pevik>
 <3824feca-cd19-453f-8c06-7223375051f6@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3824feca-cd19-453f-8c06-7223375051f6@virtuozzo.com>
X-Rspamd-Queue-Id: 7B7CE336E0
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ssh-stress: disable resource penalties
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

PiBIaSBQZXRyLAoKPiBBZ3JlZWQsIHRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIGV4cGxhbmF0aW9u
Lgo+IFlvdeKAmXJlIGFic29sdXRlbHkgcmlnaHQgYWJvdXQgJiYgLyB8fCBwcmVjZWRlbmNlIGlu
IFBPU0lYIHNoZWxscywgYW5kIHRoZQo+IDEwLnggY2FzZSBpcyBpbmRlZWQgYnJva2VuIGluIG15
IHYyLgo+IFRoZSBwcm9wb3NlZCB2ZXJzaW9uIGxvb2tzIGNvcnJlY3QgYW5kIGNsZWFuZXIgdG8g
bWUuIFBsZWFzZSBnbyBhaGVhZCBhbmQKPiBtZXJnZSBpdC4KClRoYW5rcyBmb3IgeW91ciBhY2ss
IG1lcmdlZCB3aXRoIGZpeGVzIQoKS2luZCByZWdhcmRzLApQZXRyCgo+IEtpbmQgcmVnYXJkLAo+
IFZhc2lsZWlvcyBBbG1wYW5pcwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
