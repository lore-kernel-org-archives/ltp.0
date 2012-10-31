Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TTVcG-0007JB-2t
	for ltp-list@lists.sourceforge.net; Wed, 31 Oct 2012 10:33:44 +0000
Date: Wed, 31 Oct 2012 11:31:20 +0100
From: chrubis@suse.cz
Message-ID: <20121031103119.GA18055@rei>
References: <17bab533f4f5e5c80a676158bfd75cfb1b361228.1351608161.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17bab533f4f5e5c80a676158bfd75cfb1b361228.1351608161.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] mremap: add new test mremap05
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static void *test_mremap(void *old_address, size_t old_size, size_t new_size,
> +	int flags, void *new_address, const char *msg, void *exp_ret,
> +	int exp_errno)

Looking at the number of parameters it may be better to pass a structure
pointer here. And looking at the way it's called, most of the structure
could be statically initalized.

See for an example kernel/syscalls/sendto/sendto01.c

> +{
> +	void *ret;
> +
> +	ret = mremap(old_address, old_size, new_size, flags, new_address);
> +	if (ret == exp_ret)
> +		if (ret != MAP_FAILED)
> +			tst_resm(TPASS, "%s", msg);
> +		else
> +			if (errno == exp_errno)
> +				tst_resm(TPASS, "%s", msg);
> +			else
> +				tst_resm(TFAIL|TERRNO, "%s", msg);
> +	else
> +		tst_resm(TFAIL, "%s ret: %p, expected: %p", msg,
> +			ret, exp_ret);
> +	return ret;
> +}

There is too much if ... else ... without any curly brackets, the
indentation helps a lot but I would rather see blocks longer than
one line enclosed in them.

> +int main(int ac, char **av)
> +{
> +	char *msg;
> +	int lc;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	Tst_count = 0;

There is no need to zero the Tst_count here it's initialized to
zero in tst_res.c.

> +	setup();
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +		test_fixed_require_maymove();
> +		test_new_addr_not_aligned();
> +		test_old_new_area_overlap();
> +		test_mremap_fixed_maymove();
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	pagesize = getpagesize();
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
