Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC21C02196
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:08:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2765F3C9283
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:08:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CC913C12C2
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:08:26 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A94951BE43B8
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:08:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D59B21F38D;
 Thu,  6 Feb 2025 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738850903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWW/yXfYO8e+sGeHWfPOlTlhzj5ctx9twe0szUYPxqM=;
 b=izmPHD0F5tM7Rl/x5db5X4YWP+iS6PDrPF74cgk0sOcnrV2aW8udkwLUQ399K0CXijeVtI
 28R1m7ZL9NG8F4zBQfdbmvo+Ssu55614HVo8pTXeltCGDiIB/pmuNmKIlU1/u267W8ZLlC
 /Qgmpponn4PzQELjIDcfQmO5nXFOwIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738850903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWW/yXfYO8e+sGeHWfPOlTlhzj5ctx9twe0szUYPxqM=;
 b=uTLuTfCslKTyXsJSoykOb6MyXkQMNtN/KJTh2bO+4HEgo5rmJUMrUPmRo0MlgagrTUkTI7
 XGGfFVaXSRf7T0Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738850903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWW/yXfYO8e+sGeHWfPOlTlhzj5ctx9twe0szUYPxqM=;
 b=izmPHD0F5tM7Rl/x5db5X4YWP+iS6PDrPF74cgk0sOcnrV2aW8udkwLUQ399K0CXijeVtI
 28R1m7ZL9NG8F4zBQfdbmvo+Ssu55614HVo8pTXeltCGDiIB/pmuNmKIlU1/u267W8ZLlC
 /Qgmpponn4PzQELjIDcfQmO5nXFOwIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738850903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWW/yXfYO8e+sGeHWfPOlTlhzj5ctx9twe0szUYPxqM=;
 b=uTLuTfCslKTyXsJSoykOb6MyXkQMNtN/KJTh2bO+4HEgo5rmJUMrUPmRo0MlgagrTUkTI7
 XGGfFVaXSRf7T0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C776913697;
 Thu,  6 Feb 2025 14:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qLnOL1fCpGdWHwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Feb 2025 14:08:23 +0000
Date: Thu, 6 Feb 2025 15:08:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z6TCWQIediqqUUVW@yuki.lan>
References: <89d0fb724ea534419942c2647e1ef7ca98f9e72d.1738846569.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <89d0fb724ea534419942c2647e1ef7ca98f9e72d.1738846569.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/bpf: zero-initialize bpf_attr including
 padding bits
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
> However kernel bpf syscall checks that all unused fields for a command
> are set to zero in CHECK_ATTR() macro, which causes tests to fail with
> EINVAL.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/bpf/bpf_common.c | 32 ++++++++++++----------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
> index 95b5bc12eaa4..d765c4e32936 100644
> --- a/testcases/kernel/syscalls/bpf/bpf_common.c
> +++ b/testcases/kernel/syscalls/bpf/bpf_common.c
> @@ -49,13 +49,14 @@ int bpf_map_create(union bpf_attr *const attr)
>  
>  int bpf_map_array_create(const uint32_t max_entries)
>  {
> -	union bpf_attr map_attr = {
> -		.map_type = BPF_MAP_TYPE_ARRAY,
> -		.key_size = 4,
> -		.value_size = 8,
> -		.max_entries = max_entries,
> -		.map_flags = 0
> -	};
> +	/* zero-initialize entire struct including padding bits */
> +	union bpf_attr map_attr = {};
> +
> +	map_attr.map_type = BPF_MAP_TYPE_ARRAY;
> +	map_attr.key_size = 4;
> +	map_attr.value_size = 8;
> +	map_attr.max_entries = max_entries;
> +	map_attr.map_flags = 0;

I had a closer look here, the map_attr is an union with anonymous
structures and I suppose that the problem here is that the padding after
the union is no longer cleared and that there have been some new fields
added, at least compared to the lapi fallback structures we have and we
possibly pass random mess in flags.

Maybe slightly better version would be:

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index 95b5bc12e..a8289e106 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -49,7 +49,9 @@ int bpf_map_create(union bpf_attr *const attr)

 int bpf_map_array_create(const uint32_t max_entries)
 {
-       union bpf_attr map_attr = {
+       union bpf_attr map_attr = {};
+
+       map_attr = (union bpf_attr) {
                .map_type = BPF_MAP_TYPE_ARRAY,
                .key_size = 4,
                .value_size = 8,


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
