Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XDCmx-0004Cm-GZ
	for ltp-list@lists.sourceforge.net; Fri, 01 Aug 2014 13:22:27 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XDCmv-000410-N1
	for ltp-list@lists.sourceforge.net; Fri, 01 Aug 2014 13:22:27 +0000
Message-ID: <53DB94E1.70404@oracle.com>
Date: Fri, 01 Aug 2014 17:23:45 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1406634124.3928.1.camel@G08JYZSD130126>	
	<53DA2E9A.5030902@oracle.com>
	<1406862709.2835.1.camel@G08JYZSD130126>
In-Reply-To: <1406862709.2835.1.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 1/2] network ftp: some cleanup
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

Hi Zeng!
On 08/01/2014 07:11 AM, Zeng Linggang wrote:
> * Move do_setup and do_cleanup into ftp_setup.
>
> * Delete ftp02_s1 and add do_test function for it.
>
> * Delete ftp_set_passwd and ftp_setup_vsftp_conf, since they are not be used.
>
> * Use test.sh instead of net_cmdlib.sh
>
> * Abandon trap and use tst_exit.
>
> * Make the test like:
> 	(set TCID TST_TOTAL ...)
> 	setup
> 	do_test
> 	check_result
> 	tst_exit
>
> * Some cleanup.
>
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>   testcases/network/tcp_cmds/ftp/ftp02               |  99 +++++++-----
>   testcases/network/tcp_cmds/ftp/ftp02_s1            |  71 ---------
>   testcases/network/tcp_cmds/ftp/ftp03               | 175 +++++++--------------
>   testcases/network/tcp_cmds/ftp/ftp04               | 109 ++++++-------
>   testcases/network/tcp_cmds/ftp/ftp05               | 146 ++++++++---------
>   testcases/network/tcp_cmds/ftp/ftp_set_passwd      |  28 ----
>   testcases/network/tcp_cmds/ftp/ftp_setup           |  73 +++++++++
>   .../network/tcp_cmds/ftp/ftp_setup_vsftp_conf      |   5 -
>   8 files changed, 304 insertions(+), 402 deletions(-)
>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp02_s1
>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp_set_passwd
>   create mode 100644 testcases/network/tcp_cmds/ftp/ftp_setup
>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp_setup_vsftp_conf
>
> diff --git a/testcases/network/tcp_cmds/ftp/ftp02 b/testcases/network/tcp_cmds/ftp/ftp02
> index 6d6e021..bb3139e 100755
> --- a/testcases/network/tcp_cmds/ftp/ftp02
> +++ b/testcases/network/tcp_cmds/ftp/ftp02
> @@ -28,59 +28,72 @@
>   #  NOTE:
>   #       This version is intended for EAL certification, it will need modification
>   #       to conform with LTP standards in the offical LTP tree.
> +#
> +# DESCRIPTION:
> +#	Create Test User
> +#	Make sure test user cannont log in with invalid password
> +#	Cleanup Test User from system
> +#	Exit with exit code of script called upon
> +#
>   
> -#-----------------------------------------------------------------------
> -# FUNCTION:  do_setup
> -#-----------------------------------------------------------------------
> -
> -do_setup()
> +setup()
>   {
> +	tst_check_cmds expect ftp useradd userdel
> +	export TEST_USER="ftpuser2"
> +}
>   
> -    export RHOST="localhost"
> -    export TEST_USER="ftpuser2"
> -    export TEST_USER_PASSWD="eal"
> -    export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
> -    export TEST_USER_HOMEDIR="/home/$TEST_USER"
> -
> -    # erase user if he may exist, so we can have a clean env
> -    TCtmp="/home/$TEST_USER"
> -
> -    tst_setup
> +do_test()
> +{
> +	CONNECTION_FAILED="Connection failed; test FAILED"
> +	EXPECTED="Login failed as expected; test PASSED"
> +	UNEXPECTED="Login succeeded unexpectedly; test FAILED"
>   
> -    exists expect ftp ftp02_s1 useradd userdel
> +	set PASSWD "invaild_password?!!"
> +	set timeout 90
>   
> -    userdel $TEST_USER
> -    sleep 1
> +	expect -c "
> +		#ftp to host
> +		spawn ftp $RHOST
> +		sleep 1
> +		# Check if connection succeeded.
> +		expect {
> +			\"Name\" {}
> +			timeout {send_user \"\n$CONNECTION_FAILED\n\";exit 1}
> +		}
>   
> -    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER; then
> -        end_testcase "Could not add test user $TEST_USER to system $RHOST."
> -    fi
> +		send \"$RUSER\r\"
> +		sleep 1
> +		expect -re \"Password:\"
> +		send \"$PASSWD\r\"
> +		sleep 1
>   
> -    trap do_cleanup EXIT
> +		expect {
> +			# 530 - Login failed
> +			\"530\" {send_user \"$EXPECTED\n\";exit 0}
> +			# 230 - Login successful
> +			\"230\" {send_user \"$UNEXPECTED\n\"; exit 1}
> +		}
>   
> +		expect \"ftp>\"
> +		send \"exit\r\"
> +	"
>   }
>   
> -#-----------------------------------------------------------------------
> -# FUNCTION:  do_cleanup
> -#-----------------------------------------------------------------------
> +TCID="$0"

May be we should just change it to ftp02, otherwise test name will 
depend on how you running it (e.g. running by full path, TCID becomes 
"/opt/ltp/testcases/bin/test_name".

Are you running these tests from runEALtests.sh?

Can we add them to networktests.sh, to "TCP/IP command tests" group as 
it already has ftp01?

Thanks,
Alexey


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
