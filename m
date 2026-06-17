Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D6ECD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 15:05:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7E6F3E59B0
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 17:05:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C8D93E5920
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 17:05:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D59F4600F3F
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 17:05:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6016175E2C;
 Wed, 17 Jun 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56946779A8;
 Wed, 17 Jun 2026 15:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XWwZFaG3MmpHRQAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 17 Jun 2026 15:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id E8DB1A0EC0; Wed, 17 Jun 2026 17:04:56 +0200 (CEST)
Date: Wed, 17 Jun 2026 17:04:56 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <5mgsr6wbxlcupaswzvuihzqjiybsbbtqyr5ckftlmnk4mxhidw@7cxkbdqpqxmk>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
 <20260616210448.12175-6-anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616210448.12175-6-anonymemeow@gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6016175E2C
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] fanotify21: Add FAN_REPORT_TID pidfd
 coverage
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

On Wed 17-06-26 05:04:48, AnonymeMeow wrote:
> Add a test case that generates an event from a thread. Without
> FAN_REPORT_TID, the reported pidfd is expected to refer to the thread
> group leader. With FAN_REPORT_TID, it is expected to refer to the
> triggering thread. Keep the event thread alive until the reported pidfd
> is verified, because pidfd fdinfo reports Pid: -1 after the thread
> exits.
> 
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> This patch is exactly the same as v1 except that the pthread link flag
> is added to fanotify21 target.
> 
> ---
>  testcases/kernel/syscalls/fanotify/Makefile   |  2 +-
>  .../kernel/syscalls/fanotify/fanotify21.c     | 47 ++++++++++++++++++-
>  2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
> index 3628094ba..b20bb50e9 100644
> --- a/testcases/kernel/syscalls/fanotify/Makefile
> +++ b/testcases/kernel/syscalls/fanotify/Makefile
> @@ -2,7 +2,7 @@
>  #  Copyright (c) Jan Kara <jack@suse.cz>, 2013
>  
>  top_srcdir		?= ../../../..
> -fanotify11: CFLAGS+=-pthread
> +fanotify11 fanotify21: CFLAGS+=-pthread
>  include $(top_srcdir)/include/mk/testcases.mk
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> index c05c69d58..c97ec4f92 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -25,6 +25,7 @@
>  #include "tst_test.h"
>  #include "tst_safe_stdio.h"
>  #include "tst_safe_macros.h"
> +#include "tst_safe_pthread.h"
>  #include "lapi/pidfd.h"
>  
>  #ifdef HAVE_SYS_FANOTIFY_H
> @@ -47,6 +48,7 @@ struct pidfd_fdinfo_t {
>  
>  static struct test_case_t {
>  	char *name;
> +	int event_by_thread;
>  	int want_pidfd_err;
>  	int remount_ro;
>  } test_cases[] = {
> @@ -54,15 +56,24 @@ static struct test_case_t {
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
> @@ -108,6 +119,26 @@ static void generate_event(void)
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
> @@ -165,6 +196,7 @@ static void do_test(unsigned int num)
>  	int nopidfd_err = tc->want_pidfd_err ?
>  			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
>  	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
> +	pthread_t event_thread;
>  	pid_t reader_pid;
>  	int reader_exit_status;
>  
> @@ -186,7 +218,16 @@ static void do_test(unsigned int num)
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
> @@ -349,6 +390,9 @@ next_event:
>  
>  	if (tc->want_pidfd_err)
>  		exit(0);
> +
> +	if (tc->event_by_thread)
> +		event_thread_join(event_thread);
>  }
>  
>  static void do_cleanup(void)
> @@ -371,6 +415,7 @@ static struct tst_test test = {
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
