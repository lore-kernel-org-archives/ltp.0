Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1C0C3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 09:04:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 312003D1F2B
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 11:04:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 341933D1E8E
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 11:04:02 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 084D86011E4
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 11:03:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A5581F7D2;
 Thu,  1 Aug 2024 09:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722503038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=piEElP8IximGHHpITDDoESrvpFjYW09FtPGvWeSRm50=;
 b=QMSrF+okcaFocAEqXoeBPeoFquN81wYKTmrTr6sI6wt0l5jCbu7y9L38rCXpGhkvRm/o4i
 gIWHZCblnRhDQBBD7QKbgK0/5I+7PGALZ6YJCtXO1bpBIBq+CAX7U7s0GcM81lo8LE9M0W
 oBNuSbc5MGNl8gXU60j6OwTdF4ItVHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722503038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=piEElP8IximGHHpITDDoESrvpFjYW09FtPGvWeSRm50=;
 b=Ns0X2OD5x2RJ6bgfPBA8wHvoDpz4wNeH9U69LwEHbV5HOO/HQ//7ep7Sbe79glfFolUIiL
 uGr15Ao0dzNBXVDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QMSrF+ok;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ns0X2OD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722503038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=piEElP8IximGHHpITDDoESrvpFjYW09FtPGvWeSRm50=;
 b=QMSrF+okcaFocAEqXoeBPeoFquN81wYKTmrTr6sI6wt0l5jCbu7y9L38rCXpGhkvRm/o4i
 gIWHZCblnRhDQBBD7QKbgK0/5I+7PGALZ6YJCtXO1bpBIBq+CAX7U7s0GcM81lo8LE9M0W
 oBNuSbc5MGNl8gXU60j6OwTdF4ItVHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722503038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=piEElP8IximGHHpITDDoESrvpFjYW09FtPGvWeSRm50=;
 b=Ns0X2OD5x2RJ6bgfPBA8wHvoDpz4wNeH9U69LwEHbV5HOO/HQ//7ep7Sbe79glfFolUIiL
 uGr15Ao0dzNBXVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47973136CF;
 Thu,  1 Aug 2024 09:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FgY0EX5Pq2ZjHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 01 Aug 2024 09:03:58 +0000
Date: Thu, 1 Aug 2024 11:06:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZqtQCpA2MCZLeC-x@rei>
References: <ZpfOqJaIO5mr__CW@rei>
 <20240718065532.20188-1-maxj.fnst@fujitsu.com>
 <20240729225700.GA1311523@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240729225700.GA1311523@pevik>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 5A5581F7D2
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcpu: Add testcase for EFAULT
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +static void run(void)
> > +{
> > +	unsigned int cpu_id, node_id = 0;
> > +
> > +	TST_EXP_FAIL(getcpu(tst_get_bad_addr(NULL), &node_id), EFAULT);
> I'm not sure why, but I get SIGSEGV due tst_get_bad_addr(NULL) on various
> kernels (SLES 5.14.21, Tumbleweed 6.5.1, 6.10, Debian 6.9, ...).
> 
> But the test works on SLES 4.4.180.

If you are getting SIGSEGV that means that the address is used in
userspace. Looking at man getcpu() it suggests that on some
architectures it may be implemented as VDSO, which would explain it.

So I suppose that the easies solution here would be to run the test in a
child process and accepting SIGSEGV as a correct outcome as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
