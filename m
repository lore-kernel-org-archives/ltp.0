Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SfUOC-0005Lw-9b
	for ltp-list@lists.sourceforge.net; Fri, 15 Jun 2012 11:08:28 +0000
Date: Fri, 15 Jun 2012 12:24:34 +0200
From: chrubis@suse.cz
Message-ID: <20120615102434.GA22465@saboteur.suse.cz>
References: <20120614123445.GB16073@saboteur.suse.cz>
	<20120614124335.GC16073@saboteur.suse.cz>
	<4FDAA80C.10301@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FDAA80C.10301@casparzhang.com>
Subject: Re: [LTP] Last release
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> blame me :-( I added the tag in github, since I saw Shubham only
> committed to sf.net and I failed to fetch the tag from sf.net somehow
> (looks like my git is broken somewhere). I added it but forgot to use
> annotate tag.. I'm sorry for that. I'd find out why my git fails to
> fetch tags...

The problem with git and tags is that you need to fetch them via
'git fetch --tags' and push them by 'git push --tags'. So they are treated
differently than regular commits. Which is also the reason why the syncing
script wasn't syncing the tags too... But It will to do so, from now on.

So next time please add tag only to the github and the rest should be
done automatically.

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
