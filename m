Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57C8CCA470
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 16:03:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 639343CE53F
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 18:03:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E75883CE441
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 18:03:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 228611400BD9
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 18:03:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A21533685;
 Tue,  7 Oct 2025 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759852999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlT7Wo3VdFEZmRy+m4Xv0hPJvxvbgizoJB98e5pwBdw=;
 b=XIc72iH3lGCZx2nqITje9v104xQcloTcBEAafj2vS2mEbkgcXfRiG069MxAL41gw2QBFqG
 yam+pG82BE5/Vv7wd8dbfPcSD03rS20WWs8YXJz9r9EHb2eslgO+nEbwxY86HAX6akTFpg
 ZvUfFlLX8a3KWW92KP/eOIQQZHgXlks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759852999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlT7Wo3VdFEZmRy+m4Xv0hPJvxvbgizoJB98e5pwBdw=;
 b=P355OVaaWS+xhJCsjp9YhUwc99FE5InycbTYc0nE1YbBQe+shMjBX1LfvzWbUm9YyvfXhS
 721Jn7alLXqtDcBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XIc72iH3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P355OVaa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759852999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlT7Wo3VdFEZmRy+m4Xv0hPJvxvbgizoJB98e5pwBdw=;
 b=XIc72iH3lGCZx2nqITje9v104xQcloTcBEAafj2vS2mEbkgcXfRiG069MxAL41gw2QBFqG
 yam+pG82BE5/Vv7wd8dbfPcSD03rS20WWs8YXJz9r9EHb2eslgO+nEbwxY86HAX6akTFpg
 ZvUfFlLX8a3KWW92KP/eOIQQZHgXlks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759852999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlT7Wo3VdFEZmRy+m4Xv0hPJvxvbgizoJB98e5pwBdw=;
 b=P355OVaaWS+xhJCsjp9YhUwc99FE5InycbTYc0nE1YbBQe+shMjBX1LfvzWbUm9YyvfXhS
 721Jn7alLXqtDcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA5713AAC;
 Tue,  7 Oct 2025 16:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LK7YOMY55WhBWgAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 07 Oct 2025 16:03:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 07 Oct 2025 18:03:18 +0200
Message-ID: <5030324.GXAFRqVoOG@thinkpad>
In-Reply-To: <aOOHE98H2dEipRuJ@yuki.lan>
References: <20251003101310.13359-1-akumar@suse.de> <aOODn-CZ7F1A777o@yuki.lan>
 <aOOHE98H2dEipRuJ@yuki.lan>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 0A21533685
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: update invalid clock id to accomodate
 new auxiliary clock ids
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

Hi Cyril,

On Monday, October 6, 2025 11:08:35 AM CEST you wrote:
> 
> Hi!
> > Technically you can have any number of clocks defined by a system that
> > implements POSIX. So the comment here should be:
> > 
> > "hopefully big enough not to be a valid clock value"
> > 
> > And we may possibly bump it to a larger value as well, e.g. 50
> 
> Or we may be a bit smarter, for clock_gettime() or clock_getres() we can
> loop starting at 0 until we get EINVAL or cross sufficiently large value.
> 
> 
I thought of implementing something like this. But we get EINVAL for
smaller values also for which clocks are not defined.

./clock_getres_6-2.run-test 
clock_getres(-2147483648, &res);
clock_getres(2147483647, &res);
clock_getres(2147483647, &res);
clock_getres(-2147483647, &res);
clock_getres(-1073743192, &res);
clock_getres(1073743192, &res);
clock_getres(-1, &res);
clock_getres(10, &res);
clock_getres(11, &res);
clock_getres() != -1
clock_getres(12, &res);
clock_getres(13, &res);
clock_getres(14, &res);
clock_getres(15, &res);
clock_getres(16, &res);
clock_getres() != -1
clock_getres(17, &res);
clock_getres() != -1
clock_getres(18, &res);
clock_getres() != -1
clock_getres(19, &res);
clock_getres() != -1
clock_getres(20, &res);
clock_getres() != -1
clock_getres(21, &res);
clock_getres() != -1
clock_getres(22, &res);
clock_getres() != -1
clock_getres(23, &res);
clock_getres() != -1
clock_getres(24, &res);
clock_getres(25, &res);
clock_getres(26, &res);
At least one test FAILED -- see above




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
