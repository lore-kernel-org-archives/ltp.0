Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WczGZ-0004TV-H4
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 15:39:19 +0000
Date: Wed, 23 Apr 2014 17:38:27 +0200
From: chrubis@suse.cz
Message-ID: <20140423153827.GC15663@rei.suse.cz>
References: <1271937164.305548.1398266180588.JavaMail.zimbra@adeneo-embedded.com>
	<522788825.306663.1398266671270.JavaMail.zimbra@adeneo-embedded.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <522788825.306663.1398266671270.JavaMail.zimbra@adeneo-embedded.com>
Subject: Re: [LTP] ltp-ddt issue
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
To: THEROND Quentin <qutherond@adeneo-embedded.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I working on ltp-ddt and i have a problem. If i launch <<./runltp -f
> ddt/usb_stress_io>> on BEAGLEBONE the test PASS but if i launch a same
> command on BEAGLEBOARD the test FAIL. LTP-DDT return: 

LTP-DDT is based on (slightly old) LTP but the file in question
ddt/usb_stress_io is not part of the LTP.

See: http://processors.wiki.ti.com/index.php/LTP-DDT

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
