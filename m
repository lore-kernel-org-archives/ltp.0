From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Apr 2018 15:44:03 +0200
Subject: [LTP] [RFC] tst_check_cmds to exit only current test
In-Reply-To: <20180404131501.GH32109@rei>
References: <20180329114536.vsmsjzatryu4h5dm@dell5510>
 <20180404131501.GH32109@rei>
Message-ID: <20180404134401.acd5w52wcn2z42kv@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > # TODO: find a better name
> > # another option (maybe better would be to add getopt option to tst_check_cmds()
> > tst_check_cmds_test()

> Just call it tst_test_cmds() then.

> > {
> > 	local cmd
> > 	for cmd in $*; do
> > 		if ! command -v $cmd > /dev/null 2>&1; then
> > 			tst_res TCONF "'$cmd' not found"
> > 			return 32; # we don't have tst_flag2mask() in new API
> > 		fi
> > 	done
> > }
I'll implement it regardless it's actually used in interface tests as it's handy (I'd like
to use it in ima tests).
I just don't like that new API doesn't have constants for TCONF, TPASS, etc (legacy API
has it).

> > testcases/network/stress/interface/if-addr-adddel
> > test_body()
> > {
> > 	local cmd_type=$1

> >     case $cmd_type in
> >     if_cmd) local cmd_name='ifconfig' ;;
> >     ip_cmd) local cmd_name='ip' ;;
> >     *) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
> >     esac
> > 	tst_check_cmds_test ifconfig || return
> > ...

> Huh, why do we even have the case here?

> Why isn't the cmd_type either ip or ifconfig?

> Then we can just do:

> 	tst_test_cmds $1 || return
Copy pasted, make sense to use much simpler form.


Kind regards,
Petr
