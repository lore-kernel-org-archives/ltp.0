Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RELXi-0007S2-Cg
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 13:41:50 +0000
Date: Thu, 13 Oct 2011 15:45:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111013134529.GD23592@saboteur.suse.cz>
References: <20110810121045.GB3179@saboteur.suse.cz>
	<1316411928-1941-1-git-send-email-yanpai.chen@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1316411928-1941-1-git-send-email-yanpai.chen@gmail.com>
Subject: Re: [LTP] [PATCH] testcases: syscalls: use tst_tmpdir() interface
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
To: Andrew Chen <yanpai.chen@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ypchen@faraday-tech.com

Hi!
First of all, please use more recent LTP source (ideally git checkout).
The '/* End setup() */' and '/* End cleanup() */' comments were removed
about an year ago.

> index 5f81dac..0851cbc 100644
> --- a/ltp-full-20101031/testcases/kernel/syscalls/fstatat/fstatat01.c
> +++ b/ltp-full-20101031/testcases/kernel/syscalls/fstatat/fstatat01.c
> @@ -247,6 +247,8 @@ void setup()
>  	/* capture signals */
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
> +	tst_tmpdir();
> +
>  	/* Pause if that option was specified */
>  	TEST_PAUSE;
>  }				/* End setup() */
> @@ -269,6 +271,8 @@ void cleanup()
>  	 */
>  	TEST_CLEANUP;
>  
> +	tst_rmdir();
> +
>  	/* exit with return code appropriate for results */
>  	tst_exit();
>  }				/* End cleanup() */

You missed the testfile3 that uses absolute path to /tmp/ which should
rather be absoulute path to tst_tmpdir. Something like this should work:

snprintf(testfile3, sizeof(testfile3),
         "%s/fstatattestfile.txt", tst_get_tmpdir())

Note that we no longer need the pid in the filenames as the create test
directory is unique.

And the same goes for the rest of the testcases.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
