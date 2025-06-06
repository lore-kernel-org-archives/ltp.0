Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C31C5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 10:08:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E01E3C9B85
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 12:08:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 536DB3C9A52
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 12:08:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5183A14002D9
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 12:08:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E580F1F38E;
 Fri,  6 Jun 2025 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749204516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1zozAXCgHgdLEPkKmoj5aIX1N4SLax4/We3J5dKzVQ=;
 b=iMuX3YR2W541oiMJWEyhTmoI0jTlbJjQ8oWI551LN2DRX21mYj+BIA74bkZYQbFsedT+ni
 mA8J1Fz7sbXe8yV/hu5Ku2K2fgsaiS8yGC563JnhH52FwWme10cDVRpvh/in21kqH9QzAV
 cpqCBcmPbKn7XHWK90yGGzvQesYa9yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749204516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1zozAXCgHgdLEPkKmoj5aIX1N4SLax4/We3J5dKzVQ=;
 b=7m1+kyZM9Xrp4ceQDCb9Ng+CbU1PPsCfqO/nrJzJ5sGXdjms9ftul5AuH6jkv8ccGOxsoD
 BItF1MDDqeX3+eCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749204516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1zozAXCgHgdLEPkKmoj5aIX1N4SLax4/We3J5dKzVQ=;
 b=iMuX3YR2W541oiMJWEyhTmoI0jTlbJjQ8oWI551LN2DRX21mYj+BIA74bkZYQbFsedT+ni
 mA8J1Fz7sbXe8yV/hu5Ku2K2fgsaiS8yGC563JnhH52FwWme10cDVRpvh/in21kqH9QzAV
 cpqCBcmPbKn7XHWK90yGGzvQesYa9yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749204516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1zozAXCgHgdLEPkKmoj5aIX1N4SLax4/We3J5dKzVQ=;
 b=7m1+kyZM9Xrp4ceQDCb9Ng+CbU1PPsCfqO/nrJzJ5sGXdjms9ftul5AuH6jkv8ccGOxsoD
 BItF1MDDqeX3+eCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF4521369F;
 Fri,  6 Jun 2025 10:08:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 60fcLSS+Qmh9KQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jun 2025 10:08:36 +0000
Date: Fri, 6 Jun 2025 12:08:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250606100835.GA1290409@pevik>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-2-0b5cff90c21c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605-conversions-mknod-v5-2-0b5cff90c21c@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/8] syscalls/mknod02: Use relative path to
 avoid use of SAFE_CHDIR
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Yes, man mknod(2) notes:

	the new node will inherit the group ownership from its parent directory

no matter what is cwd of the calling process.
Therefore I merged this obvious simplification (+ previous commit).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
