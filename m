Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RoEJ8-0006U8-23
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 13:15:06 +0000
Date: Fri, 20 Jan 2012 14:27:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120120132716.GE4024@saboteur.suse.cz>
References: <1327053248-18415-1-git-send-email-eguan@redhat.com>
	<1327053248-18415-2-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1327053248-18415-2-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/setxattr03: new testcase to test
 setxattr(2)
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
Both commited.

> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++)	{
> +			TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value,
> +			    tc[i].size, tc[i].flags));
> +
> +			if (TEST_ERRNO == tc[i].exp_err) {
> +				tst_resm(TPASS | TTERRNO, tc[i].desc);

And note that I've added format string "%s" to this line otherwise it
generates "format not a string literal" warning.

> +			} else {
> +				tst_resm(TFAIL | TTERRNO, "%s - expected errno"
> +				    " %d - Got", tc[i].desc, tc[i].exp_err);
> +			}
> +		}
> +	}
> +

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
