Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UmNnl-0006Qk-53
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 12:35:54 +0000
Date: Tue, 11 Jun 2013 14:37:14 +0200
From: chrubis@suse.cz
Message-ID: <20130611123714.GB8061@rei>
References: <1370433977-6944-1-git-send-email-alexey.kodanev@oracle.com>
	<271133424.4337328.1370446643439.JavaMail.root@redhat.com>
	<20130605155415.GA1059@rei> <20130606110129.GB23876@rei>
	<51B706F8.9070303@oracle.com> <20130611121106.GA8061@rei>
	<716795963.1251428.1370952887038.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <716795963.1251428.1370952887038.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] fw_load: new test of device firmware loading
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
Cc: alexey kodanev <alexey.kodanev@oracle.com>, vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi!
> 
> Perhaps also:
> 0. if module fails to build, continue with rest of LTP build

Sure, that was in some of the mails as well but I omited it here since
the question was about what to to when the test is executed.

> > 
> > 1. Is there foo.ko?
> >    
> >    if not -> module wasn't build -> TCONF
> > 
> > 2. Try to insmod/modprobe module
> > 
> >    if failure -> most likely module not compatible with kernel -> TBROK
> > 
> > 3. do actual test
> > 
> > ...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
