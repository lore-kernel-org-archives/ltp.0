Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE073C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 10:58:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53F683CAB7B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 12:58:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FB073CAB42
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:58:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63AF110009F2
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:58:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ADD9C1F38D;
 Mon, 31 Mar 2025 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743418689;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxqcP+EiAPpW4hwjQhVTIhXy7I4fQrHc71x2E3OS6Gc=;
 b=XO506DeC2ebLWj/2z8R9dYU2O6aN4UBqt8feQm6BDhj2BkFbR/cRnqtdHS6dWGQbwvMbmj
 jR35RHm5bAtEbD+sk6YOw/dlN1I6BM5YFJJKSv5DTISZtrgbEwRDYSmly97vIr05WrCYye
 yNWMW0sLh/2RLTl+IR8N5qJxgSwOmeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743418689;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxqcP+EiAPpW4hwjQhVTIhXy7I4fQrHc71x2E3OS6Gc=;
 b=CN3/IHRwXBzoES7WGVVEnxKToRadXQYYmVA5NUR3JIk/DTxfIceLgCXujXtmhLdNdXs673
 TJ92xfOCch9PJJDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XO506DeC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="CN3/IHRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743418689;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxqcP+EiAPpW4hwjQhVTIhXy7I4fQrHc71x2E3OS6Gc=;
 b=XO506DeC2ebLWj/2z8R9dYU2O6aN4UBqt8feQm6BDhj2BkFbR/cRnqtdHS6dWGQbwvMbmj
 jR35RHm5bAtEbD+sk6YOw/dlN1I6BM5YFJJKSv5DTISZtrgbEwRDYSmly97vIr05WrCYye
 yNWMW0sLh/2RLTl+IR8N5qJxgSwOmeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743418689;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxqcP+EiAPpW4hwjQhVTIhXy7I4fQrHc71x2E3OS6Gc=;
 b=CN3/IHRwXBzoES7WGVVEnxKToRadXQYYmVA5NUR3JIk/DTxfIceLgCXujXtmhLdNdXs673
 TJ92xfOCch9PJJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86835139A1;
 Mon, 31 Mar 2025 10:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nSf/H0F16md/bgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 10:58:09 +0000
Date: Mon, 31 Mar 2025 12:58:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250331105808.GC244431@pevik>
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
 <20250331031945.5948-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250331031945.5948-3-wegao@suse.com>
X-Rspamd-Queue-Id: ADD9C1F38D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 2/2] cpuset_memory_testset.sh: Remove test6
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../cpuset_memory_testset.sh                  | 37 +------------------
>  1 file changed, 2 insertions(+), 35 deletions(-)

> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> index c1e7cea8f..fd41dc97a 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> @@ -162,41 +162,8 @@ check_hugetlbfs()

>  test6()
>  {
> -	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
> -	if [ $? -ne 0 ]; then
> -		cpuset_log_error $CPUSET_TMP/stderr
> -		tst_resm TFAIL "set general group parameter failed."
> -		return 1
> -	fi
> -
> -	check_hugetlbfs
> -	if [ $? -eq 0 ]; then
> -		tst_resm TCONF "This system don't support hugetlbfs"
> -		return 0
> -	fi
> -
> -	mkdir /hugetlb
> -	mount -t hugetlbfs none /hugetlb
> -
> -	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
> -	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
> -
> -	cpuset_memory_test --mmap-file --hugepage -s $HUGEPAGESIZE >"$MEMORY_RESULT" &
> -	simple_getresult $! "$CPUSET/0"
> -
> -	umount /hugetlb
> -	rmdir /hugetlb
> -
> -	echo $save_nr_hugepages > /proc/sys/vm/nr_hugepages
> -	if [ $(cat /proc/sys/vm/nr_hugepages) -ne $save_nr_hugepages ]; then
> -		tst_resm TFAIL "can't restore nr_hugepages(nr_hugepages = $save_nr_hugepages)."
> -		return 1
> -	fi
> -
> -	if [ "$node" != "0" ]; then
> -		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#0)."
> -		return 1
> -	fi
> +	tst_resm TINFO "This test is replaced by testcases/kernel/mem/cpuset/cpuset02.c"
> +	return 0
In new C shell API this would fail because test is not propagating any result. I
suppose this will work on old API, but wouldn't be better just remove whole
test6(), renumber tests and set TST_TOTAL=17?

Kind regards,
Petr
>  }

>  test7()

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
