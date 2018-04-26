From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Apr 2018 14:15:31 +0200
Subject: [LTP] [PATCH 2/2] commands/file01: Fix "python3" match failure
In-Reply-To: <1524725137-32739-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1524725137-32739-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1524725137-32739-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180426121531.nntwhijmtmpwtiry@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> On some distros(e.g. RHEL6.9GA), we got the mismatched
> output by running 'file in.py':
> ----------------------------------------------
> in.py: a /usr/bin/env python3 script text executable
> ----------------------------------------------

> We just match both python and python3 to fix this issue.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/commands/file/file01.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
> index e04b32e..5a81b3b 100755
> --- a/testcases/commands/file/file01.sh
> +++ b/testcases/commands/file/file01.sh
> @@ -84,8 +84,8 @@ do_test()
>  	 7) file_test in.pl "[pP]erl script, ASCII text executable" \
>  			    "[pP]erl script text executable" \
>  			    "a /usr/bin/perl script text";;
> -	 8) file_test in.py "[pP]ython script, ASCII text executable" \
> -			    "[pP]ython script text executable";;
> +	 8) file_test in.py "[pP]ython3\{0,1\} script, ASCII text executable" \
This one isn't needed, as problem is with file-5.04, which use the latter one, but let's
keep it.
> +			    "[pP]ython3\{0,1\} script text executable";;
>  	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
>  			    "ASCII M4 macro language pre-processor text";;
>  	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*" \

Merged, thanks!


Kind regards,
Petr
