Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64802C87FC9
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 11:33:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B70333CB341
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 13:33:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ECE03C3270
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 13:32:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCAFE1000785
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 13:32:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C572321962;
 Wed, 30 Jul 2025 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753875165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9RsBuJe7/4ihQ498ZAUH64vn3k3Q1HKVRoCStGGFyc=;
 b=vU2KcdCHdRZt0WrLlF8PSwTU7ac0/tAOdV90v0o4+yqs1nNqeuzEwmZtsamRqj027p7sbH
 RlZ9JUtxxkAodxH1Nzpb3jeufwTRHgcNX0mroKBvpFwkfuXeFq6f4awJDv9zpLriUEJVSC
 brRUzbm6rN17jf/gcD4LrDxK/PsuTzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753875165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9RsBuJe7/4ihQ498ZAUH64vn3k3Q1HKVRoCStGGFyc=;
 b=3dmpoeNtMTENKI12kZY3Oa8A8CmaZrHAV4BFVwNxwkNkL2pEQhEajpoZnuUIrCJu4h3ZbF
 W2d7OZe/9CuwBKBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vU2KcdCH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3dmpoeNt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753875165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9RsBuJe7/4ihQ498ZAUH64vn3k3Q1HKVRoCStGGFyc=;
 b=vU2KcdCHdRZt0WrLlF8PSwTU7ac0/tAOdV90v0o4+yqs1nNqeuzEwmZtsamRqj027p7sbH
 RlZ9JUtxxkAodxH1Nzpb3jeufwTRHgcNX0mroKBvpFwkfuXeFq6f4awJDv9zpLriUEJVSC
 brRUzbm6rN17jf/gcD4LrDxK/PsuTzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753875165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9RsBuJe7/4ihQ498ZAUH64vn3k3Q1HKVRoCStGGFyc=;
 b=3dmpoeNtMTENKI12kZY3Oa8A8CmaZrHAV4BFVwNxwkNkL2pEQhEajpoZnuUIrCJu4h3ZbF
 W2d7OZe/9CuwBKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A475313942;
 Wed, 30 Jul 2025 11:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3TA7J90CimjMEwAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 30 Jul 2025 11:32:45 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Wed, 30 Jul 2025 13:32:45 +0200
Message-ID: <9489066.CDJkKcVGEf@thinkpad>
In-Reply-To: <a019aba3-eaa1-4dd9-973b-c4bb8f3d4973@suse.com>
References: <20250710082000.11641-1-akumar@suse.de>
 <svs6pl6jmibp7uylvofkia5smvu2cuezfvnawlgkmjiulbrpfm@w7s7dlxxltap>
 <a019aba3-eaa1-4dd9-973b-c4bb8f3d4973@suse.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C572321962
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_regression_test: Use unique names for
 hierarchies in each test
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all=B8

I would like to ask if there are any other suggestions on how to address th=
is
issue.
I tried a rather simpler approach (as suggested by Martin) of just adding a
delay using sleep after the umount call, which also seems to solve this iss=
ue
of incomplete unmounting.

--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -102,10 +102,11 @@ test1()
        cat cgroup/tasks > /dev/null
 =

        kill -TERM $!
        wait $! 2>/dev/null
        umount cgroup/
+       sleep 2
        check_kernel_bug
 }

I will send this in the patch if we agree to use this approach instead of
unique names.

Thanks,
Avinesh

On Monday, July 14, 2025 1:56:51 PM CEST Andrea Cervesato wrote:
> On 7/11/25 3:15 PM, Michal Koutn=FD wrote:
> > On Fri, Jul 11, 2025 at 02:41:18PM +0200, Andrea Cervesato <andrea.cerv=
esato@suse.com> wrote:
> >> This git commit is part of cgroup v1 code and now in
> >> kernel/cgroup/cgroup-v1.c:cgroup1_root_to_use, but I don't see the same
> >> mechanism used by cgroup v2, which is our main version.
> > The patched tests use cgroup v1.
> >
> >> Is that something which might affect our system?
> > Since there's only one cgroup v2 (unified) hierarchy, it sort of lives
> > forever (statically alloc'd), so I wouldn't expect such residuals on v2
> > (with the current implementation).
> >
> > Michal
> =

> I bisected util-linux, but it doesn't seem to be the problem. On my =

> system (Tumbleweed), we are facing the same failure, no matter the =

> commit that is tested in util-linux between 2.39 and 2.41 versions.
> =

> I guess this issue might be caused by a specific setup of the Linux =

> kernel and its async nature, mixed with some services which are slowing =

> down the umount process.
> =

> I'm wondering how to proceed, since this is actually a soft-failure and =

> any fix to the test might hide future bugs.
> =

> - Andrea
> =

> =







-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
