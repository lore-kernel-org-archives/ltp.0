Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D38C47077
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 16:28:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5A5C3CFCFC
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 17:28:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E8653CE322
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 17:28:25 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 472F91A0118F
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 17:28:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16F131FD55;
 Tue, 16 Jan 2024 16:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705422504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzPDXQnyp5kZLcD2jWFF36C1Wb2OHW5oXkuQRsmSqm0=;
 b=06Gq1fSL7QAgwntFp1iGHVEJaRak4r8HqSNSVDTr2NzvsxTiibSebw9cqk/lLA6oD7+BPb
 mYQW7eWkbbq9wBDvR2L2ajLe9z4fu/7z3kDew1Uw//o89iplrrx2pVZyzjPP7vfMPgEM7x
 i63Offq1hHwAY3gJldu92JP8n0/c+ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705422504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzPDXQnyp5kZLcD2jWFF36C1Wb2OHW5oXkuQRsmSqm0=;
 b=YdsfniFuaR8toE7IWK6yET6LOJ2599PsFsTwa/h07q1dDtvaL6EvXmZHQdr706N6aP+x+L
 Pax1PXzhrwRK3wAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705422504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzPDXQnyp5kZLcD2jWFF36C1Wb2OHW5oXkuQRsmSqm0=;
 b=06Gq1fSL7QAgwntFp1iGHVEJaRak4r8HqSNSVDTr2NzvsxTiibSebw9cqk/lLA6oD7+BPb
 mYQW7eWkbbq9wBDvR2L2ajLe9z4fu/7z3kDew1Uw//o89iplrrx2pVZyzjPP7vfMPgEM7x
 i63Offq1hHwAY3gJldu92JP8n0/c+ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705422504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzPDXQnyp5kZLcD2jWFF36C1Wb2OHW5oXkuQRsmSqm0=;
 b=YdsfniFuaR8toE7IWK6yET6LOJ2599PsFsTwa/h07q1dDtvaL6EvXmZHQdr706N6aP+x+L
 Pax1PXzhrwRK3wAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5032132FA;
 Tue, 16 Jan 2024 16:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sBNeNaeupmUJIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Jan 2024 16:28:23 +0000
Date: Tue, 16 Jan 2024 17:28:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Message-ID: <20240116162822.GB2606232@pevik>
References: <20240115155936.3235-1-subramanya.swamy.linux@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240115155936.3235-1-subramanya.swamy.linux@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.44 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.14)[-0.681]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] isofs.sh:Use genisoimage/xorrisofs instead of
 mkisofs
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

Hi Subramanya,

> Debain uses genisoimage/xorrisofs and Centos uses xorrisofs
> both genisoimage & xorrisofs have symlinks to mkisofs
> xorrisofs doesn't support -hfs option & supports only -hfsplus option
> genisoimage supports both -hfs & -hfsplus options

Well, there are 3 tools (although not all in all distros):

* Debian
for i in mkisofs genisoimage xorriso; do echo "=== $i ==="; $i; echo; done
=== mkisofs ===
genisoimage: Missing pathspec.
Usage: genisoimage [options] -o file directory ...

Use genisoimage -help
to get a list of valid options.

Report problems to debburn-devel@lists.alioth.debian.org.

=== genisoimage ===
genisoimage: Missing pathspec.
Usage: genisoimage [options] -o file directory ...

Use genisoimage -help
to get a list of valid options.

Report problems to debburn-devel@lists.alioth.debian.org.

=== xorriso ===
xorriso 1.5.2 : RockRidge filesystem manipulator, libburnia project.

usage : xorriso [commands]
        More is told by command -help
=> Debian has genisoimage and xorriso

* openSUSE Tumbleweed

$ for i in mkisofs genisoimage xorriso; do echo "=== $i ==="; $i; echo; done
=== mkisofs ===
mkisofs: Missing pathspec.
Usage: mkisofs [options] [-find] file... [find expression]

Use mkisofs -help
to get a list all of valid options.

Use mkisofs -find -help
to get a list of all valid -find options.

Most important Options:
	-posix-H		Follow sylinks encountered on command line
	-posix-L		Follow all symlinks
	-posix-P		Do not follow symlinks (default)
	-o FILE, -output FILE	Set output file name
	-R, -rock		Generate Rock Ridge directory information
	-r, -rational-rock	Generate rationalized Rock Ridge directory info
	-J, -joliet		Generate Joliet directory information
	-print-size		Print estimated filesystem size and exit
	-UDF			Generate UDF file system
	-dvd-audio		Generate DVD-Audio compliant UDF file system
	-dvd-video		Generate DVD-Video compliant UDF file system
	-dvd-hybrid		Generate a hybrid (DVD-Audio/DVD-Video) compliant UDF file system
	-iso-level LEVEL	Set ISO9660 level (1..3) or 4 for ISO9660 v 2
	-V ID, -volid ID	Set Volume ID
	-graft-points		Allow to use graft points for filenames
	-M FILE, -prev-session FILE	Set path to previous session to merge

=== genisoimage ===
 genisoimage: command not found

=== xorriso ===
xorriso 1.5.6 : RockRidge filesystem manipulator, libburnia project.

usage : xorriso [commands]
        More is told by command -help

=> openSUSE Tumbleweed has mkisofs and xorriso (genisoimage is not officially
supported)

How about to run test 3x - for mkisofs, genisoimage and xorriso. There would be
TCONF when file does not exist. And also detection if the binary is the expected
one? Something like this:

TST_TESTFUNC=do_test
TST_CNT=3

do_test()
{
	case $1 in
	1) MKISOFS_CMD="mkisofs";;
	2) MKISOFS_CMD="genisoimage"
	   HFSOPT="-hfsplus -D -hfs -D";;
	3) MKISOFS_CMD="xorriso"
	   HFSOPT="-hfsplus -D";;
	esac

	if ! tst_cmd_available $MKISOFS_CMD; then
		tst_res TCONF "Missing '$MKISOFS_CMD'"
		return
	fi

	if ! $CMD 2>&1 | grep -q "$MKISOFS_CMD"; then
		tst_res TCONF "'$MKISOFS_CMD' is a symlink to another tool"
		return
	fi

	... (rest of original do_test + $HFSOPT use)
}

Does it make sense to you?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
