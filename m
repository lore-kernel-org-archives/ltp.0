Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3524CC36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 13:23:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D7833C8E3B
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 14:23:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BC653C85D0
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 14:23:22 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71E5F600477
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 14:23:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A46B41F38D;
 Mon, 24 Mar 2025 13:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742822600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yn2rPYrk/2N+WSZ3exWnIzaB+do5DnCJbj2ySG0tbUA=;
 b=n4bV2dNk1r/YJKipXh+B/Z1E3PPba4xbG3vFE46i5nHeBjPKAmmoaAJxeJkvpZIbMBybH+
 OvI6HGGIuJ1GAKceHlF9rTrCJKsNjpBqKyk9eV2+j2mWAUWZlgiOnUB0K/2h4+ylW3QADC
 Yf4OAb1QXeagNVzMlwHVws30TWJIEUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742822600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yn2rPYrk/2N+WSZ3exWnIzaB+do5DnCJbj2ySG0tbUA=;
 b=nZdOLv/BOrYwXnpPwuz8q25K1Os0O7vjtf5nLAykG2fhbgmAp+LobnF0bsUB+PqVWFk0vB
 wYC+jV2WuRmzaDAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742822600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yn2rPYrk/2N+WSZ3exWnIzaB+do5DnCJbj2ySG0tbUA=;
 b=n4bV2dNk1r/YJKipXh+B/Z1E3PPba4xbG3vFE46i5nHeBjPKAmmoaAJxeJkvpZIbMBybH+
 OvI6HGGIuJ1GAKceHlF9rTrCJKsNjpBqKyk9eV2+j2mWAUWZlgiOnUB0K/2h4+ylW3QADC
 Yf4OAb1QXeagNVzMlwHVws30TWJIEUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742822600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yn2rPYrk/2N+WSZ3exWnIzaB+do5DnCJbj2ySG0tbUA=;
 b=nZdOLv/BOrYwXnpPwuz8q25K1Os0O7vjtf5nLAykG2fhbgmAp+LobnF0bsUB+PqVWFk0vB
 wYC+jV2WuRmzaDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 989C1137AC;
 Mon, 24 Mar 2025 13:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MUE4Jchc4WfTMwAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 24 Mar 2025 13:23:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 3CCDFA076A; Mon, 24 Mar 2025 14:23:20 +0100 (CET)
Date: Mon, 24 Mar 2025 14:23:20 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <xogk7anduhuifpdgrnjilfojrdtoupltfoy24fxoknjceeluac@emwvchf4gn4z>
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250319192742.999506-2-amir73il@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.998]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] fanotify24: remove redundant event_count field
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 19-03-25 20:27:40, Amir Goldstein wrote:
> treat the event-set as a null terminated array.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify24.c     | 31 +++++++++----------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
> index 8a448ea50..539f74137 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify24.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
> @@ -60,13 +60,12 @@ static struct tcase {
>  	const char *tname;
>  	struct fanotify_mark_type mark;
>  	unsigned long long mask;
> -	int event_count;
>  	struct event event_set[EVENT_SET_MAX];
>  } tcases[] = {
>  	{
>  		"inode mark, FAN_OPEN_PERM | FAN_PRE_ACCESS events",
>  		INIT_FANOTIFY_MARK_TYPE(INODE),
> -		FAN_OPEN_PERM | FAN_PRE_ACCESS, 4,
> +		FAN_OPEN_PERM | FAN_PRE_ACCESS,
>  		{
>  			{FAN_OPEN_PERM, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY},
> @@ -77,7 +76,7 @@ static struct tcase {
>  	{
>  		"inode mark, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
>  		INIT_FANOTIFY_MARK_TYPE(INODE),
> -		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 3,
> +		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
>  		{
>  			{FAN_PRE_ACCESS, FAN_DENY},
>  			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
> @@ -87,7 +86,7 @@ static struct tcase {
>  	{
>  		"mount mark, FAN_OPEN_PERM | FAN_PRE_ACCESS events",
>  		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		FAN_OPEN_PERM | FAN_PRE_ACCESS, 4,
> +		FAN_OPEN_PERM | FAN_PRE_ACCESS,
>  		{
>  			{FAN_OPEN_PERM, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY},
> @@ -98,7 +97,7 @@ static struct tcase {
>  	{
>  		"mount mark, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
>  		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 3,
> +		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
>  		{
>  			{FAN_PRE_ACCESS, FAN_DENY},
>  			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
> @@ -108,7 +107,7 @@ static struct tcase {
>  	{
>  		"filesystem mark, FAN_OPEN_PERM | FAN_PRE_ACCESS events",
>  		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> -		FAN_OPEN_PERM | FAN_PRE_ACCESS, 4,
> +		FAN_OPEN_PERM | FAN_PRE_ACCESS,
>  		{
>  			{FAN_OPEN_PERM, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY},
> @@ -119,7 +118,7 @@ static struct tcase {
>  	{
>  		"filesystem mark, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
>  		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> -		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 3,
> +		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
>  		{
>  			{FAN_PRE_ACCESS, FAN_DENY},
>  			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
> @@ -129,7 +128,7 @@ static struct tcase {
>  	{
>  		"parent watching children, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
>  		INIT_FANOTIFY_MARK_TYPE(PARENT),
> -		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM | FAN_EVENT_ON_CHILD, 3,
> +		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM | FAN_EVENT_ON_CHILD,
>  		{
>  			{FAN_PRE_ACCESS, FAN_DENY},
>  			{FAN_PRE_ACCESS, FAN_DENY},
> @@ -139,14 +138,14 @@ static struct tcase {
>  	{
>  		"parent not watching children, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
>  		INIT_FANOTIFY_MARK_TYPE(PARENT),
> -		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 0,
> +		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
>  		{
>  		}
>  	},
>  	{
>  		"inode mark, FAN_PRE_ACCESS event allowed",
>  		INIT_FANOTIFY_MARK_TYPE(INODE),
> -		FAN_PRE_ACCESS, 1,
> +		FAN_PRE_ACCESS,
>  		{
>  			/* This allows multiple FAN_PRE_ACCESS events */
>  			{FAN_PRE_ACCESS, FAN_ALLOW},
> @@ -225,7 +224,7 @@ static void generate_events(struct tcase *tc)
>  	 */
>  	if (!exp_errno) {
>  		fd = SAFE_OPEN(FILE_EXEC_PATH, O_RDWR);
> -		if (!tc->event_count)
> +		if (!tc->event_set[0].mask)
>  			exp_errno = ETXTBSY;
>  	}
>  
> @@ -335,10 +334,10 @@ static void test_fanotify(unsigned int n)
>  	/*
>  	 * Process events
>  	 *
> -	 * tc->count + 1 is to let read() wait for child process to exit
> -	 * and to accomodate for extra access events
> +	 * even if we do not expect another event, let read() wait for child
> +	 * process to exit and accomodate for multiple access events
>  	 */
> -	while (test_num < tc->event_count + 1 && fd_notify != -1) {
> +	while (test_num < EVENT_SET_MAX && fd_notify != -1) {
>  		struct fanotify_event_metadata *event;
>  
>  		if (i == len) {
> @@ -363,7 +362,7 @@ static void test_fanotify(unsigned int n)
>  		 * generate an unknown number of access permission events if they
>  		 * are allowed.
>  		 */
> -		if (test_num > 0 && test_num == tc->event_count &&
> +		if (test_num > 0 && !event_set[test_num].mask &&
>  		    event_set[test_num-1].response == FAN_ALLOW)
>  			test_num--;
>  
> @@ -418,7 +417,7 @@ static void test_fanotify(unsigned int n)
>  		test_num++;
>  	}
>  
> -	for (; test_num < tc->event_count; test_num++) {
> +	for (; event_set[test_num].mask && test_num < EVENT_SET_MAX; test_num++) {
>  		tst_res(TFAIL, "didn't get event: mask=%llx",
>  			event_set[test_num].mask);
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
