Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1BAC36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:41:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B615F3CAEAC
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:41:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D1C23CA0EF
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:40:58 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B4F16002CA
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:40:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2E441F388;
 Mon,  7 Apr 2025 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744029655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fod3U5Ykg6AUjIkYxebLbZLJjuyc5GmXMyzd6c7pD0s=;
 b=IHK7+4h/19VNM0daWIFa+JbV6QGhTWDYNPWT1N83aEmc8d5dvSW4JgnWYlqNVLpgAQnGYr
 Z7DGmJ+tvkL4ISgTVBHb1qR2lWtQTTRhdpSQaptP3QjLd1hjdcA/NO4Jb+jpMCdqUoY/ah
 eLIV+Wk988XTSao7tqMxhvw9s7woVsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744029655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fod3U5Ykg6AUjIkYxebLbZLJjuyc5GmXMyzd6c7pD0s=;
 b=4h8sQeL2QyKYFR/EJVoNJK8Al1Gx782hF7rnE3/A0xHKyvh87SZi4WwZjCFefYxpL+1tz4
 JWhbkiZUjtmvg1CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744029655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fod3U5Ykg6AUjIkYxebLbZLJjuyc5GmXMyzd6c7pD0s=;
 b=IHK7+4h/19VNM0daWIFa+JbV6QGhTWDYNPWT1N83aEmc8d5dvSW4JgnWYlqNVLpgAQnGYr
 Z7DGmJ+tvkL4ISgTVBHb1qR2lWtQTTRhdpSQaptP3QjLd1hjdcA/NO4Jb+jpMCdqUoY/ah
 eLIV+Wk988XTSao7tqMxhvw9s7woVsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744029655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fod3U5Ykg6AUjIkYxebLbZLJjuyc5GmXMyzd6c7pD0s=;
 b=4h8sQeL2QyKYFR/EJVoNJK8Al1Gx782hF7rnE3/A0xHKyvh87SZi4WwZjCFefYxpL+1tz4
 JWhbkiZUjtmvg1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E22513691;
 Mon,  7 Apr 2025 12:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5PVWJdfH82eXBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Apr 2025 12:40:55 +0000
Date: Mon, 7 Apr 2025 14:41:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <Z_PH8xBBsESE4K8I@yuki.lan>
References: <20250402-conversions-modify_ldt-v6-0-2e4b0e27870e@suse.com>
 <20250402-conversions-modify_ldt-v6-3-2e4b0e27870e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250402-conversions-modify_ldt-v6-3-2e4b0e27870e@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/3] syscalls/modify_ldt01: Refactor into new
 API
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Now that we're using the wrapped modify_ldt() from the lapi/ldt.h which
> uses tst_syscall(), it does not make sense to keep the first block of the
> original test which simply checked for ENOSYS. Also, merge modify_ldt03
> into modify_ldt01 and extend the test to cover all the errors from the
> manual page.
> =

> Signed-off-by: Ricardo B. Marli=E8re <rbm@suse.com>
> ---
>  testcases/kernel/syscalls/modify_ldt/.gitignore    |   5 +-
>  .../kernel/syscalls/modify_ldt/modify_ldt01.c      | 264 +++++----------=
------
>  .../kernel/syscalls/modify_ldt/modify_ldt03.c      | 105 --------

You should remove modify_ldt03 from the syscalls runtest file as well.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
