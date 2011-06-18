Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QZP2K-0004SS-TH
	for ltp-list@lists.sourceforge.net; Wed, 22 Jun 2011 15:08:12 +0000
Date: Sat, 18 Jun 2011 04:36:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110618023636.GA12034@saboteur.suse.cz>
References: <4E00F3A2.2040000@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E00F3A2.2040000@canonical.com>
Subject: Re: [LTP] Looking for pointers to log file format...
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
To: Brad Figg <brad.figg@canonical.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I'm looking to do some log file parsing and would like to find
> a description of the various fields in the log files.
> 
> Also, if there is somewhere that contributors have put their
> own log parsing tools, that would be helpful to know as well.

We have here (in SuSE) ctcs2 glue around LTP testcases, these are
internal now, but we will release them after they are cleaned up.

(it's set of generators for tcf files from LTP runtest files)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger.
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Data protection magic?
Nope - It's vRanger. Get your free trial download today.
http://p.sf.net/sfu/quest-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
