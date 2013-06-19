Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UpGnI-0007Zy-4a
	for ltp-list@lists.sourceforge.net; Wed, 19 Jun 2013 11:43:20 +0000
Date: Wed, 19 Jun 2013 13:44:46 +0200
From: chrubis@suse.cz
Message-ID: <20130619114446.GC24520@rei>
References: <1371474097-17589-1-git-send-email-alexey.kodanev@oracle.com>
	<20130618122850.GB6464@rei.suse.cz> <51C064BD.1040104@oracle.com>
	<20130618142118.GA15772@rei.suse.cz> <51C180F6.7040204@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51C180F6.7040204@oracle.com>
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
> >>> What about creating module_exists() module_load() and module_unload()
> >>> library functions?
> >> Yeah, it is possible. Could I use tst_resource files for that? Or perhaps,
> >> would it be better to create tst_modules files?
> > Start a separate source file for that, tst_module(s) is OK.
> >
> I would like to implement tst_module_load() function with variable 
> argument list
> (use for command line parameters of the insmod command).
> There is a macro EXPAND_VAR_ARGS defined in tst_res.c, which might be 
> used by
> that function. Is it possible to move it outside of the tst_res.c file, 
> where it can be
> easily accessed by other c files?

The standard way for this is to create internal header named common.h or
similar stored under the lib/ directory for the common macros/internal
only API.

But looking at the body of the macro, there is assert(strlen(buf) > 0)
which would mean that we can't pass empty parameters to the
module_load() function (given that the interface is module_load(const
char *module_name, const char *params, ...) or similar). So the easiest
way would IMHO be just copy part of the macro into the new code or write
it from scratch.

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
