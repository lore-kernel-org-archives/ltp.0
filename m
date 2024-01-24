Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF164C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 21:07:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A2E53CFB39
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 22:07:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85AC73C5D1E
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 22:07:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BC0601000BD4
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 22:07:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 774101FD85;
 Wed, 24 Jan 2024 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706130460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJlN+UTDIEQ6+eaqc7+8C81gK2cUGa2ixRad25rlMX0=;
 b=bhlaR2YfxB7uY2qDCArefuiHcH7mMFEfJlnP32LbHYgZ5HNmR0xr14LsJSeVq9fsi2Naoz
 7gAkO2Zrp95ev5eXzFbUECiLW/QnPiJH6+P1B0mZIge7f5kP2M2YaPd6jt7JOzthXnex0H
 BqPUa+zxlbqn2t0ZDp0OqaCTtg2Uwks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706130460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJlN+UTDIEQ6+eaqc7+8C81gK2cUGa2ixRad25rlMX0=;
 b=IW/ecCj47EDOsBR5afQ28U83EFPkaC9NbkePVxVBnRGgxpZZXuDT3j2fly/bqBx3hf4wno
 xUYBfSWWxl3edTBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706130460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJlN+UTDIEQ6+eaqc7+8C81gK2cUGa2ixRad25rlMX0=;
 b=bhlaR2YfxB7uY2qDCArefuiHcH7mMFEfJlnP32LbHYgZ5HNmR0xr14LsJSeVq9fsi2Naoz
 7gAkO2Zrp95ev5eXzFbUECiLW/QnPiJH6+P1B0mZIge7f5kP2M2YaPd6jt7JOzthXnex0H
 BqPUa+zxlbqn2t0ZDp0OqaCTtg2Uwks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706130460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJlN+UTDIEQ6+eaqc7+8C81gK2cUGa2ixRad25rlMX0=;
 b=IW/ecCj47EDOsBR5afQ28U83EFPkaC9NbkePVxVBnRGgxpZZXuDT3j2fly/bqBx3hf4wno
 xUYBfSWWxl3edTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09E0F13786;
 Wed, 24 Jan 2024 21:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LQSyORt8sWXZdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 21:07:39 +0000
Date: Wed, 24 Jan 2024 22:07:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Thomas Bertschinger <tahbertschinger@gmail.com>
Message-ID: <20240124210738.GA352616@pevik>
References: <20240124200032.GA343522@pevik>
 <20240124205149.GA268968@fedora-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240124205149.GA268968@fedora-laptop>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.08 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.58)[81.45%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] bcachefs fails to mount loop device on kernel
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
Cc: linux-bcachefs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, Jan 24, 2024 at 09:00:32PM +0100, Petr Vorel wrote:
> > Hi all,

> > bcachefs fails to mount loop device on kernel on both 6.7 and 6.8.0-rc1.
> > Is mounting loop even supported?

> > [...]

> > bcachefs mount /dev/loop0 /mnt
> > => Unknown command mount

> What version of the bcachefs CLI tool are you using? Is it distribution
> provided or did you build it yourself?

Official openSUSE Tumbleweed package:

$ rpm -qf $(which bcachefs)
bcachefs-tools-1.4.0-1.1.x86_64

BTW this was found with LTP, which has 2 APIs: C API, which uses mount(2)
which works well and shell API which uses mount (which uses bcachefs) and here
it fails.

Kind regards,
Petr

> The mount command has been implemented in Rust for a while (since
> 28f703cc256f "Rust now integrated into bcachefs binary") and if building
> without Rust support (BCACHEFS_NO_RUST defined), that command won't be
> included in the binary.

> In more recent versions of bcachefs-tools, building without Rust is not
> supported at all.

> I don't think this has anything to do with loop devices specifically.

> - Thomas Bertschinger

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
