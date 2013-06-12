Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UmrMX-00075Y-8Y
	for ltp-list@lists.sourceforge.net; Wed, 12 Jun 2013 20:09:45 +0000
Date: Wed, 12 Jun 2013 22:11:09 +0200
From: chrubis@suse.cz
Message-ID: <20130612201109.GB19266@rei.suse.cz>
References: <CANXECd4nytMbMBtrnnD+aaEaE1NMQ8+x=gO7qCFrEFcFBGBUCg@mail.gmail.com>
	<880296419.1609038.1371019910126.JavaMail.root@redhat.com>
	<CANXECd7uzb9Rc2H1LMDuBXcExC6RHbHhJ2rv-tEz9uOcDW+Vhw@mail.gmail.com>
	<602677798.1890199.1371052049559.JavaMail.root@redhat.com>
	<CANXECd5nFxsJsTTnrFdXAnGpEX0VBAzPMsO=HKKrcjkMqvDoeA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANXECd5nFxsJsTTnrFdXAnGpEX0VBAzPMsO=HKKrcjkMqvDoeA@mail.gmail.com>
Subject: Re: [LTP] Help compiling in AIX 6.1
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
To: Ismael Farf??n <sulfurfff@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > --- a/include/mk/env_pre.mk
> > +++ b/include/mk/env_pre.mk
> > @@ -74,6 +74,8 @@ else
> >  abs_top_builddir               := $(abspath $(top_builddir))
> >  endif
> >
> > +$(warning abs dirs: $(abs_top_srcdir) $(abs_top_builddir))
> > +
> >  # Where's the root object directory?
> >  builddir                       := .
> >
> > Regards,
> > Jan
> 
> I'm using gmake 3.8
> 
> I got this new line from gmake after the patch:
> /tmp/ltp-full-20130109/include/mk/env_pre.mk:77: abs dirs: -n
> /tmp/ltp-full-20130109 -n /tmp/ltp-full-20130109
> 
> The appended "-n" looks kind of suspicious?

Looks like the -n gets there from scripts/abspath.sh that is used from
include/mk/functions.mk in MAKE_3_80_abspath which is used to emulate
abspath which is implemented in newer GNU make.

If I'm right fixing the script to call echo that supports -n or getting
GNU make that supports abspath should help.

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
