Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F173DC3DA4A
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 10:32:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6895F3D20C7
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 12:32:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9952F3D1BF1
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 12:32:03 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22FA260712F
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 12:32:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 865D621EA2;
 Fri,  9 Aug 2024 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723199521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rrf/+u96x5Vc/xIw21yAxwRrPW1GLm57VTQWS2MaTSk=;
 b=oMDW6xr2BfprQost7/A3xjNfIKcv7SKpma+mq4ciaM5sKk983bBDFvBuFqv+RwQfMf383E
 aJV1I69/GXHEZv29YSmixgc2DF1AaPk/wyQnKSZBrLZNoHCKPZYgte1Alf6yMMLbKVBvF7
 9lkjP9SVxyDvYW8fi+AyVqCEMQwV+2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723199521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rrf/+u96x5Vc/xIw21yAxwRrPW1GLm57VTQWS2MaTSk=;
 b=nVVJXOE2H8fG9QnAp2gsVea8fazni2uvd8W6E2doNb3hytnCczTzZCbvKnJ0uDS2tikfZU
 UouGHBlJ1cnOQ8Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723199521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rrf/+u96x5Vc/xIw21yAxwRrPW1GLm57VTQWS2MaTSk=;
 b=oMDW6xr2BfprQost7/A3xjNfIKcv7SKpma+mq4ciaM5sKk983bBDFvBuFqv+RwQfMf383E
 aJV1I69/GXHEZv29YSmixgc2DF1AaPk/wyQnKSZBrLZNoHCKPZYgte1Alf6yMMLbKVBvF7
 9lkjP9SVxyDvYW8fi+AyVqCEMQwV+2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723199521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rrf/+u96x5Vc/xIw21yAxwRrPW1GLm57VTQWS2MaTSk=;
 b=nVVJXOE2H8fG9QnAp2gsVea8fazni2uvd8W6E2doNb3hytnCczTzZCbvKnJ0uDS2tikfZU
 UouGHBlJ1cnOQ8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FC711379A;
 Fri,  9 Aug 2024 10:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o6Y8CSHwtWbPSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Aug 2024 10:32:01 +0000
Date: Fri, 9 Aug 2024 12:31:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>
Message-ID: <20240809103155.GA352642@pevik>
References: <20240809073010.793324-1-maxj.fnst@fujitsu.com>
 <20240809084527.GA337675@pevik>
 <TY3PR01MB120713856F5B63EA95B6376C8E8BA2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TY3PR01MB120713856F5B63EA95B6376C8E8BA2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-0.50 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,imap1.dmz-prg2.suse.org:helo,cgroup_fj_function.sh:url];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cgroup_fj_common.sh: Do not disable systemd
 related cgroup subsystems
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi Ma,

> > > The cpu, io, memory, and pids subsystems under the root cgroup cannot
> > > be disabled because they are used for systemd. Currently, the test of
> > > cpu and memory subsystems in cgroup_fj_function.sh and
> > > cgroup_fj_stress.sh will report the error
> > > "echo: write error: device or resource busy".

> > Could you please share a bit of info on which system it fails. Do you use cgroup
> > v1?

> Hi Petr

> It fails on Fedora 37 which uses cgroupv2.
> cgroupv1 won't trigger this failure.

OK, thx for info, merged!

I managed to reproduce the same issue also on Debian trixie or some Alpine
(which don't use systemd).  I still wonder what could be the root cause, because
many other systemd based systems have no problem (various SLES versions and
openSUSE Tumbleweed).

Kind regards,
Petr

> > Kind regards,
> > Petr

> > > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > > Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> > > ---
> > >  .../kernel/controllers/cgroup_fj/cgroup_fj_common.sh      | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)

> > > diff --git
> > > a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > > b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > > index e866641ba..153d351d7 100755
> > > --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > > +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > > @@ -77,7 +77,13 @@ common_cleanup()

> > >      cgroup_cleanup

> > > -    [ "$cgroup_version" = "2" ] && ROD echo "-$subsystem" \>
> > "/sys/fs/cgroup/cgroup.subtree_control"
> > > +    if [ "$cgroup_version" = "2" ]; then
> > > +        case "$subsystem" in
> > > +        cpu|io|memory|pids)
> > > +            :;;
> > > +        *) ROD echo "-$subsystem" \>
> > "/sys/fs/cgroup/cgroup.subtree_control";;
> > > +        esac
> > > +    fi
> > >  }

> > >  . cgroup_lib.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
