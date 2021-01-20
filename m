From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jan 2021 16:21:31 +0100
Subject: [LTP] [PATCH v3 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <YAg6wTVc6AB28smR@yuki.lan>
References: <20210119160316.4776-1-pvorel@suse.cz>
 <20210119160316.4776-2-pvorel@suse.cz> <YAg6wTVc6AB28smR@yuki.lan>
Message-ID: <YAhKe84FcrNEYFcC@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > +	while (fgets(buf, sizeof(buf), f)) {
> > +		if (sscanf(buf, "%s", module) != 1)
> > +			continue;

> What is the point in the sscanf() here?

> Why can't we just strstr(buf, search) here?

modules.dep has format:
module:[dependency [another-dependency ...]]

e.g.:
kernel/arch/x86/kernel/cpu/mce/mce-inject.ko.xz:
kernel/arch/x86/crypto/twofish-x86_64.ko.xz: kernel/crypto/twofish_common.ko.xz
kernel/arch/x86/crypto/aesni-intel.ko.xz: kernel/crypto/crypto_simd.ko.xz kernel/crypto/cryptd.ko.xz kernel/arch/x86/crypto/glue_helper.ko.xz

First reading "%s" reads only first module with ':' separator.
Searching without it could find first module which is as dependency (e.g.
"/twofish_common.ko.xz" instead of "/twofish-x86_64.ko.xz"). Although that
shouldn't be a problem, because it's very unlikely that module dependency is
missing. Do you want me to drop sscanf() or put some comment?

Also man modules.dep(5) warns about using text format as "their format is
subject to change in the future". Hopefully we can depend on it. Or should we
use binary format?

...
> > +	if (!tst_check_driver_(driver))
> > +		return 0;
> > +
> > +	if (strrchr(driver, '-') || strrchr(driver, '_')) {
> > +		char *driver2 = strdup(driver);
> > +		char *ix = driver2;
> > +		char find = '-', replace = '_';
> > +
> > +		if (strrchr(driver, '_')) {
> > +			find = '_';
> > +			replace = '-';
> > +		}
> > +
> > +		while ((ix = strchr(ix, find)) != NULL) {
> > +			*ix++ = replace;
> > +		}

> Just:
> 		while ((ix = strchr(ix, find))
> 			*ix++ = replace;

> > +		if (!tst_check_driver_(driver2))

> free(driver2) ?

Oops, you're right. + path and search path in tst_search_driver()
Below are new versions.

Kind regards,
Petr

static int tst_search_driver(const char *driver, const char *file)
{
	struct stat st;
	char *path = NULL, *search = NULL;
	char buf[PATH_MAX], module[PATH_MAX];
	FILE *f;
	int ret = -1;

	struct utsname uts;

	if (uname(&uts)) {
		tst_brkm(TBROK | TERRNO, NULL, "uname() failed");
		return -1;
	}
	SAFE_ASPRINTF(NULL, &path, "/lib/modules/%s/%s", uts.release, file);

	if (stat(path, &st) || !(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))) {
		tst_resm(TWARN, "expected file %s does not exist or not a file", path);
		return -1;
	}

	if (access(path, R_OK)) {
		tst_resm(TWARN, "file %s cannot be read", path);
		return -1;
	}

	SAFE_ASPRINTF(NULL, &search, "/%s.ko", driver);

	f = SAFE_FOPEN(NULL, path, "r");

	while (fgets(buf, sizeof(buf), f)) {
		if (sscanf(buf, "%s", module) != 1)
			continue;

		if (strstr(module, search) != NULL) {
			ret = 0;
			break;
		}
	}

	SAFE_FCLOSE(NULL, f);
	free(search);
	free(path);

	return ret;
}

static int tst_check_driver_(const char *driver)
{
	if (!tst_search_driver(driver, "modules.dep") ||
		!tst_search_driver(driver, "modules.builtin"))
		return 0;

	return 1;
}

int tst_check_driver(const char *driver)
{
#ifdef __ANDROID__
	/*
	 * Android may not have properly installed modules.* files. We could
	 * search modules in /system/lib/modules, but to to determine built-in
	 * drivers we need modules.builtin. Therefore assume all drivers are
	 * available.
	 */
	return 0;
#endif

	if (!tst_check_driver_(driver))
		return 0;

	int ret = 1;

	if (strrchr(driver, '-') || strrchr(driver, '_')) {
		char *driver2 = strdup(driver);
		char *ix = driver2;
		char find = '-', replace = '_';

		if (strrchr(driver, '_')) {
			find = '_';
			replace = '-';
		}

		while ((ix = strchr(ix, find)))
			*ix++ = replace;

		ret = tst_check_driver_(driver2);
		free(driver2);
	}

	return ret;
}
