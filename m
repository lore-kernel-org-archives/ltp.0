Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WhJJV-0007Sv-ED
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 13:52:13 +0000
Date: Mon, 5 May 2014 15:51:14 +0200
From: chrubis@suse.cz
Message-ID: <20140505135114.GA10741@rei>
References: <47b112ce.152ba.145b070f2b0.Coremail.eeslook@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47b112ce.152ba.145b070f2b0.Coremail.eeslook@163.com>
Subject: Re: [LTP] [PATCH] Fix an bad variable name erro in runltp script
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
>     I got an error for the latest version 20140115 of ltp project.
>     This error was found in my os, I use zh_CN for default language, 
> the `date +"%Y_%b_%d-%Hh_%Mm_%Ss"`  will get like "2014_ 4yue_11-09h_36m_52s",
> it contain a space before "4yue" will get the bad variable name error.
> 
> 
>     I fix this error and change the date args,  see detail below:
> -    local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
> +    local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%m_%d-%Hh_%Mm_%Ss"`

I've reworded the summary a bit, added quotes around the variable and
pushed, thanks.

PS: I've been unable to reproduce the bug, for me date +%b does not add
    a space before the month even with LC_ALL=zh_CN, but IMHO number is
    better than month abbreviation that is different for each language.

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
