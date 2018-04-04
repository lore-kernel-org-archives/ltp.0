From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Apr 2018 15:15:01 +0200
Subject: [LTP] [RFC] tst_check_cmds to exit only current test
In-Reply-To: <20180329114536.vsmsjzatryu4h5dm@dell5510>
References: <20180329114536.vsmsjzatryu4h5dm@dell5510>
Message-ID: <20180404131501.GH32109@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> # TODO: find a better name
> # another option (maybe better would be to add getopt option to tst_check_cmds()
> tst_check_cmds_test()

Just call it tst_test_cmds() then.

> {
> 	local cmd
> 	for cmd in $*; do
> 		if ! command -v $cmd > /dev/null 2>&1; then
> 			tst_res TCONF "'$cmd' not found"
> 			return 32; # we don't have tst_flag2mask() in new API
> 		fi
> 	done
> }
> 
> testcases/network/stress/interface/if-addr-adddel
> test_body()
> {
> 	local cmd_type=$1                                                                                                                   
>                                                                                                                                         
>     case $cmd_type in                                                                                                                   
>     if_cmd) local cmd_name='ifconfig' ;;
>     ip_cmd) local cmd_name='ip' ;;                                                                                                      
>     *) tst_brkm TBROK "Unknown test parameter '$cmd_type'"                                                                              
>     esac
> 	tst_check_cmds_test ifconfig || return
> ...

Huh, why do we even have the case here?

Why isn't the cmd_type either ip or ifconfig?

Then we can just do:

	tst_test_cmds $1 || return

> Is it valid approach approach or should we use getopts to run the test twice?

That is a valid approach as well, we can just do:

if-addr-adddel_ifconfig if-addr-adddel ifconfig
if-addr-adddel_ip if-addr-adddel ip

in the runtest file, which would make the test results more detailed,
as it will be clear what was actually skipped, which is always nice.

-- 
Cyril Hrubis
chrubis@suse.cz
