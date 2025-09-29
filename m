Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6A0CAC5B0
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 08:32:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB8013CE1C6
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 10:32:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BE1C3C4F80
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 10:32:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 14DF1140020B
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 10:32:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DC53314B6;
 Mon, 29 Sep 2025 08:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759134722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bvs2oavNjSVaUUckUlOza9rx0E0NtK9gvVDOR8SHJaQ=;
 b=0Sc5z9mQdCZHWeG1fzwKAZDwUoEcWbNIXKeOSuIfSHXHodtoq8PVaZeBaGRjY5z4W6ixZl
 nihkPKwsjzWa7BaRCuk9xE4rYTdnxeyFqCG7aDXcJokMevqBaGFu5sBf5F6cWdRerri0ND
 idoxphwyW9FbdSs8w6MTDgLMVli0Wfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759134722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bvs2oavNjSVaUUckUlOza9rx0E0NtK9gvVDOR8SHJaQ=;
 b=cQScN28JVej9Mpf79Za750E0GgyA2mLdBhsIAXbiNIoqgMNDEJanH4RyEI8h2g+gzUAo+y
 8Q5omf0PCpG+6TAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0Sc5z9mQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cQScN28J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759134722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bvs2oavNjSVaUUckUlOza9rx0E0NtK9gvVDOR8SHJaQ=;
 b=0Sc5z9mQdCZHWeG1fzwKAZDwUoEcWbNIXKeOSuIfSHXHodtoq8PVaZeBaGRjY5z4W6ixZl
 nihkPKwsjzWa7BaRCuk9xE4rYTdnxeyFqCG7aDXcJokMevqBaGFu5sBf5F6cWdRerri0ND
 idoxphwyW9FbdSs8w6MTDgLMVli0Wfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759134722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bvs2oavNjSVaUUckUlOza9rx0E0NtK9gvVDOR8SHJaQ=;
 b=cQScN28JVej9Mpf79Za750E0GgyA2mLdBhsIAXbiNIoqgMNDEJanH4RyEI8h2g+gzUAo+y
 8Q5omf0PCpG+6TAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D1F913A21;
 Mon, 29 Sep 2025 08:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ca/KAQJE2mgsNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Sep 2025 08:32:02 +0000
Date: Mon, 29 Sep 2025 10:31:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250929083156.GA199802@pevik>
References: <20250917102737.GA336745@pevik>
 <aa769509-d4b8-46eb-b02d-699a573b0080@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa769509-d4b8-46eb-b02d-699a573b0080@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 5DC53314B6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] 'nobody' user for testing
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

> Hi Petr,

> On 9/17/25 12:27 PM, Petr Vorel wrote:
> > Hi,

> > I found a setup bug on LTP IMA tests ima_conditionals.sh and
> > ima_measurements.sh which use 'sudo' (with user 'nobody'). We have many C tests
> > in LTP which use 'nobody' user somehow, but they don't actually execute
> > anything with this account. IMHO these are the only tests which execute with 'sudo'
> > (please double check me).

> > $ git grep -l nobody testcases/kernel/syscalls/ | wc -l
> > 160

> > Because on newer systems (I checked Tumblewed, Fedora, Debian) 'nobody' account use
> > /usr/sbin/nologin which prevents logging, we 1) either need to change account
> > to use bash (and restore it back after testing) or 2) create a dedicated user
> > for testing. I'd try to use 'useradd' and check with grep /etc/passwd if the
> > user is not already defined.

> > I tend to use 2), add it only to IMA tests (to ima_setup.sh). But I could
> > put some more generic code to tst_test.sh so that it can be reused by other
> > tests in the future. WDYT?

> > Also, as we heavily use 'nobody' already I'm not sure if it's worth to bother
> > with putting environment variable allowing a different user. Nobody so far complained,
> > even AOSP folks seem to be used C tests which use 'nobody' (e.g. fchmod06.c is
> > compiled [1] and not disabled [2]).

> > Also, we agreed with Cyril, that it'd be good to convert these 2 IMA tests to
> > use 'su' instead of 'sudo' because 'su' is simpler than 'sudo' (although when
> > testing with rapido [3] none of them works out of the box).

> > [1] https://android.googlesource.com/platform/external/ltp/+/refs/heads/main/android/Android.bp
> > [2] https://android.googlesource.com/platform/external/ltp/+/refs/heads/main/android/tools/disabled_tests.txt
> > [3] https://github.com/rapido-linux/rapido
> As far as I understand, the ima_conditionals.sh and ima_measurements.sh
> tests are using sudo for creating a file from a specific user/group. This is
> already achieved in other tests such as dirtyc0w_shmem, where we spawn a new
> process, changing its current user/group to 'nobody' and executing a
> command.

> I don't know the internal sudo implementation, but I guess that's enough for
> the IMA tests, unless IMA testing suite wants to verify that sudo command is
> working properly within the IMA support.

> In short, I would re-implement those two tests in C to make it easy.

All tests use ima_setup.sh (more code than the test themselves) which needs to
be rewritten into C. And ideally rewrite all code at once, not having to
maintain helper implementations in both C and shell. i.e. bigger task than
simple pre-release fix.

Short term solution will be Jan's suggestion to write simple "sudo" binary or
even just let testers to fix the setup (i.e. fix it for us in openQA).

In a long term all shell tests will be either rewritten to C or
abandoned/removed (if not relevant). But because it's quite a lot of code in
helping libraries (e.g. for networking tests tst_net.sh) and we have still 248 C
API and 48 shell API legacy tests Cyril wrote shell loader (way to drop
implementing C API library functionality in shell API).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/CAASaF6yjdrLLVnehESx1TjsrB_z48nmN_2i585GPfkG3Vvg15Q@mail.gmail.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
