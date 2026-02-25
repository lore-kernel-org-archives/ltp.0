Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC603FCEE8A
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 11:39:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046CB3C1AAA
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 12:39:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 523393C1916
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:39:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C5ABF1A00804
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:39:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C365400C6;
 Wed, 25 Feb 2026 11:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772019550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pClZ9qpg0G4Bz+eFPDOffcGeDwGxdnKfTI4H1BLdcyk=;
 b=llk6f/ihSzLg0oIkrwv0jY7sythAGUdoHSMRjONiZuuyYf7iS206zaCA8RJuhf59fr6d3f
 JPtdo35AUWsIGRstB85NKHQIg5unJVI/8ePUrou6xIS6rtNgIaS5joto7H9MiUspvw3pc1
 neQVs4c+d7k8qcx6PhCUnPWTEdB8nwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772019550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pClZ9qpg0G4Bz+eFPDOffcGeDwGxdnKfTI4H1BLdcyk=;
 b=sYHTfW/Jv0LJCzDRY00GM7WpKiw7VkKZVYGMs6rdOcmKT6LUxrcIH/8zWPehKPiv3okt/e
 NSvXBCtqXOXLsSBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772019550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pClZ9qpg0G4Bz+eFPDOffcGeDwGxdnKfTI4H1BLdcyk=;
 b=llk6f/ihSzLg0oIkrwv0jY7sythAGUdoHSMRjONiZuuyYf7iS206zaCA8RJuhf59fr6d3f
 JPtdo35AUWsIGRstB85NKHQIg5unJVI/8ePUrou6xIS6rtNgIaS5joto7H9MiUspvw3pc1
 neQVs4c+d7k8qcx6PhCUnPWTEdB8nwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772019550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pClZ9qpg0G4Bz+eFPDOffcGeDwGxdnKfTI4H1BLdcyk=;
 b=sYHTfW/Jv0LJCzDRY00GM7WpKiw7VkKZVYGMs6rdOcmKT6LUxrcIH/8zWPehKPiv3okt/e
 NSvXBCtqXOXLsSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C81443EA65;
 Wed, 25 Feb 2026 11:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hqnqLV3fnmkOJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 25 Feb 2026 11:39:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: chrubis@suse.cz,
	Jinseok Kim <always.starving0@gmail.com>
Date: Wed, 25 Feb 2026 12:39:04 +0100
Message-ID: <177201951149.461843.14091281627362196839.b4-ty@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224171609.47265-1-always.starving0@gmail.com>
References: <aZ3FiPwPd-eskHCZ@yuki.lan>
 <20260224171609.47265-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[suse.cz,gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] poll: add basic POLLHUP semantics test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>


On Wed, 25 Feb 2026 02:15:38 +0900, Jinseok Kim wrote:
> Add a basic poll() test to verify that POLLHUP is reported when the
> peer end of a pipe is closed.
> 
> The test creates a pipe, closes the write end, and polls the read end
> for POLLIN events. poll() is expected to return successfully and set
> POLLHUP in revents.
> 
> [...]

Applied, thanks!

[1/2] poll: add basic POLLHUP semantics test
      commit: de9426e858f1de8fbe0a8c86676a193907c6ddce
[2/2] poll: add test for POLLNVAL on invalid fd
      commit: c7a45fc28c75092dd86340c5cbf0f8124509522d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
