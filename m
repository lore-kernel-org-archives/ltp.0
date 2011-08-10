Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qr7Yh-0008Is-W1
	for ltp-list@lists.sourceforge.net; Wed, 10 Aug 2011 12:06:51 +0000
Date: Wed, 10 Aug 2011 14:10:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110810121045.GB3179@saboteur.suse.cz>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
	<1309414787-2022-7-git-send-email-yanpai.chen@gmail.com>
	<20110721170155.GC7179@saboteur.suse.cz>
	<CANj_sbBZGdHond=dOHRKtgBrEHYiK8-iQD=hM-iv3ZU1J5_aYQ@mail.gmail.com>
	<CANj_sbB1KoHxDCBEnGGX66LihMY-00N+mj+rv-4zPYA7XpkssQ@mail.gmail.com>
	<20110727121238.GB20610@saboteur.suse.cz>
	<20110728180131.GA3307@saboteur.suse.cz>
	<CANj_sbCv=TKkRuaPmfWOBz4qArC1eKEuCoDiMb2oLrWCOf_GWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANj_sbCv=TKkRuaPmfWOBz4qArC1eKEuCoDiMb2oLrWCOf_GWQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH 7/7] testcases: syscalls: close file descriptors
 before unlinking
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
To: Andrew Yan-Pai Chen <yanpai.chen@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I've tried creating the files in TMP and the tests got passed.
> I also checked the rmdir(), it worked fine and no ENOTEMPTY.
> So, is this a filesystem specific issue?

Not really sure, for some reason files in $LTPROOT are not removed if
the fd is open on unlink(), could be anything from kernel bug to well
defined behavior in your setup.

Anyway these tests needs to be fixed and as usual patches are welcome ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
