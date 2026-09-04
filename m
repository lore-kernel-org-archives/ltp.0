Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA212C79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:46:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6395C3E9747
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:46:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FB633C5F31
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:45:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D8B111A0117A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:45:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAAAC203D0;
 Fri,  4 Sep 2026 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788515143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYVhI2jst9WqptW5Yn9LHo5e4IserQHRlzsw0BUT+yU=;
 b=whupd3JTNM9s7dyV+ARqKmz0Vuk2B9fr09BY3cNcst3DyiUfaLddEs60RUFDYuHIlphVco
 6xJlKpI9OPcN/4zACWgqKOxZWGiKLZlIxmu4orrhATPL+sIHSMPxTzNbouZ61uQxUPizgf
 fmMfeMTMtQdEBf3TcPUZhL5Rh6wQBRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788515143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYVhI2jst9WqptW5Yn9LHo5e4IserQHRlzsw0BUT+yU=;
 b=lU6RZjPYpmXJidm0l1K0xRK/YOQRF8vK1EybEkN4aAwemrk/pT77W+1DbIOyG3/xKNVccT
 F0I/9edXVY4bhdBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f+wYuyA0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qpsa70h2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788515138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYVhI2jst9WqptW5Yn9LHo5e4IserQHRlzsw0BUT+yU=;
 b=f+wYuyA0olfxVazwAJ0XI/UFDkC2B8lWuaXBKn9GykqCVEkE0XUYL5yFZd/F2AEhgl5chv
 Ki1Y+MLyzrmWCkjv6K+p1UlSfpda9/ZLxOkhSQmo7Tw2wHrVTQQvvMKT0/iUQItt/XSsz0
 +ehztBxZ7TZp437hPR4R20TMhhQy3eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788515138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYVhI2jst9WqptW5Yn9LHo5e4IserQHRlzsw0BUT+yU=;
 b=qpsa70h2oo8779ILBGgfFU/Dc+Vu7CPnKKcoJUvK5kDKg8qNGEFYVNpKG5K+r4nqWHRAjy
 BrvWjKM1vi4dRwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9970413678;
 Fri,  4 Sep 2026 09:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HT8jJEKTmmpzHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 04 Sep 2026 09:45:38 +0000
Date: Fri, 4 Sep 2026 11:45:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <20260904094533.GA1206368@pevik>
References: <20260828120242.2367797-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260828120242.2367797-1-wakel@google.com>
X-Rspamd-Queue-Id: DAAAC203D0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_fj: Check start_path before removing
 directories in cleanup
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

Hi Wake Liu,

Thanks, merged with minor changes.

> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh @@ -79,9
> +79,10 @@ common_cleanup() { killall -9 cgroup_fj_proc >/dev/null 2>&1

> -    tst_res TINFO "Removing all ltp subgroups..."
> -
> -    [ -d "$start_path" ] && find "$start_path" -depth -type d -exec rmdir '{}' \;
> +    if [ -n "$start_path" ] && [ -d "$start_path" ]; then
> +        tst_res TINFO "Removing all ltp subgroups..."
Let's remove dots.

> +        find "$start_path" -depth -type d -exec rmdir '{}' \;
> +    fi

>      cgroup_cleanup

> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> index b0c9410ca..61b7a0415 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> @@ -231,7 +231,7 @@ cleanup()
>          wait $pid >/dev/null 2>&1
>      fi

> -    rmdir "$start_path/ltp_1" >/dev/null 2>&1
> +    [ -n "$start_path" ] && [ -d "$start_path/ltp_1" ] && rmdir "$start_path/ltp_1" >/dev/null 2>&1
Now we don't need to mask errors, right?
And a bit long line.

Also, I'm not sure if ... && ... can't bring problems on 'set -e' setup,
because if code is not executed $? gets 1. That's why I use only ... || ...
or if/then/else after which $? is always 0.

>      common_cleanup
>  }

Merged with following diff.

Kind regards,
Petr

+++ testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -79,9 +79,10 @@ common_cleanup()
 {
     killall -9 cgroup_fj_proc >/dev/null 2>&1
 
-    tst_res TINFO "Removing all ltp subgroups..."
-
-    [ -d "$start_path" ] && find "$start_path" -depth -type d -exec rmdir '{}' \;
+    if [ -n "$start_path" ] && [ -d "$start_path" ]; then
+        tst_res TINFO "Removing all ltp subgroups"
+        find "$start_path" -depth -type d -exec rmdir '{}' \;
+    fi
 
     cgroup_cleanup
 
diff --git testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index b0c9410ca3..2b0dafc544 100755
--- testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -231,7 +231,10 @@ cleanup()
         wait $pid >/dev/null 2>&1
     fi
 
-    rmdir "$start_path/ltp_1" >/dev/null 2>&1
+    if [ -n "$start_path" ] && [ -d "$start_path/ltp_1" ]; then
+        rmdir "$start_path/ltp_1"
+    fi
+
     common_cleanup
 }
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
