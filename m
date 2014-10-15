Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XeI6t-0004mn-RE
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 06:30:59 +0000
Date: Wed, 15 Oct 2014 08:30:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141015063038.GA2558@rei.suse.cz>
References: <091fa8ce5be96478cf31477561e2e90e9d5f7faa.1413201833.git.jstancek@redhat.com>
	<20141014154711.GA26724@rei>
	<900297128.9002452.1413303441974.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <900297128.9002452.1413303441974.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v3] add LTP_DATAROOT and tst_dataroot()
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Hmm, maybe we can omit looking into testcases/bin/, since the
> > directory to store datafiles is well defined now (and there does not
> > seems to be any testcases that rely on that behavior).
> 
> At least creat07 needs it. It creates temporary dir and then copies
> creat07_child to it - creat07_child is not treated as datafile.
> I'd keep the fallback to testcases/bin - it doesn't hurt anything.

Ah, the ETXTBSY one that tries to call creat() on currently executed
binary, I've missed this one. Ok, let's keep it there.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
