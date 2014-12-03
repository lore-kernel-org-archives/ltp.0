Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xw9Io-0000CQ-6b
	for ltp-list@lists.sourceforge.net; Wed, 03 Dec 2014 12:45:06 +0000
Date: Wed, 3 Dec 2014 13:44:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141203124453.GB13935@rei.suse.de>
References: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
	<1416227940.10929.2.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1416227940.10929.2.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH 2/5] ima_measurements.sh: Some cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +export TST_TOTAL=3
> +export TCID="ima_measurements"
> +export TST_COUNT=0

The TST_COUNT shouldn't be initialized here (it's done in test.sh).

>  init()
>  {
> -	export TST_TOTAL=3
> -	export TCID="init"
> -        export TST_COUNT=0
> -	RC=0
> -
> -	exists sha1sum
> +	tst_check_cmds sha1sum
>  
>  	# verify using default policy
>  	if [ ! -f "$IMA_DIR/policy" ]; then
> -		tst_res TINFO $LTPTMP/imalog.$$ \
> -		 "$TCID: not using default policy"
> +		tst_resm TINFO "not using default policy"
>  	fi
> -	return $RC
>  }
>  
>  # Function:     test01
> @@ -52,40 +46,29 @@ init()
>  #		  be added to the IMA measurement list.
>  test01()
>  {
> -	TCID="test01"
> -	TST_COUNT=1
> -	RC=0
> -
>  	# Create file test.txt
> -	cat > $LTPIMA/test.txt <<-EOF || RC=$?
> -	`date` - this is a test file
> +	cat > test.txt <<-EOF
> +	$(date) - this is a test file
>  	EOF
> -	if [ $RC -ne 0 ]; then
> -		tst_res TBROK $LTPTMP/imalog.$$ "" \
> -		 "$TCID: Unable to create test file"
> -		return $RC
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK "Unable to create test file"
>  	fi
>  
> -	# Calculating the sha1sum of $LTPTMP/test.txt should add
> +	# Calculating the sha1sum of test.txt should add
>  	# the measurement to the measurement list.
>  	# (Assumes SHA1 IMA measurements.)
> -	hash=$(sha1sum < "$LTPIMA/test.txt" | sed 's/  -//')
> +	hash=$(sha1sum "test.txt" | sed 's/  -//')
>  
>  	# Check if the file is measured
>  	# (i.e. contained in the ascii measurement list.)
> -	cat /sys/kernel/security/ima/ascii_runtime_measurements > \
> -		 $LTPIMA/measurements
> +	cat /sys/kernel/security/ima/ascii_runtime_measurements > measurements
>  	sleep 1
> -	`grep $hash $LTPIMA/measurements > /dev/null` || RC=$?
> -	if [ $RC -ne 0 ]; then
> -		tst_res TFAIL $LTPTMP/imalog.$$ \
> -		 "$TCID: TPM ascii measurement list does not contain sha1sum"
> -		return $RC
> +	$(grep $hash measurements > /dev/null)
> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "TPM ascii measurement list does not contain sha1sum"
>  	else
> -		tst_res TPASS $LTPTMP/imalog.$$ \
> -		 "$TCID: TPM ascii measurement list contains sha1sum"
> +		tst_resm TPASS "TPM ascii measurement list contains sha1sum"
>  	fi
> -	return $RC
>  }
>  
>  # Function:     test02
> @@ -93,33 +76,23 @@ test01()
>  # 		  measurement to be added to the IMA measurement list.
>  test02()
>  {
> -	TCID="test02"
> -	TST_COUNT=2
> -	RC=0
> -
>  	# Modify test.txt
> -	echo `$date` - file modified >> $LTPIMA/test.txt || RC=$?
> +	echo $($date) - file modified >> test.txt
>  
> -	# Calculating the sha1sum of $LTPTMP/test.txt should add
> +	# Calculating the sha1sum of test.txt should add
>  	# the new measurement to the measurement list
> -	hash=`cat $LTPIMA/test.txt | sha1sum | sed 's/  -//'`
> +	hash=$(sha1sum test.txt | sed 's/  -//')
>  
>  	# Check if the new measurement exists
> -	cat /sys/kernel/security/ima/ascii_runtime_measurements > \
> -		$LTPIMA/measurements
> -	`grep $hash $LTPIMA/measurements > /dev/null` || RC=$?
> -
> -	if [ $RC -ne 0 ]; then
> -		tst_res TFAIL $LTPTMP/imalog.$$ \
> -		 "$TCID: Modified file not measured"
> -		tst_res TINFO $LTPTMP/imalog.$$ \
> -		 "$TCID: iversion not supported; or not mounted with iversion"
> -		return $RC
> +	cat /sys/kernel/security/ima/ascii_runtime_measurements > measurements
> +	$(grep $hash measurements > /dev/null)
> +
> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "Modified file not measured"
> +		tst_resm TINFO "iversion not supported; or not mounted with iversion"
>  	else
> -		tst_res TPASS $LTPTMP/imalog.$$ \
> -		 "$TCID: Modified file measured"
> +		tst_resm TPASS "Modified file measured"
>  	fi
> -	return $RC
>  }
>  
>  # Function:     test03
> @@ -127,57 +100,40 @@ test02()
>  #		(Default policy does not measure user files.)
>  test03()
>  {
> -	TCID="test03"
> -	TST_COUNT=3
> -	RC=0
> -
>  	# create file user-test.txt
> -	mkdir -m 0700 $LTPIMA/user
> -	chown nobody.nobody $LTPIMA/user
> -	cd $LTPIMA/user
> +	mkdir -m 0700 user
> +	chown nobody.nobody user
> +	cd user
>  	hash=0
>  
>  	# As user nobody, create and cat the new file
>  	# (The LTP tests assumes existence of 'nobody'.)
> -	sudo -n -u nobody sh -c "echo `date` - create test.txt > ./test.txt;
> +	sudo -n -u nobody sh -c "echo $(date) - create test.txt > ./test.txt;
>  				 cat ./test.txt > /dev/null"
>  
>  	# Calculating the hash will add the measurement to the measurement
>  	# list, so only calc the hash value after getting the measurement
>  	# list.
> -	cat /sys/kernel/security/ima/ascii_runtime_measurements > \
> -		 $LTPIMA/measurements
> -	hash=`cat ./test.txt | sha1sum | sed 's/  -//'`
> +	cat /sys/kernel/security/ima/ascii_runtime_measurements > measurements
> +	hash=$(sha1sum test.txt | sed 's/  -//')
>  	cd - >/dev/null
>  
>  	# Check if the file is measured
> -	grep $hash $LTPIMA/measurements > /dev/null || RC=$?
> -	if [ $RC -ne 0 ]; then
> -		RC=0
> -		tst_res TPASS $LTPTMP/imalog.$$ \
> -		 "$TCID: user file test.txt not measured"
> +	grep $hash measurements > /dev/null
> +	if [ $? -ne 0 ]; then
> +		tst_resm TPASS "user file test.txt not measured"
>  	else
> -		RC=1
> -		tst_res TFAIL $LTPTMP/imalog.$$ \
> -		 "$TCID: user file test.txt measured"
> +		tst_resm TFAIL "user file test.txt measured"
>  	fi
> -	return $RC
>  }
>  
> -# Function:     main
> -#
> -# Description:  - Execute all tests, exit with test status.
> -#
> -# Exit:         - zero on success
> -#               - non-zero on failure.
> -#
> -RC=0
> -EXIT_VAL=0
> -
> -. $(dirname "$0")/ima_setup.sh
> -setup || exit $?
> -init || exit $?
> -test01 || EXIT_VAL=$RC
> -test02 || EXIT_VAL=$RC
> -test03 || EXIT_VAL=$RC
> -exit $EXIT_VAL
> +. ima_setup.sh
> +TST_CLEANUP=cleanup
> +
> +setup

Ah so you set the TST_CLEANUP here instead.

I guess that this is OK, but the cleanup should be set right after the
setup and not before it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
