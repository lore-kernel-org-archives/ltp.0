Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99894C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 13:11:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF1013C9A6E
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 14:11:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B92333C9A62
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 14:11:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E094C1000D4F
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 14:11:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C4D91F399;
 Thu,  3 Feb 2022 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643893876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/jyxuoc71ojmYV7cIoS7avFqz4RgYtW3uLZ+RhGXx5A=;
 b=JqyHkBMPGqz2qj5PSTenyMs661qw31qDip8LNXHSe8/lA/AtHHSZAnYkvLgZ/9ffj6yuIR
 rhf8mAexuoSqmFM0yUQprhv4g0x4+FZ4c2aMNigJE0DVDeEzvwFf87fJcjA9DcVadtcRZ2
 f4PXUr25a76BVMPmqUBOWmlg7yq9WIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643893876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/jyxuoc71ojmYV7cIoS7avFqz4RgYtW3uLZ+RhGXx5A=;
 b=CQSl2bGkJem+N5yWNAKz2xHW2pbI5qUNCWCDXBLJ3thgZZ1KhMA43lDIao4qUFmc7bL2jE
 w2UC6YLosCIzwnDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC2B713BC0;
 Thu,  3 Feb 2022 13:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H+9jOHPU+2HXLwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 03 Feb 2022 13:11:15 +0000
Date: Thu, 3 Feb 2022 14:13:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YfvU6fqZK2d1PKVg@yuki>
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-4-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220203081820.29521-4-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/5] API/cgroup: Add memory.min
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
>  static const struct cgroup_file memory_ctrl_files[] = {
>  	{ "memory.current", "memory.usage_in_bytes", CTRL_MEMORY },
> +	{ "memory.min", NULL, CTRL_MEMORY },

This is obviously OK.

>  	{ "memory.max", "memory.limit_in_bytes", CTRL_MEMORY },
>  	{ "memory.stat", "memory.stat", CTRL_MEMORY },
>  	{ "memory.swappiness", "memory.swappiness", CTRL_MEMORY },
> @@ -896,7 +897,7 @@ tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
>  
>  	for_each_dir(parent, 0, dir) {
>  		new_dir = SAFE_MALLOC(sizeof(*new_dir));
> -		cgroup_dir_mk(*dir, group_name, new_dir);
> +		cgroup_dir_mk(*dir, cg->group_name, new_dir);

However this change should go in in a separate ptach.

I guess that what we do is that we store a pointer passed to us by the
user of the API into our structures instead of the copy we made, which
is mostly working fine, since we pass pointers to statically allocated
strings, but it should be fixed. But please do so in a separate patch.

If you split this change into two separate patches you can consider both
of them to have my Reviewed-by:

>  		cgroup_group_add_dir(parent, cg, new_dir);
>  	}
>  
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
