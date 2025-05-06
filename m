Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D447DC3ABAC
	for <ltp@archiver.kernel.org>; Tue,  6 May 2025 08:05:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 356FF3C974F
	for <ltp@archiver.kernel.org>; Tue,  6 May 2025 10:05:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D87063C56CD
 for <ltp@lists.linux.it>; Tue,  6 May 2025 10:04:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 00F3960087C
 for <ltp@lists.linux.it>; Tue,  6 May 2025 10:04:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2743B1F387;
 Tue,  6 May 2025 08:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746518694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2l8qWTWRw90VCkvaOj75Nw68cSPIyC1/GFjywdU67N4=;
 b=SDyMKz3Cr1LdT/6pr35VbE/J/SPMTJShoPeiqAr/YryjNNp/etvtkTyPO+h6SLa86LW1Z5
 IJnE8iY9dP2tmgisRs+B0yas69l50P/T+JkiB6TKgj12baomQvhs39cIjIKvx1O2yFf5su
 KTBiya/WwoP4tme67rysBIE0wKT8AkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746518694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2l8qWTWRw90VCkvaOj75Nw68cSPIyC1/GFjywdU67N4=;
 b=PsdzwQ7OSatH8jG2k6kNF+y9F62Kdmiqcout9uqMEHPKoMLI6/cM7mSEyTABMGnYcYVlAu
 JU6DeAJ2m82AjHBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746518694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2l8qWTWRw90VCkvaOj75Nw68cSPIyC1/GFjywdU67N4=;
 b=SDyMKz3Cr1LdT/6pr35VbE/J/SPMTJShoPeiqAr/YryjNNp/etvtkTyPO+h6SLa86LW1Z5
 IJnE8iY9dP2tmgisRs+B0yas69l50P/T+JkiB6TKgj12baomQvhs39cIjIKvx1O2yFf5su
 KTBiya/WwoP4tme67rysBIE0wKT8AkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746518694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2l8qWTWRw90VCkvaOj75Nw68cSPIyC1/GFjywdU67N4=;
 b=PsdzwQ7OSatH8jG2k6kNF+y9F62Kdmiqcout9uqMEHPKoMLI6/cM7mSEyTABMGnYcYVlAu
 JU6DeAJ2m82AjHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1745813687;
 Tue,  6 May 2025 08:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iHabBKbCGWiGUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 06 May 2025 08:04:54 +0000
Date: Tue, 6 May 2025 10:03:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aBnCSDh8eqy38mIy@rei.lan>
References: <20250429052247.GA144682@pevik> <aBSVO8uOE86UGIcp@yuki.lan>
 <20250505195003.GB137650@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250505195003.GB137650@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP in valgrind :)
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
> > It also opens some interesting questions, i.e. how do we make comparing
> > results from two different tests easier. Currently they grep the test
> > results for a summary, but maybe we can do better.
> 
> Kirk and compare json?

That does sound like an overkill for something that is basically:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 694861d95..29d9fc1d5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -64,6 +64,7 @@ static int mntpoint_mounted;
 static int ovl_mounted;
 static struct timespec tst_start_time; /* valid only for test pid */
 static int tdebug;
+static int reproducible_output;

 struct results {
        int passed;
@@ -299,6 +300,9 @@ static void print_result(const char *file, const int lineno, int ttype,
        str += ret;
        size -= ret;

+       if (reproducible_output)
+               goto print;
+
        if (tst_color_enabled(STDERR_FILENO))
                ret = snprintf(str, size, "%s%s: %s", tst_ttype2color(ttype),
                               res, ANSI_COLOR_RESET);
@@ -324,6 +328,7 @@ static void print_result(const char *file, const int lineno, int ttype,
                                "Next message is too long and truncated:");
        }

+print:
        snprintf(str, size, "\n");

        /* we might be called from signal handler, so use write() */
@@ -1273,6 +1278,8 @@ static void do_setup(int argc, char *argv[])
        if (tst_test->tconf_msg)
                tst_brk(TCONF, "%s", tst_test->tconf_msg);

+       reproducible_output = !!getenv("LTP_REPRODUCIBLE_OUTPUT");
+
        assert_test_fn();

        TCID = tid = get_tid(argv);


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
