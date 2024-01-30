Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D15C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 15:29:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B6FA3CF980
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 16:29:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17E783CE0F4
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 16:29:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5D06C1400F87
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 16:29:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 707F822117;
 Tue, 30 Jan 2024 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706628565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OL8Catcifx1NQpFR3MLaD2hPqDHNNdknpmQStsvvomc=;
 b=joOKmJcxgc6sh0K7AZog2t2okjmI7ZvsSoFg9zSnza3g5EbaCc8zb1XoiiFCimh+E8Pb5p
 qt+XQkTTg1SwUtTmefLImXh8GOvbZEcF4gkct9niSh4N8ynV9lDV7KGHTfBHYeNk0Jai76
 keXsb2lCIZ2+Po8CLLcDyE5VN4p1ouo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706628565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OL8Catcifx1NQpFR3MLaD2hPqDHNNdknpmQStsvvomc=;
 b=ia3u1k3y7BWb3rnoyM5QVN+5MnhE5ipIt4l4vAO/VPkLfcy9chSEvimBjtkEIvsl9h4nvD
 LGl0qY9nC3EwneCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706628563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OL8Catcifx1NQpFR3MLaD2hPqDHNNdknpmQStsvvomc=;
 b=ZzDSO7hc2ltpj0LtOSnVpM8bj+90QlEOQ2wM9NTxkGl1jMgluxAGOlIzy5lx3wOv5XQigi
 Jl2u/+L1sHznDsdZtpIbpwId9j2RwL19/yB+0EctUcufsKyxLqaHgZTsHexxy7TrFUSwaV
 0d+U7rZq2O78Fn2xONh5VgPqQBvk9Y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706628563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OL8Catcifx1NQpFR3MLaD2hPqDHNNdknpmQStsvvomc=;
 b=P4yVq0lo7VLe/YhFm9D1s+bGMaUjj/mZ6OA7q1K12nebvYP4SgghLXXChLzwfdT1oYihFi
 CGm1ECxnn8CtpmBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FE4912FF7;
 Tue, 30 Jan 2024 15:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2PuMFtMVuWVBeAAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 30 Jan 2024 15:29:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Jan 2024 16:29:23 +0100
Message-ID: <2945958.e9J7NaK4W3@localhost>
Organization: SUSE
In-Reply-To: <20240130131429.GA786076@pevik>
References: <20240129174647.635944-1-pvorel@suse.cz>
 <12395443.O9o76ZdvQC@localhost> <20240130131429.GA786076@pevik>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.33 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_ORG_HEADER(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.57)[81.17%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] README: Mention -f param for strace
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

On Tuesday, January 30, 2024 2:14:29 PM CET Petr Vorel wrote:
> Hi Avinesh,
> 
> > Hi Petr,
> > 
> > > -Debugging with gdb
> > > -==================
> > > +Debugging with gdb and strace
> > > +=============================
> > > 
> > >  The new test library runs the actual test, i.e. the `test()` function
> > >  in a
> > >  forked process. To get stack trace of a crashing test in gdb it's
> > >  needed to
> > > 
> > > [`set follow-fork-mode
> > > child`](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html).
> > > +To
> > > trace test with strace use `-f`.
> > 
> > For a second I thought ltp tests has `-f` option.
> > So maybe if we can make it absolutely clear, or maybe it is just me. :D
> 
> thanks for having a look!
> 
> There is currently no -f parameter, but sure, it could be in the future.
> ./fanotify01 -h # shows no -f parameter
> 
> ./fanotify01 -f
> ...
> tst_test.c:688: TBROK: Invalid option
> 
> But I meant '-f' as strace parameter, e.g.:
> 
> strace -f ./fanotify01
> 
> should I wrote this?
> 
> 	To trace test with strace use call strace with `-f` parameter.
yes, or maybe-
To trace the test with strace, use strace with `-f` option to enable tracing 
of forked processes also.

Thanks,
Avinesh
> 
> Kind regards,
> Petr





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
