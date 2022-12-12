Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2730C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:23:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 400523CBE6C
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:22:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C889A3C2B4D
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:22:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E867600060
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:22:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5872533750;
 Mon, 12 Dec 2022 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670858568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmT4VyoEOmRQIrtAWwzqNfO032TwuUEGKyQv/FikBik=;
 b=aKbcv1sL3/xP9BblaD/CrBps3KQhLwc0lMhXstiFFZXA7BywmudXIMoOLjwVZARM+WWCFv
 b80QMKB+oWt+zz5f0pNp6DefkZRJeyd7IXyXX/2cn4ALAQ9QGFcwo0Bu1njIMfh2pGQO3e
 AqjhqhNoF6uPHCZqdhddtUcmOOTx1SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670858568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmT4VyoEOmRQIrtAWwzqNfO032TwuUEGKyQv/FikBik=;
 b=AvwbktssAYz1UdW0z74fGm+6eYGnmCh0OX9apYLDD8Q9euu+/cHjRWObUKPznoyuHSYwfD
 SnuMCbVCC/VXSdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 094FC13456;
 Mon, 12 Dec 2022 15:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZTCoOkdHl2PCYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Dec 2022 15:22:47 +0000
Date: Mon, 12 Dec 2022 16:22:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y5dHRcLD1359Rm3o@pevik>
References: <20221207092428.11798-1-teo.coupriediaz@arm.com>
 <871qp4u02j.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871qp4u02j.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/brk: add direct syscall tst_variant
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

SGkgUmljaGllLAoKPiBDeXJpbCwgUGV0ciwgV291bGQgeW91IGxpa2UgdG8gYWRkIHlvdXIgcmV2
aWV3ZWQgYnkgdGFncz8gVGhlbiB3ZSBjYW4KPiBtZXJnZSB0aGlzLgoKQnkgYWNjaWRlbnQgSSBy
ZXBseSB0byBteSBwb2ludHMgdG8gdjEgWzFdLgpUbyBjb3B5IGl0IGhlcmU6CgoxKSBUaGVyZSBh
cmUgd2FybmluZ3M6CmJyazAyLmM6IEluIGZ1bmN0aW9uIOKAmGJya192YXJpYW50c+KAmToKYnJr
MDIuYzoyNjoyODogd2FybmluZzogY2FzdCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZm
ZXJlbnQgc2l6ZQpbLVdpbnQtdG8tcG9pbnRlci1jYXN0XQogICAyNiB8ICAgICAgICAgICAgICAg
ICBicmtfYWRkciA9ICh2b2lkICopYnJrKGFkZHIpOwogICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4KCjIpIG1ha2UgY2hlY2sgcmVwb3J0cyBlcnJvcnMgd2hpY2ggYXJlIGVh
c2lseSBmaXhlZC4KClRlbyByZXBsaWVkIFsyXSwgdGhhdCBoZSdzIGdvaW5nIHRvIGZpeCBpdC4g
SSB0aG91Z2h0IEkgaGFkIHNldCBpdAoiQ2hhbmdlcyByZXF1ZXN0ZWQiLCBidXQgbm93IEkgc2Vl
ICJOZWVkcyBSZXZpZXcgLyBBQ0siLiBTZXR0aW5nIGl0IHRvCiJDaGFuZ2VzIHJlcXVlc3RlZCIu
CgpLaW5kIHJlZ2FyZHMsClBldHIKClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAy
MjEyMDYxNDA0MjEuR0IyMTgzOUBwZXZpay8KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0
cC9mZTFjNWJhYy0wZWQxLTkyZWYtM2MyOC1lMzc1OGRjMzQ2NWRAYXJtLmNvbS8KCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
