Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BEACD4F54
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 09:32:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FB933C735A
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 11:32:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A52F73C71F4
 for <ltp@lists.linux.it>; Wed, 20 May 2026 11:32:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71F106005FC
 for <ltp@lists.linux.it>; Wed, 20 May 2026 11:32:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F4AB67677;
 Wed, 20 May 2026 09:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779269555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/PPyR+Cav1szB7AYQBuZXiIA7Yoe5oYoNJNMXbKvP3s=;
 b=fuAcEivqUsCynuHRUlErQIaqike9irQ/AEdoLB1pO6DlmvXYLG2Pt18CiPQ8hDNqQd8Bbm
 r7ylV7h45RLaJ5G4ZFrlja9BPg+msrbgHCGnWrmtU/UpCDI9Lgjd4lA0lX2vzDTxFx/xQJ
 1GwUaf5MbDUSShvB781G7H383SCc1g4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779269555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/PPyR+Cav1szB7AYQBuZXiIA7Yoe5oYoNJNMXbKvP3s=;
 b=oGQ67JN5xdTu+/2LclL5TD4QxeHga0dbIU15CJzdfm9IDxfY6bcgmzR0fJprpJZ3cRiGLz
 HpRMi7Mh9f40SZBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fuAcEivq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oGQ67JN5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779269555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/PPyR+Cav1szB7AYQBuZXiIA7Yoe5oYoNJNMXbKvP3s=;
 b=fuAcEivqUsCynuHRUlErQIaqike9irQ/AEdoLB1pO6DlmvXYLG2Pt18CiPQ8hDNqQd8Bbm
 r7ylV7h45RLaJ5G4ZFrlja9BPg+msrbgHCGnWrmtU/UpCDI9Lgjd4lA0lX2vzDTxFx/xQJ
 1GwUaf5MbDUSShvB781G7H383SCc1g4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779269555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/PPyR+Cav1szB7AYQBuZXiIA7Yoe5oYoNJNMXbKvP3s=;
 b=oGQ67JN5xdTu+/2LclL5TD4QxeHga0dbIU15CJzdfm9IDxfY6bcgmzR0fJprpJZ3cRiGLz
 HpRMi7Mh9f40SZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F8C7593AA;
 Wed, 20 May 2026 09:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YiaoHrN/DWoXWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 May 2026 09:32:35 +0000
Date: Wed, 20 May 2026 11:32:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260520093226.GA90509@pevik>
References: <20260505083016.36843-1-li.wang@linux.dev>
 <20260515155814.GB45497@pevik> <agf53mSShy735Whu@linux.dev>
 <20260516171536.GA190882@pevik> <agkn30ZUs1h8Da3s@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <agkn30ZUs1h8Da3s@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 8F4AB67677
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: Introduce tst_path_macros.h to
 consolidate system paths
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

Hi Li,

> Petr Vorel wrote:

> > The problem is even now on master:
> > output of testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c contains e.g. PATH_OC_HPAGES
> > from include/tst_hugepage.h.

> > https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html#hugemmap10

> > da3088183a ("metadata: metaparse: Implement recursive include")
> > skips certain LTP includes e.g. tst_test.h in skip_includes[] causes
> > all definitions not being propagated. I guess it could be fixable to parse
> > include/tst_test.h and include certain headers.

> > $ metadata/metaparse -v testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> > does not print INCLUDE .. because include/tst_hugepage.h is included via
> > tst_test.h, not directly in the test.

> After looking into the mataparse.c I think we have two methods:

> 1. Explicitly parsing tst_path_defs.h in metaparse.c:

>    Since tst_test.h is explicitly ignored by the skip_includes[] array,
>    any files it includes (e.g. tst_path_defs.h) are consequently bypassed
>    by the parser. To resolve this, we can instruct metaparse to proactively
>    search for and parse tst_path_defs.h during its initialization phase.

>    We can achieve this by adding a dedicated function in metaparse.c to
>    read this specific header file, and then invoking it within the main
>    parse_file function.

LGTM.

> 2. Simply adding the list of macros to the internal_macros[].

>    As long as all the konbs definitions are listed there, metaparse can
>    convert them into string paths in tst_test for use in ltp.json.

> --- a/metadata/metaparse.c
> +++ b/metadata/metaparse.c
> @@ -881,6 +881,66 @@ static const struct macro {
>         {"TST_SR_TBROK_RO", "TBROK_RO"},
>         {"TST_SR_TCONF_RO", "TCONF_RO"},
>         {"TST_SR_SKIP_RO", "SKIP_RO"},
> +        {"PATH_KERNEL_HOSTNAME", "/proc/sys/kernel/hostname"},
> +        {"PATH_KERNEL_OSRELEASE", "/proc/sys/kernel/osrelease"},
> +        {"PATH_KERNEL_VERSION", "/proc/sys/kernel/version"},
> +        {"PATH_KERNEL_DOMAINNAME", "/proc/sys/kernel/domainname"},
> +        {"PATH_KERNEL_PRINTK", "/proc/sys/kernel/printk"},
> +        {"PATH_KERNEL_PID_MAX", "/proc/sys/kernel/pid_max"},
> +        {"PATH_KERNEL_SHMMAX", "/proc/sys/kernel/shmmax"},
> ...

If you mean that the definitions would be on more places (tst_path_defs.h and
metadata/metaparse.c) I would not consider is as a good option.

> I don't have any preferences, but method-1 looks more elegant.

+1

> > My fear was that to clash with existing system headers causing build failure due
> > macro redefinition (that's IMHO reason for "TST_" prefix). But "PATH_" might
> > be safe, because /usr/include/paths.h contains "_PATH_" prefix - with leading
> > underscore (e.g. _PATH_CONSOLE). And the only "PATH_" prefix is PATH_MAX
> > in /usr/include/limits.h.

> We now have PATH_{KERNEL|USER|VM|FS}, so conflicts should be very low.

OK with me, but I'd prefer to get this acked by somebody else.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
