Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C526C25B75
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 17:51:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 481B83D0687
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 19:51:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD9F73C60BA
 for <ltp@lists.linux.it>; Wed, 29 May 2024 19:51:25 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 417691001295
 for <ltp@lists.linux.it>; Wed, 29 May 2024 19:51:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9880C205E0;
 Wed, 29 May 2024 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717005081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=phmGwQcYlqgnUxPX38JLtQn6iOnpU1w8/tWTG2RHu9A=;
 b=fmKAMiftAYprzFSIjNa/MxYxHVKi565RtLZgknS8Z/Y9GzI4mdC/Z1JyQSQib5vcNgrSHx
 GmvjrcyhHXYP7nB7jq08xtIpogZJlb9E7dOwtys7ayxxBRnIO5IOXL+cVQsleoLt4eU+1b
 2ea5Zo+8GZQH0Vh/amlctLhJWJwsnDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717005081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=phmGwQcYlqgnUxPX38JLtQn6iOnpU1w8/tWTG2RHu9A=;
 b=VwEwnb+GlBfH9rBZjLJJo0+jY1efrXb6hLjQMI9HMBWOznVc4vFdUzhxrbpvAzPXvXizvN
 TusDYkE0h52Ny3Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fmKAMift;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VwEwnb+G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717005081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=phmGwQcYlqgnUxPX38JLtQn6iOnpU1w8/tWTG2RHu9A=;
 b=fmKAMiftAYprzFSIjNa/MxYxHVKi565RtLZgknS8Z/Y9GzI4mdC/Z1JyQSQib5vcNgrSHx
 GmvjrcyhHXYP7nB7jq08xtIpogZJlb9E7dOwtys7ayxxBRnIO5IOXL+cVQsleoLt4eU+1b
 2ea5Zo+8GZQH0Vh/amlctLhJWJwsnDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717005081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=phmGwQcYlqgnUxPX38JLtQn6iOnpU1w8/tWTG2RHu9A=;
 b=VwEwnb+GlBfH9rBZjLJJo0+jY1efrXb6hLjQMI9HMBWOznVc4vFdUzhxrbpvAzPXvXizvN
 TusDYkE0h52Ny3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8191813A6B;
 Wed, 29 May 2024 17:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lBrQHRlrV2YBIAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 29 May 2024 17:51:21 +0000
Date: Wed, 29 May 2024 19:51:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZldrDNzrnXcI9XJ7@yuki>
References: <20240527202858.350200-1-pvorel@suse.cz>
 <20240527202858.350200-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240527202858.350200-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.99 / 50.00]; BAYES_HAM(-2.98)[99.92%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9880C205E0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] tst_test: Don't print hints if failed to
 acquire
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

Hi!
This is a great catch but I do not think that it should be limited to
the device init. We should distable the hints during the whole library
setup and only enable them once we actually start running the test.

I guess that we need:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 190e8da2a..47d0ecf7d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -61,6 +61,7 @@ static int mntpoint_mounted;
 static int ovl_mounted;
 static struct timespec tst_start_time; /* valid only for test pid */
 static int tdebug;
+static int show_failure_hints;

 struct results {
        int passed;
@@ -883,7 +884,8 @@ static void do_exit(int ret)

                if (results->broken) {
                        ret |= TBROK;
-                       print_failure_hints();
+                       if (show_failure_hints)
+                               print_failure_hints();
                }

                fprintf(stderr, "\nSummary:\n");
@@ -1740,6 +1742,8 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
        if (tst_test->test_variants)
                test_variants = tst_test->test_variants;

+       show_failure_hints = 1;
+
        for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
                if (tst_test->all_filesystems)
                        ret |= run_tcases_per_fs();



-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
