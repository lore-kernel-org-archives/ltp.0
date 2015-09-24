Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZfBU8-0004es-Un
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2015 18:43:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZfBU7-0003N6-Hf
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2015 18:43:12 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id A814EAC02
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2015 18:43:03 +0000 (UTC)
Date: Thu, 24 Sep 2015 20:42:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150924184208.GB1260@rei.suse.cz>
References: <1441889771-8243-1-git-send-email-chnyda@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1441889771-8243-1-git-send-email-chnyda@suse.com>
Subject: Re: [LTP] [PATCH] cgroup_fj: fixed exit codes in case of not
 supported tests
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
> @@ -125,8 +125,8 @@ esac
>  ret=$?
>  if [ $ret -eq 0 ]; then
>  	tst_resm TPASS "case$i($CASETYPE$CASECMD)    PASS"
> -elif [ $ret -ne 9 ]; then
> +elif [ $ret -ne 32 ]; then
>  	tst_resm TFAIL "case$i($CASETYPE $CASECMD)    FAIL"
>  fi
>  
> -exit $ret;
> +tst_exit

Unless the whole script is converted to the test.sh the exit $ret must
stay here, otherwise the return status from the test will be always 0.

The rest looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
