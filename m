Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ShgQX-0004cB-HX
	for ltp-list@lists.sourceforge.net; Thu, 21 Jun 2012 12:23:57 +0000
Date: Thu, 21 Jun 2012 13:40:34 +0200
From: chrubis@suse.cz
Message-ID: <20120621114034.GA25933@saboteur.suse.cz>
References: <4FE2CCE3.1030500@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FE2CCE3.1030500@windriver.com>
Subject: Re: [LTP] [bug report] a typo in runltp script
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
To: "Li, Jin" <Jin.Li@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> When I use runltp with the option [-b DEVICE], notice the typo as follows:
> 
> sed -i "" -e "s|DEVICE_FS_TYPE|$DEVICE_FS_TYPE|"  ${TMP}/alltests
> 
> The runltp will hit error and exit.
> 
> Is it a typo or I miss something else ?

That line went in with Garrett's patch to improve the script. I guess he
was using slightly different version of sed (or just typed the line
wrong). (CCed him in case he remebers).

And in any case we should fix that. Do you care to send a patch?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
