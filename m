Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1REMOq-0004xA-Ji
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 14:36:44 +0000
Date: Thu, 13 Oct 2011 16:40:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111013144017.GA26842@saboteur.suse.cz>
References: <260174ADA4D63F4AA543B9C81F2DE7124714C8@POCITMSEXMB02.LntUniverse.com>
	<1316539785.4441.6.camel@subratamodak.linux.ibm.com>
	<260174ADA4D63F4AA543B9C81F2DE71247156D@POCITMSEXMB02.LntUniverse.com>
	<1316587124.4544.3.camel@subratamodak.linux.ibm.com>
	<260174ADA4D63F4AA543B9C81F2DE712471654@POCITMSEXMB02.LntUniverse.com>
	<1316674584.4516.7.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1316674584.4516.7.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] Cross Compiling LTP for Android platform
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
>      1. You can add a statement 'ifdef _android' or something in your
>         code and try to compile it. So, this code will not compile at
>         all,
>      2. Similarly check for other SYSTEM CALLs and APIs which are not
>         supported on Android and create a list first (else you will keep
>         coming back to LTP mailing list with all these failures, and, i
>         am not sure whether anybody will look into all your issues).
>         Create patches accordingly,
>      3. Maintain those patches privately(apply them every time you are
>         building LTP) with you as i believe LTP community will probably
>         not interested to add check for Android (they may be, you can
>         talk to Cyril/Shubham/Garrett/Mike Frysinger),

If you look into Makefiles (for example testcases/kernel/Makefile) there
often is check ifeq($(UCLINUX), 1) or something like that and some
tests/subdirectories are filtered out from the targets based on that. So
if you are using original LTP buildsystem you may just do the same for
android (and if done right, this changes will be accepted upstream).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
