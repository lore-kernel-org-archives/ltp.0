Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED91C67861
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 12:03:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9540D3CEE77
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 14:03:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 345063CE2AA
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 14:02:45 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9602B65233C
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 14:02:42 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0D9B1F797;
 Fri,  5 Apr 2024 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712318561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYtPOAdxTzuyEvjnW3gQ4Vo5mqdqWoaF/Dv13Au6jFc=;
 b=McFa+ygdlLj9HbV9BXAM/DZ+c7XenyYU1qkChFaXf7aGNSEdZb0YPSsn8RNM5VFSUl+rpD
 9F9WiD5lhBeijr5JUfpnHeOyNXKQlO5kNvuvlLdvQZt/+EKSbveo1+mF5jCbkYClvU35Ue
 bOqld5ZGpIUg8Ixl4SXpf66e55HS2uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712318561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYtPOAdxTzuyEvjnW3gQ4Vo5mqdqWoaF/Dv13Au6jFc=;
 b=Ew6A1djA3HTmXvWZ2rLi9pqZEyTVzNPqSZjQSfQ/O+kdx0aXzCkwHQEhzcYGpyplQvnJkf
 1ouULpwGW4udOUBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712318561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYtPOAdxTzuyEvjnW3gQ4Vo5mqdqWoaF/Dv13Au6jFc=;
 b=McFa+ygdlLj9HbV9BXAM/DZ+c7XenyYU1qkChFaXf7aGNSEdZb0YPSsn8RNM5VFSUl+rpD
 9F9WiD5lhBeijr5JUfpnHeOyNXKQlO5kNvuvlLdvQZt/+EKSbveo1+mF5jCbkYClvU35Ue
 bOqld5ZGpIUg8Ixl4SXpf66e55HS2uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712318561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYtPOAdxTzuyEvjnW3gQ4Vo5mqdqWoaF/Dv13Au6jFc=;
 b=Ew6A1djA3HTmXvWZ2rLi9pqZEyTVzNPqSZjQSfQ/O+kdx0aXzCkwHQEhzcYGpyplQvnJkf
 1ouULpwGW4udOUBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FF99139F1;
 Fri,  5 Apr 2024 12:02:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 3a/9IWHoD2bSDgAAn2gu4w
 (envelope-from <chrubis@suse.cz>); Fri, 05 Apr 2024 12:02:41 +0000
Date: Fri, 5 Apr 2024 14:01:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Message-ID: <Zg_oLGuLcssY-rYY@yuki>
References: <20240401150015.301640-1-samasth.norway.ananda@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240401150015.301640-1-samasth.norway.ananda@oracle.com>
X-Spamd-Result: default: False [-3.72 / 50.00]; BAYES_HAM(-2.92)[99.65%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap2.dmz-prg2.suse.org:helo,
 imap2.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mremap06: fallocate is not supported on nfsv3
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
Cc: calum.mackay@oracle.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The function fallocate() is not supported on nfsv3. Thus when we run the
> mremap06 test over a nfsv3 filesystem the test fails.

Can we rather than this just skip the test on nfsv3?

If we want to skip the test on nfs in generall we can just set
.skip_filesystems = {"nfs", NULL} in the tst_test structure.

I'm not sure if we can easily detect the nfs version. The test library
does that by checking the NFS_SUPER_MAGIC againts stat, but there is a
single SUPER_MAGIC for all nfs versions.

So if we want to keep the test enabled for nfsv4 we can exit with TCONF
when the call fails only when we are on NFS with tst_fs_type() and check
that against TST_NFS_MAGIC.

> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  testcases/kernel/syscalls/mremap/mremap06.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/mremap/mremap06.c b/testcases/kernel/syscalls/mremap/mremap06.c
> index 3bbaf441a..362b03e19 100644
> --- a/testcases/kernel/syscalls/mremap/mremap06.c
> +++ b/testcases/kernel/syscalls/mremap/mremap06.c
> @@ -104,8 +104,14 @@ static void setup(void)
>  	fd = SAFE_OPEN("testfile", O_CREAT | O_RDWR | O_TRUNC, 0600);
>  
>  	ret = fallocate(fd, 0, 0, mmap_size);
> -	if (ret == -1)
> +	if (ret != 0) {
> +		if (errno == EOPNOTSUPP || errno == ENOSYS) {
> +			tst_brk(TCONF,
> +				"fallocate system call is not implemented");
> +		}
>  		tst_brk(TBROK, "fallocate() failed");
> +		return;

The return shouldn't be here, tst_brk() does not return.

> +	}
>  
>  	buf = SAFE_MMAP(0, mmap_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>  
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
