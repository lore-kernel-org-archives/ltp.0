Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905D2C25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 12:01:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22F0E3CEBBD
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 14:01:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0C4A3CCAB1
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 14:01:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D91DC1A01967
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 14:01:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5230221B71;
 Fri, 27 Oct 2023 12:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698408066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+6Af8Sb6cGPzO8jEIx+1g0hnJHlIA76Cw4/kb3m/Uw=;
 b=hBjmI23pdMiTIaqgmrUfMi59PIXBfcBgZRH8NMC80mAupbUCYBQDuwm+XVimQpbr0F/zNm
 9WpgB1gdLklT2Zh18zSe+ms8oFfbOklwDIfCWnDwDreLUYJxn5ORwus9jN7UESrbcNEi9y
 ZDspIrQ45gm+7MJNqnl9+hc8FsAsnVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698408066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+6Af8Sb6cGPzO8jEIx+1g0hnJHlIA76Cw4/kb3m/Uw=;
 b=TcGKI5O37WzLAomtfbktYRasg11as+9E6SERSvdNiewKF0KEM3371LnMx5sxRBDDdRNWtr
 w1bvLIIJPaCvppCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26CD313524;
 Fri, 27 Oct 2023 12:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ic4gB4KmO2UqLwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 12:01:06 +0000
Date: Fri, 27 Oct 2023 14:01:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231027120104.GA657078@pevik>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz>
 <CAEemH2fQuqPhd+5wjiBeswJQOG=FikpKmL6eubdWgyWqehX6fw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fQuqPhd+5wjiBeswJQOG=FikpKmL6eubdWgyWqehX6fw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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

Hi all,

[ Cc Cyril ]

...
> > +++ b/include/tst_test.h
> > @@ -297,9 +297,12 @@ struct tst_test {
> >         /* NULL terminated array of resource file names */
> >         const char *const *resource_files;

> > -       /* NULL terminated array of needed kernel drivers */
> > +       /* NULL terminated array of needed kernel drivers to be checked */
> >         const char * const *needs_drivers;

> > +       /* NULL terminated array of needed kernel drivers to be loaded
> > with modprobe */
> > +       const char * const *modprobe;
> > +
> >         /*
> >          * {NULL, NULL} terminated array of (/proc, /sys) files to save
> >          * before setup and restore after cleanup
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 087c62a16..ccbaa4c02 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -49,6 +49,7 @@ const char *TCID __attribute__((weak));
> >  #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"

> >  #define DEFAULT_TIMEOUT 30
> > +#define MODULES_MAX_LEN 10

> >  struct tst_test *tst_test;

> > @@ -83,6 +84,8 @@ const char *tst_ipc_path = ipc_path;

> >  static char shm_path[1024];

> > +static int modules_loaded[MODULES_MAX_LEN];
> > +
> >  int TST_ERR;
> >  int TST_PASS;
> >  long TST_RET;
> > @@ -1135,6 +1138,29 @@ static void do_cgroup_requires(void)
> >         tst_cg_init();
> >  }

> > +/*
> > + * Search kernel driver in /proc/modules.
> > + *
> > + * @param driver The name of the driver.
> > + * @return 1 if driver is found, otherwise 0.
> > + */
> > +static int module_loaded(const char *driver)



> What about renaming it as tst_module_is_loaded() and move into tst_kernel.h?
> I guess we could make use of it widely for checking module loading or not.

I can do that, but lib/tst_kernel.c uses the old API. I guess it would fit
better in lib/tst_module.c, but that also uses the old API. Most of the tests
are converted, but at least these modules are still in the old API and use
tst_module_load from tst_module.h:

testcases/kernel/device-drivers/acpi/ltp_acpi.c
testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
testcases/kernel/device-drivers/pci/tpci_user/tpci.c
testcases/kernel/device-drivers/uaccess/uaccess.c
testcases/kernel/firmware/fw_load_user/fw_load.c
testcases/kernel/device-drivers/tbio/tbio_user/tbio.c

All but the last one were written by Alexey, they look ok, so they should 
probably be converted. But I would rather not block this .modprobe_module
effort due this.

IMHO We need another file, which would be new API only. I'm also not sure if
it's a good idea to put another file with just single function to it. We already
have 38 lib/tst_*.c files which use new API. Any tip, what to use?
Or should I really put it into lib/tst_module.c ain include/tst_module.h, but
not into include/old/old_module.h (as we want old tests to be converted first?).

> > +{
> > +       char line[4096];
> > +       int found = 0;
> > +       FILE *file = SAFE_FOPEN("/proc/modules", "r");
> > +
> > +       while (fgets(line, sizeof(line), file)) {
> > +               if (strstr(line, driver)) {
> > +                       found = 1;
> > +                       break;
> > +               }
> > +       }
> > +       SAFE_FCLOSE(file);
> > +
> > +       return found;
> > +}
> > +
> >  static void do_setup(int argc, char *argv[])
> >  {
> >         if (!tst_test)
> > @@ -1194,6 +1220,20 @@ static void do_setup(int argc, char *argv[])
> >                         safe_check_driver(name);
> >         }

> > +       if (tst_test->modprobe) {




> > +               const char *name;
> > +               int i;
> > +
> > +               for (i = 0; (name = tst_test->modprobe[i]); ++i) {
> > +                       /* only load module if not already loaded */
> > +                       if (!module_loaded(name) &&
> > tst_check_builtin_driver(name)) {
> > +                               const char *const cmd_modprobe[] =
> > {"modprobe", name, NULL};
> > +                               SAFE_CMD(cmd_modprobe, NULL, NULL);



> And here print the name to tell people the module is loaded.


+1

> > +                               modules_loaded[i] = 1;
> > +                       }
> > +               }
> > +       }



> This part could be as a separate function like tst_load_module() and
> built single into another lib. We prefer to keep the main tst_test.c
> as a simple outline.

+1 for a separate function, it should be in the same file as
tst_module_is_loaded().

> On the other hand, the extern functions can be used separately to let
> modules to be loaded and unloaded during the test iteration.
> It gives us more flexibility in test case design.

Having it as the separate function would allow to use it in
kvm_pagefault01.c and zram03.c - tiny simplification as they now call
SAFE_CMD().

kvm_pagefault01.c and can_common.h use them parameters, it might be worth
to implement them.

> > +
> >         if (tst_test->mount_device)
> >                 tst_test->format_device = 1;

> > @@ -1362,6 +1402,19 @@ static void do_cleanup(void)

> >         tst_sys_conf_restore(0);

> > +       if (tst_test->modprobe) {




> > +               const char *name;
> > +               int i;
> > +
> > +               for (i = 0; (name = tst_test->modprobe[i]); ++i) {
> > +                       if (!modules_loaded[i])
> > +                               continue;
> > +
> > +                       const char *const cmd_rmmod[] = {"rmmod", name,
> > NULL};
> > +                       SAFE_CMD(cmd_rmmod, NULL, NULL);


> Print unload module name.

+1

> > +               }
> > +       }


> Here as well. something maybe like tst_unload_module().

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
