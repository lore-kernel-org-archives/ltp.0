Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A12CCCD195
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 09:40:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDEEE3CEE64
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 11:40:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 346A13CEE18
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:39:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A22BA200D00
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:39:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3D4C1FBEF;
 Fri, 17 Oct 2025 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760693988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rxsh8YLpkHchYlKNshAf0z+s1yJbhAt1iJY0i+ejDYU=;
 b=GAoPDIcCV6+vpN2iDFtj/3mvkDJEFoKmHBl0/NbpADziwHIRGKrxk6WZTnuXaIj+tsCpwC
 WCXA/uELPzNIHv90Xx2h/icyFYRnyiziC6S6WKonTkApJfTGXkOy0KyiI/sn2zYvQGZY1v
 kIfHSL9p6TANqJwIQ1u4JI3ZEXDeJ98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760693988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rxsh8YLpkHchYlKNshAf0z+s1yJbhAt1iJY0i+ejDYU=;
 b=o/MKD3Bbm3JaNR/TROHgWTnoVERx9RZ98wLS52tZYuyVSfVETzAzXZvjm6WE3qhhQU5x1I
 KGxxJtV/NbOp0PBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cXuafEbT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B7hzEdwA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760693987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rxsh8YLpkHchYlKNshAf0z+s1yJbhAt1iJY0i+ejDYU=;
 b=cXuafEbTAX9/XZgTNg/BOLkg8giGNM+h+2RNoboAK9WVqwtwTkKDotiqMCgJsFmPrNJx1D
 pFii51bEOdPeD0tWKFfXHNRd3nemr8T5I+8PcA9CEf/B5W25sMe41NKjCdomHjbg1Whx75
 CKQKbFiNAPSIjyvaduIumr23JuRiRKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760693987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rxsh8YLpkHchYlKNshAf0z+s1yJbhAt1iJY0i+ejDYU=;
 b=B7hzEdwAsrhSUk1zN5WRAOe2DljWClmcfy8BvsMauxdR6uwn4FPAXDkjh8Z99eMZvR/FnP
 UEqNwwtqu0tR9rDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D078B136C6;
 Fri, 17 Oct 2025 09:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 73ROMeMO8mjeOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Oct 2025 09:39:47 +0000
Date: Fri, 17 Oct 2025 11:40:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <aPIPGeWo8gtxVxQX@yuki.lan>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
X-Rspamd-Queue-Id: E3D4C1FBEF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[16]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
 ioctl(pidfd, PIDFD_GET_INFO_SHORT,
 info_invalid) expected EINVAL: ENOTTY (25)
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Andrey Albershteyn <aalbersh@kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ben Copeland <benjamin.copeland@linaro.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > ## Test error log
> > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > tst_test.c:2021: TINFO: LTP version: 20250930
> > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > @1760657272 aarch64
> > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > which might slow the execution
> > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > info_invalid) expected EINVAL: ENOTTY (25)

Looking closely this is a different problem.

What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
size with:

struct pidfd_info_invalid {
        uint32_t dummy;
};

#define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)


And we expect to hit:

        if (usize < PIDFD_INFO_SIZE_VER0)
                return -EINVAL; /* First version, no smaller struct possible */

in fs/pidfs.c


And apparently the return value was changed in:

commit 3c17001b21b9f168c957ced9384abe969019b609
Author: Christian Brauner <brauner@kernel.org>
Date:   Fri Sep 12 13:52:24 2025 +0200

    pidfs: validate extensible ioctls
    
    Validate extensible ioctls stricter than we do now.
    
    Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
    Reviewed-by: Jan Kara <jack@suse.cz>
    Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/pidfs.c b/fs/pidfs.c
index edc35522d75c..0a5083b9cce5 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
                 * erronously mistook the file descriptor for a pidfd.
                 * This is not perfect but will catch most cases.
                 */
-               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
+               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
        }
 
        return false;


So kernel has changed error it returns, if this is a regression or not
is for kernel developers to decide.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
