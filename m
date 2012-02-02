Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rsxe8-0005hQ-7e
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 14:28:20 +0000
Date: Thu, 2 Feb 2012 15:41:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120202144138.GD28620@saboteur.suse.cz>
References: <1327642218-27034-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1327642218-27034-2-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F24EDCB.3070904@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F24EDCB.3070904@casparzhang.com>
Subject: Re: [LTP] [PATCH 1/5] hugemmap01: code cleanups
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
> >  
> >  void help()
> 
> I personally like to put it after main() function, Cyril, what's your
> opinion?

Either way is fine with me.

> >  {
> > -	printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs \n");
> > +	printf("    -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs\n");
> >  }
> >  
> >  int
> >  main(int ac, char **av)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
