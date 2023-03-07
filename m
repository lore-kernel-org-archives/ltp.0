Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B566C678D4
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 08:28:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BDD43CD9A6
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 09:28:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E5FC3C27D9
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 09:28:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A3F9A1400DB8
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 09:27:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B162D1FE0C;
 Tue,  7 Mar 2023 08:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678177678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28yTniayCcq29dBnoLLYst9U3AxOizw4COSSlH+UzQc=;
 b=REPsWIKAqBMRP4m9JE4jAZzGyfsjnqRQBh+G/0XV3gTV0IIMBZgZDdDDfdsgR1MOMRRVlh
 HD3RapvPynwwrQANdJGsp3lPfPu0eeTwA5CbC96UOycQ1fr+8RVzsVy8IomTsxEEkTQ652
 VX9RVaxbet7KBRq7SOakizURlC6mJd8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FB0A1341F;
 Tue,  7 Mar 2023 08:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dRpeNo31BmRQGAAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 07 Mar 2023 08:27:57 +0000
Date: Tue, 7 Mar 2023 03:27:55 -0500
To: Li Wang <liwang@redhat.com>
Message-ID: <20230307082755.GA13371@localhost>
References: <20230306151303.2757-1-wegao@suse.com>
 <20230306235715.29868-1-wegao@suse.com>
 <CAEemH2fZs33CkwHY+Jre71eKpkB6bPPmOOxuHZQTGHOofa9KaA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fZs33CkwHY+Jre71eKpkB6bPPmOOxuHZQTGHOofa9KaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] kill01: New case cgroup kill
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 07, 2023 at 03:13:56PM +0800, Li Wang wrote:
> Hi Wei,
> 
> The new test generally looks good to me.
> 
> I'm thinking maybe we make use of guarded buffers which could
> remove the setup/cleanup function then. And doing memset(buf,...)
> before reading into buf[] is quite necessary, to avoid someone
> running this test with parameter '-i N' that the buf[] is polluted
> by the first time.
> 
> https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L1799
> 
> <https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L1799>
> e.g.

I have tried use guarded buffers but compile can not pass. 
Following error will trigger since buf_len is caculate instead of FIX constant. So 
I suppose we can not use guarded buffers?

kill01.c:131:34: error: initializer element is not constant
  .bufs = (struct tst_buffers []) {

For memset before reading buf issue, i will update in next patch.

> 
> --- a/testcases/kernel/controllers/kill/kill01.c
> +++ b/testcases/kernel/controllers/kill/kill01.c
> @@ -26,7 +26,7 @@
> 
>  #define MAX_PID_NUM 100
>  #define pid_num MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
> -#define buf_len (20 * pid_num)
> +#define buf_len (10 * MAX_PID_NUM)
> 
>  static char *buf;
>  static struct tst_cg_group *cg_child_test_simple;
> @@ -60,7 +60,6 @@ static void child_fn(void)
> 
>         while (getppid() == ppid)
>                 usleep(1000);
> -
>  }
> 
>  static int cg_run_nowait(const struct tst_cg_group *const cg,
> @@ -82,6 +81,8 @@ static int cg_wait_for_proc_count(const struct
> tst_cg_group *cg, int count)
>         int attempts;
>         char *ptr;
> 
> +       memset(buf, 0, buf_len);
> +
>         for (attempts = 100; attempts >= 0; attempts--) {
>                 int nr = 0;
> 
> @@ -121,23 +122,14 @@ static void run(void)
>         cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
>  }
> 
> -static void setup(void)
> -{
> -       buf = SAFE_MALLOC(buf_len);
> -       memset(buf, 0, buf_len);
> -}
> -
> -static void cleanup(void)
> -{
> -       free(buf);
> -}
> -
>  static struct tst_test test = {
>         .test_all = run,
> -       .setup = setup,
> -       .cleanup = cleanup,
>         .forks_child = 1,
>         .max_runtime = 15,
>         .needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
>         .needs_cgroup_ver = TST_CG_V2,
> +       .bufs = (struct tst_buffers []) {
> +               {&buf, .size = buf_len},
> +               {}
> +       }
>  };
> 
> Anyway this version you could add my reviewed-by:
> 
> Reviewed-by: Li Wang <liwang@redhat.com>
> 
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
