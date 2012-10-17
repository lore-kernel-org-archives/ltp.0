Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TOULL-0003op-Ot
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 14:11:31 +0000
Date: Wed, 17 Oct 2012 16:09:20 +0200
From: chrubis@suse.cz
Message-ID: <20121017140920.GA28517@rei>
References: <20121015182122.GA6698@rei.suse.cz>
	<1350443616-20186-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<201210170031.23266.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201210170031.23266.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] tools: add tst_ncpus/_max api to get number of
	CPUS
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > --- a/tools/apicmds/ltpapicmd.c
> > +++ b/tools/apicmds/ltpapicmd.c
> > @@ -266,6 +266,12 @@ int main(int argc, char *argv[])
> >  		else if (exit_value > 0)
> >  			exit_value = 2;
> >  		exit(exit_value);
> > +	} else if (strcmp(cmd_name, "tst_ncpus") == 0) {
> > +		long exit_ncpus = tst_ncpus();
> > +		exit(exit_ncpus);
> > +	} else if (strcmp(cmd_name, "tst_ncpus_max") == 0) {
> > +		long exit_ncpus_max = tst_ncpus_max();
> > +		exit(exit_ncpus_max);
> >  	}
> 
> i'm afraid exit() won't work.  the value is anded with 0xff which means if you 
> have a system with 4096 cpus, these will exit(0) and obviously that isn't what 
> you want :).  plus, extracting the value from the exit status is not normal 
> behavior in the shell scripting world.
> 
> simply write it to stdout instead:
> 	printf("%li\n", tst_ncpus());

Ah, right, I really overlooked this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
