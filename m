Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10273C4332F
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 14:14:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3CB03C93E4
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 15:14:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD7D83C04CF
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 15:13:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8EC471400F56
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 15:13:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A64CD21135;
 Mon, 10 Jan 2022 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641824036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i60QOYbbboiGWE23rA4TWMJBwO2n1GbcXoXdopHF68A=;
 b=byV0JsF+5ehKEHCeHAN8e+ixyCokPa2mz0bJKIUZChkLLt9xKWHxLdLf+JRBFNjdrP5Gvu
 wMuMPaJxORSD1oxZj6qtigjSM47tqP44yod951EQuODyYkXJc2hNQprt2H1C6GIaUAsiSx
 gEOzJEsjzh+hiMevsDyXHgYn7OsQK2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641824036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i60QOYbbboiGWE23rA4TWMJBwO2n1GbcXoXdopHF68A=;
 b=GlArZ6eHFG1EkEXapOX2ecIKiLyd+bDLwIoAEsHRMx2F9g8BRP+fmxbWzAsCidkOH7/thG
 Kv8PX3WvekpKu5DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90D4C13D74;
 Mon, 10 Jan 2022 14:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T2wfIiQ/3GHuUQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 10 Jan 2022 14:13:56 +0000
Date: Mon, 10 Jan 2022 15:15:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Ydw/g77bnGd1G/9I@yuki>
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641779349-8424-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641779349-8424-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] sysctl/sysctl02.sh: Use kconfig shell api
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
> +	tst_check_kconfigs "CONFIG_KALLSYMS=y" "CONFIG_KALLSYMS_ALL=y" "CONFIG_KASAN=y" \
                               ^
			       This should be a single string now,
			       right?

			       Also we should pass the delimiter unless
			       we change the tst_check_kconfigs default
			       to ',' if no delimiter was passed (which
			       sounds reasonable).

> +		|| tst_brk TCONF "kconfig doesn't meet test's requirement!"
> +
>  	ROD sysctl -w -q $sys_name=0
>  
> -	if grep -q kasan_report $syms_file; then
> -		if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
> -			tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
> -		else
> -			tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
> -		fi
> +	if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
> +		tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
>  	else
> -		tst_res TCONF "kernel doesn't support KASAN"
> +		tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
>  	fi
>  }
>  
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
