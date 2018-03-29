From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Mar 2018 13:45:37 +0200
Subject: [LTP] [RFC] tst_check_cmds to exit only current test
Message-ID: <20180329114536.vsmsjzatryu4h5dm@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm thinking about implementing tst_check_cmds() equivalent just for current test.
tst_check_cmds() breaks whole testing (tst_brkm TCONF "'$cmd' not found"), which is usually what we want. But sometimes it'd be handy to have an easy way to skip only current test.
E.g. interface stress tests (if-addr-adddel, ...) run test with ifconfig and then with ip and require ifconfig (tst_check_cmds ifconfig).
As ifconfig is not already available in some distros nothing is tested in this case.

# TODO: find a better name
# another option (maybe better would be to add getopt option to tst_check_cmds()
tst_check_cmds_test()
{
	local cmd
	for cmd in $*; do
		if ! command -v $cmd > /dev/null 2>&1; then
			tst_res TCONF "'$cmd' not found"
			return 32; # we don't have tst_flag2mask() in new API
		fi
	done
}

testcases/network/stress/interface/if-addr-adddel
test_body()
{
	local cmd_type=$1                                                                                                                   
                                                                                                                                        
    case $cmd_type in                                                                                                                   
    if_cmd) local cmd_name='ifconfig' ;;
    ip_cmd) local cmd_name='ip' ;;                                                                                                      
    *) tst_brkm TBROK "Unknown test parameter '$cmd_type'"                                                                              
    esac
	tst_check_cmds_test ifconfig || return
...

Is it valid approach approach or should we use getopts to run the test twice?
Well, this wouldn't help with interface stress tests as test_net.sh still use the old
shell API, but that can change.

Kind regards,
Petr
