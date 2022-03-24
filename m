Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AD0C433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 20:41:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B9EC3C54E4
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 21:41:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB7DD3C06A9
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 21:40:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B96051000793
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 21:40:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 084911F38D;
 Thu, 24 Mar 2022 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648154450;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUK7Yk/MLB64Auxy6brolVLnAVR8yIOK+th8depWWJw=;
 b=hRrDdHiYDbHpOBL8ZqKI/4UJROEH2r3thGcfgCuBoyc+4mU0La2poPr1vdbzxjeHlAWd5P
 1BIb4zB+xHEmL80M91ElUO3fUrVVQTZYELCoyFjJRdd4xk2C/bxJbSJRMsB0bbaesvQt3g
 28N8UXv/fVFv/LPb4XIadbTT0hTsI1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648154450;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUK7Yk/MLB64Auxy6brolVLnAVR8yIOK+th8depWWJw=;
 b=Up/2HuGW+yXsc/dM1QOJ5FO4sjDKG+NM1WhbvIu6H7c4iilLv1co29iXPYVykhPKj8u7N1
 DHA7EKFvdXteIUAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF9E9132E9;
 Thu, 24 Mar 2022 20:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vTH6J1HXPGJWHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 24 Mar 2022 20:40:49 +0000
Date: Thu, 24 Mar 2022 21:40:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YjzXT5JLWOccCwE1@pevik>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-4-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315122351.8556-4-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/8] Rewrite userns03.c using new LTP API
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

Hi Andrea,

generally LGTM, few notes below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  testcases/kernel/containers/userns/userns03.c | 266 ++++++++----------
> +/*\
> + * [Description]
> + *
> + * Verify that /proc/PID/uid_map and /proc/PID/gid_map contains three values
> + * separated by white space:
>   * ID-inside-ns   ID-outside-ns   length
>   *
>   * ID-outside-ns is interpreted according to which process is opening the file.
> @@ -26,29 +21,23 @@
>   * The string "deny" would be written to /proc/self/setgroups before GID
>   * check if setgroups is allowed, see kernel commits:
>   *
> - *   commit 9cc46516ddf497ea16e8d7cb986ae03a0f6b92f8
> - *   Author: Eric W. Biederman <ebiederm@xmission.com>
> - *   Date:   Tue Dec 2 12:27:26 2014 -0600
> - *     userns: Add a knob to disable setgroups on a per user namespace basis
> - *
> - *   commit 66d2f338ee4c449396b6f99f5e75cd18eb6df272
> - *   Author: Eric W. Biederman <ebiederm@xmission.com>
> - *   Date:   Fri Dec 5 19:36:04 2014 -0600
> - *     userns: Allow setting gid_maps without privilege when setgroups is disabled

> + * commit 9cc46516ddf497ea16e8d7cb986ae03a0f6b92f8
> + * Author: Eric W. Biederman <ebiederm@xmission.com>
> + * Date:   Tue Dec 2 12:27:26 2014 -0600
> + * userns: Add a knob to disable setgroups on a per user namespace basis
>   *
> + * commit 66d2f338ee4c449396b6f99f5e75cd18eb6df272
> + * Author: Eric W. Biederman <ebiederm@xmission.com>
> + * Date:   Fri Dec 5 19:36:04 2014 -0600
> + * userns: Allow setting gid_maps without privilege when setgroups is disabled
Commits like these two will be very badly formatted in html/pdf output.
I'd also add some blank lines so that text will be split in paragraphs.
Thus I suggest:

/*\
 * [Description]
 *
 * Verify that /proc/PID/uid_map and /proc/PID/gid_map contains three values
 * separated by white space:
 *
 * ID-inside-ns   ID-outside-ns   length
 *
 * ID-outside-ns is interpreted according to which process is opening the file.
 *
 * If the process opening the file is in the same user namespace as the process
 * PID, then ID-outside-ns is defined with respect to the parent user namespace.
 *
 * If the process opening the file is in a different user namespace, then
 * ID-outside-ns is defined with respect to the user namespace of the process
 * opening the file.
 *
 * The string "deny" would be written to /proc/self/setgroups before GID
 * check if setgroups is allowed, see kernel commits:
 *
 * * 9cc46516ddf4 ("userns: Add a knob to disable setgroups on a per user namespace basis")
 * * 66d2f338ee4c ("userns: Allow setting gid_maps without privilege when setgroups is disabled")
 */


> @@ -75,161 +64,148 @@ static int child_fn1(void)
...
>  	/* map file format:ID-inside-ns   ID-outside-ns   length
> -	If the process opening the file is in the same user namespace as
> -	the process PID, then ID-outside-ns is defined with respect to the
> -	 parent user namespace.*/
> +	 * If the process opening the file is in the same user namespace as
> +	 * the process PID, then ID-outside-ns is defined with respect to the
> +	 * parent user namespace
> +	 */
>  	if (idinsidens != CHILD2UID || idoutsidens != parentuid) {
> -		printf("child_fn2 checks /proc/cpid2/uid_map:\n");
> -		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> -			idinsidens, idoutsidens);
> -		exit_val = 1;
> +		tst_res(TINFO, "child2 checks /proc/cpid2/uid_map");
nit: I'd put this TINFO before if, so that it's printed also for TPASS.
Also I'd wrote CPID2 to be obvious it's supposed to be a number, or even put
pid value.

> +		tst_res(TFAIL, "unexpected: namespace ID inside=%d outside=%d", idinsidens, idoutsidens);
> +	} else {
> +		tst_res(TPASS, "expected namespaces IDs");
>  	}

>  	sprintf(cpid1uidpath, "/proc/%d/uid_map", cpid1);
> -	SAFE_FILE_SCANF(NULL, cpid1uidpath, "%d %d %d", &idinsidens,
> -		&idoutsidens, &length);
> +	SAFE_FILE_SCANF(cpid1uidpath, "%d %d %d", &idinsidens, &idoutsidens, &length);

>  	/* If the process opening the file is in a different user namespace,
> -	then ID-outside-ns is defined with respect to the user namespace
> -	of the process opening the file.*/
> +	 * then ID-outside-ns is defined with respect to the user namespace
> +	 * of the process opening the file
> +	 */
>  	if (idinsidens != CHILD1UID || idoutsidens != CHILD2UID) {
> -		printf("child_fn2 checks /proc/cpid1/uid_map:\n");
> -		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> -			idinsidens, idoutsidens);
> -		exit_val = 1;
> +		tst_res(TINFO, "child2 checks /proc/cpid1/uid_map");
And here as well.

> +		tst_res(TFAIL, "unexpected: namespace ID inside=%d outside=%d", idinsidens, idoutsidens);
> +	} else {
> +		tst_res(TPASS, "expected namespaces IDs");
>  	}

>  	sprintf(cpid1gidpath, "/proc/%d/gid_map", cpid1);
> -	SAFE_FILE_SCANF(NULL, "/proc/self/gid_map", "%d %d %d",
> -		 &idinsidens, &idoutsidens, &length);
> +	SAFE_FILE_SCANF("/proc/self/gid_map", "%d %d %d", &idinsidens, &idoutsidens, &length);

>  	if (idinsidens != CHILD2GID || idoutsidens != parentgid) {
> -		printf("child_fn2 checks /proc/cpid2/gid_map:\n");
> -		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> -			idinsidens, idoutsidens);
> -		exit_val = 1;
> +		tst_res(TINFO, "child2 checks /proc/cpid2/gid_map");
And here.
> +		tst_res(TFAIL, "unexpected: namespace ID inside=%d outside=%d", idinsidens, idoutsidens);
> +	} else {
> +		tst_res(TPASS, "expected namespaces IDs");
>  	}

> -	SAFE_FILE_SCANF(NULL, cpid1gidpath, "%d %d %d", &idinsidens,
> -		&idoutsidens, &length);
> +	SAFE_FILE_SCANF(cpid1gidpath, "%d %d %d", &idinsidens, &idoutsidens, &length);

>  	if (idinsidens != CHILD1GID || idoutsidens != CHILD2GID) {
> -		printf("child_fn1 checks /proc/cpid1/gid_map:\n");
> -		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> -			idinsidens, idoutsidens);
> -		exit_val = 1;
> +		tst_res(TINFO, "child1 checks /proc/cpid1/gid_map");
And here.
> +		tst_res(TFAIL, "unexpected: namespace ID inside=%d outside=%d", idinsidens, idoutsidens);
> +	} else {
> +		tst_res(TPASS, "expected namespaces IDs");
>  	}

> -int main(int argc, char *argv[])
> +static void run(void)
>  {
> +	parentuid = geteuid();
> +	parentgid = getegid();
> +
> +	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, NULL);
> +	if (cpid1 < 0)
> +		tst_brk(TBROK | TTERRNO, "cpid1 clone failed");
> +
> +	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn2, NULL);
> +	if (cpid2 < 0)
> +		tst_brk(TBROK | TTERRNO, "cpid2 clone failed");
> +
> +	if (access("/proc/self/setgroups", F_OK) == 0) {
> +		sprintf(path, "/proc/%d/setgroups", cpid1);
> +
> +		fd = SAFE_OPEN(path, O_WRONLY, 0644);
> +		SAFE_WRITE(1, fd, "deny", 4);
> +		SAFE_CLOSE(fd);
> +
> +		/* If the setgroups file has the value "deny",
> +		 * then the setgroups(2) system call can't
> +		 * subsequently be reenabled (by writing "allow" to
> +		 * the file) in this user namespace.  (Attempts to
> +		 * do so will fail with the error EPERM.)
> +		 */
> +
> +		/* test that setgroups can't be re-enabled */
> +		fd = SAFE_OPEN(path, O_WRONLY, 0644);
> +		ret = write(fd, "allow", 5);
> +
> +		if (ret >= 0)
nit: Maybe keep ret != -1 (as was in original?)
> +			tst_brk(TBROK, "write action should fail");
> +		else if (errno != EPERM)
> +			tst_brk(TBROK | TTERRNO, "unexpected error");
> +
> +		SAFE_CLOSE(fd);
> +
> +		tst_res(TPASS, "setgroups can't be re-enabled");
> +
> +		sprintf(path, "/proc/%d/setgroups", cpid2);
> +
> +		fd = SAFE_OPEN(path, O_WRONLY, 0644);
> +		SAFE_WRITE(1, fd, "deny", 4);
> +		SAFE_CLOSE(fd);
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
