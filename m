Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WO5Yb-0000fT-O4
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 13:20:21 +0000
Date: Thu, 13 Mar 2014 14:20:03 +0100
From: chrubis@suse.cz
Message-ID: <20140313132002.GD31515@rei.suse.cz>
References: <1394715829-35808-1-git-send-email-liljegren.mats2@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394715829-35808-1-git-send-email-liljegren.mats2@gmail.com>
Subject: Re: [LTP] [PATCH] .gitignore: Add files created when building
 stress_floppy tests
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
To: liljegren.mats2@gmail.com
Cc: ltp-list@lists.sourceforge.net, Mats Liljegren <mats.liljegren@enea.com>

Hi!
> Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
> ---
>  .gitignore |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 1e9c911..9da07b9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -61,3 +61,8 @@ logfile.*
>  /lib/tests/tst_process_state
>  /lib/tests/tst_cleanup_once
>  /lib/tests/tst_safe_macros
> +
> +/testcases/kernel/io/stress_floppy/1000K_file
> +/testcases/kernel/io/stress_floppy/100K_file
> +/testcases/kernel/io/stress_floppy/10K_file
> +/testcases/kernel/io/stress_floppy/dumpdir/

Can you please start a new .gitignore file in the
testcases/kernel/io/stress_floppy/ directory?

It's easier to maintain if the records are defined per directory rather
than in the global file.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
