Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF768C54E5D
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 05:04:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 270563D0583
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 06:04:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0C263CDC55
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 06:04:09 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ED6271A0098C
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 06:04:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5A735D0AC;
 Tue, 19 Mar 2024 05:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710824646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJgMe+EOzWpQbjahZEgjdwvsFPDyDPM3WAbn73wbTvk=;
 b=YPxW+tRz7IwnlRMVpNYIh8yc54vjmjA2gNrX36cKQjAC+vcAFWPXcXu7YoYpg4WmCpnPwh
 EKLSgEpS7qpHFJoOdWISHLhRQd3QjeTKA6s77P1/f6hX6cfXB6VRBg2hRooZEi5JlnfQJ8
 cuJ9HOeMZllb3O2VNI6qY3z+9bJHNMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710824646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJgMe+EOzWpQbjahZEgjdwvsFPDyDPM3WAbn73wbTvk=;
 b=4rRCxH2pmBcpjh+qPLwt8UfRbmxMS4sTtE2ibdaZQfnvTTwugZk3bKYOl/1zVhnKHzKJ1h
 Jqc2N5fiigjSwlBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710824646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJgMe+EOzWpQbjahZEgjdwvsFPDyDPM3WAbn73wbTvk=;
 b=YPxW+tRz7IwnlRMVpNYIh8yc54vjmjA2gNrX36cKQjAC+vcAFWPXcXu7YoYpg4WmCpnPwh
 EKLSgEpS7qpHFJoOdWISHLhRQd3QjeTKA6s77P1/f6hX6cfXB6VRBg2hRooZEi5JlnfQJ8
 cuJ9HOeMZllb3O2VNI6qY3z+9bJHNMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710824646;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJgMe+EOzWpQbjahZEgjdwvsFPDyDPM3WAbn73wbTvk=;
 b=4rRCxH2pmBcpjh+qPLwt8UfRbmxMS4sTtE2ibdaZQfnvTTwugZk3bKYOl/1zVhnKHzKJ1h
 Jqc2N5fiigjSwlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C53C136A5;
 Tue, 19 Mar 2024 05:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a4VVIcYc+WUvQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 19 Mar 2024 05:04:06 +0000
Date: Tue, 19 Mar 2024 06:03:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240319050357.GA417761@pevik>
References: <ZfP8YEwKpLGweAe1@wegao.29.253.26>
 <CAEemH2e5BB=L6-uT25ppcjGnXqJu7U-MmTCNdFsu8FE3sGv=Lw@mail.gmail.com>
 <ZfQoVC7xBfGHNsgI@wegao.157.234.177>
 <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
 <ZfezDUSKwUdoSamA@wegao.215.20.80>
 <CAEemH2cLfO9nMnOdB3wTuK6bmkfsPJp_fdQOXSFU-SfHfdQSZA@mail.gmail.com>
 <Zffm+yWYrGhyVTsf@wegao.213.190.243>
 <CAEemH2e4iC1+dViTu4WgNz4-BOTg+f9+9sggy+WKhK+ZsCQmvQ@mail.gmail.com>
 <Zfg2E59Pa1uF84di@wegao.115.61.67>
 <CAEemH2c--aHRW5ZqvBZTP2AVuoiKcY4x6GAxcaMb1KgbXVUEDA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c--aHRW5ZqvBZTP2AVuoiKcY4x6GAxcaMb1KgbXVUEDA@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YPxW+tRz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4rRCxH2p
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.com:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[23.62%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A5A735D0AC
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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

PiBPbiBNb24sIE1hciAxOCwgMjAyNCBhdCA4OjQw4oCvUE0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5j
b20+IHdyb3RlOgoKCgoKPiA+ID4gVGhhdCdzIGJlY2F1c2UgdGhlIGF2YWlsYWJsZSBzd2FwZmls
ZSBvbiB5b3VyIFNVVCBpcyB0b28gc21hbGwsCj4gPiA+IHlvdSBjYW4gYWRqdXN0IGl0ICh0aGVu
IHJldGVzdCBpdCkgYnkgeW91cnNlbGYgdG8gZmluZCBhIHByb3BlciBzaXplLgoKPiA+ID4gVGhp
cyBpcyBmaW5lIGFzIGxvbmcgYXMgdGhlIHN3YXBmaWxlIHNpemUgaXMgbGVzcyB0aGFuIDMwME1C
LAo+ID4gPiBvdGhlcndpc2Ugd2UgbmVlZCB0byBzZXQgLmRldl9taW5fc2l6ZSBsaWtlIHdoYXQg
d2UgZGlkCj4gPiA+IGZvciBzd2Fwb2ZmMDEuYy4KCj4gPiA+IEFuZCwgb24gdGhlIG90aGVyIHNp
ZGUsIHdlIGNhbid0IGd1YXJhbnRlZSB0aGUgc3lzdGVtIFN3YXBDYWNoZWQKPiA+ID4gaGFwcGVu
ZWQgZXZlcnkgdGltZSwgaXQgZGVwZW5kcyBvbiB0aGUgc3lzdGVtJ3MgY29uZmlndXJhdGlvbi4K
Cgo+ID4gMTAwTSBpcyBnb29kIGVub3VnaCBmb3IgY3VycmVudCBzeXN0ZW0sIGNvdWxkIHlvdSBo
ZWxwIGNoZWNrIGZvbGxvd2luZwo+ID4gcGF0Y2g/CgoKPiBDYW4gd2UgcmV3cml0ZSB0aGUgbWFr
ZV9zd2FwZmlsZSgpIEFQSSB0byBzdXBwb3J0IHBhc3NpbmcgTUIgc2l6ZSBmb3IKPiBtYWtpbmcg
dGhlIHN3YXBmaWxlPwoKSSBndWVzcyBpdCB3b3VsZCBiZSBkZXNpcmFibGUgKGJ1dCBrZWVwIGFs
c28gcG9zc2libGUgdG8gcGFzcyB0aGF0IDEwIGJsb2NrcywKdGhlcmVmb3JlIG1heWJlIHVzZSBm
bGFnIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gTUIgYW5kIGJsb2Nrcz8pLgoKS2luZCByZWdhcmRz
LApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
