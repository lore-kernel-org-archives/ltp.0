Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wwu7t-0003bH-LW
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 14:12:41 +0000
Date: Tue, 17 Jun 2014 16:12:26 +0200
From: chrubis@suse.cz
Message-ID: <20140617141226.GC29117@rei>
References: <1402627999-11535-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1402627999-11535-2-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402627999-11535-2-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/3] utimes/utimes01.c: cleanup
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
> -/* History:     Porting from Crackerjack to LTP is done by		    */
> -/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/

I've added this to the header under the Authors.

> -		/**
> -		 * Note (garrcoop):
> -		 *
> -		 * If you do NULL directly, then gcc [4.3] will complain when
> -		 * one specifies -Wnonnull in CPPFLAGS. This is a negative
> -		 * test, but let's not allow the compiler to complain about
> -		 * something trivial like this.
> -		 **/
> -		const char *dummy = NULL;
> -		TEST(sys_ret = utimes(dummy, tv));
> +	if (TEST_ERRNO == tc->exp_errno) {
> +		tst_resm(TPASS | TTERRNO, "utimes() failed as expected");
                                                      ^
				      I've changed this to "worked as expected"
				      because the first two testcases
				      do not fait at all.

Also I may be better to split the test into two files one for positive
tests and one for negative tests because as it is the code does not
check that utimes() actually changed the times and we may add test that
calls utimes() with NULL times, which should set the times to current
time. Adding these changes to the currect code would overcomplicate the
verify function...

Patchset applied, Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
