From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Aug 2017 14:51:34 +0200
Subject: [LTP] [PATCH v2] [vma] Add regression tests for vsyscall and
	vdso
In-Reply-To: <20170803162803.12106-1-vkabatov@redhat.com>
References: <20170803162803.12106-1-vkabatov@redhat.com>
Message-ID: <20170809125134.GE32573@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +vma_report_check()
> +{
> +	if [ $(uname -m) == "x86_64" ] ; then
> +		if LINE=$(grep "vsyscall" /proc/self/maps) ; then
> +			RIGHT="ffffffffff600000-ffffffffff601000[[:space:]]r-xp"
> +			if grep -q "$RIGHT" <<< "$LINE" ; then
> +				tst_res TPASS "[vsyscall] reported correctly"
> +			else
> +				tst_res TFAIL "[vsyscall] reporting wrong"
> +			fi
> +		fi
> +	fi
> +
> +	rm -rf core*
> +	{ vma05_vdso; } >& /dev/null
> +	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
> +		vma05_vdso ./core* 2> /dev/null)

One last nit, we should make sure that /proc/sys/kernel/core_pattern is
set to 'core' otherwise this may fail to find the core file.

We can set and reset it in the setup/cleanup as we do with the ulimit if
it's present.

-- 
Cyril Hrubis
chrubis@suse.cz
