Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WmmC3-0007E2-N9
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 15:43:07 +0000
Date: Tue, 20 May 2014 17:42:56 +0200
From: chrubis@suse.cz
Message-ID: <20140520154255.GA30279@rei.suse.cz>
References: <1398079016-9193-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398079016-9193-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] renameat/renameat01.c: cleanup
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
To: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> +#define TESTDIR "testdir"
> +#define NEW_TESTDIR "newtestdir"
> +#define TESTFILE "testfile"
> +#define NEW_TESTFILE "newtestfile"
> +#define TESTFILE2 "testdir/testfile"
> +#define NEW_TESTFILE2 "newtestdir/newtestfile"
> +#define TESTFILE3 "/tmp/testfile3"
> +#define NEW_TESTFILE3 "/tmp/newtestfile3"

The test must not create files outside of the test tmpdir. Have a look
at mkdriat01.c, readlinkat01.c or any *at01.c that I've fixed recently.

You need to construct the absolute path from output of tst_get_tmpdir().

> +static void setup(void);
> +static void cleanup(void);
> +static void test_success1(void);
> +static void test_success2(void);
> +static void test_success3(void);
> +static void test_enotdir(void);
> +static void test_ebadf(void);
> +static void check_and_print(int expected_errno);
> +
> +static void (*testfunc[])(void) = { test_success1, test_success2,
> +				test_success3, test_enotdir, test_ebadf };

I think that the data driven approach (having one structure with all
parameters and single test function) is a bit easier to read, but that
is not a big problem. Have a look at mkdirat01.c.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
