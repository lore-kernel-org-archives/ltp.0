From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Oct 2017 11:18:48 +0100
Subject: [LTP] [PATCH 2/3] lib: tst_rhost_run: new option -B for saving
 background log
In-Reply-To: <1507812041-2068-2-git-send-email-alexey.kodanev@oracle.com>
References: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
 <1507812041-2068-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20171031101847.o5yimjvbwhkvecs7@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/lib/test_net.sh |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
<snip>

>  		case "$opt" in
> -		b) [ "$TST_USE_NETNS" ] && pre_cmd="" || pre_cmd="nohup"
> -		   post_cmd=" > /dev/null 2>&1 &"
> +		b|B) [ "$TST_USE_NETNS" ] && pre_cmd="" || pre_cmd="nohup"
Minor nit: use cmd=
		b|B) [ "$TST_USE_NETNS" ] && pre_cmd= || pre_cmd="nohup"

> +		   [ "$opt" = b ] && bg="/dev/null" || bg="$TST_TMPDIR/bg.cmd"
> +		   post_cmd=" > $bg 2>&1 &"
>  		   out="1> /dev/null"
>  		;;
>  		s) safe=1 ;;

LGTM.


Kind regards,
Petr
