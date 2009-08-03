Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MXr6c-0003HT-9U
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 06:33:10 +0000
Received: from mail-qy0-f181.google.com ([209.85.221.181])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXr6X-0002zV-IQ
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 06:33:10 +0000
Received: by qyk11 with SMTP id 11so2973172qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 02 Aug 2009 23:32:59 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 2 Aug 2009 23:32:59 -0700
Message-ID: <364299f40908022332q29608627vb36b1c5c7c996b93@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [RFC] Bourne shell command library
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
To: LTP list <ltp-list@lists.sourceforge.net>

The following is a proposed start for a command library that can be
used by all bourne shell scripts for executing bourne shell based
scripts / testcases, as there is a large degree of duplication in
testcases/network/{ipv6,tcp_cmds}/*, and there's no doubt a large
degree elsewhere.

The other driving motivator for this is that it would force folks to
adhere to a set standard for shell scripts, and would provide a common
set of simple routines for tracking whether or not prerequisites
exist, as well as whether or not to cleanup, report failure, find
commands, etc.

I will employ this logic in the testcases/network/{ipv6,tcp_cmds}/*
scripts, but I would really like some feedback as to whether or not
what I have is a good idea, or if I could stand more, or less
information, or whether or not this could be done in a better way...

Thanks.

(No sign-off included here because it's not in final form, yet -- will
sign off in my CVS branch space though)

#!/bin/sh
#
#    Command library that provides a boilerplate set of functions and variables
#    required for all bourne shell based scripts.
#
#    Copyright (C) 2009, Cisco Systems Inc.
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Garrett Cooper, August 2009
#

set -u

export SHELL_DEBUG=${SHELL_DEBUG:=0}
if [ "$SHELL_DEBUG" = 1 ] ; then
    set -x
fi

#=============================================================================
# FUNCTION NAME:        cleanup
#
# FUNCTION DESCRIPTION: Clean up after a testcase.
#
# PARAMETERS:           None.
#
# RETURNS:              None.
#=============================================================================

cleanup()
{
    # To ensure set -u passes...
    TCtmp=${TCtmp:=}
    tst_resm TINFO "Cleaning up."
    # Nuke the testcase temporary directory if it exists.
    [ -d "$TCtmp" ] && rm -rf "$TCtmp"
}

#=============================================================================
# FUNCTION NAME:        end_testcase
#
# FUNCTION DESCRIPTION: Print out whether or not a test failed. Do not use
#			this when TBROK messages should be applied.
#
# PARAMETERS:           Failure message, or "" / unset if passed.
#
# RETURNS:              None.
#=============================================================================

end_testcase()
{
    cleanup
    if [ $# -eq 0 ]; then
        tst_resm TPASS "Test successful"
    else
        tst_resm TBROK "Test broken: $*"
        exit 1
    fi
}

#-----------------------------------------------------------------------
#
# FUNCTION:  exists
# PURPOSE:   Check if command(s) used by this test script exist.
#
#-----------------------------------------------------------------------

exists()
{
    for cmd in $@; do
        if ! which $cmd 2>&1 1>/dev/null; then
            end_testcase "$cmd: command not found"
            exit 1
        fi
    done
}

#-----------------------------------------------------------------------
#
# FUNCTION:  setup
# PURPOSE:   Setup the test environment.
#
#-----------------------------------------------------------------------

setup() {

    #
    # $0 is maintained by the caller script; tested on FreeBSD (ash) and
    # Gentoo GNU/Linux (bash) --
    #
    # foo.sh:
    # echo ${0##*/}
    # . ${$0%%*}/bar.sh
    # bar.sh:
    # echo ${0##*/}
    # echo $SHELL
    #
    # Gentoo:
    # gcooper@orangebox ~/Desktop $ ./foo.sh
    # foo.sh
    # foo.sh
    # /bin/bash
    # gcooper@orangebox ~/Desktop $ uname -sr
    # Linux 2.6.29-gentoo-r5
    #
    # $ ./foo.sh
    # foo.sh
    # foo.sh
    # /bin/sh
    # $ uname -sr
    # FreeBSD 8.0-BETA2
    #
    TCID=${TCID:=}
    [ -z "$TCID" ] && TCID=${0##*/}
    export TCID

    for varname in TST_COUNT TST_TOTAL; do
        if ! eval "test -z \"\$${varname}\""; then
            end_testcase "You must set ${varname} before calling setup()."
        fi
    done

    LTPROOT=${LTPROOT:="../../../../"}
    TEMPDIR=${TEMPDIR:=/tmp}
    TCtmp=${TCtmp:=$TEMPDIR/$TC$$}
    # User wants a temporary sandbox to play with.
    if [ -n "$TCtmp" ] ; then
        test -d "$TCtmp" || mkdir -p "$TCtmp"
        # Clean up on exit.
        trap cleanup EXIT
    fi

fi

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
