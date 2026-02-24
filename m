Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD49EE9B262
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 13:40:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F1723D0F8E
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 14:40:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8B843C015D
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 14:40:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B2B21400BED
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 14:40:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 486623F240;
 Tue, 24 Feb 2026 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771940425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hFGstF6o2Vr+BlN0ifNTSbhhUtLoWhPiEcm5HEUKztY=;
 b=f/PcK9w3MOvEcfxTwaTK/SrgwBeaExUII6NR2XIRaJmhM9IMmV4SSRc2NeEuI9YoihyOns
 jtgPhvm51OO+2KOiC7ZY08FNIn4idtTIc7Plhe9Jm96iy7ZsrH7FQdMktFeSjkqpdP0c67
 VNJVQzXkRbZxt7eNPmUNa215hqXFYLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771940425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hFGstF6o2Vr+BlN0ifNTSbhhUtLoWhPiEcm5HEUKztY=;
 b=JLuK1TojFchW6LjJcvUXmAXiYAe1gTreE/2ahRVwxII7x1l6sDfh0/giQlT1NBAGJBQSXY
 j/Uk4ZYjGH4EXyAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="f/PcK9w3";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JLuK1Toj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771940425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hFGstF6o2Vr+BlN0ifNTSbhhUtLoWhPiEcm5HEUKztY=;
 b=f/PcK9w3MOvEcfxTwaTK/SrgwBeaExUII6NR2XIRaJmhM9IMmV4SSRc2NeEuI9YoihyOns
 jtgPhvm51OO+2KOiC7ZY08FNIn4idtTIc7Plhe9Jm96iy7ZsrH7FQdMktFeSjkqpdP0c67
 VNJVQzXkRbZxt7eNPmUNa215hqXFYLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771940425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hFGstF6o2Vr+BlN0ifNTSbhhUtLoWhPiEcm5HEUKztY=;
 b=JLuK1TojFchW6LjJcvUXmAXiYAe1gTreE/2ahRVwxII7x1l6sDfh0/giQlT1NBAGJBQSXY
 j/Uk4ZYjGH4EXyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 250113EA68;
 Tue, 24 Feb 2026 13:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2vRQCEmqnWlPFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 24 Feb 2026 13:40:25 +0000
Date: Tue, 24 Feb 2026 14:40:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260224134023.GB59724@pevik>
References: <20260220154742.54150-1-mdoucha@suse.cz>
 <20260220154742.54150-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260220154742.54150-3-mdoucha@suse.cz>
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
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 486623F240
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for fanotify monitoring of tracing
 filesystem
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
Cc: ppavlu@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

LGTM
Reviewed-by: Petr Vorel <pvorel@suse.cz>
...
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify25.c
...
> +#define MNTPOINT "/sys/kernel/tracing"
> +#define EVENTS_SYSFILE MNTPOINT "/kprobe_events"
> +
> +static const struct traceconfig {
> +	const char *filename;
> +	const char *wdata;
> +} trace_cmds[] = {
> +	{EVENTS_SYSFILE, "p:ltp_load_module_0 load_module"},
> +	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "1"},
> +	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "0"},
> +	{EVENTS_SYSFILE, "-:ltp_load_module_0"},
> +	{}
> +};
> +
> +static int fan_fd = -1;
> +static int unmount_needed;
> +
> +static void setup(void)
> +{
> +	if (tst_fs_type(MNTPOINT) != TST_TRACEFS_MAGIC) {
> +		SAFE_MOUNT("tracefs", MNTPOINT, "tracefs",
> +			MS_NODEV | MS_NOEXEC | MS_NOSUID, NULL);

I see possible mounting is the reason...

> +		unmount_needed = 1;
> +	}
> +
> +	if (access(EVENTS_SYSFILE, F_OK))
> +		tst_brk(TCONF, "Kprobe events not supported by kernel");

... why we cannot check /sys/kernel/tracing/kprobe_events presence via
.save_restore.

> +
> +	fan_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK, O_RDONLY);
> +	SAFE_FANOTIFY_MARK(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT, FAN_MODIFY,
> +		-1, MNTPOINT);
> +}
> +
> +static void do_child(void)
> +{
> +	int i, fd, events, ret;
> +	pid_t pid = getpid();
> +	struct fanotify_event_metadata buf;
> +
> +	for (i = 0, events = 0; trace_cmds[i].filename; i++) {
> +		fd = SAFE_OPEN(trace_cmds[i].filename, O_WRONLY, 0644);
> +		SAFE_WRITE(1, fd, trace_cmds[i].wdata,
> +			strlen(trace_cmds[i].wdata));
> +		SAFE_CLOSE(fd);
> +
> +		while ((ret = read(fan_fd, &buf, sizeof(buf))) > 0) {
> +			if (buf.pid != pid)
> +				continue;
> +
> +			if (!(buf.mask & FAN_MODIFY)) {
> +				tst_res(TFAIL, "Unexpected event %llx",
> +					buf.mask);
> +				continue;
> +			}
> +
> +			events++;
> +		}
> +
> +		if (ret < 0 && errno != EAGAIN)
> +			tst_res(TFAIL | TERRNO, "fanotify read() failed");
> +	}
> +
> +	if (events == i)
> +		tst_res(TPASS, "Received %d events", events);
> +	else
> +		tst_res(TFAIL, "Received %d events, expected %d", events, i);
> +}
OT: I guess we miss optional string arg for TST_EXP_EQ_*() macros to be usable.

> +
> +static void run(void)
> +{
> +	/*
> +	 * Fork a child to do the actual trace writes, otherwise tracefs
> +	 * would be busy until the current process exits and it would become
> +	 * impossible to unmount in cleanup().
> +	 */
+1

Kind regards,
Petr

> +	if (!SAFE_FORK()) {
> +		do_child();
> +		SAFE_CLOSE(fan_fd);
> +		exit(0);
> +	}
> +}
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
