Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rv7bu-0007fM-4U
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 13:30:58 +0000
Date: Wed, 8 Feb 2012 14:44:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120208134446.GC17568@saboteur.suse.cz>
References: <1328581235-8304-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1328581235-8304-2-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F30D3F3.6030709@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F30D3F3.6030709@casparzhang.com>
Subject: Re: [LTP] [PATCH 1/4] hugemmap01: auto mount the temporary dir for
 testing
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I think we need some error check mechanism here.
> 
> (@Cyril: Looks like we need a strtol wrapper in LTP lib? we have several
> examples before, like:
> 
>     val = strtol(str, &endptr, 10);
>     if (((val == LONG_MAX || val == LONG_MIN) && errno == ERANGE) ||
>             (errno != 0 && val == 0))
>         tst_brkm(TBROK|TERRNO, cleanup, "strtol");
>     if (endptr == str || *endptr != '\0')
>         tst_brkm(TBROK, cleanup, "Invalid number parameter: %s", str);
> 

Hmm, that sounds reasonable, the code to handle strtol is too
compilcated to be written again and again.

I would do something similar to the safe macros, perhaps:

SAFE_STRTOL(cleanup_fn, str, min, max)

Which would assert that string was converted correctly and is between
min and max value.

see include/safe_macros.h

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
