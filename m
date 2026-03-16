Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B5EEFCBD4
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 07:57:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16DCD3C9AE8
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 08:57:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 456693C9AE8
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 08:56:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A7D16600840
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 08:56:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0FACE5BCC3;
 Mon, 16 Mar 2026 07:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773647804;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XFFnyzLrHgcdpgHfPHVlIH/s7CiDLZ7qIm0x0rY0Z5I=;
 b=FA+7cdQrVo27ERvMlDmc932+NQVtc8QR4mctpRTAbyN8t1ixgCV8pD4Vu8lZj8gzDR6K/d
 S2ciAPpb5S6EgaKF3tvUMB3kzf/cs06V2JuZU9FnQbn0gl2xtEiRQnP2Z7t0h+zznmWMFe
 0bPysZxk2eZJ+9cEJx4wUSVKxCBEO04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773647804;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XFFnyzLrHgcdpgHfPHVlIH/s7CiDLZ7qIm0x0rY0Z5I=;
 b=STYMI6vQj8SA2Z9MR6tvlY6h0TltBprxr0cbzznXlYqmie3Y2LbqwCPv7Zmv77RVKVvdUy
 P8OkcrvaDGaYj6AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FA+7cdQr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=STYMI6vQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773647804;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XFFnyzLrHgcdpgHfPHVlIH/s7CiDLZ7qIm0x0rY0Z5I=;
 b=FA+7cdQrVo27ERvMlDmc932+NQVtc8QR4mctpRTAbyN8t1ixgCV8pD4Vu8lZj8gzDR6K/d
 S2ciAPpb5S6EgaKF3tvUMB3kzf/cs06V2JuZU9FnQbn0gl2xtEiRQnP2Z7t0h+zznmWMFe
 0bPysZxk2eZJ+9cEJx4wUSVKxCBEO04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773647804;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XFFnyzLrHgcdpgHfPHVlIH/s7CiDLZ7qIm0x0rY0Z5I=;
 b=STYMI6vQj8SA2Z9MR6tvlY6h0TltBprxr0cbzznXlYqmie3Y2LbqwCPv7Zmv77RVKVvdUy
 P8OkcrvaDGaYj6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C63AB4273B;
 Mon, 16 Mar 2026 07:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M3HnK7u3t2mIOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Mar 2026 07:56:43 +0000
Date: Mon, 16 Mar 2026 08:56:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20260316075637.GA283115@pevik>
References: <20260314151304.82136-1-japo@linux.ibm.com>
 <20260314151304.82136-3-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260314151304.82136-3-japo@linux.ibm.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0FACE5BCC3
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] setxattr02: Adapt test for kernel 7.1.0+
 socket xattr support
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> Starting with kernel 7.1.0, sockets support extended attributes in the
> user.* namespace. This behavior was enabled by dc0876b9846d ("xattr:
> support extended attributes on sockets"), which permits user.* xattrs on
> S_IFSOCK inodes (previously rejected with -EPERM).

> Adapts the test to expect success (exp_err = 0) instead of EPERM when
> testing setxattr(2) on sockets with kernel 7.1.0+.

> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  testcases/kernel/syscalls/setxattr/setxattr02.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
> index 9f5f998da9ba..c905f42dbb9e 100644
> --- a/testcases/kernel/syscalls/setxattr/setxattr02.c
> +++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
> @@ -15,7 +15,7 @@
>   * - EPERM - set attribute to a FIFO
>   * - EPERM - set attribute to a char special file
>   * - EPERM - set attribute to a block special file
> - * - EPERM - set attribute to a UNIX domain socket
> + * - EPERM/SUCCEED - set attribute to a UNIX domain socket (commit dc0876b9846d)
>   */

>  #include "config.h"
> @@ -132,6 +132,10 @@ static void verify_setxattr(unsigned int i)
>  	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
>  		tst_brk(TCONF, "setxattr(2) not supported");

> +	/* consider kernels with commit dc0876b9846d */
> +	if ((tst_kvercmp(7, 1, 0) >= 0) && (strncmp(tc[i].fname, SOCK, strlen(SOCK)) == 0))
> +		tc[i].exp_err = 0;
I'm sorry I haven't pointed out it on v1.

1) Kernel detection should be in the setup function (otherwise kernel detection
is done 7x, but needed only 1x, and when run more times with -i1000 it's even
more time wasted), result stored into static variable, see:
testcases/kernel/syscalls/userfaultfd/userfaultfd01.c

2) While checking file name works, we usually try to somehow move the check into
struct test_case.

testcases/kernel/syscalls/finit_module/finit_module02.c
function pointer to in the test struct, function fixes the errno, code run in
the setup.

In this case when a single case requires it, I would combine these 2 approaches:

1) detect kver in the setup

#define BEFORE_7_1 1
#define AFTER_7_1 2
static int kver;

static void setup(void)
{
	...
	if (tst_kvercmp(7, 1, 0) >= 0)
		kver = AFTER_7_1;
	else
		kver = BEFORE_7_1;
}

2) custom function
struct test_case {
	...
	void (*fix_errno)(struct test_case *tc);
};

static void fix_sock(struct tcase *tc)
{
	/* dc0876b9846d ("xattr: support extended attributes on sockets") */
	if (kver == AFTER_7_1)
		tc[i].exp_err = 0;
}

static void verify_setxattr(unsigned int i)
{
	if (tc[i].fix_errno)
		tc[i].fix_errno(&tc[i]);
	...
}

Also, it helps reviewing when your cover letter contains changelog.
On single patch it can be added under --- (so that it's not part of the commit
message.

Kind regards,
Petr
> +
>  	/* success */

>  	if (!tc[i].exp_err) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
