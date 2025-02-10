Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A51C0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 13:16:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A49853C98BA
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 14:15:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 325133C0939
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 14:15:42 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 301D3140E5FB
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 14:15:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 902C521106;
 Mon, 10 Feb 2025 13:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739193340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJuIVcs6ABSoXWAkTUYSZh2k03cIjGh4X6LW3jYHB5w=;
 b=L3jh09gfdfMfq4d27Gsj3dIck2z38jdRSIhmdksirKEYtAaqADzxiu/0KGf4qB/zkIAM2C
 z1JcLDl7zosSTzo7DnuGBAtifBxlwJ/diRZh8h4ioa/3u+2hJ3kuX4QJtDPVfj7h6nol3x
 XO0K8pU6TMgcHBtZ+JA2lyfpQNHdBUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739193340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJuIVcs6ABSoXWAkTUYSZh2k03cIjGh4X6LW3jYHB5w=;
 b=lrBthQeLCHRHgI2w2ohHhM6vfYTv28Mb725S9BMX3nq0lZv8R4RX7kiY4IGt67OOU/Xhq/
 vwRy2nJ8dKBP8QAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L3jh09gf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lrBthQeL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739193340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJuIVcs6ABSoXWAkTUYSZh2k03cIjGh4X6LW3jYHB5w=;
 b=L3jh09gfdfMfq4d27Gsj3dIck2z38jdRSIhmdksirKEYtAaqADzxiu/0KGf4qB/zkIAM2C
 z1JcLDl7zosSTzo7DnuGBAtifBxlwJ/diRZh8h4ioa/3u+2hJ3kuX4QJtDPVfj7h6nol3x
 XO0K8pU6TMgcHBtZ+JA2lyfpQNHdBUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739193340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJuIVcs6ABSoXWAkTUYSZh2k03cIjGh4X6LW3jYHB5w=;
 b=lrBthQeLCHRHgI2w2ohHhM6vfYTv28Mb725S9BMX3nq0lZv8R4RX7kiY4IGt67OOU/Xhq/
 vwRy2nJ8dKBP8QAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A58E13A62;
 Mon, 10 Feb 2025 13:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n2KvIfz7qWcgBwAAD6G6ig
 (envelope-from <pvorel@suse.de>); Mon, 10 Feb 2025 13:15:40 +0000
MIME-Version: 1.0
Date: Mon, 10 Feb 2025 14:15:40 +0100
From: pvorel <pvorel@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <34c1451a-2adb-4efd-874b-e2d9b660e56f@suse.com>
References: <34c1451a-2adb-4efd-874b-e2d9b660e56f@suse.com>
User-Agent: Roundcube Webmail
Message-ID: <3e686620764bdcf2ea12fb46511a8c90@suse.de>
X-Sender: pvorel@suse.de
X-Rspamd-Queue-Id: 902C521106
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Open discussion] docparse handling
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2025-02-10 13:25, Andrea Cervesato via ltp wrote:
> Hi all,
> 
> we just added a test catalog in the LTP documentation [1], but most of
> the tests are still using asciidoc as the main tests' description
> syntax. Obviously, we need to switch to RST [2] syntax, that is now
> used in the whole LTP documentation along with sphinx [3] support.

Yes, we need to convert to RST (fix formatting and get rid of warnings 
and errors from sphinx).

> I would like to introduce a discussion on this topic, since I seen a
> few patches meant to adapt old tests' descriptions [4] into asciidoc
> and we don't really want to double our job. In particular:
> 
> - is [Description] tag still needed? Shall we use **Description** 
> instead?

This would mean plain bold. The original motivation was that this should 
be a header (not plain bold) and we did not want to embed the header 
level in source code (Cyril, please, correct me if I'm wrong). E.g. this 
is not related to RST, it's a special LTP formatting.

Although title is more suitable than bold, I'm ok with have the others 
(e.g. [Algorithm]) formatted as bold. But I really suggest to remove 
[Description] entirely [1] because IMHO it does not add any information 
value and therefore it just prolong the page.

Originally I noted the reason for removal that it's missing in some CVE 
tests (inconsistency).
Cyril proposed to fix this problem in the code [2], but I would really 
prefer to remove it.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20250131115828.GB1116925@pevik/
[2] https://lore.kernel.org/ltp/Z5y03QTwjlgsuJ88@yuki.lan/

> - shall we start to convert all tests' descriptions into asciidoc? If
> yes, how? Automatically or manually?
> 
> Best regards,
> Andrea Cervesato
> 
> [1] 
> https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html
> [2] 
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html
> [3] https://www.sphinx-doc.org/en/master/index.html
> [4] 
> https://patchwork.ozlabs.org/project/ltp/patch/20250210091044.359274-1-maxj.fnst@fujitsu.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
