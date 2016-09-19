From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Sep 2016 14:00:28 +0200
Subject: [LTP] [PATCH 2/2] network/nfs06: rewrite the test and change
 test-cases
In-Reply-To: <1470306799-10970-2-git-send-email-alexey.kodanev@oracle.com>
References: <1470306799-10970-1-git-send-email-alexey.kodanev@oracle.com>
 <1470306799-10970-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160919120028.GB7877@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +TCID=nfs06
> +TST_TOTAL=1
> +TST_CLEANUP="nfs_cleanup"
> +
> +. nfs_lib.sh
> +. test_net.sh
> +
> +do_test()
> +{
> +	tst_resm TINFO "Starting fsstress processes on NFS mounts"
> +
> +	local n=0
> +	local pids
> +	for i in $VERSION; do
> +		fsstress -l 1 -d $TST_TMPDIR/$i/$n -n 1000 -p 50 -r -c > /dev/null &
> +		pids="$pids $!"
> +		n=$(( n + 1 ))
> +	done
> +
> +	tst_resm TINFO "waiting for pids:$pids"
> +	for p in $pids; do
> +		wait $p
> +		if [ $? -ne 0 ]; then
> +			kill -9 $pids
> +			tst_brkm TFAIL "fsstress process failed"
> +		else
> +			tst_resm TINFO "fsstress '$p' completed"
> +		fi
> +	done
> +
> +	tst_resm TPASS "all fsstress processes completed on '$n' NFS mounts"
> +}
> +
> +tst_check_cmds sar

Do we still need this check?

-- 
Cyril Hrubis
chrubis@suse.cz
