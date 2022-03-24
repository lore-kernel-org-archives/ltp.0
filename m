Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46759C433EF
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 14:23:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3295F3C9AF8
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 15:23:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EB9C3C96B4
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 15:23:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5896200CFA
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 15:23:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BA5D210DD;
 Thu, 24 Mar 2022 14:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648131818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0LD+xw9G7bJ193vMWotZgI+0xT5H4dl3bIDoFSlbWCs=;
 b=TnvL+Pu9Qbm9UoMI+t5NdupZ9Qgng3BAUclEZ6mHePaqTLyjeWtz2vZlMuLhlWTWgsxtp7
 W5i+6OgRSjs+ZS8p2FE6pLSh+3A8+WlBTO0x8ONwp9j1dP+9I8kBg/mriKHG9XKzOY7VcH
 qLm9AeJ9h2CZp4Ca/xls8jyrFhoZIPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648131818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0LD+xw9G7bJ193vMWotZgI+0xT5H4dl3bIDoFSlbWCs=;
 b=QqWI4seWz4EXDguW5ND2NBxb8X/ViF4vK6290eZSNGjpIJPc5mPsCGu+DnQ+PyN70tIunq
 BKKKAUQltpDMd9Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1620B12FF7;
 Thu, 24 Mar 2022 14:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GvsJBOp+PGLGBQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 24 Mar 2022 14:23:38 +0000
Date: Thu, 24 Mar 2022 15:25:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yjx/dQD99V/KansZ@yuki>
References: <20220315103254.7185-1-andrea.cervesato@suse.de>
 <20220315103254.7185-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315103254.7185-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 01/10] Rewrite mesgq_nstest.c using new LTP API
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
> +#include "tst_safe_sysv_ipc.h"
> +#include "tst_test.h"
> +#include "common.h"
> +
> +#define KEY_VAL 154326L
> +#define MSG_TYPE 5
> +#define MSG_TEXT "My message!"
> +
> +static char *str_op = "clone";

There is a small problem with setting the str_op here. The test library
expects that the str_* variables are initialized to NULL and uses that
logic to detect redefinitions (i.e. passing a parameter more than once
on the commandline). Which means that we get a warning in the case that
we pass -m on the commandline and because of that warning the test ends
with non-zero exit value.

I guess that the easiests solution would be not to initialize it here
and instead default to T_NONE in the get_clone_unshare_enum() when NULL
is passed.

> +static int use_clone;
> +static int ipc_id = -1;
> +
> +static struct msg_buf {
> +	long mtype;
> +	char mtext[80];
>  } msg;
>  
> -void mesgq_read(int id)
> +static int check_mesgq(LTP_ATTRIBUTE_UNUSED void *vtest)
>  {
> -	int READMAX = 80;
> -	int n;
> -	/* read msg type 5 on the Q; msgtype, flags are last 2 params.. */
> +	int id, n;
>  
> -	n = msgrcv(id, &msg, READMAX, 5, 0);
> -	if (n == -1)
> -		perror("msgrcv"), tst_exit();
> -
> -	tst_resm(TINFO, "Mesg read of %d bytes; Type %ld: Msg: %.*s",
> -		 n, msg.mtype, n, msg.mtext);
> -}
> +	id = msgget(KEY_VAL, 0);
>  
> -int check_mesgq(void *vtest)
> -{
> -	char buf[3];
> -	int id;
> +	if (id < 0) {
> +		if (use_clone == T_NONE)
> +			tst_res(TFAIL, "Plain cloned process didn't find mesgq");
> +		else
> +			tst_res(TPASS, "%s: container didn't find mesgq", str_op);
> +	} else {
> +		if (use_clone == T_NONE)
> +			tst_res(TPASS, "Plain cloned process found mesgq inside container");
> +		else
> +			tst_res(TFAIL, "%s: container init process found mesgq", str_op);
>  
> -	(void) vtest;
> +		n = SAFE_MSGRCV(id, &msg, sizeof(msg.mtext), MSG_TYPE, 0);
>  
> -	close(p1[1]);
> -	close(p2[0]);
> +		tst_res(TINFO, "Mesg read of %d bytes, Type %ld, Msg: %s", n, msg.mtype, msg.mtext);
>  
> -	read(p1[0], buf, 3);
> -	id = msgget(KEY_VAL, 0);
> -	if (id == -1)
> -		write(p2[1], "notfnd", 7);
> -	else {
> -		write(p2[1], "exists", 7);
> -		mesgq_read(id);
> +		if (strcmp(msg.mtext, MSG_TEXT))
> +			tst_res(TFAIL, "Received the wrong text message");
>  	}

We can save some indentation by using return instead of else here as:

	if (id < 0) {
		...
		return;
	}

	if (use_clone == T_NONE)
	...

	n = SAFE_MSGRCV(...);

Also it does not make sense to try to receive any messages in the case
that use_clone != T_NONE.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
