Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQvOV-0004u8-Pa
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 10:10:11 +0000
Date: Thu, 26 Feb 2015 11:09:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150226100927.GA13639@rei.suse.de>
References: <1424855586-9818-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1424855586-9818-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 1/3] device-drivers/locking: add wrapper for
 locktorture kernel module
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +TCID="lock_torture"
> +TST_TOTAL=5
> +TST_CLEANUP=cleanup
> +. test.sh
> +
> +# default options
> +test_time=60
> +
> +while getopts :ht: opt; do
> +	case "$opt" in
> +	h)
> +		echo "Usage:"
> +		echo "h        help"
> +		echo "t x      time in seconds for each test-case"
> +		exit 0
> +	;;
> +	t) test_time=$OPTARG ;;
> +	*)
> +		tst_brkm TBROK "unknown option: $opt"
> +	;;
> +	esac
> +done
> +
> +cleanup()
> +{
> +	tst_resm TINFO "cleanup"
> +	rmmod locktorture > /dev/null 2>&1
> +}
> +
> +tst_kvercmp 3 18 0 && \
> +	tst_brkm TCONF "test must be run with kernel 3.18 or newer"

We check if the module is present, do we have to check for the kernel
version too?


Otherwise it look OK.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
