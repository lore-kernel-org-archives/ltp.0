Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata.modak@in.ibm.com>) id 1P0xc5-0004wp-Al
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 14:26:29 +0000
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P0xc3-0008Uy-DI
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 14:26:29 +0000
In-Reply-To: <20100929141051.GB4620@hallyn.com>
References: <20100924100303.5709.80714.sendpatchset@sravan-laptop>
	<20100927142304.GA23119@hallyn.com>
	<4CA0AEB7.7080701@linux.vnet.ibm.com>
	<20100927180239.GA15486@hallyn.com>
	<4CA1ADB0.7070908@linux.vnet.ibm.com>
	<20100928213611.GA1046@hallyn.com>
	<4CA31140.4000805@linux.vnet.ibm.com>
	<20100929141051.GB4620@hallyn.com>
Message-ID: <OFA3C42AE5.7F12F4DF-ON652577AD.004DA114-652577AD.004DCA76@in.ibm.com>
From: Subrata Modak1 <subrata.modak@in.ibm.com>
Date: Wed, 29 Sep 2010 19:39:02 +0530
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Compilation Error Fixed in filecaps.
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
To: Serge Hallyn <serge.hallyn@canonical.com>, ltp-list@lists.sf.net
Cc: sravan <sravan@linux.vnet.ibm.com>

Serge Hallyn <serge.hallyn@canonical.com> wrote on 09/29/2010 07:40:51 PM:
>
> Quoting sravan (sravan@linux.vnet.ibm.com):
> >  Sorry for the confusion Serge.
> > I have taken the "c.c" file from the latest ltp release and found
> > that it is not compiling.
> >
> > The same file is not compiling in the earlier release of ltp also.
> > To resolve the compilation issue I have added the following
> > flag(HAVE_SYS_CAPABILITY_H).
> > The same flag is also used in
ltp-full-20100831/testcases/kernel/security/
> filecaps/verify_caps_exec.c
> > file.
> >
> > #if HAVE_SYS_CAPABILITY_H            //Added by Sravan
> > #include <sys/capability.h>
> > #endif                                              // Added by Sravan
> >
> > Please let me know if this is the correct approach.
>
> Well, the better approach would be to install the libcap-dev
> package (or whatever it is called on your distro)  :)  But so
> long as you're just getting your own compile working, whatever
> gets you a working build is fine.
>
> What worries me, though, is the thought that the official
> 20100831 release has the wrong files in it!  Can you follow
> up on that with Subrata?  In particular, the c.c file is
> different from the one in ltp.git.  Something is going very
> wrong!

Garret,

Did we miss/drop something during our migration from ltp-dev.git to
ltp.git ?

Regards--
Subrata

>
> thanks,
> -serge


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
