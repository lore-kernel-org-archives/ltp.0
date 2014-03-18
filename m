Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WPx8c-0002fz-WC
	for ltp-list@lists.sourceforge.net; Tue, 18 Mar 2014 16:45:15 +0000
Date: Tue, 18 Mar 2014 17:44:48 +0100
From: chrubis@suse.cz
Message-ID: <20140318164448.GA14235@rei.Home>
References: <1395150116-16817-1-git-send-email-alexey.kodanev@oracle.com>
	<20140318135236.GB12227@rei> <532873A4.8090802@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <532873A4.8090802@oracle.com>
Subject: Re: [LTP] [PATCH v2] tools/apicmd: add tst_get_unused_port
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> >> ---
> >>   tools/apicmds/.gitignore  |    1 +
> >>   tools/apicmds/Makefile    |    2 +-
> >>   tools/apicmds/ltpapicmd.c |   37 +++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 39 insertions(+), 1 deletions(-)
> > I've tried the resulting binary and there is a small problem with the
> > fact that it's compiled from the apicmd. It requires to have TCID
> > TST_TOTAL and TST_COUNT. The test.sh library requires TCID and TST_TOTAL
> > but not TST_COUNT.
> >
> > So we either start new helper program to call tst_ functions or remove
> > the requirement fro TST_COUNT or add dummy TST_COUNT to test.sh...
> >
> Can we replace LTP_TST_CNT with TST_COUNT in test.sh?

I've looked at the ltpapicmd.c and it does not modify the value of
TST_COUNT env variable so this is fine. Feel free to send a patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
