From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 May 2016 16:21:31 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
Message-ID: <20160530142131.GA7416@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The 1st issue I tried to hack by...
> 
> # diff -uprN testcases/bin/acl_test01.orig testcases/bin/acl_test01
> --- testcases/bin/acl_test01.orig       2016-05-30 15:11:10.771931080 +0200
> +++ testcases/bin/acl_test01    2016-05-30 15:22:31.627909726 +0200
> @@ -41,8 +41,6 @@ export TCID=acltest01
>  export TST_TOTAL=5
>  export TST_COUNT=1
> 
> -. test.sh
> -
>  TMP=${TMP:=/tmp}
> 
>  TEST_USER1="acltest1"
> @@ -54,6 +52,8 @@ FILE_ACL="$TMP/tacl/mount-ext3/test_file
>  FILE_ACL_LINK="$TMP/tacl/mount-ext3/test_file_link"
>  TCbin=`pwd`
> 
> +. $TCbin/test.sh
> +
>  COMMAND=$(command -v "getenforce" "setenforce" |wc -l)
>  if [ $COMMAND -eq 2 ]; then
>         SELINUX=$(getenforce)
> 
> Not sure if this correct.

No it's not. You have to have path to testcases/bin/ directory in $PATH
in order to run a LTP testcase (and it's even written in
documentation...).

Strangely enough the $PATH should be set correctly when you run
testcases via runltp. That is one of the first things done in setup() in
that script. And it works fine for me.

The TCbin should be removed from the test entirely.

> For the 2nd issue - dunno what's going on.

Looks like the do_cleanup is executed twice. Once via trap do_cleanup
EXIT and once at the end of the script. This should be fixed.

> Beyond all this, how can I test the work of Andreas with LTP?
> Any help appreciated.

I guess that kernel/syscalls/*xattr* should be relevant.

-- 
Cyril Hrubis
chrubis@suse.cz
