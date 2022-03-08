Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D94C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 14:40:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64CAB3C2730
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 15:40:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFB7A3C0FA8
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 15:40:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DBF51400971
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 15:40:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4D08210F4;
 Tue,  8 Mar 2022 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646750431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHBEqFBnLlHBBIXm7POvkxGUO+l9EtYp6CFTOB50uOQ=;
 b=2vmZqxUEnm+xC0aTs5kG6NmueFua8ALjBq5bpHIr00EMDOQjfZlHW3DvftcbDs8cJTC6oE
 i0JN/nv+j2THwNPxKzcvKMAB7b4eQI8vv4TTkqB/XXR8/pFJo4vblFu2Qgl0XJ8SGPFuaQ
 JhpAO5C1TOQVk5VZrOXpPTmGFj1TfTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646750431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHBEqFBnLlHBBIXm7POvkxGUO+l9EtYp6CFTOB50uOQ=;
 b=wkPjlC5hvO5hEFXWMgUm4Nxef8pBPkFy9Sik+3GjO9T7mIg/eJ5TuxN3RWv03Fh4U7xcXa
 R3L03+/HqU4Fb0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1D1613CC6;
 Tue,  8 Mar 2022 14:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yGneKt9qJ2LtPwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Mar 2022 14:40:31 +0000
Date: Tue, 8 Mar 2022 15:42:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yidrapuv55RcgOXQ@yuki>
References: <20220208100948.22913-1-andrea.cervesato@suse.de>
 <20220208100948.22913-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220208100948.22913-3-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/9] Rewrite mesgq_nstest.c using new LTP API
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines Corp., 2009
> + *				Veerendra C <vechandr@in.ibm.com>
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * In Parent Process , create mesgq with key 154326L
> + * Now create container by passing 1 of the flag values..
> + *	Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
> + * In cloned process, try to access the created mesgq
> + * Test PASS: If the mesgq is readable when flag is None.
> + * Test FAIL: If the mesgq is readable when flag is Unshare or Clone.

Please reformat this into asciidoc.

> + */
> +
> +#define _GNU_SOURCE
> +
>  #include <sys/ipc.h>
> +#include <sys/wait.h>
>  #include <sys/msg.h>
> -#include <libclone.h>
> -#include "test.h"
> -#include "ipcns_helper.h"
> -
> -#define KEY_VAL		154326L
> -#define UNSHARESTR	"unshare"
> -#define CLONESTR	"clone"
> -#define NONESTR		"none"
> -
> -char *TCID = "mesgq_nstest";
> -int TST_TOTAL = 1;
> -int p1[2];
> -int p2[2];
> -struct msg_buf {
> -	long int mtype;		/* type of received/sent message */
> -	char mtext[80];		/* text of the message */
> +#include <sys/types.h>
> +#include "tst_test.h"
> +#include "common.h"
> +
> +#define KEY_VAL 154326L
> +
> +static char *str_op = "clone";
> +
> +static int p1[2];
> +static int p2[2];
> +
> +static struct msg_buf {
> +	int mtype; /* type of received/sent message */
> +	char mtext[80]; /* text of the message */

Just remove the useless comments here.

>  } msg;
>  
> -void mesgq_read(int id)
> +static void mesgq_read(int id)
>  {
> -	int READMAX = 80;
>  	int n;
> -	/* read msg type 5 on the Q; msgtype, flags are last 2 params.. */
>  
> -	n = msgrcv(id, &msg, READMAX, 5, 0);
> -	if (n == -1)
> -		perror("msgrcv"), tst_exit();
> +	/* read msg type 5 on the Q; msgtype, flags are last 2 params.. */
> +	n = msgrcv(id, &msg, sizeof(struct msg_buf) - sizeof(long), 5, 0);
> +	if (n < 0)
> +		tst_brk(TBROK, "msgrcv: %s", tst_strerrno(-n));
>  
> -	tst_resm(TINFO, "Mesg read of %d bytes; Type %ld: Msg: %.*s",
> -		 n, msg.mtype, n, msg.mtext);
> +	tst_res(TINFO, "Mesg read of %d bytes; Type %ld: Msg: %.*s", n,
> +		msg.mtype, n, msg.mtext);
>  }
>  
> -int check_mesgq(void *vtest)
> +static int check_mesgq(LTP_ATTRIBUTE_UNUSED void *vtest)
>  {
>  	char buf[3];
>  	int id;
>  
> -	(void) vtest;
> +	SAFE_CLOSE(p1[1]);
> +	SAFE_CLOSE(p2[0]);
>  
> -	close(p1[1]);
> -	close(p2[0]);
> +	SAFE_READ(1, p1[0], buf, 3);
>  
> -	read(p1[0], buf, 3);
>  	id = msgget(KEY_VAL, 0);
> -	if (id == -1)
> -		write(p2[1], "notfnd", 7);
> +	if (id < 0)
> +		SAFE_WRITE(1, p2[1], "notfnd", 7);
>  	else {
> -		write(p2[1], "exists", 7);
> +		SAFE_WRITE(1, p2[1], "exists", 7);
>  		mesgq_read(id);
>  	}

There is absolutely no reason to propagate the test results via pipe in
the new library tests. You can use the tst_res() directly here in the
child process.

Generally there is no need for the pipes at all, the parent should just
send a message and start a child that will attempt to receive it. The
child will either produce PASS or FAIL depending on a value of a global
variable that would be initialized in the setup with the value of the
enum that describes the test type (NONE, CLONE, UNSHARE) and the parent
will just do tst_reap_children() and the remove the message queue.

> -	tst_exit();
> -}
>  
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_newipc();
> +	return 0;
>  }
>  
> -int main(int argc, char *argv[])
> +static void run(void)
>  {
> -	int ret, use_clone = T_NONE, id, n;
> -	char *tsttype = NONESTR;
> +	int use_clone = T_NONE, id, n;
>  	char buf[7];
>  
> -	setup();
> -
> -	if (argc != 2) {
> -		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>", argv[0]);
> -		tst_brkm(TFAIL, NULL, " where clone, unshare, or fork specifies"
> -			 " unshare method.");
> -	}
> -
>  	/* Using PIPE's to sync between container and Parent */
> -	if (pipe(p1) == -1) {
> -		perror("pipe");
> -		exit(EXIT_FAILURE);
> -	}
> -	if (pipe(p2) == -1) {
> -		perror("pipe");
> -		exit(EXIT_FAILURE);
> -	}
> +	SAFE_PIPE(p1);
> +	SAFE_PIPE(p2);
>  
> -	tsttype = NONESTR;
> -
> -	if (strcmp(argv[1], "clone") == 0) {
> +	if (!strcmp(str_op, "clone"))
>  		use_clone = T_CLONE;
> -		tsttype = CLONESTR;
> -	} else if (strcmp(argv[1], "unshare") == 0) {
> +	else if (!strcmp(str_op, "unshare"))
>  		use_clone = T_UNSHARE;
> -		tsttype = UNSHARESTR;
> -	}
>  
>  	id = msgget(KEY_VAL, IPC_CREAT | IPC_EXCL | 0600);
> -	if (id == -1) {
> -		perror("msgget");
> +	if (id < 0) {
>  		/* Retry without attempting to create the MQ */
>  		id = msgget(KEY_VAL, 0);
> -		if (id == -1)
> -			perror("msgget failure"), exit(1);
> +		if (id < 0)
> +			tst_brk(TBROK, "msgget: %s", tst_strerrno(-id));
>  	}
>  
>  	msg.mtype = 5;
>  	strcpy(msg.mtext, "Message of type 5!");
> +
>  	n = msgsnd(id, &msg, strlen(msg.mtext), 0);
> -	if (n == -1)
> -		perror("msgsnd"), tst_exit();
> +	if (n < 0)
> +		tst_brk(TBROK, "msgsnd: %s", tst_strerrno(-n));
>  
> -	tst_resm(TINFO, "mesgq namespaces test : %s", tsttype);
> -	/* fire off the test */
> -	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
> -	if (ret < 0) {
> -		tst_brkm(TFAIL, NULL, "%s failed", tsttype);
> -	}
> +	tst_res(TINFO, "mesgq namespaces test : %s", str_op);
>  
> -	close(p1[0]);
> -	close(p2[1]);
> -	write(p1[1], "go", 3);
> -
> -	read(p2[0], buf, 7);
> -	if (strcmp(buf, "exists") == 0) {
> -		if (use_clone == T_NONE)
> -			tst_resm(TPASS, "Plain cloned process found mesgq "
> -				 "inside container");
> -		else
> -			tst_resm(TFAIL,
> -				 "%s: Container init process found mesgq",
> -				 tsttype);
> +	/* fire off the test */
> +	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
> +
> +	SAFE_CLOSE(p1[0]);
> +	SAFE_CLOSE(p2[1]);
> +
> +	SAFE_WRITE(1, p1[1], "go", 3);
> +	SAFE_READ(1, p2[0], buf, 7);
> +
> +	if (!strcmp(buf, "exists")) {
> +		if (use_clone == T_NONE) {
> +			tst_res(TPASS, "Plain cloned process found mesgq "
> +				       "inside container");
> +		} else {
> +			tst_res(TFAIL, "%s: Container init process found mesgq",
> +				str_op);
> +		}
>  	} else {
> -		if (use_clone == T_NONE)
> -			tst_resm(TFAIL,
> -				 "Plain cloned process didn't find mesgq");
> -		else
> -			tst_resm(TPASS, "%s: Container didn't find mesgq",
> -				 tsttype);
> +		if (use_clone == T_NONE) {
> +			tst_res(TFAIL,
> +				"Plain cloned process didn't find mesgq");
> +		} else {
> +			tst_res(TPASS, "%s: Container didn't find mesgq",
> +				str_op);
> +		}
>  	}
>  
>  	/* Delete the mesgQ */
>  	id = msgget(KEY_VAL, 0);
>  	msgctl(id, IPC_RMID, NULL);
> +}
>  
> -	tst_exit();
> +static void setup(void)
> +{
> +	check_newipc();

Technically this is not required for "none".

> +	if (strcmp(str_op, "clone") && strcmp(str_op, "unshare") &&
> +	    strcmp(str_op, "none"))
> +		tst_brk(TBROK, "Test execution mode <clone|unshare|none>");

Can we just add a function to parse the str_op and return the enum into
the common.h instead of checking it here and then converting it in the
run() function we should convert it here in the setup...

>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.options =
> +		(struct tst_option[]){
> +			{ "m:", &str_op,
> +			  "Test execution mode <clone|unshare|none>" },
> +			{},
> +		},
> +};
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
