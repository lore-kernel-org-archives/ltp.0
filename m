Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WBT9M-00086h-Fx
	for ltp-list@lists.sourceforge.net; Thu, 06 Feb 2014 17:54:08 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0268CABE0
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Feb 2014 17:54:01 +0000 (UTC)
Date: Thu, 6 Feb 2014 18:53:35 +0100
From: chrubis@suse.cz
Message-ID: <20140206175334.GA16965@rei.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
Subject: [LTP] [RFC] shell test library
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
In order to make consistent usage of temporary directory and other
things in tests written in shell I've prototyped a simple library that
more or less mirrors the C test interface (when it's posible and when it
makes sense). All functions and variables from the test library are
prefixed with tst_ or TST_ you should not define variables with this
prefixes except for the TST_CLEANUP.

The expected usage is following:

#!/bin/sh
TCID=foo
. test.sh

cleanup()
{
	tst_rmdir
}

# if test needs to run as root
tst_require_root

# if test needs to run in temporary directory
# the content of TST_CLEANUP variable is evaluated
# on test exit
tst_tmpdir
TST_CLEANUP=cleanup

tst_resm TPASS "Testcase passed"
tst_brkm TFAIL "Testcase failed, this will exit the test immediately"

# exits the test with return value from the tst_resm
tst_exit

As usuall comments and patches are welcome :)

-- 
Cyril Hrubis
chrubis@suse.cz

--cWoXeonUoKmBZSoM
Content-Type: application/x-sh
Content-Disposition: inline; filename="test.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A#=0A# This is a LTP test library for shell=0A#=0A=0Aexport LTP_=
RET_VAL=3D0=0Aexport LTP_TST_CNT=3D1=0A=0A# Exit values map=0Atst_flag2mask=
()=0A{=0A	case "$1" in=0A	TPASS) return 0;;=0A	TFAIL) return 1;;=0A	TBROK) =
return 2;;=0A	TWARN) return 4;;=0A	TRETR) return 8;;=0A	TINFO) return 16;;=
=0A	TCONF) return 32;;=0A	*) tst_brkm TBROK "Invalid resm type '$1'";;=0A	e=
sac=0A}=0A=0Atst_resm()=0A{=0A	tst_flag2mask "$1"=0A	local mask=3D$?=0A	LTP=
_RET_VAL=3D$((LTP_RET_VAL|mask))=0A	echo "$TCID $LTP_TST_CNT $1 : $2"=0A	LT=
P_TST_CNT=3D$((LTP_TST_CNT+1))=0A}=0A=0Atst_brkm()=0A{=0A	case "$1" in=0A	T=
FAIL) ;;=0A	TBROK) ;;=0A	TCONF) ;;=0A	TRETR) ;;=0A	*) tst_brkm TBROK "Inval=
id tst_brkm type '$1'";;=0A	esac=0A=0A	tst_resm "$1" "$2"=0A	tst_exit=0A}=
=0A=0Atst_require_root()=0A{=0A	if [ "$(id -ru)" !=3D 0 ]; then=0A		tst_brk=
m TBROK "Must be super/root for this test!"=0A	fi=0A}=0A=0Atst_exit()=0A{=
=0A	if [ -n "$TST_CLEANUP" ]; then=0A		$TST_CLEANUP=0A	fi=0A=0A	exit $LTP_R=
ET_VAL=0A}=0A=0Atst_tmpdir()=0A{=0A	if [ -z "$TMPDIR" ]; then=0A		export TM=
PDIR=3D"/tmp"=0A	fi=0A=0A	TST_TMPDIR=3D$(mktemp -d "$TMPDIR/$TCID.XXXXXXXXX=
X")=0A=0A	cd "$TST_TMPDIR"=0A}=0A=0Atst_rmdir()=0A{=0A	cd "$LTPROOT"=0A	rm =
-r "$TST_TMPDIR"=0A}=0A=0A#=0A# Checks if coomands passed as arguments exis=
ts=0A#=0Atst_check_cmds()=0A{=0A	for cmd in $*; do=0A		if ! command -v $cmd=
 > /dev/null 2>&1; then=0A			tst_brkm TCONF "'$cmd' not found"=0A		fi=0A	do=
ne=0A}=0A=0A# Check that test name is set=0Aif [ -z "$TCID" ]; then=0A	echo=
 "TCID not defined"=0Afi=0A=0A# Setup LTPROOT, default to current directory=
 if not set=0Aif [ -z "$LTPROOT" ]; then=0A	export LTPROOT=3D"$PWD"=0Afi=0A
--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--cWoXeonUoKmBZSoM--

