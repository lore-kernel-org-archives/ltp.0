Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCD0C433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 09:50:10 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEEE561053
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 09:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEEE561053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B30613C7378
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 10:50:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4B123C2FCF
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 10:49:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0BD1E601D46
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 10:49:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 219EC1FD36;
 Fri,  5 Nov 2021 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636105796;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRWMMk17DEUJ38plRlKGaMqVFwoarVGmkRNCrKvlLlE=;
 b=EHIGftrMPkFRrjr+SuZB9O8gmgYFpzR0uil99nJMC6+7+SUAOshCPnFZQK7DndFf6mfnru
 n9jElJVP1FFj/bdxXKGGHyVsbutZh3ynaVBF2ZjsEx69Ct/nZ1azumbQbGq1pOIpzomet3
 l9x3UKBzrRBaCWVEoMVbXHF3IoGoxQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636105796;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRWMMk17DEUJ38plRlKGaMqVFwoarVGmkRNCrKvlLlE=;
 b=BaNhKzDqtgydvv/EjFreSV71xfA0X0pxAeTvO9F0SvNqZiOP49yuS8M9fNDpI+tht+NaNt
 bakhs2yq8LSa7HBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0B5413B97;
 Fri,  5 Nov 2021 09:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2UjXLEP+hGHtcAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 09:49:55 +0000
Date: Fri, 5 Nov 2021 10:49:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YYT+Qm/Sy3drGR1+@pevik>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-6-krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/9] syscalls/fanotify21: Validate incoming FID
 in FAN_FS_ERROR
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
Cc: kernel@collabora.com, khazhy@google.com, repnop@google.com, jack@suse.com,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
> +				 const struct test_case *ex)
> +{
> +	struct file_handle *fh = (struct file_handle *) &fid->handle;
> +
> +	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
> +		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
> +			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
> +			FSID_VAL_MEMBER(ex->fid->fsid, 0));
Correct way is (I'll fix it before pushing this PR):

	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
			ex->fid->fsid.val[0]);

Using FSID_VAL_MEMBER() is invalid, it broke compilation for musl.
FSID_VAL_MEMBER was created to fix musl compilations, but it should be used only
for struct fanotify_event_info_fid, using it for struct event_t (which has also
__kernel_fsid_t fsid) is invalid and causes this error:

In file included from fanotify21.c:35:
fanotify21.c: In function 'check_error_event_info_fid':
fanotify.h:200:41: error: 'lapi_fsid_t' has no member named '__val'; did you mean 'val'?
  200 | # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
      |                                         ^~~~~
../../../../include/tst_test.h:58:54: note: in expansion of macro 'FSID_VAL_MEMBER'
   58 |   tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
      |                                                      ^~~~~~~~~~~
fanotify21.c:132:3: note: in expansion of macro 'tst_res'
  132 |   tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
      |   ^~~~~~~
make: *** [../../../../include/mk/rules.mk:37: fanotify21] Error 1

Sorry for confusion, not sure how to improve FSID_VAL_MEMBER() to avoid these
errors.

See f37704d6c ("fanotify: Fix FSID_VAL_MEMBER() usage")

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
