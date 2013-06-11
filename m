Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UmNOQ-0004Xc-KA
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 12:09:42 +0000
Date: Tue, 11 Jun 2013 14:11:06 +0200
From: chrubis@suse.cz
Message-ID: <20130611121106.GA8061@rei>
References: <1370433977-6944-1-git-send-email-alexey.kodanev@oracle.com>
	<271133424.4337328.1370446643439.JavaMail.root@redhat.com>
	<20130605155415.GA1059@rei> <20130606110129.GB23876@rei>
	<51B706F8.9070303@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51B706F8.9070303@oracle.com>
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
To: alexey.kodanev@oracle.com
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi!
> >> Right, we should at least limit the module build to kernel versions that
> >> are known to work. In this particular case I would limit it to 3.7+
> > Or even better to be both forward and backward compatible, we should not
> > stop the build when kernel module has failed to build. We should carry
> > on with the build, install etc. and return TCONF when the particula test
> > was called.
> >
> As I understand from the last comment, userspace test should check 
> availability
> of module.ko. If it didn't find the module, the test must return TCONF,
> further, no need to check modules build against kernel version. Is it 
> correct?

The insmod or modprobe will return error when you try to insert kernel
module build against different kerenel (i.e. version magic is
different).

So I would do the logick as:

1. Is there foo.ko?
   
   if not -> module wasn't build -> TCONF

2. Try to insmod/modprobe module

   if failure -> most likely module not compatible with kernel -> TBROK

3. do actual test

...

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
