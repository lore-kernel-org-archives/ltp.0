Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UZOU5-0005aV-0C
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 16:41:53 +0000
Date: Mon, 6 May 2013 18:42:53 +0200
From: chrubis@suse.cz
Message-ID: <20130506164253.GA15114@rei.suse.cz>
References: <1367833278-18177-1-git-send-email-alexey.kodanev@oracle.com>
	<20130506134721.GE4388@rei> <5187D15B.7080106@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5187D15B.7080106@oracle.com>
Subject: Re: [LTP] [PATCH] New core test of hardlinks and symlinks
 restrictions added in Linux 3.6. Disabled by default in Linux 3.7.
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
> > Use tabs for indentation. And look for lines over 80 chars. Please use
> > checkpatch.pl from linux kernel sources to check the patch next time.
> I used checkpatch.pl on this code, but considered 80 chars limit as not 
> strict warning, I will fix it.

Okay.

> >> +static void create_test_user(void)
> >> +{
> >> +	char cmd[MAX_CMD_LEN];
> >> +	snprintf(cmd, MAX_CMD_LEN, "%s %s", "useradd", users[TEST_USER].name);
> > You can change the format string to "useradd %s" ;)
> that's right :), at first I thought to use it as a function parameter to 
> pass "useradd" or "userdel -r"

That would work as well.

> >> +	char *cwd = get_tst_tmpdir();
> >> +	cwd_offset = strlen(cwd);
> >> +
> >> +	mode_t mode = S_IRWXU | S_IRWXG | S_IRWXO;
> >> +	chmod(cwd, mode);
> >> +
> >> +	struct dir_params *bdir = bdirs;
> >> +	strcpy(bdir->path, cwd);
> >> +	free(cwd);
> > Do you really need the global path to the tst tmp dir? The call to
> > tst_tmpdir() changes your CWD to it, so at least the subdirs could be
> > created with local paths.
> It's simplify hardlinks and symlinks creation, otherwise I have to 
> construct relative paths that a bit more complicated.
> Also, some test-cases can be added to deal with files which are outside 
> of test tmpdir.

What about using relative paths where they are easier to use? 

> Thank you for your comments!
> 
> Could you please tell me how should I send the corrected patch, just in 
> the same way?

Yes please, the LTP mailing list is right place to post patches for review.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
