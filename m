Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB60C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 08:45:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C9303D1C06
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 10:45:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4D1A3C1A0F
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 10:44:58 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5449E60062B
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 10:44:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 321101F788;
 Wed, 24 Jul 2024 08:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721810697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E77WR/egXQHFKXfnfmAH1iDdPSreMgzRzJAh2pBMlCM=;
 b=02UAkLcIvRXR1gg1uiiwmBC8PUjk1oxcRADRFgbDrppzx8jWw/S8eaRPIqL/d1goIIvCRq
 vfdnTFXTmjTYkMn3+ufqUAf6vwkr/verGooaEYXbzoOaMEzWJdqsCmq1l68Ts1KEdPu7KC
 mv5rgrzkAnr9dw9gpVDEljKSGd/twVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721810697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E77WR/egXQHFKXfnfmAH1iDdPSreMgzRzJAh2pBMlCM=;
 b=p3yYecqEyCIQiiZ/89YkrYegJabb1awA99WsKUSIEw+JZ7AGfETKhxW0hg9ZQLF7QNRQ3D
 zMLgaCXlEYJ55uBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721810697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E77WR/egXQHFKXfnfmAH1iDdPSreMgzRzJAh2pBMlCM=;
 b=02UAkLcIvRXR1gg1uiiwmBC8PUjk1oxcRADRFgbDrppzx8jWw/S8eaRPIqL/d1goIIvCRq
 vfdnTFXTmjTYkMn3+ufqUAf6vwkr/verGooaEYXbzoOaMEzWJdqsCmq1l68Ts1KEdPu7KC
 mv5rgrzkAnr9dw9gpVDEljKSGd/twVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721810697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E77WR/egXQHFKXfnfmAH1iDdPSreMgzRzJAh2pBMlCM=;
 b=p3yYecqEyCIQiiZ/89YkrYegJabb1awA99WsKUSIEw+JZ7AGfETKhxW0hg9ZQLF7QNRQ3D
 zMLgaCXlEYJ55uBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 214971324F;
 Wed, 24 Jul 2024 08:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mec9Bwm/oGalTAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 08:44:57 +0000
Date: Wed, 24 Jul 2024 10:44:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZqC-69CoVPMRsJLv@yuki>
References: <20240712134412.30853-1-chrubis@suse.cz>
 <20240717082547.GA584952@pevik> <20240717083116.GA587967@pevik>
 <20240722130651.GA857641@pevik> <Zp5aPZZikKndIqgi@yuki>
 <205c3123-be3b-41e5-adf3-3458bee9ec89@suse.com>
 <20240724074247.GA924796@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240724074247.GA924796@pevik>
X-Spamd-Result: default: False [-3.60 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add tst_tmpdir_path() and tst_tmpdir_mkpath()
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
> > I had a strange SEGFAULT when .needs_tmpdir is not defined. Are you sure the
> > feature is correctly working in that case? TCONF should be expected in that
> > case.
> 
> Could you be more specific what is wrong? (failing test, what backtrace from gdb
> outputs. Maybe run it both *with* and *without* set follow-fork-mode child, not
> sure if the info will be in the library run or in the test fork run).
> 
> I tested bind02.c, which is *without* .needs_tmpdir and it works. bind01.c is
> *with* .needs_tmpdir and it also works.  These are not modified by the merged
> change (c5d95b6d3), thus I also tested chroot01.c (*without* .needs_tmpdir) and
> it also works.
> 
> Besides, openSUSE LTP testing of LTP syscalls with c5d95b6d3 [1] does not have
> any new failures.

I suppose that we need this, to have a TBROK message instead of SegFault
if users call things out of order:

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 1fb1bd698..bbb45dfa9 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -358,6 +358,9 @@ char *tst_tmpdir_path(void)
 {
        static char *tmpdir;

+       if (!TESTDIR)
+               tst_brk(TBROK, ".needs_tmpdir must be set!");
+
        if (tmpdir)
                return tmpdir;

@@ -368,11 +371,16 @@ char *tst_tmpdir_path(void)

 char *tst_tmpdir_mkpath(const char *fmt, ...)
 {
-       size_t testdir_len = strlen(TESTDIR);
-       size_t path_len = testdir_len;
+       size_t testdir_len, path_len;
        va_list va, vac;
        char *ret;

+       if (!TESTDIR)
+               tst_brk(TBROK, ".needs_tmpdir must be set!");
+
+       testdir_len = strlen(TESTDIR);
+       path_len = testdir_len;
+
        va_start(va, fmt);
        va_copy(vac, va);
        path_len += vsnprintf(NULL, 0, fmt, va) + 2;


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
