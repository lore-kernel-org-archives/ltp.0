Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E72E81BA6
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 11:47:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8273D3CA379
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 12:47:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5DC93C99D6
 for <ltp@lists.linux.it>; Mon,  9 Feb 2026 12:47:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B866F14001F7
 for <ltp@lists.linux.it>; Mon,  9 Feb 2026 12:47:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1E0E3E6F2;
 Mon,  9 Feb 2026 11:47:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B57E3EA63;
 Mon,  9 Feb 2026 11:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zfvSIDXJiWmUAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Feb 2026 11:47:01 +0000
Date: Mon, 9 Feb 2026 12:47:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Changwei Zou <changwei.zou@canonical.com>
Message-ID: <20260209114700.GA488389@pevik>
References: <20260207145942.299366-1-changwei.zou@canonical.com>
 <20260209075146.GA450151@pevik>
 <46bdaf39-4d82-4b33-94c6-0ef8525ffaf1@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46bdaf39-4d82-4b33-94c6-0ef8525ffaf1@canonical.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C1E0E3E6F2
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/tls: reserve pre-TCB space to avoid
 undefined behavior in clone10.c
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

Hi Changwei,

> Hi Petr,
> With the original upstream LTP,
> I ran clone10 -i 1000 on three machines (including AArch64 and AMD64), and
> it failed on all of them.

> This suggests there may be another bug that we still need to identify.

Yes, it's a separate bug, not relevant to your fix. I trigger it on x86_64.

Kind regards,
Petr

> Thank you very much for your invaluable information.
> Kind regards,
> Changwei
> *1. On an AArch64 cloud instance*
> ```sh
> azure@clone10-aarch64-kcp:~/orig/ltp$
> ./testcases/kernel/syscalls/clone/clone10-i1000
> clone10.c:68: TPASS:Parent(PID: 106163,TID:106163): TLS value correct: 100
> clone10.c:48: TINFO:Child(PID: 106163,TID:106200): TLS value set to: 101
> tst_test.c:1953: TBROK:TestkilledbySIGBUS!
> Summary:
> passed 36
> failed 0
> broken 1
> skipped 0
> warnings 0
> ```
> *2. On an AMD64 machine*
> ```sh
> ubuntu@ZBook:~/orig/ltp$ ./testcases/kernel/syscalls/clone/clone10-i1000
> clone10.c:48: TINFO:Child(PID: 125560,TID:125870): TLS value set to: 101
> clone10.c:68: TPASS:Parent(PID: 125560,TID:125560): TLS value correct: 100
> double freeorcorruption(out)
> clone10.c:48: TINFO:Child(PID: 125560,TID:125871): TLS value set to: 101
> clone10.c:68: TPASS:Parent(PID: 125560,TID:125560): TLS value correct: 100
> tst_test.c:1953: TBROK:TestkilledbySIGIOT/SIGABRT!
> Summary:
> passed 311
> failed 0
> broken 1
> skipped 0
> warnings 0
> ```
> *3. On an AArch64 machine*
> ```sh
> ubuntu@asus-pe100a:~/orig/ltp$
> ./testcases/kernel/syscalls/clone/clone10-i1000
> clone10.c:68: TPASS:Parent(PID: 158953,TID:158953): TLS value correct: 100
> clone10.c:48: TINFO:Child(PID: 158953,TID:159029): TLS value set to: 101
> tst_test.c:1953: TBROK:TestkilledbySIGSEGV!
> Summary:
> passed 75
> failed 0
> broken 1
> skipped 0
> warnings 0
> ```


> On 2/9/26 18:51, Petr Vorel wrote:
> > Hi Changwei,

> > > Allocate extra space before the TLS area to hold a struct pthread, ensuring
> > > THREAD_SELF->cancelhandling is initialized to 0. This prevents undefined
> > > behavior in __pthread_disable_asynccancel(), which is called at thread
> > > cancellation points such as write().
> > > Without this, touch_tls_in_child() could get stuck in tst_res().
> > LGTM, but I'd prefer others had a look on it.
> > Acked-by: Petr Vorel<pvorel@suse.cz>

> > BTW clone10.c segfaults w/a the patch when run with more iterations:

> > ./clone10 -i200
> > clone10.c:48: TINFO: Child (PID: 4271, TID: 4285): TLS value set to: 101
> > clone10.c:68: TPASS: Parent (PID: 4271, TID: 4271): TLS value correct: 100
> > clone10.c:48: TINFO: Child (PID: 4271, TID: 4286): TLS value set to: 101
> > clone10.c:68: TPASS: Parent (PID: 4271, TID: 4271): TLS value correct: 100
> > tst_test.c:1953: TBROK: Test killed by SIGSEGV!

> > Summary:
> > passed   15
> > failed   0
> > broken   1
> > skipped  0
> > warnings 0

> > Kind regards,
> > Petr

> > > (gdb) bt
> > >    0  futex_wait () at ../sysdeps/nptl/futex-internal.h:141
> > >    1  futex_wait_simple () at ../sysdeps/nptl/futex-internal.h:172
> > >    2  __libc_disable_asynccancel () at ../nptl/cancellation.c:100
> > >    3  __GI___libc_write () at ../sysdeps/unix/sysv/linux/write.c:26
> > >    4  __GI___libc_write () at ../sysdeps/unix/sysv/linux/write.c:24
> > >    5  print_result ()  at tst_test.c:387
> > >    6  tst_vres_ () at tst_test.c:401
> > >    7  tst_res_ () at tst_test.c:512
> > >    8  touch_tls_in_child (arg=<optimized out>) atclone10.c:48
> > >    9  thread_start () at ../sysdeps/unix/sysv/linux/aarch64/clone.S:78
> > > Signed-off-by: Changwei Zou<changwei.zou@canonical.com>
> > > ---
> > >   include/lapi/tls.h | 16 +++++++++++++---
> > >   1 file changed, 13 insertions(+), 3 deletions(-)
> > > diff --git a/include/lapi/tls.h b/include/lapi/tls.h
> > > index 468fe3086..7f2fa18a1 100644
> > > --- a/include/lapi/tls.h
> > > +++ b/include/lapi/tls.h
> > > @@ -22,6 +22,15 @@
> > >   #define TLS_SIZE 4096
> > >   #define TLS_ALIGN 16
> > > +/*
> > > + * Space allocated large enough to hold a struct pthread.
> > > + *
> > > + * Zero-initialized to ensure THREAD_SELF->cancelhandling starts at 0,
> > > + * avoiding undefined behavior (e.g., in clone10.c) in __pthread_disable_asynccancel(),
> > > + * which is called at thread cancellation points such as write().
> > > + */
> > > +#define TLS_PRE_TCB_SIZE (TLS_ALIGN * 256)
> > > +
> > >   #if defined(__x86_64__)
> > >   typedef struct {
> > >   	void *tcb;
> > > @@ -36,10 +45,11 @@ extern void *tls_ptr;
> > >   static inline void *allocate_tls_area(void)
> > >   {
> > > -	void *tls_area = aligned_alloc(TLS_ALIGN, TLS_SIZE);
> > > +	char *tls_area = aligned_alloc(TLS_ALIGN, TLS_PRE_TCB_SIZE + TLS_SIZE);
> > >   	if (!tls_area)
> > >   		tst_brk(TBROK | TERRNO, "aligned_alloc failed");
> > > -	memset(tls_area, 0, TLS_SIZE);
> > > +	memset(tls_area, 0, TLS_PRE_TCB_SIZE + TLS_SIZE);
> > > +	tls_area += TLS_PRE_TCB_SIZE;
> > >   #if defined(__x86_64__)
> > >   	tcb_t *tcb = (tcb_t *)tls_area;
> > > @@ -59,7 +69,7 @@ static inline void free_tls(void)
> > >   {
> > >   	usleep(10000);
> > >   	if (tls_ptr) {
> > > -		free(tls_ptr);
> > > +		free(((char *)tls_ptr) - TLS_PRE_TCB_SIZE);
> > >   		tls_ptr = NULL;
> > >   	}
> > >   }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
