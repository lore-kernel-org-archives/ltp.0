Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A34DC021AA
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 14:17:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 990723C9CCB
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 15:17:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D6F13C9B25
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 15:17:32 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3D4661BBEDCA
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 15:17:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A69C2117A;
 Mon, 17 Feb 2025 14:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739801819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FyH6MgOrI33T9tqzhNUP8IDVNVE6z/Mq6p7Wp4VQNg=;
 b=jU/PaiYIV+uW9isVI+P0qTLXado2e0lrNWy/N6T9TGs2jdFAqgMrcISItcduAuERSlfSBD
 tvO/yfFGKv0RNDa4rJ3auR9/MAJdmIJ2KvJkJJkCzBNbYoUKux4LyehM9pp/5TH1RuLlyg
 3YEfT+KyAR5+r8NoH3n7wGN0eLSqiN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739801819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FyH6MgOrI33T9tqzhNUP8IDVNVE6z/Mq6p7Wp4VQNg=;
 b=FlzhB1cb8UsZMukypwt/PgWNnppe25XWxLdqHiXS+rUYSggyFognWXkEcPhTaxFQveYc5f
 9bVQoaxJ60B3NTAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739801819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FyH6MgOrI33T9tqzhNUP8IDVNVE6z/Mq6p7Wp4VQNg=;
 b=jU/PaiYIV+uW9isVI+P0qTLXado2e0lrNWy/N6T9TGs2jdFAqgMrcISItcduAuERSlfSBD
 tvO/yfFGKv0RNDa4rJ3auR9/MAJdmIJ2KvJkJJkCzBNbYoUKux4LyehM9pp/5TH1RuLlyg
 3YEfT+KyAR5+r8NoH3n7wGN0eLSqiN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739801819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FyH6MgOrI33T9tqzhNUP8IDVNVE6z/Mq6p7Wp4VQNg=;
 b=FlzhB1cb8UsZMukypwt/PgWNnppe25XWxLdqHiXS+rUYSggyFognWXkEcPhTaxFQveYc5f
 9bVQoaxJ60B3NTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDAEE133F9;
 Mon, 17 Feb 2025 14:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0NnlMdpEs2dTIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 14:16:58 +0000
Date: Mon, 17 Feb 2025 15:16:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250217141652.GB2397156@pevik>
References: <20250217130839.2392666-1-pvorel@suse.cz>
 <20250217130839.2392666-2-pvorel@suse.cz>
 <ea6764ea-db92-4f49-ba5a-650f62bcfa23@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea6764ea-db92-4f49-ba5a-650f62bcfa23@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ima_selinux.sh: Detect SELinux before loading
 policy
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi!

> On 2/17/25 14:08, Petr Vorel wrote:
> > Adding TST_SETUP_EARLY to run test specific setup before loading policy.
> > That allows to avoid loading IMA policy (which usually request reboot)
> > if the test would be skipped anyway.

> > Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 3 ++-
> >   testcases/kernel/security/integrity/ima/tests/ima_setup.sh   | 2 ++
> >   2 files changed, 4 insertions(+), 1 deletion(-)

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > index 97c5d64ec5..577f7c2aca 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > @@ -13,9 +13,10 @@
> >   TST_NEEDS_CMDS="awk cut grep tail"
> >   TST_CNT=2
> > -TST_SETUP="setup"
> >   TST_MIN_KVER="5.12"
> > +TST_SETUP_EARLY="setup"
> > +
> >   REQUIRED_POLICY_CONTENT='selinux.policy'
> >   setup()
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > index 1f1c267c4b..2a9f64978e 100644
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -265,6 +265,8 @@ ima_setup()
> >   		cd "$TST_MNTPOINT"
> >   	fi
> > +	[ -n "$TST_SETUP_EARLY" ] && $TST_SETUP_EARLY
> > +
> Why not doing ". ima_setup.sh" at the end of setup() ?

I do not understand what you mean. How would it help?

Also since 04021637f4 ("tst_test.sh: Cleanup getopts usage")
shell library is required to be run at the end of a shell test,
just before tst_run.

FYI at least for some tests (these with $REQUIRED_BUILTIN_POLICY, e.g.
evm_overlay.sh) it makes sense to check /proc/cmdline content (e.g. run
load_ima_policy()) before the test specific setup to quit early enough. But OTOH
it's best to postpone loading the policy after other checks are done (e.g. here
check for SELinux), because loading policy often requires reboot. Maybe best
would be to do $REQUIRED_BUILTIN_POLICY check *before running the setup and
keep loading the policy *after* the setup. Maybe I should postpone loading
(see the diff below).

Kind regards,
Petr

> >   	if ! verify_ima_policy; then
> >   		load_ima_policy
> >   	fi
> Andrea

diff --git testcases/kernel/security/integrity/ima/tests/ima_selinux.sh testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index c8eb80b641..97c5d64ec5 100755
--- testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -13,10 +13,9 @@
 
 TST_NEEDS_CMDS="awk cut grep tail"
 TST_CNT=2
+TST_SETUP="setup"
 TST_MIN_KVER="5.12"
 
-IMA_SETUP_EARLY="setup"
-
 REQUIRED_POLICY_CONTENT='selinux.policy'
 
 setup()
diff --git testcases/kernel/security/integrity/ima/tests/ima_setup.sh testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index befaf7f73c..f7ec5aeb35 100644
--- testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -245,6 +245,8 @@ load_ima_policy()
 
 ima_setup()
 {
+	local load_policy
+
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
 
 	IMA_DIR="$SECURITYFS/ima"
@@ -265,13 +267,15 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
-	[ -n "$IMA_SETUP_EARLY" ] && $IMA_SETUP_EARLY
+	verify_ima_policy
+	load_policy=$?
+
+	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 
-	if ! verify_ima_policy; then
+	if [ $load_policy -ne 0 ]; then
 		load_ima_policy
 	fi
 
-	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
 ima_cleanup()

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
