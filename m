Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD61C83F07
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 09:46:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 166583C0131
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 11:46:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CB823C0639
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 11:45:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A5B64600218
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 11:45:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20F9221167;
 Mon,  7 Jul 2025 09:45:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EF5B13797;
 Mon,  7 Jul 2025 09:45:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eiA1AlCXa2goTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Jul 2025 09:45:52 +0000
Date: Mon, 7 Jul 2025 11:46:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aGuXdYP1fkikZzgN@yuki.lan>
References: <20250703-xattr_bug_repr-v2-1-154e9afe2463@suse.com>
 <aGwjGgbvy4Ik2Sy5@MiWiFi-CR6608-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aGwjGgbvy4Ik2Sy5@MiWiFi-CR6608-srv>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 20F9221167
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add listxattr04 reproducer
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +		tst_res(TFAIL, "listxattr() failed to read attributes length: ERANGE");
> > +		return;
> Why ERANGE is Checked Separately?
> Such as tst_res(TFAIL | TERRNO, "listxattr() error") will also report
> errno.

Because with ERANGE we reproduced the bug and return TFAIL while with
any other errno we report TBROK.

> > +	}
> > +
> > +	tst_res(TPASS, "listxattr() correctly read attributes length");
> > +}
> > +
> > +static void run(void)
> > +{
> > +	int size;
> > +
> > +	size = listxattr(TEST_FILE, NULL, 0);
> > +	if (size == -1)
> > +		tst_brk(TBROK | TERRNO, "listxattr() error");
> > +
> > +	verify_xattr(size);
> > +}
> > +
> > +static int selinux_enabled(void)
> > +{
> > +	uint32_t lsm_num;
> > +	uint64_t ids[32];
> > +	uint32_t page_size;
> > +	int available = 0;
> > +
> > +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> > +
> > +	lsm_num = lsm_list_modules(ids, &page_size, 0);
> > +	if (!lsm_num)
> > +		return 0;
> > +
> > +	for (uint32_t i = 0; i < lsm_num; i++) {
> > +		if (ids[i] == LSM_ID_SELINUX) {
> > +			available = 1;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return available;
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	int res;
> > +
> > +	if (!selinux_enabled())
> Mabye we can use is_selinux_enabled instead of self build function?

That mean that we have to compile the test again one more library. I
would rather add tst_selinux_enabled() into the test library. We already
have tst_selinux_enforcing() there anyways. That should be as easy as
reading another file in /sys/fs/selinux/.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
