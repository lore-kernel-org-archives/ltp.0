Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699A3CD4F3C
	for <ltp@archiver.kernel.org>; Sat, 16 May 2026 17:16:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832C93E5905
	for <ltp@archiver.kernel.org>; Sat, 16 May 2026 19:16:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A50F3E57BB
 for <ltp@lists.linux.it>; Sat, 16 May 2026 19:15:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D522140053B
 for <ltp@lists.linux.it>; Sat, 16 May 2026 19:15:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE3E25CF0B;
 Sat, 16 May 2026 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778951742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7S1wmHpeJ1kbcgpJb0QcSxUUVKqXlkSiw04RsDOM6w=;
 b=YvKBwwvXR0uN4XR1k5Tl2yQ03RTPhn95wXTpBYAZwyuK6vhGv7gKImtgNwlIpXyPbmj59d
 +WLQn8VbgrONbVLzBpOeafSl9VPmyOG+MWa6jwu1V8mEzpg2zuKgQuqq8FMegIrDw9sKrh
 V3wsiQgm+/aXKND/8GfIBQw/9GVaBk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778951742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7S1wmHpeJ1kbcgpJb0QcSxUUVKqXlkSiw04RsDOM6w=;
 b=A3/gg43GA2LGI0QDHce2FW6h+wSnJokIU36svcIZOHwKPpSOJS7mEKsB09YgypPlrfw5sq
 zYzDTh3UlmNna4AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d40fQ1QW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8UhFw8sh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778951741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7S1wmHpeJ1kbcgpJb0QcSxUUVKqXlkSiw04RsDOM6w=;
 b=d40fQ1QWlzgyS5dSGp+QISaRdpQIN+4qxqSLoYZcvjfc/63hEVqentKrfqc66FwhSPhsE7
 VitQZBMypi0UVhqK9oQwnXeSQgf1QyIuj+SVcMRJz1jUszLc1kDfelXZMzgusUezF9p09V
 WKTx/zXi2eV8st+Bq3aZAJEzaWEtxGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778951741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7S1wmHpeJ1kbcgpJb0QcSxUUVKqXlkSiw04RsDOM6w=;
 b=8UhFw8shqXJTyvTu8RLWm79azLpOK4cKgTAxlmRToOnE4lEnR/CfFuzpS+rT0R4554OIiL
 6chqdoAXLElfSpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE0D6593A8;
 Sat, 16 May 2026 17:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WZ5/Kz2mCGpcJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sat, 16 May 2026 17:15:41 +0000
Date: Sat, 16 May 2026 19:15:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260516171536.GA190882@pevik>
References: <20260505083016.36843-1-li.wang@linux.dev>
 <20260515155814.GB45497@pevik> <agf53mSShy735Whu@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <agf53mSShy735Whu@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: DE3E25CF0B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

> Petr Vorel wrote:

> > Hi Li,

> > could you please rebase to master and push branch to your fork?
> > Patch now does not apply:

> Sure, rebased and pushed to my fork:
>  https://github.com/wangli5665/ltp/tree/tst_path_defs

Thank you!

+1. I'll try to find time soon, but probably after SUSE Labs conference
(which is next week till Thursday).

> > I suppose metadata will work with it correctly since Cyril's support for macros
> > in past (i.e. metadata/ltp.json will have "/proc/sys/kernel/hostname", not
> > PATH_HOSTNAME, which tells nothing to LTP users).

> Oh, I didn't realized this, seems the ltp.json contains define words:

> # cat metadata/ltp.json |grep PATH_
>      "PATH_MAX_USER_NAMESPACES",
>      "PATH_MAX_USER_NAMESPACES",
>      "PATH_MAX_USER_NAMESPACES",
>      "PATH_MAX_USER_NAMESPACES",
>      "PATH_UNPRIVILEGED_USERNS_CLONE",
>      "PATH_MAX_USER_NAMESPACES",
>      "PATH_UNPRIVILEGED_USERNS_CLONE",
>      "PATH_VM_OVERCOMMIT_HPAGES",
>      "PATH_VM_OVERCOMMIT_HPAGES",
>      ...

> I can change them back to the original types (for ltp.json) in a separate patch.

The problem is even now on master:
output of testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c contains e.g. PATH_OC_HPAGES
from include/tst_hugepage.h.

https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html#hugemmap10

da3088183a ("metadata: metaparse: Implement recursive include")
skips certain LTP includes e.g. tst_test.h in skip_includes[] causes
all definitions not being propagated. I guess it could be fixable to parse
include/tst_test.h and include certain headers.

$ metadata/metaparse -v testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
does not print INCLUDE .. because include/tst_hugepage.h is included via
tst_test.h, not directly in the test.

> > I slightly prefer the previous name tst_path.h (for me macros are complex
> > functions, not just simple definitions, what info gives me "macro-only content"?
> > I care more about the actual content). I'm ok with it current name, but maybe
> > kernel_paths.h or proc_sys_paths.h would be more obvious which paths is it
> > about. Also, it's not just about paths, but also about the content in these
> > /proc|sys files (e.g. "HugePages_Total:").

> Yes, I'm also hesitant about the naming. The tst_ prefix is needed since it will
> be placed in the include/ directory and used across the entire project. proc_ or
> sys_ sounds a bit too narrow in scope. Maybe:

>   tst_path_defs.h
>   tst_sys_paths.h

> I'm now leaning towards tst_path_defs.h. WDYT?

I'm OK with it. My guess is that it will sooner or later contain more than just
paths (it already has now /proc/meminfo keys) but I'm not able to suggest
anything better.

I was also thinking about name containing "uapi", because it's all about
info provided by kernel to userspace (yes, mostly paths but not only), but that
would lead to confusions about kernel's uapi (i.e. what we more or less have as
lapi/).

> > >     	* Replaced generic string concatenation macros with explicit.
> > >     	* Manualy built & Tested all touched tests on my c10s vm.

> > ...

> > > +/* KERNEL */
> > > +#define PATH_HOSTNAME			"/proc/sys/kernel/hostname"
> > > +#define PATH_OSRELEASE			"/proc/sys/kernel/osrelease"
> > ...
> > > +/* USER */
> > > +#define PATH_MAX_USER_NAMESPACES	"/proc/sys/user/max_user_namespaces"

> > I have 2 concerns:

> > 1) we often try to have LTP specific 'TST_' prefix to avoid clash with
> > whatever definition. Is it ok to ignore it now?

> I'd prefer to stick with PATH_ instead of TST_PATH_. PATH_ is universally
> understood as a file path definition. Adding TST_ makes it unnecessarily
> verbose.

My fear was that to clash with existing system headers causing build failure due
macro redefinition (that's IMHO reason for "TST_" prefix). But "PATH_" might
be safe, because /usr/include/paths.h contains "_PATH_" prefix - with leading
underscore (e.g. _PATH_CONSOLE). And the only "PATH_" prefix is PATH_MAX
in /usr/include/limits.h.

> > 2) I'm pretty sure I will have to look into this file often, because from
> > definition name I have no idea where exactly file is. I'd be ok with long name
> > TST_PROC_SYS_KERNEL_HOSTNAME, but understand Cyril wants short names. Maybe at
> > least TST_PATH_KERNEL_HOSTNAME and TST_PATH_USER_MAX_USER_NAMESPACES(last
> > directory and file)? That would be similar to what sysctl is using:

> > 	sysctl kernel.hostname
> > 	sysctl user.max_user_namespaces

> I understand the concern, but long macros like TST_PATH_USER_MAX_USER_NAMESPACES
> will make the test code very verbose and easily lead to 80-character
> line wrapping issues.

Yeah, true.

> To address the readability issue without making the names too long,
> I can add _KERNEL_ and _USER_ to the defines (like PATH_KERNEL_HOSTNAME
> and PATH_USER_MAX_USER_NAMESPACES). I think this is a good middle ground.

Sounds good to me.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
