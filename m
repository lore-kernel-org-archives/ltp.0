Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED032C433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 14:34:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E8583C9166
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 15:34:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C7063C222E
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 15:34:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 753161400B63
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 15:34:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8FEEC2112A;
 Wed,  5 Jan 2022 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641393256;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IknSewtKUmKylAxmyyodA4napLr+2XD71v+v5IsOQcg=;
 b=MzdwQNjPF4oJyA7SZYiYiJpi8LxX2GyD6nNKFAX3/r+NdfaXLFLKA0adY+0emlB9UcmAM3
 4hA9vSQBsr27jCENdjDbqEvbnIyWpx90ZCeRZIq5BiOdYb4Vi23bLYVOV7DGVJtAOEYEzK
 rrli9VCmO/pCD+cyFHvtVM0mFkWPtAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641393256;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IknSewtKUmKylAxmyyodA4napLr+2XD71v+v5IsOQcg=;
 b=2oJv04fwOjrLRr0Z2pQN5PhMnEbwFJxYLkQ7V2+60RUyuYSyDgMByPbyqD20bjLKA2OMiF
 nyG8hvCmb8phucBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FDA513BE7;
 Wed,  5 Jan 2022 14:34:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zXYmFWis1WFJVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jan 2022 14:34:16 +0000
Date: Wed, 5 Jan 2022 15:34:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YdWsZpTjnBLszubC@pevik>
References: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641279439-2421-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdQpwpbyGGNKx84z@pevik> <61D545B7.7020003@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61D545B7.7020003@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] shell: add kconfig parse api
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> >> +'$TST_NEEDS_KCONFIGS'.
> >> +Optional '$TST_NEEDS_KCONFIG_IFS' is used for splitting, default value is comma.
> >> +Optional '$TST_TCONF_IF_KCONFIG' is used for deciding how to exit the test if kernel
> >> +.config doesn't meet test's requirement, default value is 1(TCONF). Otherwise, just
> > I wonder if we need TST_TCONF_IF_KCONFIG functionality in the test or if it's an
> > user request (i.e. user like variable LTP_TCONF_IF_KCONFIG doc/user-guide.txt).
> > Because I'm not sure whether test would need it, but I can imagine user want to
> > have test running even kernel config is not available (e.g. embedded platforms).
> > Or maybe we need both user variable and test variable.
> Oh, I misunderstand the usage.

> I should use TST_TCONF_IF_KCONFIG for non-found kconfig file instead of 
> non-found kconfig list.

> I think one variable is enough.

OK, but I'd like to know others' opinion what's needed.
Cyril, Li?

> > Also not sure about TST_TCONF_IF_KCONFIG name, IMHO "IF" should be replaced to
> > something which describes what it does.
> Thinking a good name isn't a easy thing.

> how about TCONF_IF_NO_KCONFIG?

Well, I was not sure about "IF" part. For use in test code it should have "TST_"
prefix, for users to set it should have "LTP_" prefix.

> > Also this patchset is about syncing C API functionality with shell API. But you
> > introduce TST_TCONF_IF_KCONFIG only for shell. Shouldn't it be functionality for
> > both parts?
> Yes, code maybe as below:

> void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len)
> +static char kconfig_flag;
> +
> +int tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len)
>   {
>          char line[128];
>          unsigned int vars_found = 0;
> +       const char *flag = getenv("TWARN_IF_NO_KCONFIG");
> +
> +       if (flag && !strcmp(flag,"y"))
> +               kconfig_flag = 'y';

>          FILE *fp = open_kconfig();
> -       if (!fp)
> +       if (!fp) {
> +               if (kconfig_flag == 'y') {
> +                       tst_res(TWARN, "Cannot parse kernel .config");
> +                       return 1;
> +               }
>                  tst_brk(TBROK, "Cannot parse kernel .config");
> -
> +       }
>          while (fgets(line, sizeof(line), fp)) {
>                  if (kconfig_parse_line(line, vars, vars_len))
>                          vars_found++;
> @@ -198,6 +210,7 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], 
> size_t vars_len)

>   exit:
>          close_kconfig(fp);
> +       return 0;
>   }

Sure, once we agree what should be implemented.

>   static size_t array_len(const char *const kconfigs[])
> @@ -504,7 +517,9 @@ int tst_kconfig_check(const char *const kconfigs[])

>          var_cnt = populate_vars(exprs, expr_cnt, vars);

> -       tst_kconfig_read(vars, var_cnt);
> +       ret = tst_kconfig_read(vars, var_cnt);
> +       if (ret)
> +               return kconfig_flag == 'y' ? 0 : 1;




> > More notes about this variable also below.

> > BTW github actions have probably kernel config on expected place, which means
> > that most of the new tests TCONF, but tst_check_kconfig05.sh TFAIL.
> I guess we can export the  KCONFIG_PATH to solve this problem. But I 
> don't know the expected place on github actions.

Sure, for github we can find config place.
But this can happen to user who runs the test. IMHO test should not fail if
user's system is without config. That's why I'd like to have a variable making
errors non-fatal.

> > tst_rhost_run 1 TCONF: veth(null)      0  TWARN  :  /__w/ltp/ltp/lib/tst_kernel.c:110: expected file /lib/modules/5.11.0-1022-azure/modules.dep does not exist or not a file
> > 320
> > (null)      0  TWARN  :  /__w/ltp/ltp/lib/tst_kernel.c:110: expected file /lib/modules/5.11.0-1022-azure/modules.builtin does not exist or not a file driver not available

> >> +use TWRAN and continue to run test.
> >> +
> >> +Now, we support the length of kconfig list is 10.
> > Why 10? Cyril suggested that in PR, where he suggested to use separated
> > variables:
> > https://github.com/linux-test-project/ltp/issues/891#issuecomment-989712350

> > But for string used like array there is no performance limitation, thus I'd use
> > something like 50 or 100. Because for certain IMA tests there are at least 6
> > kconfig requirements, thus>  10 could be hit.
> If case needs more than 10 kconfigs, we can use & ie
> "CONFIG_EX4_FS & CONFIG_XFS_FS & CONFIG_QUOTAL_FS, CONFIG_PROC_FS..."
Sure. I just meant there is no reason to put low number and then workaround it.

> >> --- a/testcases/lib/tst_test.sh
> >> +	tst_check_kconfigs $kconfig1 $kconfig2 $kconfig3 $kconfig4 $kconfig5 $kconfig6\
> >> +			$kconfig7 $kconfig8 $kconfig9 $kconfig10
> >> +	if [ $? -ne 0 ]; then
> >> +		if [ $TST_TCONF_IF_KCONFIG -eq 1 ]; then
> >> +			tst_brk TCONF "kconfig not available"

> >> +		else
> >> +			tst_res TWARN "kconfig not available"
> > This is quite strong: either test "fails" due TWARN non-zero exit code or it's
> > skipped. I'd prefer to have user variable for systems which are properly
> > configured (user will make sure all kconfig options are set), but it's just
> > missing kconfig due system configuration.
> I plan to fix the variable usage for non-found kconfig path/file instead 
> of kconfig list.

> Best Regards
> Yang Xu

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
