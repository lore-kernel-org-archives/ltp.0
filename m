Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB36606A329
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=aIUya0DC;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PWZE6g2o;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=aIUya0DC;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PWZE6g2o
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D86A73EAA26
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 17:24:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C91243C19BF
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 17:23:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8AEAB1400993
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 17:23:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0DE21FD6F;
 Mon, 16 Nov 2026 16:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794846224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zijaWzruC6jY28tlJW50Z93ENFj8OCF99eSD99vJC+o=;
 b=aIUya0DCfT1wsR1g/6mpT34wC1TC7n5WoY6PsFo+1qRjW1x2MaNb4nWwHc3Su1zTRW9EyF
 GZng8TYvFqb4Zu0SGV8/8CGvZK8Gxy1r/QWmner9k4Ez3NE3fgKWl0SDv1eVO1mT5nHVR/
 5Y8H4KEfvThhfyH+EYpY5OXhkXu10nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794846224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zijaWzruC6jY28tlJW50Z93ENFj8OCF99eSD99vJC+o=;
 b=PWZE6g2oM4lgr77kLdn/dJzi0wLo0ckvP/rueNWIp76s1yhjPlSkF6NFpFbNAyaPBp5Id/
 gGURFanKw5dC/QDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794846224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zijaWzruC6jY28tlJW50Z93ENFj8OCF99eSD99vJC+o=;
 b=aIUya0DCfT1wsR1g/6mpT34wC1TC7n5WoY6PsFo+1qRjW1x2MaNb4nWwHc3Su1zTRW9EyF
 GZng8TYvFqb4Zu0SGV8/8CGvZK8Gxy1r/QWmner9k4Ez3NE3fgKWl0SDv1eVO1mT5nHVR/
 5Y8H4KEfvThhfyH+EYpY5OXhkXu10nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794846224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zijaWzruC6jY28tlJW50Z93ENFj8OCF99eSD99vJC+o=;
 b=PWZE6g2oM4lgr77kLdn/dJzi0wLo0ckvP/rueNWIp76s1yhjPlSkF6NFpFbNAyaPBp5Id/
 gGURFanKw5dC/QDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 704B71334C;
 Mon, 16 Nov 2026 16:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nqXvDhAu+2rYagAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 16 Nov 2026 16:23:44 +0000
Date: Mon, 16 Nov 2026 17:24:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <avsuLPpinUJg7a4l@yuki.lan>
References: <20261116093659.828828-1-avinesh.kumar@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261116093659.828828-1-avinesh.kumar@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pids.sh: Wait for killed tasks to leave the cgroup
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> pids_task1 leaves an orphaned child in the cgroup, so "wait" in
> stop_pids_tasks_path() can't wait for it, and kill -9 only queues the
> signal. The rmdir that follows can fail with EBUSY (unchecked), leaving
> the child cgroup behind and breaking the cgroup cleanup:
> 
>     rmdir: failed to remove '.../test-3200/child1': Device or resource busy
>     tst_cgroup.c:1052: TBROK: unlinkat(..., 'test-3200', AT_REMOVEDIR): EBUSY
> 
> Wait for the cgroup to become empty at the end of
> stop_pids_tasks_path() and in cleanup() before the test cgroup is removed.
> 
> Fixes: dd2b901a9 ("controllers: Update pids.sh to use newer cgroup lib")
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  testcases/kernel/controllers/pids/pids.sh | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
> index dd27b5616f0c..32434ab0dba0 100755
> --- a/testcases/kernel/controllers/pids/pids.sh
> +++ b/testcases/kernel/controllers/pids/pids.sh
> @@ -32,11 +32,28 @@ OPTIONS
>  EOF
>  }
>  
> +wait_cgroup_empty()
> +{
> +	local delay=1000
> +
> +	while [ -n "$(cat "$1/$task_list" 2>/dev/null)" ]; do
> +		if [ $delay -gt 4000000 ]; then
> +			# tst_brk() only warns in cleanup(), so return after it
> +			tst_brk TBROK "cgroup $1 is not empty"
> +			return
> +		fi
> +		tst_sleep ${delay}us
> +		delay=$((delay * 2))
> +	done
> +}
> +
>  cleanup()
>  {
>  	killall -9 pids_task2 >/dev/null 2>&1
>  	killall -9 pids_task1 >/dev/null 2>&1
>  
> +	[ -n "$testpath" ] && wait_cgroup_empty "$testpath"
> +
>  	cgroup_cleanup
>  }
>  
> @@ -83,6 +100,10 @@ stop_pids_tasks_path()
>  		kill -9 $i 2>/dev/null
>  		wait $i 2>/dev/null
>  	done
> +
> +	# wait can't reap the orphaned pids_task1 children, so wait for them
> +	# to leave the cgroup instead
> +	wait_cgroup_empty "$path"
>  }

This is working around the real problem. The tst_cg_cleanup() function
in lib/tst_cgroup.c that is eventually called from cgroup_cleanup
(testcases/lib/tst_cgctl.c) makes sure there are no processes left
before unlinking the cgroups.

The ugly part of the shell cgroup library is that it dumps the cgroup
library state into a file and then re-loads it in each command. So my
guess is that there is a bug somewhere in that code.

And I also suppose that it would be easier to rewrite the test into C so
that we can use the library natively than trying to find the problem.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
