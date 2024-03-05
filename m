Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0695C54798
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 21:04:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB8E13D0D08
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 22:04:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DBD83CD840
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 22:04:31 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 97B96100098A
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 22:04:30 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D4205C58C;
 Tue,  5 Mar 2024 21:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709672667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MmZFlRhtxDVp/vMNFmQ2lymOfxMiWvZYG9kZxv8HkI=;
 b=hYe2xfPkm5ROVTsGmlnzPpT3LHmHsDzN16mdystmz2wIdEwjBDoeLQRKYZCzuSJ10vuDDF
 B9cQ9fPPx/7HGJqcZo03I+JUQZDyIjjivZOpBgZAVwVWAetwDBU1kVQnUHhsUxxfzxkCm9
 rOT06ZYLd/BblrgHb8kHUUHoG4zQ0pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709672667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MmZFlRhtxDVp/vMNFmQ2lymOfxMiWvZYG9kZxv8HkI=;
 b=C+vuZJG4kS7yTCmaXdR5Aocb7B49HKuBOKjRoV0Hd0gl85S/5XiHQvPW2cD4OP6QOS08df
 VNdkn6ttliwaZPBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709672667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MmZFlRhtxDVp/vMNFmQ2lymOfxMiWvZYG9kZxv8HkI=;
 b=hYe2xfPkm5ROVTsGmlnzPpT3LHmHsDzN16mdystmz2wIdEwjBDoeLQRKYZCzuSJ10vuDDF
 B9cQ9fPPx/7HGJqcZo03I+JUQZDyIjjivZOpBgZAVwVWAetwDBU1kVQnUHhsUxxfzxkCm9
 rOT06ZYLd/BblrgHb8kHUUHoG4zQ0pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709672667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MmZFlRhtxDVp/vMNFmQ2lymOfxMiWvZYG9kZxv8HkI=;
 b=C+vuZJG4kS7yTCmaXdR5Aocb7B49HKuBOKjRoV0Hd0gl85S/5XiHQvPW2cD4OP6QOS08df
 VNdkn6ttliwaZPBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 70B7E13466;
 Tue,  5 Mar 2024 21:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Lj1IGtuI52VdGgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 05 Mar 2024 21:04:27 +0000
Date: Tue, 5 Mar 2024 22:04:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240305210421.GA44833@pevik>
References: <20240301062716.3023-1-wegao@suse.com>
 <20240305141057.8754-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240305141057.8754-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hYe2xfPk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C+vuZJG4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.37 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.66)[92.85%]
X-Rspamd-Queue-Id: 9D4205C58C
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] libswap.c: Improve calculate swap dev number
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

Hi Wei, all,

thanks, merged!

FYI swapon03 with this patch still fails on SLES 12-SP5 (4.12 based kernel):

tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
swapon03.c:55: TFAIL: swapon(filename, 0) failed: EPERM (1)
swapon03.c:55: TFAIL: swapon(filename, 0) failed: EPERM (1)

But that's likely fails even without the patch (going to verify older SLES
releases).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
