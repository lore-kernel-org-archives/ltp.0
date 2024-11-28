Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C9DD690EF
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 10:06:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3820A3DBB32
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 11:06:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E41823DBAA1
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 11:06:03 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 34820142FCE2
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 11:06:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A35F621190;
 Thu, 28 Nov 2024 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732788360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7L7vcvyFAJdh+sZbYOSX1pSNjDWIOc/VQRTGZD7Xzc=;
 b=263QqLqYcLJTd+92TWTLJmafPZYqU6NEiRVMxDBtDiQAOf0OE8Ot17LoeocV1Emguxl23N
 OpQylhiKXaeB7/HdOczPOtbdt10bOwJvO18AY56imC96TvIs3dOj4XJN8oHBNgzLTTex/Y
 6ISBrUU9eKLXhyxX9kVUscVuZKcFq3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732788360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7L7vcvyFAJdh+sZbYOSX1pSNjDWIOc/VQRTGZD7Xzc=;
 b=5AQifgxlXwMtmnkYsM748WMBdQMPIUFZWc+2VvPHYGOQNzW7hDzzAU/QpUGosEi8CfhFuq
 6Z6/ZT9suHFfpWBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=263QqLqY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5AQifgxl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732788360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7L7vcvyFAJdh+sZbYOSX1pSNjDWIOc/VQRTGZD7Xzc=;
 b=263QqLqYcLJTd+92TWTLJmafPZYqU6NEiRVMxDBtDiQAOf0OE8Ot17LoeocV1Emguxl23N
 OpQylhiKXaeB7/HdOczPOtbdt10bOwJvO18AY56imC96TvIs3dOj4XJN8oHBNgzLTTex/Y
 6ISBrUU9eKLXhyxX9kVUscVuZKcFq3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732788360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7L7vcvyFAJdh+sZbYOSX1pSNjDWIOc/VQRTGZD7Xzc=;
 b=5AQifgxlXwMtmnkYsM748WMBdQMPIUFZWc+2VvPHYGOQNzW7hDzzAU/QpUGosEi8CfhFuq
 6Z6/ZT9suHFfpWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C94413974;
 Thu, 28 Nov 2024 10:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SGQ7IYhASGd3PwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 28 Nov 2024 10:06:00 +0000
Date: Thu, 28 Nov 2024 11:04:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: R Akshay Dharmapuri <raghavendra.akshay@alifsemi.com>
Message-ID: <Z0hANm7UAsbFF1s0@rei>
References: <LV1PR22MB601444E2D0CA1619E19EAE2BF5282@LV1PR22MB6014.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <LV1PR22MB601444E2D0CA1619E19EAE2BF5282@LV1PR22MB6014.namprd22.prod.outlook.com>
X-Rspamd-Queue-Id: A35F621190
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_EQ_ADDR_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Regarding the Musl C library for using Linux Test Project
 on our Board linux kernel 5.4.25
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Myself Akshay from Alif Semiconductor working on LTP(Linux Test
> Project).I am using
> environment-setup-cortexa32hf-neon-poky-linux-musleabi (Musl C) for
> our target board.  I wanted to enquire how to test LTP on Arm 32
> architecture(board architecture).We are using linux kernel 5.4.25 to
> deploy onto the target hardware.

Most of LTP should work fine on 32bit arm. We we do run 32bit LTP on
64bit kernel at least for x86, so there shouldn't be that much 32bit
related problems. There may be stil few arm related or Musl related test
failures though.

> Also wanted to enquire if musl C (above toolchain) is fully supported
> as I checked onto the documentation link of Linux Test Project(Its not
> yet fully supported)

The documentation links to a ci/alpine.sh script that lists four tests
that are not supported on Musl (does not compile) and skipped in our CI.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
