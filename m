Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WVMXu-0004BI-VS
	for ltp-list@lists.sourceforge.net; Wed, 02 Apr 2014 14:53:43 +0000
Date: Wed, 2 Apr 2014 16:53:02 +0200
From: chrubis@suse.cz
Message-ID: <20140402145301.GA16032@rei.Home>
References: <1395730866-28862-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395730866-28862-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2] lib/test_net.sh: add network help script
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +[ -z "$TST_LIB_LOADED" ] && . test.sh
> +
> +# Run command on remote host.
> +# Options:
> +# -b run in background
> +# -s safe option, if something goes wrong, will exit with TBROK
> +# -c specify command to run
> +
> +tst_rhost_run()
> +{
> +	# this is needed to run tools/apicmds on remote host
> +	local pre_cmd="TCID=$TCID TST_COUNT=1 TST_TOTAL=1"

Hmm, if I get it right, this is here in order to make possible to run
the tst_get_unused_port apicmd command.

I don't like that much that we have to set the TST_COUNT and TST_TOTAL
too. Maybe we should relax the rules in ltpapicmd.c, given that
TST_TOTAL is not used for anything in the lib/ directory and the
tst_count is used only used only in the tst_print().

> +	local post_cmd=
> +	local out=
> +	local user="root"
> +	local cmd=
> +	local safe=0
> +
> +	OPTIND=0
> +
> +	while getopts :bsc:u: opt; do
> +		case "$opt" in
> +		b)
> +			pre_cmd="$pre_cmd nohup"
> +			post_cmd=" > /dev/null 2>&1 &"
> +			out="1> /dev/null"
> +		;;
> +		s) safe=1 ;;
> +		c) cmd=$OPTARG ;;
> +		u) user=$OPTARG ;;
> +		*)
> +			tst_brkm TBROK "tst_rhost_run: unknown option: $opt"
> +		;;
> +		esac
> +	done
> +
> +	OPTIND=0
> +
> +	[ -z "$cmd" ] && tst_brkm TBROK "command not defined"
> +
> +	local output=
> +	local ret=
> +	if [ -n "$TST_USE_SSH" -a "$TST_USE_SSH" -eq 1 ]; then

I would just simplify it to if [ -n "$TST_USE_SSH" ].

> +		output=`ssh -n -q $user@$RHOST "sh -c \
> +			'$pre_cmd $cmd $post_cmd'" $out 2> /dev/null`
> +	else
> +		output=`rsh -n -l $user $RHOST "sh -c \
> +			'$pre_cmd $cmd $post_cmd'" $out 2> /dev/null`
> +	fi
> +	ret=$?
> +	[ $ret -ne 0 -a "$safe" -eq 1 ] && \
> +		tst_brkm TBROK "failed to run '$cmd' on '$RHOST'"
> +
> +	[ -z "$out" -a -n "$output" ] && echo "$output"
> +
> +	return $ret
> +}

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
