From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Sep 2017 15:17:29 +0200
Subject: [LTP] [PATCH v4 1/2] libltp: add support to mount tmpfs for
 EROFS testing
In-Reply-To: <20170919194959.126495-1-sspatil@google.com>
References: <20170919194959.126495-1-sspatil@google.com>
Message-ID: <20170925131729.GC25748@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If the test is only to check for EROFS, this can be achieved by simply
> by the bind mounting (MS_BIND) for '/' on 'mntpoint' and then remount
> the same as 'read-only'.

I've fixed this part of the changelog since we use tmpfs instead of bind
mount.

> Example of tests that can benefit from this are:
>   access04, mkdirat02, mknodat02, acct01, fchown04, mknod07 etc.
> 
> This also allows for these tests to successfully run on Android.
> 
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> Tested-by: Jan Stancek <jstancek@redhat.com>

...

> +	if (tst_test->needs_rofs) {
> +		/* If we failed to do read-only bind mount for '/'. Fallback to
> +		 * using a device with empty read-only filesystem.
> +		 */

And this comment as well.



And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
