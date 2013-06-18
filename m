Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UowlC-0004TN-9o
	for ltp-list@lists.sourceforge.net; Tue, 18 Jun 2013 14:19:50 +0000
Date: Tue, 18 Jun 2013 16:21:18 +0200
From: chrubis@suse.cz
Message-ID: <20130618142118.GA15772@rei.suse.cz>
References: <1371474097-17589-1-git-send-email-alexey.kodanev@oracle.com>
	<20130618122850.GB6464@rei.suse.cz> <51C064BD.1040104@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51C064BD.1040104@oracle.com>
Subject: Re: [LTP] [PATCH v3] fw_load: new test of device firmware loading
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
> I thought it is not necessary because WITH_MODULES won't be set if make
> target is clean.

Ah, the config.mk is include omited on 'make clean'. However I think
that depending on this is too confusing.

> >> +	if (access(module_name, F_OK) == -1) {
> >> +		tst_brkm(TCONF, NULL,
> >> +			"Test requires kernel module '%s'", module_name);
> >> +	}
> > Here you expect that the module is in current directory, which is not
> > robust enough.
> >
> > What about creating module_exists() module_load() and module_unload()
> > library functions?
> Yeah, it is possible. Could I use tst_resource files for that? Or perhaps,
> would it be better to create tst_modules files?

Start a separate source file for that, tst_module(s) is OK.

> > The path to the module should be determined from LTPROOT env variable,
> > see lib/tst_resource.c and lib/tst_resource.h that handles similar
> > situation for files needed by the tests.
> >
> >
> >> +
> >> +static void cleanup(void)
> >> +{
> >> +	if (skip_cleanup)
> >> +		return;
> >> +	int i;
> >> +	for (i = fw_num - 1; i>= 0; --i) {
> > Is there any reason for the loop going backward?
> >
> It is the only way to successfully remove created directories.
> I need to start from the last created file or/and directory and move
> upward.

I see, some of the dirs are subdirs of previously created dirs. What
about adding a short comment explaining that?

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
