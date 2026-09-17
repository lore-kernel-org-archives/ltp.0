Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A53C982CF
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 12:11:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B37523E75A1
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 14:11:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2A8C3C06E3
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 14:11:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 02CF71400DF5
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 14:11:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E28321D07;
 Thu, 17 Sep 2026 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789647084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9xdp6A33Nji58O/wtlHZkMpCyHZ7DKK3I3xLQmq5eM=;
 b=xMegw5m6/JsLbQm6xRHm8pi2Ss0IdmkDxPSgEGnl/xUG3ktkla/U0mN5GmldW0YkDSGxhJ
 o5KfvOUmKHw05OqPZdA11SlWlnUK+/fMgNkT2EQorfKvJ3hxAiPVzAs4JLjBciTOTvXBuY
 XPkk3lo6XWMeeuswzUSO+/kTzQSBOF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789647084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9xdp6A33Nji58O/wtlHZkMpCyHZ7DKK3I3xLQmq5eM=;
 b=zK9KBBjrFQI0rMTvrH0H7qO1dlCF4SdGy847RTN7ywidjVgCPzLS6XT+vTdVmExerrJSRG
 SZRQkK30S9K6soCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D8jCVCxd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k3lo1LG2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789647080;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9xdp6A33Nji58O/wtlHZkMpCyHZ7DKK3I3xLQmq5eM=;
 b=D8jCVCxduS/nLJjcL6FSrF9HHvHM9IyzGw+N8tDuiXgBDe2P8fkigyGDlQa7UevoedK9Dp
 e6u/td0IunQ8aH4ofq6K5eIWsOm3fVfNp8d05OmnRCUPMwf+gd3lL5F73sXIvkL7l40L3Z
 LY6pJPyg3uE/7bRB/ksM05fq9z1qhN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789647080;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9xdp6A33Nji58O/wtlHZkMpCyHZ7DKK3I3xLQmq5eM=;
 b=k3lo1LG24orhTRXR9L5/2DZfnIRk3XIuWKpg2sPmcsGTUA6/LL5QzWjEwT4tLSq0UVDHjv
 KT4Szp/1ul77RzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8B9E1374A;
 Thu, 17 Sep 2026 12:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /2txK+fYq2qdaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 17 Sep 2026 12:11:19 +0000
Date: Thu, 17 Sep 2026 14:11:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260917121118.GA1845840@pevik>
References: <20260429105644.986278-1-pvorel@suse.cz>
 <6a4377a6.51d65a57.19e759.3280@mx.google.com>
 <CAASaF6w2cwaYmWBcJi3Dm3Pu_d0R4jUaN8wJLTbwt4M4Tv5a-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6w2cwaYmWBcJi3Dm3Pu_d0R4jUaN8wJLTbwt4M4Tv5a-g@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4E28321D07
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,ozlabs.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Move runtest/irq into runtest/kernel_misc
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
Cc: Tim Bird <tim.bird@sony.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiBPbiBUdWUsIEp1biAzMCwgMjAyNiBhdCAxMDowMOKAr0FNIEFuZHJlYSBDZXJ2
ZXNhdG8KPiA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4gd3JvdGU6Cgo+ID4gSGkgUGV0ciwK
Cj4gPiBhbnkgbmV3cyBhYm91dCB0aGlzPyBDYW4gd2UgbWVnZSBpdD8KCj4gKzEKCj4gQWNrZWQt
Ynk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKRllJIHRoaXMgcGF0Y2hzZXQg
d2FzIGZpbmFsbHkgbWVyZ2VkIGFzOgoKMjA2NjQ5NmViZiAoIk1vdmUgcnVudGVzdC9pcnEgaW50
byBydW50ZXN0L2tlcm5lbF9taXNjIikKCisgb2xkIHN0YXR1cyB1cGRhdGVkIGluIHRoZSBvbGQg
cGF0Y2h3b3JrLm96bGFicy5vcmcgaW5zdGFuY2UuCgpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3
IGFuZCBwYXRpZW5jZS4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
