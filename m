Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDF1D462B9
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 14:51:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC2B13D679F
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 15:50:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA19E3D677A
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 15:50:43 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A0E3E141B2CA
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 15:50:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2A51F37C;
 Wed, 13 Nov 2024 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731509441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bnfb8fRKKwtVV3i0IQSaKI483CpRBHmDGL2Jcns2cTg=;
 b=oJbRKfkmpmTaJlikjBMZNd3Nlz+TauUMp2si/eBJKha7OskST0AJrCIV2q/YOT5tcTATbd
 fjIkPUgJDXhVZ7c6/jV9eVaPHLLs1qfnJ6NimOwvuin18RJpiiVhRk6ne6HOmJWry5wiUY
 LnRAwTSE12TwmK+fOYn4VPQUp0zsz5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731509441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bnfb8fRKKwtVV3i0IQSaKI483CpRBHmDGL2Jcns2cTg=;
 b=0QtrzoPskxZ8XsHEpZgx17J02uEiIjWaW1MT+LGwYrYxI1sdlJKUJZfMBOvf2fsNq1CPkL
 I8o6pr9n2TufsWDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oJbRKfkm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0QtrzoPs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731509441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bnfb8fRKKwtVV3i0IQSaKI483CpRBHmDGL2Jcns2cTg=;
 b=oJbRKfkmpmTaJlikjBMZNd3Nlz+TauUMp2si/eBJKha7OskST0AJrCIV2q/YOT5tcTATbd
 fjIkPUgJDXhVZ7c6/jV9eVaPHLLs1qfnJ6NimOwvuin18RJpiiVhRk6ne6HOmJWry5wiUY
 LnRAwTSE12TwmK+fOYn4VPQUp0zsz5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731509441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bnfb8fRKKwtVV3i0IQSaKI483CpRBHmDGL2Jcns2cTg=;
 b=0QtrzoPskxZ8XsHEpZgx17J02uEiIjWaW1MT+LGwYrYxI1sdlJKUJZfMBOvf2fsNq1CPkL
 I8o6pr9n2TufsWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C941513301;
 Wed, 13 Nov 2024 14:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mCXVL8C8NGfPfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 Nov 2024 14:50:40 +0000
Date: Wed, 13 Nov 2024 15:50:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241113145039.GB162955@pevik>
References: <20241101141111.104803-1-mdoucha@suse.cz>
 <20241101141111.104803-6-mdoucha@suse.cz>
 <20241101233221.GC1324664@pevik>
 <e4209eb0-1d9c-4908-948f-3e2f987cc79e@suse.cz>
 <20241112214015.GA235246@pevik>
 <65ff536e-02a4-479a-aeb8-68aae7e64bb0@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <65ff536e-02a4-479a-aeb8-68aae7e64bb0@suse.cz>
X-Rspamd-Queue-Id: 0F2A51F37C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] Add test for data integrity over NFS
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 12. 11. 24 22:40, Petr Vorel wrote:
> > > On 02. 11. 24 0:32, Petr Vorel wrote:
> > > > Hi Martin,

> > > > BTW I got timeout when testing nfs10.sh -v 4 -t tcp on Tumbleweed VM (2 CPU,
> > > > 1.4 GB RAM, 2 GB SWAP) on my laptop:
> > > > ...

> > > > The quickest way would be to use the same calculation (* $TST_CNT + 5% for spare
> > > > time) in nfs10.sh and increase tst_set_timeout with.

> > > Yes, that is expected for now, we need to add separate timeouts for each
> > > subtest, including per-filesystem.

> > Right, I suppose you post v2.

> > I wonder why you did not get timeouts on your laptop. I suppose calculation for
> > fsplough was below 5 min, right?

> I've tested nfs7.sh with LTP_TIMEOUT_MUL=2 which was enough to make it
> pass. The per-testcase timeout implementation needs to be a separate patch
> anyway so sending a v2 doesn't make sense at the moment. I can write the
> timeout patch but I'll need to figure out how the shell timeout works.

IMHO using TST_TIMEOUT in nfs10.sh should be enough (hence asking for v2).
Because TST_TIMEOUT is for each test run. It's visible from the test output I
posted, also _tst_setup_timer, which sets the timeout is called only in
_tst_run_iterations. And _tst_run_iterations is called for each filesystem in
_tst_run_tcases_per_fs (or directly otherwise).

_tst_run_iterations()
{
	local _tst_i=$TST_ITERATIONS
	local _tst_j

	[ "$TST_NEEDS_TMPDIR" = 1 ] && cd "$TST_TMPDIR"

	_prepare_device

	_tst_setup_timer

_tst_run_tcases_per_fs()
{
	local fs
	local filesystems

	filesystems="$(tst_supported_fs -s "$TST_SKIP_FILESYSTEMS")"
	if [ $? -ne 0 ]; then
		tst_brk TCONF "There are no supported filesystems or all skipped"
	fi

	for fs in $filesystems; do
		tst_res TINFO "=== Testing on $fs ==="
		TST_FS_TYPE="$fs"
		_tst_run_iterations
	done
}

tst_run()
{
	...

	if [ "$TST_ALL_FILESYSTEMS" = 1 ]; then
		_tst_run_tcases_per_fs
	else
		_tst_run_iterations
	fi

	_tst_do_exit
}

Using the same calculation you use in fsplough:
tst_set_max_runtime(bufsize * loop_count / (8 * 1024 * 1024))
In TST_TIMEOUT the number of the above would be 4* (4 tests), loop_count == 512.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
