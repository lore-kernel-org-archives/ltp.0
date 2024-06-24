Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB360C2BD05
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 10:45:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39D8C3D0F77
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 12:45:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50E353D0F70
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 12:45:38 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CD3D1400041
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 12:45:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E87EB21A89;
 Mon, 24 Jun 2024 10:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719225936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h3sHFhf+5Zatvebso6DAzUr9E2H4nKcvEZE6rGxiFqU=;
 b=PLf1YeV/EoHwUbTbr2F7MxWiNfkYaVsTj6IbLkQOtg1UJoirS859MNsZbbLobNVhCZgSzH
 aUXwS3j/YSyavKsflc9INeMmSzoXpsr8OqV+mmPynV1E71R3/XapVWnXPfcaW0dcZ7Hjx8
 fuYpOEmeEo52d+L1fmxZyRPYgRKshUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719225936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h3sHFhf+5Zatvebso6DAzUr9E2H4nKcvEZE6rGxiFqU=;
 b=6uAKH+aP6q5Zsrn+TeM2XXB81WZKfFxslCUwb9V1n433ccOJDOyKOALJE3gn1OnFTO0GaQ
 Yy0h0ppJgqD6FLDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RKGJ5Fh1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HPmU1N5W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719225935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h3sHFhf+5Zatvebso6DAzUr9E2H4nKcvEZE6rGxiFqU=;
 b=RKGJ5Fh1QvXV69BrppILhy1PU6K+M4ZA0zl8pD32ObItvw+hflkiFIu+JXrnsrLpgIlgVp
 hhPE4+YzaJdGXcwFMXCrksIwDzmiDLdQE17WWzysZQm8JvlocwFMkwMp06cYt3WpEKrLk+
 P/nSxGf7A4ezkU9dFZqY009Der19o/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719225935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h3sHFhf+5Zatvebso6DAzUr9E2H4nKcvEZE6rGxiFqU=;
 b=HPmU1N5WQaaQYYwIuQfAtqGxN6BgU++qfqWylpRQjxluJ6vVEzR9Iak7TAA72Zu2IX6uEK
 FeRTXylzrDbWaPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C700A1384C;
 Mon, 24 Jun 2024 10:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ac6bLU9OeWbKPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Jun 2024 10:45:35 +0000
Date: Mon, 24 Jun 2024 12:45:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: John Stultz <jstultz@google.com>
Message-ID: <ZnlORS6RGTAA4UhS@yuki>
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-3-jstultz@google.com>
 <Zi9jL1jycx6oo37g@yuki>
 <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zjn1-1YRyZGIUtEP@yuki>
X-Rspamd-Queue-Id: E87EB21A89
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
Cc: kernel-team@android.com, ltp@lists.linux.it,
 Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
FYI the patch that removes the autotools from the testcases/realtime has
been merged, it should be possible to use the include/tst_atomic.h and
other headers without conflicts now.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
