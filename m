Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ukaf3-00023k-9Z
	for ltp-list@lists.sourceforge.net; Thu, 06 Jun 2013 13:55:29 +0000
Date: Thu, 6 Jun 2013 15:56:47 +0200
From: chrubis@suse.cz
Message-ID: <20130606135647.GA29348@rei.suse.cz>
References: <1370433674-6838-1-git-send-email-alexey.kodanev@oracle.com>
	<20130606105736.GA23876@rei> <51B0716B.2090107@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51B0716B.2090107@oracle.com>
Subject: Re: [LTP] [PATCH] configure: add configure checks to compile kernel
 modules
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> There're new configure options added to tune modules building process.
> >> New m4 function tries to determine if kernel-devel package is available
> >> and sets makefile's variables (WITH_MODULES, ...) accordingly.
> >>
> >> Signed-off-by: Alexey Kodanev<alexey.kodanev@oracle.com>
> > This part looks fine.
> >
> > Maybe it would be better to include detected kernel version in the
> > configure output as well, but apart from that it's ok.
> >
> Sure, I will add VERSION and PATCHLEVEL variables from 
> .../build/Makefile to configure. Then we can use these variables 
> (WITH_MODULES, KERNEL_VERSION and KERNEL_PATCHLEVEL) to determine 
> whether to compile specific modules or not. Also, would it be better to 
> use KBUILD_VERSION, KBUILD_PATCHLEVEL, KBUILD_RELEASE names?

Sounds better to me.

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
