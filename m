Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WhIPa-0007on-A2
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 12:54:26 +0000
Date: Mon, 5 May 2014 14:53:27 +0200
From: chrubis@suse.cz
Message-ID: <20140505125327.GB9470@rei>
References: <5b2c7cc.14f0c.145b06999bd.Coremail.eeslook@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5b2c7cc.14f0c.145b06999bd.Coremail.eeslook@163.com>
Subject: Re: [LTP] [PATCH] Fix an error command format for sar in
	ltpstress.sh
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
To: look <eeslook@163.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Hi All and chrubis,
> 
> 
>     I got an error for the lastest version 20140115 of ltp project.
>     The sar command never support zero as an number of iterations, this may have been wrongly merged.
> I send attch path file for fix this error.
> 
> 
>     Details messages:
> @@ -254,7 +254,7 @@ ${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/stress.part3 > ${TMP}/stress.par
> -  sar -o $datafile $interval 0 &
> +  sar -o $datafile $interval > /dev/null &

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
