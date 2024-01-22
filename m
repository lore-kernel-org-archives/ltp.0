Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A06C4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 09:14:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A0723CE227
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 10:14:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C1063C9978
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:14:00 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5AC56200D0E
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:13:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C0801FBAE;
 Mon, 22 Jan 2024 09:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705914839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2077kBr+SbS0+UgXVEhfnrk+5geOUWZulQldKmRWrfI=;
 b=aYAqSUYz8DUzYGEWqzLFqUl3yuiU3o5AegTjltDgMfmoJoyM007hWrstXva/04GcDlLvOm
 NTE+fFyT9h4FWrIEN5mH9wAOF6R1T0QoJetAi+DD/gVI6KYof0sBzrGknubNM2yLLNep8Q
 HU5O1FiVwVvS9f7IcXmlaPDRCufX66M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705914839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2077kBr+SbS0+UgXVEhfnrk+5geOUWZulQldKmRWrfI=;
 b=LCsAjkUoP2Gv9H/RtxGuHFSprMb/zmuKm4Md2XGrdVbNm4Kr2IQcMG27ryjHOZeMT+V10t
 rGT0k3efCMwp7RBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705914838;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2077kBr+SbS0+UgXVEhfnrk+5geOUWZulQldKmRWrfI=;
 b=cVddwd6uvnPmVdTaDlneRHHy8tzPxXcZbUz/y2j3gRf/SiqKKpz+MZTpyk6U0dZzf543U1
 yqiO/dx3bMu2B3g/GNj2Rw5gXlyfQwwxyBPYYGQrEssHMOxbInibg6fBh/DylrDXAHn5km
 zpmDWDPVtIiZhjupkpIiTjfhlLgGek8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705914838;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2077kBr+SbS0+UgXVEhfnrk+5geOUWZulQldKmRWrfI=;
 b=NJcbIYYWhruUwncgOrQlTIy/9vjKj+bop6YaoCun3JHplJ316rIkzeAC+DNuXHE+xaJ0uh
 y00ZGYnDczaD9UDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 003BB13995;
 Mon, 22 Jan 2024 09:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pIy6OtUxrmV2bAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 09:13:57 +0000
Date: Mon, 22 Jan 2024 10:13:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240122091356.GF76754@pevik>
References: <20240122072948.2568801-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240122072948.2568801-1-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

Hi Li,

> This introduce an enhancement to the library's is_swap_supported
> function to check for filesystem compatibility before attempting
> to create and enable a swap file.  A list of supported filesystems
> is added (ext2, ext3, ext4, xfs, vfat, exfat, ntfs), and a check
> against this list is performed to ensure that the swap operations
> are only attempted on known compatible filesystems.

> If the make_swapfile function fails, the error handling is now
> more descriptive: it distinguishes between failures due to the
> filesystem not supporting swap files and other types of failures.
> Similarly, when attempting to enable the swap file with swapon,
> the patch ensures that clearer error messages are provided in
> cases where the operation is not supported by the filesystem.

+1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

formatting issues (tabs) are actually mostly from this commit, please fix them
before merge.

libswap.c:40: WARNING: Missing a blank line after declarations
libswap.c:66: WARNING: please, no spaces at the start of a line
libswap.c:67: WARNING: Missing a blank line after declarations
libswap.c:67: WARNING: please, no spaces at the start of a line
libswap.c:67: WARNING: suspect code indent for conditional statements (7, 15)
libswap.c:68: ERROR: code indent should use tabs where possible
libswap.c:68: WARNING: please, no spaces at the start of a line
libswap.c:68: WARNING: suspect code indent for conditional statements (15, 23)
libswap.c:69: ERROR: code indent should use tabs where possible
libswap.c:69: WARNING: please, no spaces at the start of a line
libswap.c:70: ERROR: code indent should use tabs where possible
libswap.c:70: WARNING: please, no spaces at the start of a line
libswap.c:70: WARNING: suspect code indent for conditional statements (15, 23)
libswap.c:71: ERROR: code indent should use tabs where possible
libswap.c:71: WARNING: please, no spaces at the start of a line
libswap.c:72: WARNING: please, no spaces at the start of a line

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
