Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E5AC0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 23:53:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4965C3C99C0
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 00:53:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11D1A3C9967
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:53:17 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 440F365A5D1
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:53:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1758C21C43;
 Tue, 11 Feb 2025 23:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739317994;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rzt1QRsnk1dGnh0JJ4aiBBpflComn8rFh8kZWs02lOs=;
 b=cuQdsFLNt6Bx6Qe+G+gCYs97JieiFMZefzSuumfo1lYZrRRD+UNmrGqnnmzCEuBfr7WHWp
 77biHT5m7HO/OkpXc8wj0V8DXNaRj3Kj8v4Wxnh/uesUFktF3cgaxwdAUUWClJYz424Ct0
 7zbT4Q0LsXAbIxiR72bNSy76cMQPyS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739317994;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rzt1QRsnk1dGnh0JJ4aiBBpflComn8rFh8kZWs02lOs=;
 b=DRbA9wGM5sr4mEihgVErqkogQBQCjVsiRHJNFLJOvODmysZiG3I6c14LajySF0Ohh3nvPL
 +RGmfUVbPwKsK+AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739317993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rzt1QRsnk1dGnh0JJ4aiBBpflComn8rFh8kZWs02lOs=;
 b=iOglUe1Y1bzsF8j7yHTFsinViAFWHUq1vzgPzrKZG2GafW820ymMZZh3yYAID7wYTfWLBy
 BW9ygLNnbZ/E3as6MzkpZp1RtY03RmvZkHa8JwNCob3d6QuTk1+cc6qUBm6rjtuWJ5geCS
 b8Es5rHqKf0oAdWW8RL/eXkkM1aBzrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739317993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rzt1QRsnk1dGnh0JJ4aiBBpflComn8rFh8kZWs02lOs=;
 b=7cbqoe+1Dak3MJSnJXbiM8nRFxXz86COeh2kW5FOxrLvmuNRhdCerZZUk9RyDSesaiCjCx
 jPMyjU0RjPQgY7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EED2413782;
 Tue, 11 Feb 2025 23:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vrGHOejiq2duewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 23:53:12 +0000
Date: Wed, 12 Feb 2025 00:52:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250211235256.GB1992438@pevik>
References: <20250211214627.152634-1-jmoyer@redhat.com>
 <20250211214627.152634-2-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250211214627.152634-2-jmoyer@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib/tst_device.c: factor out
 btrfs-specific logic from tst_find_backing_dev
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

Hi Jeff,

> In preparation for handling overlayfs (which also has a major device
> number of 0), factor out the btrfs logic.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
