Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D7C02181
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 10:12:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBB183C564D
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 11:12:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 993663C22DF
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 11:11:59 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 137CE212B6F
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 11:11:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7B971F391;
 Fri, 24 Jan 2025 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737713518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHEFxTnfayIhzlleo/bjoHNnWunDdEc5S12CAr3v/+M=;
 b=E7Te0iUAbvDOhTUKRDMecHrriE2GJJeBlHJuzss1IuvXXc1xgf5lO25u8Wml0TVqmks5X5
 He8f3DVUgsu3/TGuf2qFpBZyqkLsIGQNkzEkTsE5OIReXx+oe9Eq8hUP68vIK63tjOv1mS
 rivvVJDRZrEnHQLLhgMX4+gzgfJhAmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737713518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHEFxTnfayIhzlleo/bjoHNnWunDdEc5S12CAr3v/+M=;
 b=+lMm8DQj091g7VCO5nmwIopgVn9PAxTthEdo89GMw+R9ZbswR7QykdwUWm83qk6GEVU2z+
 1L5dWA3dgJhBFEBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c+g9XoKK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0kCvl0O8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737713517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHEFxTnfayIhzlleo/bjoHNnWunDdEc5S12CAr3v/+M=;
 b=c+g9XoKKKj8jc6aI4k5tR4d9VRLbKb+iEvvzvw0Ld1qd4HwEIbqWy0u33LZGpCWwn+MZYd
 sb24PyglsHfiybCNRkt9AXkrJZygSLQg1oqygij5GxbGRzs4NKxWow4IEkxNj0MswLjH36
 x3k8IORQ0uUujZBIcDtDaO3mT267YTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737713517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHEFxTnfayIhzlleo/bjoHNnWunDdEc5S12CAr3v/+M=;
 b=0kCvl0O8Ikr4ofCKsMes6tJbBTk7jy+2Sq04RyeGFL4yHU4HuKhh4PJIVOkJcYEHGoCx3A
 oqBaVwLVBKhSOfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 161A1139CB;
 Fri, 24 Jan 2025 10:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id snEDOGxnk2ecdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Jan 2025 10:11:56 +0000
Date: Fri, 24 Jan 2025 11:11:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
 Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Message-ID: <20250124101140.GE159953@pevik>
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122172440.506677-2-amir73il@gmail.com>
 <20250123171826.GA125552@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250123171826.GA125552@pevik>
X-Rspamd-Queue-Id: E7B971F391
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,suse.cz,lists.linux.it];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fanotify13: Verify that we did not get an
 extra event
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, all,
> Hi Amir, all,

> > For example, verify that we did not get an event on a directory object
> > without requesting FAN_ONDIR.  Also, report a test failure if no events
> > received at all instead of blocking on read of fanotify_fd.

> > With this change, the test fails with overlayfs variants over btrfs,
> > because the size of fid of overalyfs over btrfs is about 90 bytes and
> > the events on the three objects do not all fit into a single 256 bytes
> > buffer read. Increase the size of the events buffer to fix this failure.

> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  .../kernel/syscalls/fanotify/fanotify13.c     | 22 ++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)

> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
> > index 5cd857707..16fd99ba1 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify13.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
> > @@ -34,7 +34,7 @@
> >  #include "fanotify.h"

> >  #define PATH_LEN 128
> > -#define BUF_SIZE 256
> > +#define BUF_SIZE 1024
> >  #define DIR_ONE "dir_one"
> >  #define FILE_ONE "file_one"
> >  #define FILE_TWO "file_two"
> > @@ -130,10 +130,15 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
> >  		SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD | mark->flag, tc->mask,
> >  				   AT_FDCWD, objects[i].path);

> > -		/* Setup the expected mask for each generated event */
> > +		/*
> > +		 * Setup the expected mask for each generated event.
> > +		 * No events are expected on directory without FAN_ONDIR.
> > +		 */
> >  		event_set[i].expected_mask = tc->mask;
> >  		if (!objects[i].is_dir)
> >  			event_set[i].expected_mask &= ~FAN_ONDIR;
> > +		else if (!(event_set[i].expected_mask & FAN_ONDIR))
> > +			event_set[i].expected_mask = 0;
> >  	}
> >  	return 0;
> >  }
> > @@ -163,7 +168,8 @@ static void do_test(unsigned int number)
> >  		return;
> >  	}

> > -	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
> > +	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID |
> > +					 FAN_NONBLOCK, O_RDONLY);

> >  	/*
> >  	 * Place marks on a set of objects and setup the expected masks
> > @@ -279,6 +285,16 @@ static void do_test(unsigned int number)
> >  			FSID_VAL_MEMBER(event_fid->fsid, 1),
> >  			*(unsigned long *) event_file_handle->f_handle);
> >  	}
> > +
> > +	/*
> > +	 * Verify that we did not get an extra event, for example, that we did
> > +	 * not get an event on directory without FAN_ONDIR.
> > +	 */
> > +	if (event_set[i].expected_mask) {
> > +		tst_res(TFAIL,
> > +			"Did not get an expected event (expected: %llx)",
> > +			event_set[i].expected_mask);

> I verified that on openSUSE on x86_64 test properly fails with 6.12.9:
> fanotify13.c:282: TFAIL: handle_bytes (0) returned in event does not equal to handle_bytes (24) returned in name_to_handle_at(2)

> and works with 6.12.10. So far so good.

> But when testing on other archs, 6.12.10 fails on aarch64 and ppc64le:

> fanotify13.c:339: TFAIL: Did not get an expected event (expected: 200)

> That's a different failure than on 6.12.9.

Also fanotify13.c for the same reason on s390x on various SLES (enterprise)
kernels based on various mainline kernels (6.4, 5.3.18, ...).

fanotify13.c:341: TFAIL: Did not get an expected event (expected: 3403000018)

(Just a different mask than on aarch64 and ppc64le.)

@Cyril: due the above I suggest to merge before release only fanotify05.c and
fanotify21.c changes.

Kind regards,
Petr

> Any hint what could be wrong?

> Kind regards,
> Petr

> > +	}
> >  out:
> >  	SAFE_CLOSE(fanotify_fd);
> >  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
