Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rv73E-0002kn-HF
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 12:55:08 +0000
Date: Wed, 8 Feb 2012 14:09:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120208130902.GB23425@saboteur.suse.cz>
References: <CABX9GEBGv4PHve2qZW7EqXnBt5SP6bwKMhBDhJzMxLMoZQAO2A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABX9GEBGv4PHve2qZW7EqXnBt5SP6bwKMhBDhJzMxLMoZQAO2A@mail.gmail.com>
Subject: Re: [LTP] Regarding LTP test failure
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
To: Shivamurthy Shastri <shiva.linuxworks@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am testing LTP on mips64 architecture.
> Some tests are failing on it.
> Please let me know LTP is supported on mips64 or not.

Generally LTP should run on any linux, however some of the tests may not
work on some platforms. (and if you look on mails on this list, there
are even patches pending to fix some of the tests on mips64)

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
