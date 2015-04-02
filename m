Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Yddmb-0001v8-9P
	for ltp-list@lists.sourceforge.net; Thu, 02 Apr 2015 11:59:37 +0000
Date: Thu, 2 Apr 2015 13:59:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150402115922.GA30680@rei>
References: <1427970931.19106.8.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1427970931.19106.8.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [RFC PATCH] commands/du: Added new testcase to test du(1)
 command.
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
> +#!/bin/sh
> +#
> +# Copyright (c) 2015 Fujitsu Ltd.
> +# Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> +#
> +# This program is free software;  you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +# the GNU General Public License for more details.
> +#
> +# Test du command with some basic options.
> +#
> +
> +TCID=du01
> +
> +TEST_FILE="du_test.file"
> +test_cases=(
> +	[1]=""
> +	[2]="$TEST_FILE"
> +	[3]="-0"
> +	[4]="--null"
> +	[5]="-a"
> +	[6]="--all"
> +	[7]="-B 20"
> +	[8]="--block-size=20"
> +	[9]="-b"
> +	[10]="--bytes"
> +	[11]="-c"
> +	[12]="--total"
> +	[13]="-D dir1/${TEST_FILE}"
> +	[14]="--dereference-args dir1/${TEST_FILE}"
> +	[15]="--max-depth=1"
> +	[16]="-H dir1/${TEST_FILE}"
> +	[17]="-h"
> +	[18]="--human-readable"
> +	[19]="-k"
> +	[20]="-L dir1/"
> +	[21]="--dereference dir1/"
> +	[22]="-m"
> +	[23]="-P"
> +	[24]="--no-dereference"
> +	[25]="--si"
> +	[26]="-s"
> +	[27]="--summarize"
> +	[28]="--exclude=${TEST_FILE}"
> +)

Have you tried with real sh (from bussybox) or dash? I doubt that this
array syntax works there.

> +TST_TOTAL=${#test_cases[@]}

This as well.

> +. test.sh
> +
> +export TEST_RETURN
> +TEST()
> +{
> +	$@ >${TCID}.temp 2>&1
> +	TEST_RETURN=$?
> +}

Hmm, why to save the output to a file if it's not used at all?

> +setup()
> +{
> +	tst_check_cmds du
> +
> +	tst_tmpdir
> +
> +	echo "test for du" > du_test.file
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK "create du_test.file failed."
> +	fi
> +
> +	mkdir -p dir1
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK "mkdir dir1 failed."
> +	fi

Hmm, maybe we should introduce safe_mkdir etc, similarily to the safe
macros we have for C.

> +	ln -s $(pwd)/du_test.file dir1/du_test.file

ln -s ./du_test.file dir1/du_test.file ?

> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK "ln -s $(pwd)/du_test.file dir1/du_test.file"
> +	fi
> +}
> +
> +cleanup()
> +{
> +	tst_rmdir
> +}
> +
> +setup
> +TST_CLEANUP=cleanup
> +
> +for i in $(seq 1 ${#test_cases[@]})
> +do
> +	TEST du ${test_cases[$i]}
> +	if [ ${TEST_RETURN} -eq 0 ]; then
> +		tst_resm TPASS "du(option: ${test_cases[$i]}) succeeded."

Better test would also parse the test output and check if it's sane, but
for basic test this is okay.

> +	else
> +		tst_resm TFAIL "du(option: ${test_cases[$i]}) failed."
> +	fi
> +done
> +
> +tst_exit
> -- 
> 1.9.3
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website, sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the 
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
