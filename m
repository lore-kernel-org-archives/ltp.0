Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ymjwe-0007MZ-7P
	for ltp-list@lists.sourceforge.net; Mon, 27 Apr 2015 14:23:36 +0000
Date: Mon, 27 Apr 2015 16:23:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150427142307.GC10567@rei.suse.de>
References: <1429839868-2011-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1429839868-2011-1-git-send-email-cuibixuan@huawei.com>
Subject: Re: [LTP] [PATCH v3] mv/mv_tests.sh: Add test02 to test 'mv -b'
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
The test as it is is messy and needs to be cleaned up before it gets new
testcases. Have a look at:

http://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell

A few comments on the code follow:

> +# Function:             test02
> +#
> +# Description   - Test #2: Test that mv -b <file1> <file2> will move
> +#                 file1 to file2 and backup the file2.
> +#               - create file1 and file2.
> +#               - get the MD5 message of file2.
> +#               - mv -b file1 to file2
> +#               - get the MD5 message of backup file2.
> +#               - compare  with MD5 messages.

That is too much of comments, I can pretty much see what the code below
does. What should be here is that the test is testing mv -b
functionality.

> +# Return                - zero on success
> +#               - non zero on failure. return value from commands ($RC)
> +
> +test02()
> +{
> +	RC=0                    # Return value from commands.
> +	export TCID=mv02        # Name of the test case.
> +	export TST_COUNT=1      # Test number.

The TCID and TST_COUNT should be initialized only once in the test.

> +	tmpfile1=$LTPTMP/tst_mv.tmp/tmpfile1
> +	tmpfile2=$LTPTMP/tst_mv.tmp/tmpfile2
> +	backup_tmpfile2=$LTPTMP/tst_mv.tmp/tmpfile2~
> +
> +	$LTPBIN/tst_resm TINFO \
> +		"Test #2: mv -b <file1> <file2> will move dir1 to dir2"

The path to tst_resm must be in $PATH prior to the test execution, and
these should be executed without the global path.

> +	touch $tmpfile1 $tmpfile2 > $LTPTMP/tst_mv.err 2>&1 || RC=$?
> +	if [ $RC -ne 0 ]
> +	then
> +		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
> +			"Test #2: can not touch file1 and file2. Reason:"
> +		return $RC
> +	fi
> +
> +	MD5_old=`md5sum $tmpfile2 |awk '{print $1}'` > $LTPTMP/tst_mv.err \
> +		2>&1 || RC=$?
> +	if [ $RC -ne 0 ]
> +	then
> +		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
> +			"Test #2: can't get the MD5 message of file2. Reason:"
> +		return $RC
> +	fi
> +
> +	mv -b $tmpfile1 $tmpfile2  > $LTPTMP/tst_mv.err 2>&1 || RC=$?
> +	if [ $RC -ne 0 ]
> +	then
> +		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
> +			"Test #2: mv -b file1 file2 failed. Reason:"
> +		return $RC
> +	fi
> +
> +	# if mv  -b file1 file2 succeed,there will be "file2~" file
> +
> +	MD5_backup=`md5sum $tmpfile2 |awk '{print $1}'` > $LTPTMP/tst_mv.err \
> +		2>&1 || RC=$?
> +	if [ $RC -ne 0 ]
> +	then
> +		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
> +		"Test #2: can not get the MD5 message of backup file2. Reason:"
> +		return $RC
> +	fi
> +
> +	if [ "$MD5_old" != "$MD5_backup" ]
> +	then
> +		$LTPBIN/tst_resm TFAIL \
> +			"Test #2: mv -b failed"
> +		return $(($RC+1))
> +	else
> +		$LTPBIN/tst_resm TPASS "Test #2: mv -b success"
> +	fi
> +
> +	return $RC
> +}
>  
>  # Function:		main
>  #
> @@ -258,6 +333,15 @@ then
>  	TFAILCNT=$(($TFAILCNT+1))
>  fi
>  
> +rm -fr $LTPTMP/tst_mv.*

We have tst_tmpdir() and tst_rmdir() to simplify this.

> +init || return $RC      # Exit if initializing testcases fails.
> +
> +test02 || RC=$?
> +if [ $RC -ne 0 ]
> +then
> +	TFAILCNT=$(($TFAILCNT+1))
> +fi
>  
>  rm -fr $LTPTMP/tst_mv.*

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
