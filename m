Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZSSFT-000682-DE
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 15:59:27 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZSSFR-0006Bw-I6
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 15:59:27 +0000
Date: Thu, 20 Aug 2015 17:58:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150820155853.GC5144@rei.suse.de>
References: <1439887006-17985-1-git-send-email-liwang@redhat.com>
	<1439887006-17985-2-git-send-email-liwang@redhat.com>
	<1439887006-17985-3-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439887006-17985-3-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH 3/3] pounder/cpufreq: Skip the test if processors
 are not supported by cpufreq
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  # Do any CPU support cpufreq?
> -#CPUFREQ_ENABLED_CPUS=`/bin/ls -lad /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null | wc -l`
> +CPUFREQ_ENABLED_CPUS=`/bin/ls -lad /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null | wc -l`

Calling ls by full path is simply wrong.

> -#if [ "$CPUFREQ_ENABLED_CPUS" -lt 1 ]; then
> -#	echo "None of your CPUs support cpufreq.  Bye."
> -#	exit 255
> -#fi
> +if [ "$CPUFREQ_ENABLED_CPUS" -lt 1 ]; then
> +	echo "None of your CPUs support cpufreq.  Bye."
> +	exit 255
> +fi

This part of code was specially disabled in one commit, unfortunately it
does not say why exactly it was disabled. So I'm hesitant to enable it
unless we are sure that the code actually works fine on several
distributions.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
