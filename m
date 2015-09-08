Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZH9v-0006o0-Ek
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 11:33:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZH9t-0005sL-Fl
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 11:33:55 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id E15D7AD73
	for <ltp-list@lists.sourceforge.net>;
	Tue,  8 Sep 2015 11:33:46 +0000 (UTC)
Date: Tue, 8 Sep 2015 13:33:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150908113308.GA3357@rei.suse.cz>
References: <1441707499-25852-1-git-send-email-chnyda@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1441707499-25852-1-git-send-email-chnyda@suse.com>
Subject: Re: [LTP] [PATCH] cgroup_fj: splited the tests to run them
	separately
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
To: Cedric Hnyda <chnyda@suse.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +CASETYPE=$1
> +CASECMD=""
> +cnt=1
> +for arg; do
> +	if [ $cnt -gt 1 ]; then
> +		CASECMD+=" "
> +		CASECMD+=$arg
>  	fi
> +	cnt=$(( $cnt + 1 ))
>  done

There is no need to do this. Just use the $@ instead of $CASECMD below.

> +case $CASETYPE in
> +"function" )
> +	: $(( CASENO1 += 1 ))
> +	export CASENO1=$CASENO1
> +	$TESTROOT/cgroup_fj_function.sh $CASECMD
> +	;;
> +"function2" )
> +	: $(( CASENO1 += 1 ))
> +	export CASENO1=$CASENO1
> +	$TESTROOT/cgroup_fj_function2.sh $CASECMD
> +	;;
> +"stress" )
> +	: $(( CASENO2 += 1 ))
> +	export CASENO2=$CASENO2
> +	$TESTROOT/cgroup_fj_stress.sh $CASECMD
> +	;;
> +esac
> +
> +ret=$?
> +if [ $ret -eq 0 ]; then
> +	tst_resm TPASS "case$i($CASETYPE$CASECMD)    PASS"
> +elif [ $ret -ne 9 ]; then
> +	tst_resm TFAIL "case$i($CASETYPE$CASECMD)    FAIL"
> +fi

The rest looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
