Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsDGZ-0002gR-SM
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 14:33:43 +0000
Date: Thu, 27 Jun 2013 16:35:14 +0200
From: chrubis@suse.cz
Message-ID: <20130627143514.GA22310@rei.suse.cz>
References: <1372264605-29259-1-git-send-email-alexey.kodanev@oracle.com>
	<20130627142230.GB21873@rei.suse.cz> <51CC4C53.4020602@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51CC4C53.4020602@oracle.com>
Subject: Re: [LTP] [PATCH v3] lib: tst_module: add library functions for
 kernel modules
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
> >> +
> >> +	if (err != 0) {
> >> +		free(buf);
> >> +		tst_brkm(TCONF, cleanup_fn, "Failed to find module '%s'",
> >> +			mod_name);
> >> +	}
> >> +
> >> +	if (mod_path != NULL)
> >> +		*mod_path = buf;
> >> +	else
> >> +		free(buf);
> >> +}
> > So you expect that the '.ko' suffix is part of the module name. It
> > should be written in the comment in the header. Because at least I
> > expect the module name to be the name that is returned by lsmod.
> I will change module name to module's file name in the comments, is it OK?

Ok.

> >> +void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
> >> +{
> >> +	char *mod_path = NULL;
> >> +	tst_module_exists(cleanup_fn, mod_name,&mod_path);
> >> +	char *const argv[] = { "rmmod", mod_path, NULL };
> > Hmm, man rmmod suggest that it takes module name (not module path) as
> > parameter i.e. the string without the path and the '.ko' suffix. Does it
> > work with module path too?
> >
> It works fine with path too, also without/with suffix .ko

Ok, then we can avoid the tst_module_exists() call and call rmmod with
just mod_name.

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
