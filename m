Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UhL0N-0001Y5-Ml
	for ltp-list@lists.sourceforge.net; Tue, 28 May 2013 14:36:03 +0000
Date: Tue, 28 May 2013 16:37:08 +0200
From: chrubis@suse.cz
Message-ID: <20130528143707.GA4229@rei>
References: <1369398051-2772-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1369398051-2772-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] New core test of cgroups and extended attributes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +void setup(int argc, char *argv[])
> +{
> +	char *msg;
> +	msg = parse_opts(argc, argv, options, help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	tst_require_root(NULL);
> +
> +	if (access("/proc/cgroups", F_OK) == -1)
> +		tst_brkm(TCONF, NULL, "Kernel doesn't support for cgroups");
                                                     ^         ^
				               Either add have here or
					       remove the for

> +	/* initialize test value */
> +	val.size = value_size;
> +	val.buf = SAFE_MALLOC(NULL, value_size);
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	tst_tmpdir();
> +
> +	make_cgroup_options();
> +
> +	int any_mounted = 0;
> +	int i;
> +	for (i = 0; i < cgrp_opt_num; ++i) {
> +		char dir[MAX_DIR_NAME];
> +		snprintf(cgrp_opt[i].dir, MAX_DIR_NAME, "cgx_%d",
> +			cgrp_opt[i].hier);
> +		SAFE_MKDIR(cleanup, cgrp_opt[i].dir, 0755);
> +		if (mount(cgrp_opt[i].dir, cgrp_opt[i].dir, "cgroup", 0,
> +			cgrp_opt[i].opt) == -1) {
> +			tst_resm(TINFO, "Can't mount: %s", dir);
> +			continue;
> +		}
> +
> +		any_mounted = 1;
> +		cgrp_opt[i].mounted = 1;
> +
> +		/* create new hierarchy */
> +		SAFE_CHDIR(cleanup, cgrp_opt[i].dir);
> +		SAFE_MKDIR(cleanup, subdir_name, 0755);
> +		cgrp_opt[i].subdir = 1;
> +		SAFE_CHDIR(cleanup, "..");
> +	}

I would keep the mounting code in the function that parses the cgroups
proc file, that way we can have simple:

	if (!mount_cgroups())
		tst_brkm(TBROK, cleanup, "Nothing mounted");

in the setup and keep all the details in the function.

> +	if (!any_mounted)
> +		tst_brkm(TBROK, cleanup, "Mounted nothing");

This should be TCONF.

> +}
> +
> +void make_cgroup_options(void)
> +{
> +	/* detect subsystems */
> +	FILE *fd = fopen("/proc/cgroups", "r");
> +	if (fd == NULL)
> +		tst_brkm(TBROK, cleanup, "Failed to read /proc/cgroups");
> +
> +	char str[MAX_DIR_NAME];
> +	char name[MAX_DIR_NAME];
> +	int	hier	= 0,
> +		num	= 0,
> +		enabled	= 0,
> +		first	= 1;

I would keep these at one line, which would save vertical space, but
that is purely cosmetic change.

> +	while ((fgets(str, MAX_DIR_NAME, fd)) != NULL) {
> +		/* skip first line */
> +		if (first) {
> +			first = 0;
> +			continue;
> +		}
> +		if (sscanf(str, "%s\t%d\t%d\t%d",
> +			name, &hier, &num, &enabled) != 4)
> +			tst_brkm(TBROK, cleanup, "Can't parse /proc/cgroups");
> +
> +		if (!enabled)
> +			continue;
> +
> +		/* BUG WORKAROUND
> +		 * Only mount those subsystems, which are not mounted yet.
> +		 * It's a workaround to a bug when mount doesn't
> +		 * return any err code while mounting already mounted
> +		 * subsystems, but with additional "xattr" option.
> +		 * In that case, mount will succeed, but xattr won't be
> +		 * supported in the new mount anyway.
> +		 * Should be removed as soon as a fix committed to upstream.
> +		 */
> +		if (hier != 0)
> +			continue;
> +		/* end of workaround */

Remove the /* end of workaround */ please.

> +		int found = 0;
> +		int i;
> +		for (i = 0; i < cgrp_opt_num; ++i) {
> +			if (cgrp_opt[i].hier == hier) {
> +				found = 1;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			i = cgrp_opt_num++;
> +			cgrp_opt[i].hier = hier;
> +		}
> +
> +		int len = strlen(cgrp_opt[i].opt);
> +		if (len == 0) {

                Could also be if (cgrp_opt[i].opt[0] == '\0') {
		(or something similar)

> +			strcpy(cgrp_opt[i].opt, "xattr");
> +			len = strlen(cgrp_opt[i].opt);

                        len == 5 in this case ;)

> +		}
> +
> +		sprintf(cgrp_opt[i].opt + len, ",%s", name);

So we create a list of subsystem by hierarchy here, and try to mount
them with xattr later?

Ah but due to bug in kernel (hier == 0 when we got to this part) we end
up only with these that are not mounted at the moment, right?

That looks OK. Hopefully the kernel gets fixed. Will the kernel support
mouting the subsystems with additional xattr flags or will the mount
return an error (on my machine all mounted subsystems are mounted
without xattr)?

> +	}
> +	fclose(fd);
> +
> +	int i;
> +	for (i = 0; i < cgrp_opt_num; ++i) {
> +		tst_resm(TINFO, "mount options %d: %s (hier = %d)",
> +			i, cgrp_opt[i].opt, cgrp_opt[i].hier);
> +	}
> +}
> +


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
