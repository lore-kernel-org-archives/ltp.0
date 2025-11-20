Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C60CF8859
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 13:33:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78B6F3D00BD
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 14:33:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 531FD3CD346
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 14:33:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BC0E2600F0C
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 14:33:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A64A5211AA;
 Thu, 20 Nov 2025 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763645600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcXfquumbGOD0VA8rp2Zl4cVVnaxqXfb6aQhmQ93/ds=;
 b=jarJ7MnHgyzSjDBHV+8L2LON/SAisNWR8N7Mxx64qOTLYwil6te8gz4HaBOv2Snfe3hF8J
 5vXHMAKtLvmVOji1n+FGjCb/fU13XSEP8EHFU3ISahjLHh9D2aBW3C3vvV5AZlbrmJ4hZS
 XPWaMC1ChDxJ3imqH5Sm4TEFq7tmrf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763645600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcXfquumbGOD0VA8rp2Zl4cVVnaxqXfb6aQhmQ93/ds=;
 b=jWUFSCPuah4O/cVYMEhcPfY2b/xK5Xia6itwg5F34KlGfxxgBIaUwNx5qE+Uwo3pNlhl76
 tRvnZ0W3Gu2KKeDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=da7UX1Jt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0OhKgHR4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763645599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcXfquumbGOD0VA8rp2Zl4cVVnaxqXfb6aQhmQ93/ds=;
 b=da7UX1JtoH8kslALjjfrCkUwVaDtO/FhmDVrpoIrnVWnS26/os/1K9bvCmHvTGP52Byu7K
 OPl4GsV+zoCLyyyMySpedqBU6Co//XKuE48RQjy0kINvmOTcSfQBG/QqdQJ5JsUzvoHYHg
 wAbd/8f8OBdmhXeECE5wH+HH3iQVrPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763645599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcXfquumbGOD0VA8rp2Zl4cVVnaxqXfb6aQhmQ93/ds=;
 b=0OhKgHR42/O5Umnki2Rx7hq+QhzJc2ceJFwSy1p2cqYZrmKCwlVErs8GFFSeSxVPanRhxI
 6+MdXAj6QfgFIXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BFBA3EA61;
 Thu, 20 Nov 2025 13:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5/RwHJ8YH2kOEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Nov 2025 13:33:19 +0000
Date: Thu, 20 Nov 2025 14:33:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20251120133313.GA318945@pevik>
References: <20251119093120.18775-1-chrubis@suse.cz>
 <CAEemH2f87qUSNZ0u5uFBPeZ=DrZLjcvtGFGZGzvpgwhzeaVuSA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f87qUSNZ0u5uFBPeZ=DrZLjcvtGFGZGzvpgwhzeaVuSA@mail.gmail.com>
X-Rspamd-Queue-Id: A64A5211AA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] shell: Add support for runtime
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

Hi Cyril, Li,

LGTM
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > +++ b/testcases/lib/tests/shell_loader_filesystems.sh
> > @@ -6,6 +6,7 @@
> >  # env
> >  # {
> >  #  "mount_device": true,
> > +#  "runtime": 10,
> >  #  "mntpoint": "ltp_mntpoint",
> >  #  "filesystems": [
> >  #   {
> > @@ -38,6 +39,14 @@ tst_test()
> >         else
> >                 tst_res TFAIL "Device not mounted!"
> >         fi
> > +
> > +       RUNTIME=$(tst_remaining_runtime)
> > +
> > +       if [ "$RUNTIME" -ge 9 ]; then
> > +               tst_res TPASS "Remaining runtime $RUNTIME"
> > +       else
> > +               tst_res TFAIL "Remaning runtime $RUNTIME"

> Typo ->  s/Remaning/Remaining

+1

> > +       fi
> >  }

..
> > +++ b/testcases/lib/tst_run_shell.c
> > @@ -60,6 +60,7 @@ enum test_attr_ids {
> >         MIN_CPUS,
> >         MIN_MEM_AVAIL,
> >         MIN_KVER,
> > +       MIN_RUNTIME,
> >         MIN_SWAP_AVAIL,
> >         MNTPOINT,
> >         MOUNT_DEVICE,
> > @@ -74,6 +75,7 @@ enum test_attr_ids {
> >         NEEDS_ROOT,
> >         NEEDS_TMPDIR,
> >         RESTORE_WALLCLOCK,
> > +       RUNTIME,


> Do we need to add a flexible TIMEOUT in shell support as well?

> The default TST_TIMEOUT in SHELL is 300, which is not consistent with C

300 s (5 min) is for tst_test.sh API. C API has 120 s (2 min), therefore that's
the default also for the shell loader API (the newest shell API).
And this specific test has 2 min 10 sec (due runtime 10).

The longer timeout is due Tumbleweed having CONFIG_FAULT_INJECTION, otherwise
it'd be 30 s (or 40 s for the test). I'm still not convinced that
CONFIG_FAULT_INJECTION itself should give 4x longer timeout for all
Tumbleweed/SLES testing. But that's something else, not relevant to the patch.

Kind regards,
Petr

> method (DEFAULT_TIMEOUT + tst_test->timeout).

> Anyway, this patch itself looks good:
> Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
