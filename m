Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5F3C5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 10:07:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87BE73CE9D4
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 11:07:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E6A63C0E51
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:07:20 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 40FD414088CD
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:07:17 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56B183EC1C;
 Wed,  6 Mar 2024 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709719637;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGj7W2u0aD7rBJak8sPyA4FW3tm0waJePY71aW2Vybw=;
 b=WzXBjs9I52crTZWq1IkpTxZPAy44s+VcN5TKsExsNUlSFQvn75qIYnQQ40Zc4YHoYKHADB
 r1CJYoWq0eX5mAgjzCp/gj2y3GObaOjBI65xFxc7VR9aAfM8J2ZDLHHWOrcnAqwjQRoJOW
 dE2OJ6/C9eUUyN24bIHhzV28/Djf3N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709719637;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGj7W2u0aD7rBJak8sPyA4FW3tm0waJePY71aW2Vybw=;
 b=w/ohPY/enw3N98Xr9xjYBNF5se8RZl3SKIxlUwSA5J5m7ifcL7PdolNaaotieQ2fStDX1Q
 gq2gbni2YMG6hUAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709719637;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGj7W2u0aD7rBJak8sPyA4FW3tm0waJePY71aW2Vybw=;
 b=WzXBjs9I52crTZWq1IkpTxZPAy44s+VcN5TKsExsNUlSFQvn75qIYnQQ40Zc4YHoYKHADB
 r1CJYoWq0eX5mAgjzCp/gj2y3GObaOjBI65xFxc7VR9aAfM8J2ZDLHHWOrcnAqwjQRoJOW
 dE2OJ6/C9eUUyN24bIHhzV28/Djf3N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709719637;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGj7W2u0aD7rBJak8sPyA4FW3tm0waJePY71aW2Vybw=;
 b=w/ohPY/enw3N98Xr9xjYBNF5se8RZl3SKIxlUwSA5J5m7ifcL7PdolNaaotieQ2fStDX1Q
 gq2gbni2YMG6hUAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D1B11377D;
 Wed,  6 Mar 2024 10:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id HJzNDVVA6GWELgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 06 Mar 2024 10:07:17 +0000
Date: Wed, 6 Mar 2024 11:07:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dennis Brendel <dbrendel@redhat.com>
Message-ID: <20240306100715.GA532480@pevik>
References: <6dfa210d-1c9a-4888-9408-eccc3068cd2a@redhat.com>
 <20240305213050.GB44833@pevik>
 <1a27ec16-e4ca-4790-81f7-8aac5e28cca4@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a27ec16-e4ca-4790-81f7-8aac5e28cca4@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.42 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.12)[67.15%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] munlockall: add test case that verifies memory
 has been unlocked
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

> On 3/5/24 22:30, Petr Vorel wrote:
> >> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
> >> +
> >> +	if (size == 0UL)
> >> +		tst_brk(TBROK, "Locked memory after mlockall() should be "
> >> +			       "greater than 0, but is %ld", size);
> > I suppose < 0 really means no memory locked, thus really safe to quit before
> > munlockall(), right?

> Forgot to reply to that.

> < 0 should not happen due to unsigned type.

> If the size is 0 then it is safe to quit. In general it should always be safe
> to exit even if there was memory locked, i.e. when the parsing of
> /proc/self/status is faulty or when wrong numbers are reported.

Good point, thanks!

Kind regards,
Petr

> Dennis


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
