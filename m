Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WczmE-0006FW-74
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 16:12:02 +0000
Date: Wed, 23 Apr 2014 18:11:11 +0200
From: chrubis@suse.cz
Message-ID: <20140423161110.GC16286@rei.suse.cz>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1395757480-27424-9-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395757480-27424-9-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V2 08/14] rpc-tirpc: implemented a wrapper
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +RHOST=${RHOST:-`hostname`}

So the test defaults to local machine if RHOST is not set, but still
needs rsh installed to run the testcases.

Can we do it without the need for rsh in this case?

> +SERVER=""
> +CLIENT=""
> +CLIENT_EXTRA_OPTS=""
> +CLEANER=""
> +PROGNUMNOSVC=536875000

What is this magic constant?

> +SERVERTIMEOUT=1
> +
> +cleanup()
> +{
> +	if [ ! -z "$SERVER" ]; then

if [ -n "$SERVER" ] ?

> +		rsh -n "$RHOST" "killall -9 $SERVER"
> +		rsh -n "$RHOST" "$CLEANER $PROGNUMNOSVC"
> +	fi
> +}
> +
> +usage()
> +{
> +	echo "USAGE: $0 [-s sprog] -c clprog [ -e extra ]"
> +	echo ""
> +	echo "sprog   - server program binary"
> +	echo "clprog  - client program binary"
> +	echo "extra   - extra client options"
> +	echo ""
> +	echo "This scripts connects to the RHOST host by rsh and starts"
> +	echo "sprog there. After that it executes clprog passing it the"
> +	echo "RHOST value."
> +	echo "After the test completes, this script kills sprog on RHOST"
> +	echo "and performs a cleaning operation."
> +	echo ""
> +	echo "If RHOST is not set, the local host is used."
> +
> +	exit 1
> +}
> +
> +while getopts s:c:e:h arg; do
> +	case $arg in
> +		s) SERVER="$LTPROOT/testcases/bin/$OPTARG" ;;
> +		c) CLIENT="$OPTARG" ;;
> +		e) CLIENT_EXTRA_OPTS="$OPTARG" ;;
> +		h) usage ;;
> +	esac
> +done
> +
> +if [ ! -z "$SERVER" ]; then
> +	if `echo "$SERVER" | grep -e '^tirpc'`; then
> +		CLEANER="$LTPROOT/testcases/bin/tirpc_cleaner"
> +	else
> +		CLEANER="$LTPROOT/testcases/bin/rpc_cleaner"
> +	fi
> +fi

This is a bit hacky, but I cannot think of easy solution.

We can pass the cleaner to this wrapper which would be cleaner solution
but would require changing all the runtest records.

> +if [ -z "$CLIENT" ]; then
> +	echo "client program not set"
> +	echo ""
> +	usage
> +fi
> +
> +TCID="$CLIENT"
> +TST_TOTAL=1
> +TST_COUNT=1
> +. test.sh
> +TST_CLEANUP=cleanup
> +
> +if [ ! -z "$SERVER" ]; then
> +	rsh -n "$RHOST" "$SERVER $PROGNUMNOSVC" &
> +	sleep "$SERVERTIMEOUT"

This is not really timeout, but rather startup sleep.

> +fi
> +
> +"$CLIENT" "$RHOST" "$PROGNUMNOSVC" $CLIENT_EXTRA_OPTS
> +ret=$?
> +
> +if [ "$ret" -eq 0 ]; then
> +	tst_resm TPASS "Test passed"
> +else
> +	tst_resm TFAIL "Test failed"
> +fi
> +
> +tst_exit

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
