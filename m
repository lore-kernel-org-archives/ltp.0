From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Apr 2018 12:22:37 +0200
Subject: [LTP] [RFC PATCH 7/9] testcases: df: Add "--printf" option as
 needed commands
In-Reply-To: <20180423094639.14612-8-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-8-mylene.josserand@bootlin.com>
Message-ID: <20180423102237.GF24481@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> index fbf1e2f2a..147620020 100755
> --- a/testcases/commands/df/df01.sh
> +++ b/testcases/commands/df/df01.sh
> @@ -26,6 +26,8 @@ TST_PARSE_ARGS=parse_args
>  TST_NEEDS_ROOT=1
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_DEVICE=1
> +TST_NEEDS_CMDS="stat --printf=%f"

Does this work? Because when I do something as:

$ command -v stat --nonexistent-option
/usr/bin/stat
$ echo $?
0

-- 
Cyril Hrubis
chrubis@suse.cz
