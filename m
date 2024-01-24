Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2342AC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 16:02:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 927233CFA8C
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 17:02:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D7283CCC5B
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 17:02:00 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3847A1401649
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 17:01:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8FEE1FD6A;
 Wed, 24 Jan 2024 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706112118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eH+g8MwcGid3F2OTpofjznQb7DQk30vv/rcMI/MuLlw=;
 b=CUGpEM4lEXfU+k5qF3f8rasx8d4ht57U7UomPMHQbPWgRDatBLuUMj9VvrL+JoaVE5mXGF
 GgTbyzVSZH6IwR4M97H9GY8BHSdqS90fo56+ySp7sh+JYoXkefK9QdZZPtCOuXE5vImOv0
 I1UNSMNzjWtUI78n1JfJAAlVLDCXm/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706112118;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eH+g8MwcGid3F2OTpofjznQb7DQk30vv/rcMI/MuLlw=;
 b=akayFNNnFTuClo7h+YXBLMoOCSwLQtYMf+OH7Iw6Po94pr4ELQrFNVBzrzXUmM4a9Gb/VN
 Gta3D0mA4PjmjwAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706112117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eH+g8MwcGid3F2OTpofjznQb7DQk30vv/rcMI/MuLlw=;
 b=VUApYnbSmb+Tu6Ib1LEJOkmv4A6YFlDoZAdYG3ARq4wOpdr1iWLxZdhQRflHARLzRSFVQn
 bcPlY5AcGJJ5Paeb4fOgKzrvsDa+Wmmm5v2mlSvdthx8YfHN80UJZEMo6aLNlI3lTKiVy1
 LEpcovKWKQLZD0zko5Jmr/7MxClwd/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706112117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eH+g8MwcGid3F2OTpofjznQb7DQk30vv/rcMI/MuLlw=;
 b=VyKXBw+qqA4s4lYtLIrV8QZUjd7D3Xb1nvi4e3zn132EylGDLYoB+n93xcnZBJC4rhPw/G
 2AElG4QbzUB6U2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E17331333E;
 Wed, 24 Jan 2024 16:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nVMEN3U0sWVtGwAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 24 Jan 2024 16:01:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id AD315A0807; Wed, 24 Jan 2024 17:01:53 +0100 (CET)
Date: Wed, 24 Jan 2024 17:01:53 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240124160153.mwjuhy5l5xju2xwv@quack3>
References: <20240124122130.288374-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240124122130.288374-1-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.cz,redhat.com,gmail.com,suse.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fanotify: Handle EOPNOTSUPP as TCONF
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
Cc: Jan Kara <jack@suse.cz>, Dominique Leuenberger <dleuenberger@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 24-01-24 13:21:30, Petr Vorel wrote:
> Found on kernel 6.7 (Tumbleweed) on exfat:
> 
> tst_test.c:1669: TINFO: === Testing on exfat ===
> tst_test.c:1117: TINFO: Formatting /dev/loop1 with exfat opts='' extra opts=''
> tst_test.c:1131: TINFO: Mounting /dev/loop1 to /tmp/LTP_fanoL9KLE/mntpoint fstyp=exfat flags=0
> fanotify14.c:246: TINFO: Test case 0: fanotify_init(FAN_CLASS_CONTENT | FAN_REPORT_FID, O_RDONLY)
> fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
> fanotify14.c:246: TINFO: Test case 1: fanotify_init(FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, O_RDONLY)
> fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
> fanotify14.c:246: TINFO: Test case 2: fanotify_init(FAN_CLASS_NOTIF, O_RDONLY)
> fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
> fanotify14.c:283: TINFO: Testing FAN_MARK_INODE with INODE_EVENTS
> fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : EINVAL (22)
> fanotify14.c:246: TINFO: Test case 3: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY)
> fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
> fanotify14.c:283: TINFO: Testing FAN_MARK_MOUNT with INODE_EVENTS
> fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : EINVAL (22)
> fanotify14.c:246: TINFO: Test case 4: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_NAME, O_RDONLY)
> fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
> fanotify14.c:246: TINFO: Test case 5: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME, O_RDONLY)
> fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
> fanotify14.c:246: TINFO: Test case 6: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME, O_RDONLY)
> fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
> fanotify14.c:246: TINFO: Test case 7: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, O_RDONLY)
> fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
> fanotify14.c:246: TINFO: Test case 8: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID, O_RDONLY)
> fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
> fanotify14.c:283: TINFO: Testing FAN_MARK_INODE with FAN_RENAME
> fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : EINVAL (22)
> fanotify14.c:246: TINFO: Test case 9: fanotify_init(FAN_CLASS_NOTIF, O_RDONLY)
> fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
> fanotify14.c:283: TINFO: Testing FAN_MARK_ONLYDIR with FAN_OPEN
> fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : ENOTDIR (20)
> fanotify14.c:298: TPASS: Adding an inode mark on directory did not fail with ENOTDIR error as on non-dir inode
> fanotify14.c:246: TINFO: Test case 10: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, O_RDONLY)
> fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
> fanotify14.c:283: TINFO: Testing FAN_MARK_INODE with FAN_DELETE
> fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : ENOTDIR (20)
> fanotify14.c:298: TPASS: Adding an inode mark on directory did not fail with ENOTDIR error as on non-dir inode
> fanotify14.c:303: TBROK: fanotify_mark(5, 0x101, 0x200, ..., mntpoint/file1) unsupported: EOPNOTSUPP (95)
> 
> Reported-by: Dominique Leuenberger <dleuenberger@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks for looking into this. So EOPNOTSUPP is expected with a
FAN_MARK_FILESYSTEM because exfat does not have export operations and thus
cannot decode file handles (which is needed for sensible use of filesystem
marks). 

I think we should just ignore this failure in the test. Amir?

								Honza

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index e0d178bcc..dd1f5c84c 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -47,9 +47,15 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
>  	rval = fanotify_mark(fd, flags, mask, dfd, pathname);
>  
>  	if (rval == -1) {
> -		tst_brk_(file, lineno, TBROK | TERRNO,
> -			 "fanotify_mark(%d, 0x%x, 0x%lx, ..., %s) failed",
> -			 fd, flags, mask, pathname);
> +		if (errno == EOPNOTSUPP) {
> +			tst_brk_(file, lineno, TCONF | TERRNO,
> +					 "fanotify_mark(%d, 0x%x, 0x%lx, ..., %s) unsupported",
> +					 fd, flags, mask, pathname);
> +		} else {
> +			tst_brk_(file, lineno, TBROK | TERRNO,
> +					 "fanotify_mark(%d, 0x%x, 0x%lx, ..., %s) failed",
> +					 fd, flags, mask, pathname);
> +		}
>  	}
>  
>  	if (rval < -1) {
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
