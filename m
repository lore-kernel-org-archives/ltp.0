From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Thu, 15 Nov 2018 20:43:57 +0000
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
 config
In-Reply-To: <20181115134441.27359-1-chrubis@suse.cz>
References: <20181115134441.27359-1-chrubis@suse.cz>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF88A40FCE@USCULXMSG01.am.sony.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> -----Original Message-----
> From: Cyril Hrubis on  Thursday, November 15, 2018 5:45 AM
> 
...

> The required kernel options are passed as an array of strings via the
> .needs_kconfigs pointer in the tst_test structure. The purpose of this
> is twofold, one is that the test can disable itself at runtime if given
> functionality is missing from kernel .config and second is about being
> able to propagate this information to the testrunner (this could be done
> once we figure out how export the information from the structure to the
> test runner) then we can avoid running tests on unsuitable
> configurations from the start.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Pengfei Xu <pengfei.xu@intel.com>
> CC: automated-testing@yoctoproject.org
> ---
>  doc/test-writing-guidelines.txt |  32 +++++++
>  include/tst_kconfig.h           |  34 ++++++++
>  include/tst_test.h              |   6 ++
>  lib/newlib_tests/.gitignore     |   1 +
>  lib/newlib_tests/tst_kconfig.c  |  24 ++++++
>  lib/tst_kconfig.c               | 183
> ++++++++++++++++++++++++++++++++++++++++
>  lib/tst_test.c                  |   4 +
>  7 files changed, 284 insertions(+)
>  create mode 100644 include/tst_kconfig.h
>  create mode 100644 lib/newlib_tests/tst_kconfig.c
>  create mode 100644 lib/tst_kconfig.c
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index d0b91c362..846c39532 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1504,6 +1504,38 @@ static struct tst_test test = {
>  	.save_restore = save_restore,
>  };
> 
> +2.2.28 Parsing kernel .config
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Generally testcases should attempt to autodetect as much kernel features
> as
> +possible based on the currently running kernel. We do have
> tst_check_driver()
> +to check if functionality that could be compiled as kernel module is present
> +on the system, disabled syscalls can be detected by checking for 'ENOSYS'
> +errno etc.
> +
> +However in rare cases core kernel features couldn't be detected based on
> the
> +kernel userspace API and we have to resort on kernel .config parsing.
> +
> +For this cases the test should set the 'NULL' terminated needs_kconfig array
> +of kernel config options required for the test. The test will exit with
> +'TCONF' if any of the required options wasn't set to 'y' or 'm'.

This is good.  Just a comment on the proposed syntax and options.
Fuego uses NEED_KCONFIG (upper-case because it's a shell global variable),
and 0-day uses need_kconfig.

There are a few slight differences in syntax between different systems.
(I'm making no judgements, just noting the differences).

Fuego and 0day also support a string including the option value, such
as:
 CONFIG_PRINTK=y
 CONFIG_LOCKDEP_SUPPORT=n
 CONFIG_CAN=m

See https://elinux.org/Test_Dependencies

where I've started collecting some of these different syntaxes.
 -- Tim


