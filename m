From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Nov 2018 14:53:15 +0100
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
	config
In-Reply-To: <4a063677-8a43-2737-b9af-3459a57fa3f5@arm.com>
References: <20181115134441.27359-1-chrubis@suse.cz>
 <4a063677-8a43-2737-b9af-3459a57fa3f5@arm.com>
Message-ID: <20181116135315.GD29013@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> this morning I was just thinking about brutally zcatting config.gz to be 
> able to skip some tests based upon current Kernel configs (not 
> drivers/moduleoptions)...and I'd need a mechanism to do that...then I 
> saw this patch :D

That's the beauty of opensource, your problems gets solved even before
you try :-).

...

> +#define TST_NO_DEFAULT_MAIN
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <tst_test.h>
> +#include <tst_kconfig.h>
> +
> +int main(int argc, const char **argv)
> +{
> +       int missing = 0;
> +       const char **cfg = NULL;
> +
> +       if (argc < 2)
> +               return -1;
> +
> +       for (cfg = &argv[1]; !missing && *cfg; cfg++) {
> +               char rval = '\0';
> +
> +               fprintf(stderr, "Check for: %s\n", *cfg);
> +               rval = tst_kconfig(*cfg);
> +               switch (rval) {
> +               case 'y':
> +               case 'm':
> +                       tst_res(TINFO, "Kernel %s found", *cfg);
> +                       break;
> +               default:
> +                       missing = 1;
> +                       tst_res(TINFO, "Kernel is missing %s", *cfg);
> +                       break;
> +               }
> +       }
> +
> +       return missing;
> +}
> 
> and it seems to work !

Hmm, I guess that we can even pass argv+1 to the tst_kconfig_check(),
the function will exit with 32 on missing modules and with 2 if
something went wrong.

We can slightly modify it, if we want to have better control over the
exit functions here, but generally that should be even easier than this.

> cmdline="quota_remount_test01.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> Check for: CONFIG_QFMT_V1
> tst_check_kconfigs.c:44: INFO: Kernel is missing CONFIG_QFMT_V1
> quota_remount_test01    1  TCONF  :  ltpapicmd.c:188: Kernel QUOTA 
> Options NOT configured!
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=32 corefile=no
> cutime=0 cstime=0
> 
> Do you think could be useful ?

Yes, we will likely need shell helper for this API.

> Or should be done another way really (I'm brand new to LTP tests...) ?

Actually for the case quotas calling quotactl(2) and checking for ENOSYS
may be easier and probably prefered.

We may want to record the required config options somewhere though.

-- 
Cyril Hrubis
chrubis@suse.cz
