From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Dec 2020 13:02:43 +0100
Subject: [LTP] [PATCH V3 3/3] syscalls: finit_module: Add tests
In-Reply-To: <d537c9be33a54d31f70bd25e3268dbebbb67ea8f.1608200941.git.viresh.kumar@linaro.org>
References: <0279beda4660ab1b401164e369c79475633bd067.1608189944.git.viresh.kumar@linaro.org>
 <d537c9be33a54d31f70bd25e3268dbebbb67ea8f.1608200941.git.viresh.kumar@linaro.org>
Message-ID: <X9tI4w6K0cz3hhNf@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void setup(void)
> +{
> +	finit_module_supported_by_kernel();
> +
> +	/* Kernel returned ENOEXEC for fd = -1 earlier */
> +	if ((tst_kvercmp(4, 6, 0)) < 0)
> +		tcases[0].exp_errno = ENOEXEC;

There are plenty of ways how to avoid hackery like that.

What about we defined a setup function in the test structure and then
loop over the testcases in the test setup() and execute all per-test
setup functions we have.

The we can keep the errno set to zero in the static structure and
initialize it in the per-testcase setup as:

static void bad_fd_setup(struct tcase *tc)
{
	if (tst_kvercmp(4, 6, 0)) < 0)
		tc->errno = ENOEXEC;
	else
		tc->errno = EBADFD;
}


Also I think that the last test needs to handle ETXTBSY in the same way
and we may possibly add more tests since I guess that most of the errors
that apply to execve() would apply here as well. What happpens for
example if we pass a fd that points to a directory?

-- 
Cyril Hrubis
chrubis@suse.cz
