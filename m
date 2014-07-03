Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X2f1S-00032s-NV
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 11:17:50 +0000
Date: Thu, 3 Jul 2014 13:17:28 +0200
From: chrubis@suse.cz
Message-ID: <20140703111728.GB2534@rei.scz.novell.com>
References: <1404356716-20493-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<53B4CE30.9050407@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B4CE30.9050407@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] doc/man3/tst_res.3: fix the wrong description
 about TPASS
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
> > Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> > ---
> >  doc/man3/tst_res.3 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/doc/man3/tst_res.3 b/doc/man3/tst_res.3
> > index 0754daf..3fc8e79 100644
> > --- a/doc/man3/tst_res.3
> > +++ b/doc/man3/tst_res.3
> > @@ -233,7 +233,7 @@ TCONF
> >  0040	/* ..1. .... */
> >  .RE
> >  .P
> > -NOTE: \fBTPASS, TRETR, TINFO\fR, and \fBTCONF\fR do not have an effect
> > +NOTE: \fBTRETR, TINFO\fR, and \fBTCONF\fR do not have an effect
> >  on the test program exit status.

Hmm, but looking at the TCONF this is no longer true.

Maybe it's time we get rid of the tst_* man pages since all the
important documentation is now in test-writing-guidelines.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
