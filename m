From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Jan 2021 22:48:46 +0100
Subject: [LTP] [PATCH v3 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <YAc5hMnHm0GIQJ96@google.com>
References: <20210119160316.4776-1-pvorel@suse.cz>
 <20210119160316.4776-2-pvorel@suse.cz>
 <YAc5hMnHm0GIQJ96@google.com>
Message-ID: <YAdTvomK8qSjpD0l@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sandeep,

thanks for your comments!

> > +	SAFE_ASPRINTF(NULL, &path, "/lib/modules/%s/%s", uts.release, file);

> This is just the ramdisk location, the on-disk location is
> /vendor/lib/modules/. I also think that the ramdisk one goes away after we
> switch over 2nd stage init. Is there a test I can run that uses these
> functions now to make sure this works?
Any C based test which defines needs_drivers (e.g. fsetxattr02, ioctl08,
uevent01, ...) (or shell based tests with TST_NEEDS_DRIVERS, but you probably
don't run any shell test).

> Also, unfortunately (and sadly) we may have to do something Android specific
> downstream as the /vendor/lib/modules and /lib/modules only started to appear
> as of android 11 :(.
Feel free to send a patch upstream. If not that much complicated and you're
willing to maintain it, it might get to upstream (depends on other maintainers,
but we're quite open).

> Once you share how I can test, I'm happy to test and add my Tested-by for
> Android.

> +cc: kernel-team@android.com
> > +
> > +	if (stat(path, &st) || !(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))) {
> > +		tst_resm(TWARN, "expected file %s does not exist or not a file", path);
> > +		return -1;
> > +	}
> > +
> > +	if (access(path, R_OK)) {
> > +		tst_resm(TWARN, "file %s cannot be read", path);
> > +		return -1;
> > +	}
> > +
> > +	SAFE_ASPRINTF(NULL, &search, "/%s.ko", driver);
> > +
> > +	f = SAFE_FOPEN(NULL, path, "r");
> > +
> > +	while (fgets(buf, sizeof(buf), f)) {
> > +		if (sscanf(buf, "%s", module) != 1)
> > +			continue;
> > +
> > +		if (strstr(module, search) != NULL) {
> > +			SAFE_FCLOSE(NULL, f);
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	SAFE_FCLOSE(NULL, f);
> > +
> > +	return -1;
> > +}
> > +
> > +int tst_check_driver_(const char *driver)
> > +{
> > +	if (!tst_search_driver(driver, "modules.dep") ||
> > +		!tst_search_driver(driver, "modules.builtin"))
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +
> > +int tst_check_driver(const char *driver)
> > +{
> > +#ifdef __ANDROID__
> > +	/*
> > +	 * Android may not have properly installed modules.* files. We could
> > +	 * search modules in /system/lib/modules, but to to determine built-in

> the appropriate location would be /lib/modules OR /vendor/lib/modules.
OK. I tested only old aosp (Oreo, Nougat and KitKat).
Out of curiosity, does have Android 11 modules.{builtin,dep}? If yes, it'd make
sense to treat it as Linux (apply "modules always available" approach only if
files aren't available).

Kind regards,
Petr

> > +	 * drivers we need modules.builtin. Therefore assume all drivers are
> > +	 * available.
> >  	 */
> >  	return 0;
> >  #endif
