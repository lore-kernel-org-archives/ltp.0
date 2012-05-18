Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SVMp3-0006k3-M1
	for ltp-list@lists.sourceforge.net; Fri, 18 May 2012 13:02:21 +0000
Date: Fri, 18 May 2012 14:59:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120518125929.GA23311@saboteur.suse.cz>
References: <alpine.BSF.2.00.1204041743120.25027@toaster.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.00.1204041743120.25027@toaster.local>
Subject: Re: [LTP] [PATCH] Add a functional test for the IN_DELETE_SELF event
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/****************************************************************************
> + * NAME
> + *     inotify04
> + *
> + * DESCRIPTION
> + *     verify that IN_DELETE_SELF functions as expected
> + *
> + * ALGORITHM
> + *     Create a temporary directory, then add watches to a predefined file and
> + *     directory, and delete the file and directory to ensure that the
> + *     IN_DELETE_SELF event is captured properly.
> + *
> + *     Because of how the inotify(7) API is designed, we also need to catch the
> + *     IN_ATTRIB and IN_IGNORED events.
> + *
> + * HISTORY
> + *
> + * ***************************************************************************/

Looks good, but runtest entry is missing. And (as I said in different
mail allready) I would remove the NAME and HISTORY from the comment
above.

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
