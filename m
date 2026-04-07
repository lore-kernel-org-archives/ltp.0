Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EF4EDB7DF
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 10:02:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D01603E1F3C
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 12:02:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA0843C65BB
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 12:02:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2072260004C
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 12:02:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED05E4E3C8;
 Tue,  7 Apr 2026 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775556121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VvlEiSv2pnyuNUYuUUQkfcO7KQUpfPQxWd7UW2J/3GA=;
 b=T4Oz6gpNbPycADhbuMkMykzyaVI2oAbzoo4iCs2qVyzewzQgJqeL54o+tvx2RvNtKKmPUD
 lsXXgIbVa/k3waUA2tBX3FqLZJtVXxW3KX/fRpwhtfWy0Kg+rwjbg28aZ8AiVQqb9qARQp
 czKAfqH7gEElSQ80lfnSqhSFDbcwRKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775556121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VvlEiSv2pnyuNUYuUUQkfcO7KQUpfPQxWd7UW2J/3GA=;
 b=ip5eL/TcJIsSnjNKUmtF+w6L8x2CBNw3lrxGyVGJB9xKzswFlDu9HD85FvDh65LO2OzUJK
 FFFeIXNlKi76oeBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G6ntDtar;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DNnFoX6+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775556119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VvlEiSv2pnyuNUYuUUQkfcO7KQUpfPQxWd7UW2J/3GA=;
 b=G6ntDtareRQzY2N4Z9lwC1OIJ78b4pFv97L7WzHGb1MWApDMnemZRsqoiVXCaWrMcD1d56
 QFviqsjGimefkAT2YkrYv8biBCyS0+WXqdfiQvhpKrE3qI/1bnV35fMWNAEOkhFzSQl0wp
 a+qhWJhIZpBeCLXIMBU5prItupyu5V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775556119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VvlEiSv2pnyuNUYuUUQkfcO7KQUpfPQxWd7UW2J/3GA=;
 b=DNnFoX6+05KDZZ2+OmA43ZZhrZrvBkBNuZid6i/B9WVKS0bdy/g9905Q2TVfEdwjNju/aq
 ohvC2NKe5w/6krBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC4354A0B0;
 Tue,  7 Apr 2026 10:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DIMaNBfW1GklfQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Apr 2026 10:01:59 +0000
Date: Tue, 7 Apr 2026 12:02:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <adTWHgQO2gLj_bXX@yuki.lan>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-17-chrubis@suse.cz>
 <CAEemH2c5OfBhcR_KB6LY4yJdxAUDR7HbWAf-V0KjiZMN2Jkarw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c5OfBhcR_KB6LY4yJdxAUDR7HbWAf-V0KjiZMN2Jkarw@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: ED05E4E3C8
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 16/17] lib: tst_test: Remove now unused
 needs_drivers
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
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -498,10 +498,6 @@ struct tst_fs {
> >   *                  to the test temporary directory from the LTP datafiles
> >   *                  directory.
> >   *
> > - * @needs_drivers: A NULL terminated array of kernel modules required to run
> > - *                 the test. The module has to be build in or present in order
> > - *                 for the test to run.
> > - *
> >   * @save_restore: A {} terminated array of /proc or /sys files that should
> >   *                saved at the start of the test and restored at the end. See
> >   *                tst_sys_conf_save() and :ref:`struct tst_path_val` for details.
> 
> As we add runtime_check and module_check, I think we also need to update
> the descrition comments of @needs_kconfigs in tst_test.h.


What about something like this:

diff --git a/include/tst_test.h b/include/tst_test.h
index 752688c45..f2a5378cd 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -511,6 +511,13 @@ struct tst_fs {
  *                  and parenthesis are supported, e.g.
  *                  "CONFIG_X86_INTEL_UMIP=y | CONFIG_X86_UIMP=y" is evaluated
  *                  to true if at least one of the options is present.
+ *                  For some config options their presence in the config file
+ *                  is not enough to assure the functionality is present or
+ *                  enabled. E.g. config option may be set to 'm' but the
+ *                  module may not be installed or functionality may be
+ *                  disabled on the kernel command line. The kconfig library
+ *                  has a set of additonal checks for a few config options that
+ *                  are used in the tests and need additional checks.
  *
  * @bufs: A description of guarded buffers to be allocated for the test. Guarded
  *        buffers are buffers with poisoned page allocated right before the start


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
