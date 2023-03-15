Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D213BC7618A
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 12:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AADED3CD48D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 13:55:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E64AF3C54D5
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:55:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 237C61400253
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:55:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F1601FD6C;
 Wed, 15 Mar 2023 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678884937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wD7+TJosfIhchdT6jxOqCcqwXBsuuYl2SqtBZgaQfPA=;
 b=KWzgPlM82Z2ttPMNqjhe82PV5FilDanfKzAxNmgkxJmF+gB3vEZVLP1N11ZpizoaBbHcbW
 KQP7SrW6X1NZT1mWoNqhkwM44Cn7GNUWnNYhKI02fhrhK2L6mZChE82d6YuHMGt3SvB6il
 goGpuS952MBvgocKzBZwA20v0sTjBpA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44ACC13A00;
 Wed, 15 Mar 2023 12:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JSA3AkjAEWTaGAAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 15 Mar 2023 12:55:36 +0000
Date: Wed, 15 Mar 2023 08:55:32 -0400
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20230315125532.GB10248@localhost>
References: <20230306235715.29868-1-wegao@suse.com>
 <20230307085139.3574-1-wegao@suse.com> <87ttyo6g7o.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ttyo6g7o.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] kill01: New case cgroup kill
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Li Wang <liwan@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Mar 13, 2023 at 10:45:12AM +0000, Richard Palethorpe wrote:
> Hello,
> 
> > +static int wait_for_pid(pid_t pid)
> > +{
> > +	int status, ret;
> > +
> > +again:
> > +	ret = waitpid(pid, &status, 0);
> > +	if (ret == -1) {
> > +		if (errno == EINTR)
> > +			goto again;
> > +
> > +		return -1;
> > +	}
> > +
> > +	if (!WIFEXITED(status))
> > +		return -1;
> > +
> > +	return WEXITSTATUS(status);
> > +}
> 
> We have tst_reap_children for this, but this just appears to be wrong
> for this test.
tst_reap_children can not return reason of status, such as i need call 
WIFSIGNALED(wstatus) in next patch to make sure children is killed by 
signal.

> > + * A simple process running in a sleep loop until being
> > + * re-parented.
> > + */
> > +static void child_fn(void)
> > +{
> > +	int ppid = getppid();
> > +
> > +	while (getppid() == ppid)
> > +		usleep(1000);
> > +
> > +}
> > +
> > +static int cg_run_nowait(const struct tst_cg_group *const cg,
> > +		  void (*fn)(void))
> 
> Why keep this function?
> 
> If you want to convert tests to LTP, then don't do the minimum possible
> to use the LTP API. Use as much of it as possible otherwise we are just
> importing brittle self tests.
> 
function is useful and wrap the fork action & put pid into cgroup.procs,
is there any LTP API can replace this function? Could you help give example.
> > +{
> > +	int pid;
> > +
> > +	pid = SAFE_FORK();
> > +	if (pid == 0) {
> > +		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
> > +		fn();
> > +	}
> > +
> > +	return pid;
> > +}
> > +
> > +static int cg_wait_for_proc_count(const struct tst_cg_group *cg, int count)
> > +{
> > +	int attempts;
> > +	char *ptr;
> > +
> > +	for (attempts = 100; attempts >= 0; attempts--) {
> > +		int nr = 0;
> > +
> > +		SAFE_CG_READ(cg, "cgroup.procs", buf, buf_len);
> > +
> > +		for (ptr = buf; *ptr; ptr++)
> > +			if (*ptr == '\n')
> > +				nr++;
> > +
> > +		if (nr >= count)
> > +			return 0;
> > +
> > +		usleep(100000);
> 
> It's best to avoid arbitrary sleep values and attempts. You could use
> TST_CHECKPOINT* or increment a counter in some shared memory with
> SAFE_MMAP and tst_atomic_inc.
> 
I will try to use TST_CHECKPOINT* to sync before call this function
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> > +static void run(void)
> > +{
> > +	pid_t pids[MAX_PID_NUM];
> > +	int i;
> > +
> > +	cg_child_test_simple = tst_cg_group_mk(tst_cg,
> > "cg_test_simple");
> > +
> > +	memset(buf, 0, buf_len);
> 
> IIRC guarded buffers are zeroed already.
Already explained by Li Wang in other email.
> 
> > +
> > +	for (i = 0; i < pid_num; i++)
> > +		pids[i] = cg_run_nowait(cg_child_test_simple, child_fn);
> 
> If the parent is killed and the children are moved then they will return
> and cause a fork bomb.
There is no extra fork action in child_fn so all child_fn will reparent and exit.
So i do not think fork bomb will happen.
> 
> This is not obvious because of the unecessary indirection (function
> pointer and functions).
> 
> > +
> > +	TST_EXP_PASS(cg_wait_for_proc_count(cg_child_test_simple,
> > pid_num));
> 
> If this fails then there will be little information to debug it. This is
> a common issue with the self tests which we will be importing into the LTP.
> 
Add extra log info into this function maybe help, what's your suggestion?
> > +	SAFE_CG_PRINTF(cg_child_test_simple, "cgroup.kill", "%d", 1);
> > +
> > +	for (i = 0; i < pid_num; i++) {
> > +		/* wait_for_pid(pids[i]); */
> > +		TST_EXP_PASS_SILENT(wait_for_pid(pids[i]) == SIGKILL);
> 
> It seems wait_for_pid will never == SIGKILL. The function does not
> inspect the signal a process was killed with at all.
> 
> The test passes becaues this is not the correct use of TST_EXP_PASS*.
Good catch! Thanks a lot for finding this, i should use WIFSIGNALED 
to translate status and check children killed by SIGKILL, will fix this
in next patch.
> 
> > +	}
> > +
> > +	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	buf = tst_alloc(buf_len);
> 
> Simple allocations like this can be done in the test struct.
This already discussed with Wang Li, compile error will happen since buf_len 
not fixed in my case.
> 
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.forks_child = 1,
> > +	.max_runtime = 15,
> > +	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
> 
> Why do we need the memory controller?
> 
> If it is just to make the LTP library happy, then you can change the
> library instead (e.g. add a "cgroup" pseudo controller if we didn't do
> that already).
You guess right, i just go quick way to let LTP happy xD
I will check library and try to implement this.

Thanks again for your valuable feedback!
> 
> > +	.needs_cgroup_ver = TST_CG_V2,
> > +};
> > -- 
> > 2.35.3
> 
> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
