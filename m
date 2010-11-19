Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PJPmr-00039i-Cm
	for ltp-list@lists.sourceforge.net; Fri, 19 Nov 2010 12:09:53 +0000
Date: Fri, 19 Nov 2010 13:21:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101119122145.GB19564@saboteur.suse.cz>
References: <4CE61F95.0@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CE61F95.0@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH]Instead sem_wait by fcntl for sigaction
 test.
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

Hi!
> Some days before, mitani-san reported some sigaction test failed at linux,
> http://sourceforge.net/mailarchive/message.php?msg_id=000001cb798d%241aaa0210%244ffe0630%24%40co.jp
> 
> As Garrett said, add Linux-isms is not advisably. So i want try to fix it by another method.
> 
> I have seen the assertions.xml, these tests want to test sigaction with SA_RESTART
> not sem_wait(it looks like there's a bug at older linux kernel), so i suggest to
> instead sem_wait by fcntl.
> 
> What about this one?  If you agree with me, i will post other patchs.

As far as I understand this, you are trying to avoid a fact, that older
kernels are not comforming to the POSIX specification. This is a case
where the test is failing for a good reason, all we could do here is
print message like:

"this test is known to fail on linux kernel < 2.6.22"

Before the test reports failure.


On the other end I do not object to adding test for file locks with
SA_RESTART. But you should not remove the sem_lock() test (as it's not
broken).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
