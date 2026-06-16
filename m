Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A425CD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 07:57:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1406F3E5957
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:57:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9ED73E2238
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:57:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4AB0E2003A7
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:57:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BC106C8B5;
 Tue, 16 Jun 2026 07:57:32 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02CCD779A8;
 Tue, 16 Jun 2026 07:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LYatAOwBMWp/WwAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 16 Jun 2026 07:57:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id ADDDEA12D3; Tue, 16 Jun 2026 09:57:27 +0200 (CEST)
Date: Tue, 16 Jun 2026 09:57:27 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <vi4aunwnidqqcqpnixkv3s3eqlbqkdvxru2bvzetygj6vwnfxh@b7pekjoycsj5>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
 <20260615180629.7148-6-anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615180629.7148-6-anonymemeow@gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 0BC106C8B5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] fanotify21: Add FAN_REPORT_TID pidfd coverage
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
Cc: amir73il@gmail.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 16-06-26 02:06:29, AnonymeMeow wrote:
> Add a test case that generates an event from a thread. Without
> FAN_REPORT_TID, the reported pidfd is expected to refer to the thread
> group leader. With FAN_REPORT_TID, it is expected to refer to the
> triggering thread. Keep the event thread alive until the reported pidfd
> is verified, because pidfd fdinfo reports Pid: -1 after the thread
> exits.
> 
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify21.c     | 47 ++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> index fd43c8c1c..8a5b35334 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -24,6 +24,7 @@
>  #include "tst_test.h"
>  #include "tst_safe_stdio.h"
>  #include "tst_safe_macros.h"
> +#include "tst_safe_pthread.h"
>  #include "lapi/pidfd.h"
>  
>  #ifdef HAVE_SYS_FANOTIFY_H
> @@ -46,6 +47,7 @@ struct pidfd_fdinfo_t {
>  
>  static struct test_case_t {
>  	char *name;
> +	int event_by_thread;
>  	int want_pidfd_err;
>  	int remount_ro;
>  } test_cases[] = {
> @@ -53,15 +55,24 @@ static struct test_case_t {
>  		"return a valid pidfd for event created by self",
>  		0,
>  		0,
> +		0,
> +	},
> +	{
> +		"return a valid pidfd for event created by thread",
> +		1,
> +		0,
> +		0,
>  	},
>  	{
>  		"return invalid pidfd for reader in descendant PID namespace",
> +		0,
>  		1,
>  		0,
>  	},
>  	{
>  		"fail to open rw fd for event created on read-only mount",
>  		0,
> +		0,
>  		1,
>  	},
>  };
> @@ -107,6 +118,26 @@ static void generate_event(void)
>  	SAFE_CLOSE(fd);
>  }
>  
> +static void *generate_event_pthread(void *args LTP_ATTRIBUTE_UNUSED)
> +{
> +	generate_event();
> +	TST_CHECKPOINT_WAIT(0);
> +	return NULL;
> +}
> +
> +static pthread_t event_thread_create(void)
> +{
> +	pthread_t pthread_id;
> +	SAFE_PTHREAD_CREATE(&pthread_id, NULL, generate_event_pthread, NULL);
> +	return pthread_id;
> +}
> +
> +static void event_thread_join(pthread_t pthread_id)
> +{
> +	TST_CHECKPOINT_WAKE(0);
> +	SAFE_PTHREAD_JOIN(pthread_id, NULL);
> +}
> +
>  static const char *test_variant_name(void)
>  {
>  	switch (tst_variant) {
> @@ -164,6 +195,7 @@ static void do_test(unsigned int num)
>  	int nopidfd_err = tc->want_pidfd_err ?
>  			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
>  	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
> +	pthread_t event_thread;
>  	pid_t reader_pid;
>  	int reader_exit_status;
>  
> @@ -185,7 +217,16 @@ static void do_test(unsigned int num)
>  	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
>  		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
>  
> -	generate_event();
> +	/*
> +	 * Generate the event by either self or a thread. Event generation in
> +	 * a thread is done so that in FAN_REPORT_TID mode the pidfd can be
> +	 * verified to refer to the tid, not the tgid. The thread waits until
> +	 * the pidfd is verified before exiting.
> +	 */
> +	if (tc->event_by_thread)
> +		event_thread = event_thread_create();
> +	else
> +		generate_event();
>  
>  	/*
>  	 * Read the event in either self or a child process in a descendant
> @@ -348,6 +389,9 @@ next_event:
>  
>  	if (tc->want_pidfd_err)
>  		exit(0);
> +
> +	if (tc->event_by_thread)
> +		event_thread_join(event_thread);
>  }
>  
>  static void do_cleanup(void)
> @@ -370,6 +414,7 @@ static struct tst_test test = {
>  	.mount_device = 1,
>  	.mntpoint = MOUNT_PATH,
>  	.forks_child = 1,
> +	.needs_checkpoints = 1,
>  };
>  
>  #else
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
