Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8E6C2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 13:58:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 113E53CC52A
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 15:58:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F0C93CC32D
 for <ltp@lists.linux.it>; Thu, 15 May 2025 15:58:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 79B3C1A02395
 for <ltp@lists.linux.it>; Thu, 15 May 2025 15:58:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A25E1F799;
 Thu, 15 May 2025 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747317520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ginp05GRy/vpWVi7e5ltG9k7CjIFsoq0kuOGKIvVew=;
 b=YG1ikNgNkZTRG2bo9804zo0s/b9sBUYayecPa8+tHQqbA5AoQyNYAERsdf5StwOHbxdteu
 VqvFwQ12wTZSIpyQqHjQZT4EJO6peA83wisGm57xC4j00n4hIdIVa77N1A5Do+MqKVLNiD
 CWSPvMudKICIUkRjvBqvyoFlOnk8qdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747317520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ginp05GRy/vpWVi7e5ltG9k7CjIFsoq0kuOGKIvVew=;
 b=ZBJHxa7MNSbWEMviUU8RARFDm/PhtuUwTt1Dpz8yyVL25LJjV325g9Ju27sP9cqnhKovz2
 chZ5plxpJjUR5wDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747317520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ginp05GRy/vpWVi7e5ltG9k7CjIFsoq0kuOGKIvVew=;
 b=YG1ikNgNkZTRG2bo9804zo0s/b9sBUYayecPa8+tHQqbA5AoQyNYAERsdf5StwOHbxdteu
 VqvFwQ12wTZSIpyQqHjQZT4EJO6peA83wisGm57xC4j00n4hIdIVa77N1A5Do+MqKVLNiD
 CWSPvMudKICIUkRjvBqvyoFlOnk8qdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747317520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ginp05GRy/vpWVi7e5ltG9k7CjIFsoq0kuOGKIvVew=;
 b=ZBJHxa7MNSbWEMviUU8RARFDm/PhtuUwTt1Dpz8yyVL25LJjV325g9Ju27sP9cqnhKovz2
 chZ5plxpJjUR5wDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1887A137E8;
 Thu, 15 May 2025 13:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +tkqBRDzJWj/JwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 May 2025 13:58:40 +0000
Date: Thu, 15 May 2025 15:58:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Message-ID: <20250515135834.GB498002@pevik>
References: <20250515103146.14950-1-chrubis@suse.cz>
 <20250515124420.GA491427@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250515124420.GA491427@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: tst_test: Add reproducible output.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

+	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT When set to 1 or y discards the actual content of the messages printed by the test\n");

nit: "When set to 1 or y" is slightly verbose to me.  Maybe just "1/y discards
the actual content of the messages printed by the test" ?

But anyway that's very minor, therefore I kept the same approach when adding
LTP_ENABLE_DEBUG in the next patch I'm going to send now.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
