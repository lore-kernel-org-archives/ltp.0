From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Dec 2018 15:25:38 +0100
Subject: [LTP] [PATCH v2 1/4] cgroup_regression_test.sh ported to newlib
In-Reply-To: <20181220182149.48326-2-cristian.marussi@arm.com>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
 <20181220182149.48326-2-cristian.marussi@arm.com>
Message-ID: <20181221142538.GB22257@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

...
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>  {
>  	grep -q -w "ns" /proc/cgroups
>  	if [ $? -ne 0 ]; then
> -		tst_resm TCONF "CONFIG_CGROUP_NS"
> +		tst_res TCONF "CONFIG_CGROUP_NS"
>  		return
>  	fi

This could be just

grep -q -w "ns" /proc/cgroups || tst_res TCONF "CONFIG_CGROUP_NS is not enabled"

But CONFIG_CGROUP_NS was removed in a77aea92010a ("cgroup: remove the ns_cgroup")
in v3.0. We don't have TST_MAX_KVER, so we cannot use TST_MAX_KVER="3.0", but
maybe compare kernel version with tst_kvcmp (see doc) and adjust warning for new kernels.

Kind regards,
Petr
