Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E68AC02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 13:36:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8DF03C04A5
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:36:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12C523C04A5
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 14:36:30 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E7BDF6296BE
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 14:36:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D00B1210F5;
 Thu,  6 Feb 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C185413697;
 Thu,  6 Feb 2025 13:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Zdl4Ltu6pGdvFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Feb 2025 13:36:27 +0000
Date: Thu, 6 Feb 2025 14:36:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z6S61bgTwBBP6KOp@yuki.lan>
References: <89d0fb724ea534419942c2647e1ef7ca98f9e72d.1738846569.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <89d0fb724ea534419942c2647e1ef7ca98f9e72d.1738846569.git.jstancek@redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: D00B1210F5
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
> gcc 15 stopped zero-initializing padding bits:
>   https://gcc.gnu.org/gcc-15/changes.html

I would even call this a bug even if it's allowed by the C standard.

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

So struct foo bar = {.bar = foo}; does not work,
but struct foo bar = {}: bar.bar = foo; does? That is insane...

>  	return bpf_map_create(&map_attr);
>  }
> @@ -64,13 +65,16 @@ void bpf_map_array_get(const int map_fd,
>  		       const uint32_t *const array_indx,
>  		       uint64_t *const array_val)
>  {
> -	union bpf_attr elem_attr = {
> -		.map_fd = map_fd,
> -		.key = ptr_to_u64(array_indx),
> -		.value = ptr_to_u64(array_val),
> -		.flags = 0
> -	};
> -	const int ret = bpf(BPF_MAP_LOOKUP_ELEM, &elem_attr, sizeof(elem_attr));
> +	/* zero-initialize entire struct including padding bits */
> +	union bpf_attr elem_attr = {};
> +	int ret;
> +
> +	elem_attr.map_fd = map_fd;
> +	elem_attr.key = ptr_to_u64(array_indx);
> +	elem_attr.value = ptr_to_u64(array_val);
> +	elem_attr.flags = 0;
> +
> +	ret = bpf(BPF_MAP_LOOKUP_ELEM, &elem_attr, sizeof(elem_attr));
>  
>  	if (ret) {
>  		tst_brk(TBROK | TTERRNO,
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
