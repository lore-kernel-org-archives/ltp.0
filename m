Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UkXvO-0005b5-21
	for ltp-list@lists.sourceforge.net; Thu, 06 Jun 2013 11:00:10 +0000
Date: Thu, 6 Jun 2013 13:01:30 +0200
From: chrubis@suse.cz
Message-ID: <20130606110129.GB23876@rei>
References: <1370433977-6944-1-git-send-email-alexey.kodanev@oracle.com>
	<271133424.4337328.1370446643439.JavaMail.root@redhat.com>
	<20130605155415.GA1059@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130605155415.GA1059@rei>
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
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi,
> > 
> > This patch tries to build kernel module also on kernels < 3.7, which seems
> > unnecessary, because the test won't run. And for very old kernels it won't
> > build at all. 
> > 
> > I know some people still build/run LTP on kernels as old as 2.6.18, which is why
> > I would rather go with WITH_MODULES="no" as default, if more kernel modules
> > become part of the build.
> 
> Right, we should at least limit the module build to kernel versions that
> are known to work. In this particular case I would limit it to 3.7+

Or even better to be both forward and backward compatible, we should not
stop the build when kernel module has failed to build. We should carry
on with the build, install etc. and return TCONF when the particula test
was called.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
