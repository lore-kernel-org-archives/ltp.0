Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YKpC9-0008Dg-49
	for ltp-list@lists.sourceforge.net; Mon, 09 Feb 2015 14:20:13 +0000
Date: Mon, 9 Feb 2015 15:19:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150209141952.GC7605@rei.suse.de>
References: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1423212090-24164-4-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1423212090-24164-4-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 4/6] power_management: add uclinux check and
 move some check
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/power_management/pm_check_env.sh b/testcases/kernel/power_management/pm_check_env.sh
> new file mode 100755
> index 0000000..ebfaf08
> --- /dev/null
> +++ b/testcases/kernel/power_management/pm_check_env.sh
> @@ -0,0 +1,41 @@
> +#
> +# Copyright (c) 2015 Fujitsu Ltd.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +check_env() {
> +	# Checking the system type
> +	./pm_check_uclinux; rc=$?
> +	if [ $rc -eq 1 ]; then
> +		tst_brkm TCONF "UCLINUX not supported; not running testcases"
> +	fi
> +
> +	# Checking required kernel version and architecture
> +	tst_kvercmp 2 6 21; rc=$?
> +	if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +		tst_brkm TCONF "Kernel version not supported; not running \
> +			testcases"
> +	else
> +		case "$(uname -m)" in
> +		i[4-6]86|x86_64)
> +			;;
> +		*)
> +			tst_brkm TCONF "Arch not supported; not running \
> +				testcases"
> +			;;
> +		esac
> +	fi
> +}
> diff --git a/testcases/kernel/power_management/pm_check_uclinux.c b/testcases/kernel/power_management/pm_check_uclinux.c
> new file mode 100644
> index 0000000..e3823b1
> --- /dev/null
> +++ b/testcases/kernel/power_management/pm_check_uclinux.c
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (c) 2015 Fujitsu Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +/* Check wether the current system is uclinux. */
> +int main(int argc, char **argv)
> +{
> +	int chkcmp;
> +#ifdef UCLINUX
> +	chkcmp = 1;
> +#else
> +	chkcmp = 0;
> +#endif
> +	return chkcmp;
> +}

I do not like this. It's compile time check executed in runtime. The
configure check is far better.

> diff --git a/testcases/kernel/power_management/runpwtests.sh b/testcases/kernel/power_management/runpwtests.sh
> index 9055964..0a66dc4 100755
> --- a/testcases/kernel/power_management/runpwtests.sh
> +++ b/testcases/kernel/power_management/runpwtests.sh
> @@ -42,6 +42,7 @@ YES=0
>  NO=1
>  #List of reusable functions defined in pm_include.sh
>  . pm_include.sh
> +. pm_check_env.sh

Is the same check needed in more than one file?

Because if it's not there is no need to move it into separate file...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
