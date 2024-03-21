Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0422C54E68
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 04:47:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 073F33D0040
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 05:47:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC0513C06B8
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 05:46:58 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 37C2060226E
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 05:46:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6DEA35116;
 Thu, 21 Mar 2024 04:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710996414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L3u3avF79KxpnTy+nKBc/f95Q8nx8DVX2DFPpptUSa8=;
 b=23gwB9+vkjvwemnG3JtsHNxSkpiaTSBC3EEEI9yIEP3gbs++VGqlrl7NbT5Gf2820Oyt2W
 9po/s7qX6fa61RkvYP2Zrw+aCM8Hvdqx4P31lQkRoGOkzQvk0gnBUu0v3f5Teo7By8xQ3H
 IR//eP71xiaQ3z2h9K/BGhUzwX36byQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710996414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L3u3avF79KxpnTy+nKBc/f95Q8nx8DVX2DFPpptUSa8=;
 b=h0d0TfQcZLksRf1cZP62RBw74/pf97rDoiUe7sctEu5xcJnGy6UGHpXpAOagTSJAH9So+8
 mmRkC9j/TTY+eTAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710996414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L3u3avF79KxpnTy+nKBc/f95Q8nx8DVX2DFPpptUSa8=;
 b=23gwB9+vkjvwemnG3JtsHNxSkpiaTSBC3EEEI9yIEP3gbs++VGqlrl7NbT5Gf2820Oyt2W
 9po/s7qX6fa61RkvYP2Zrw+aCM8Hvdqx4P31lQkRoGOkzQvk0gnBUu0v3f5Teo7By8xQ3H
 IR//eP71xiaQ3z2h9K/BGhUzwX36byQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710996414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L3u3avF79KxpnTy+nKBc/f95Q8nx8DVX2DFPpptUSa8=;
 b=h0d0TfQcZLksRf1cZP62RBw74/pf97rDoiUe7sctEu5xcJnGy6UGHpXpAOagTSJAH9So+8
 mmRkC9j/TTY+eTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0401136AD;
 Thu, 21 Mar 2024 04:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yjf3Jb67+2VcMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 21 Mar 2024 04:46:54 +0000
Date: Thu, 21 Mar 2024 05:46:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240321044645.GB507984@pevik>
References: <20231227000430.30224-1-wegao@suse.com>
 <20231228025537.28807-1-wegao@suse.com>
 <2cc04819-1bd7-4f24-842d-cf686cda7fa7@suse.cz>
 <20240320074304.GC452876@pevik>
 <8798c323-8298-49b1-9950-09f2a7c309cb@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8798c323-8298-49b1-9950-09f2a7c309cb@suse.cz>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=23gwB9+v;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h0d0TfQc
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.55 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.04)[-0.188];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[42.16%]
X-Rspamd-Queue-Id: B6DEA35116
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] move_mount03: check allow to mount beneath top
 mount
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

> On 20. 03. 24 8:43, Petr Vorel wrote:
> > > On 28. 12. 23 3:55, Wei Gao via ltp wrote:
> > > > +static void cleanup(void)
> > > > +{
> > > > +	if (tst_is_mounted_at_tmpdir(DIRA))
> > > > +		SAFE_UMOUNT(DIRA);
> > > > +
> > > > +	if (tst_is_mounted_at_tmpdir(DIRB))
> > > > +		SAFE_UMOUNT(DIRB);

> > > I believe that DIRB may need to be unmounted twice here. Also please close
> > > fda and fdb here if they're still open.

> > What would do the second mount? move_mount() ?

> > There are SAFE_UMOUNT() in the end of the testing function, that's why usually
> > even these 2 SAFE_UMOUNT() aren't needed (but obviously we need to add them if
> > SAFE_TOUCH() or something quits testing early):

> > move_mount03.c:92: TPASS: move_mount(fda, "", fdb, "", MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH) passed
> > move_mount03.c:98: TPASS: access(DIRB "/B", F_OK) passed
> > move_mount03.c:99: TINFO: Umounting /tmp/LTP_movqeTZGu/LTP_DIR_B
> > move_mount03.c:100: TPASS: access(DIRB "/A", F_OK) passed
> > move_mount03.c:102: TINFO: Umounting /tmp/LTP_movqeTZGu/LTP_DIR_B
> > move_mount03.c:103: TINFO: Umounting /tmp/LTP_movqeTZGu/LTP_DIR_A
> > tst_device.c:442: TINFO: No device is mounted at /tmp/LTP_movqeTZGu/LTP_DIR_A
> > tst_device.c:442: TINFO: No device is mounted at /tmp/LTP_movqeTZGu/LTP_DIR_B

> Yes, open_tree() was called with OPEN_TREE_CLONE so after move_mount(), the
> mounts look like this:
> - tmpfs[1] at DIRA
> - tmpfs[1] at DIRB
> - tmpfs[2] at DIRB

> If either SAFE_CLOSE() immediately after move_mount() fails, cleanup() will
> unmount tmpfs[1] from DIRA and tmpfs[2] from DIRB but leave tmpfs[1] mounted
> at DIRB.

Correct. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
