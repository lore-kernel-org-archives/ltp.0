Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC37ECAAD5
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 17:02:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A24C33CA995
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 19:01:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62F973C06D3
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 19:01:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C0A6140024C
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 19:01:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EB9033985;
 Tue,  6 Sep 2022 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662483705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wAa6Ngx9AA6ODtrdQW1CTuh/ehJ9Or1Xj4Hg/kPrmNA=;
 b=eSehJreRfOFJGHIbNXcAk4PoD4Cx8c5BT4n3aB70LiTowELtV1f5V2bMTWEfjI9kzlX8IW
 rtb+wIaD8dNv70NJ2cATBOOchgKDlyjIxKVMpLY017uPrJrjemhIJAS6twB74YYQgwe/rj
 gBjdc/RJGtheGJLwYIU7TkSn6bYjK/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662483705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wAa6Ngx9AA6ODtrdQW1CTuh/ehJ9Or1Xj4Hg/kPrmNA=;
 b=tHl2/K+KiPmR0w8syyvZbTxC6Buyx8YPF7riBcNDwJrwz+YqNJT6ziG3LvkQkYyOj7nKlX
 o8a81EPxXxIqaeAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 265A513A7A;
 Tue,  6 Sep 2022 17:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pW1MBvl8F2MFRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 17:01:45 +0000
Date: Tue, 6 Sep 2022 19:01:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Yxd89vLt8IBluyoI@pevik>
References: <20220905154239.2652169-1-amir73il@gmail.com>
 <20220905154239.2652169-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220905154239.2652169-6-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/9] syscalls/fanotify10: Add more verifications
 and debug info
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, all,

> Check that non-evictable inode ignore marks exist as expected
> and print mask of unexpected events.

> Fix information printed for events from unexpected pid.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
...
> @@ -582,14 +591,18 @@ static void test_fanotify(unsigned int n)
>  	for (p = 1; p < num_classes && !tc->expected_mask_with_ignore; p++) {
>  		for (i = 0; i < GROUPS_PER_PRIO; i++) {
>  			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
> -			if (ret == 0) {
> +			if (ret >= 0 && ret < (int)FAN_EVENT_METADATA_LEN) {
>  				tst_brk(TBROK,
> -					"zero length read from fanotify fd");
> +					"short read when reading fanotify "
> +					"events (%d < %d)", ret,
> +					(int)EVENT_BUF_LEN);
Just for the record printing like this...

>  			}
> +			event = (struct fanotify_event_metadata *)event_buf;
>  			if (ret > 0) {
>  				tst_res(TFAIL, "group %d (%x) with %s and "
> -					"%s ignore mask got event",
> -					i, fanotify_class[p], mark->name, ignore_mark->name);
> +					"%s ignore mask got unexpected event (mask %llx)",
> +					i, fanotify_class[p], mark->name, ignore_mark->name,
> +					event->mask);
and this will be possible to avoid with macros include/tst_test_macros.h,
which prints them for free. FYI there can be also custom error text instead
of the failing syscall with parameters printed by default. But IMHO there should
be a reason to use it (mostly the default should be good enough, in case of
failure test reviewers will have to look into the test source anyway).

Kind regards,
Petr

>  				if (event->fd != FAN_NOFD)
>  					SAFE_CLOSE(event->fd);
>  			} else if (errno == EAGAIN) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
