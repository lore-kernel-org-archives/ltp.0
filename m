From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Aug 2017 17:00:36 +0200
Subject: [LTP] [PATCH] [vma] Add regression tests for vsyscall and vdso
In-Reply-To: <20170803094726.12301-1-vkabatov@redhat.com>
References: <20170803094726.12301-1-vkabatov@redhat.com>
Message-ID: <20170803150036.GC15519@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +setup()
> +{
> +	ulimit -c unlimited
> +	cat << EOF > test_vdso.c
> +#include <signal.h>
> +#include <unistd.h>
> +
> +static void handle_alrm(int signo)
> +{
> +	kill(getpid(), SIGSEGV);
> +}
> +
> +int main(void)
> +{
> +	signal(SIGALRM, handle_alrm);
> +	alarm(1);
> +	pause();
> +	return 0;

Can't we raise() the SIGALARM here instead of sleeping for one second
doing nothing? And if that is not possible, can we use setitimer() with
reasonably small interval instead (>0.1s)?

> +}
> +EOF
> +
> +	gcc -o test_vdso test_vdso.c -ggdb3
> +}

Why can't we compile this as a part of the LTP build process?

If we put the C file into the same directory as this test, it will be
compiled and installed automatically. We would have to add CFLAGS with
-ggdb to the Makefile though.

Also the path to the directory with LTP binaries must be in $PATH while
LTP test are executed, hence we then can call the binary without the ./

And lastly but not least the test binary should be prefixed by the test
name. Here it should be named vma05_test_vdso.c in a case that it gets
installed.

> +cleanup()
> +{
> +	ulimit -c "$CORE_LIMIT"
> +}
> +
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
> +	{ ./test_vdso; } >& /dev/null
> +	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
> +		./test_vdso ./core* 2> /dev/null)
> +	if grep -q "<signal handler called>" <<< "$TRACE" ; then
> +		tst_res TPASS "[vdso] backtrace complete"
> +	else
> +		tst_res TFAIL "[vdso] bug not patched"
> +	fi
> +}
> +
> +tst_run
> -- 
> 2.13.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
