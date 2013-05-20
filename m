Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UePul-0007wG-Oq
	for ltp-list@lists.sourceforge.net; Mon, 20 May 2013 13:14:11 +0000
Date: Mon, 20 May 2013 15:15:21 +0200
From: chrubis@suse.cz
Message-ID: <20130520131521.GA20537@rei.suse.cz>
References: <1368706811-14497-1-git-send-email-alexey.kodanev@oracle.com>
	<20130520121654.GB19493@rei> <519A1D9F.9060204@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <519A1D9F.9060204@oracle.com>
Subject: Re: [LTP] [PATCH] Create a function tst_resm_hexd to print a buffer
 in hex values
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
> >> +	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
> >> +
> >> +	static const size_t symb_num = 3; /* space + xx */
> >> +
> >> +	size_t offset = strlen(tmesg);
> >> +
> >> +	if ((offset + symb_num * size + 1)>= USERMESG) {
> >> +		printf("%s: %i: line too long\n", __func__, __LINE__);
> >> +		abort();
> > What about printing only the start of the buffer as:
> >
> > 'This is test message: 0x0F 0x04 0x33 0x44 ...'
> >
> > instead of the abort?
> Yes, it's possible. Do I need to calc the header which tst_res() is 
> going to add or simply print first four bytes and check if it fits the 
> tmesg?

I would print as much as we can fit into the buffer, i.e. count leftover
space minus space for ' ...' and divide it by length of one entry (and
not to forget to accound for '\0');

> >> +	}
> >> +
> >> +	size_t i;
> >> +	for (i = 0; i<  size; ++i) {
> >> +		sprintf(tmesg + offset + i * symb_num,
> >> +			" %02x", (unsigned char)buf[i]);
> >> +	}
> >> +
> >> +	tst_res(ttype, NULL, "%s", tmesg);
> >> +}
> Also, I printing buffer without 0x prefix to make it more compact, 
> should I add it?

Sounds good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
