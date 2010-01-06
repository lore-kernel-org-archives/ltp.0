Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NSKZl-0006gf-Lc
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 01:20:41 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSKZf-0007KI-Gp
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 01:20:41 +0000
Message-ID: <4B43E52E.4000205@web.de>
Date: Wed, 06 Jan 2010 02:19:42 +0100
From: Jiri Palecek <jpalecek@web.de>
MIME-Version: 1.0
References: <4B41E55D.2020801@st.com>
In-Reply-To: <4B41E55D.2020801@st.com>
Subject: Re: [LTP] mtest01: free memory allocated
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Francesco RUNDO napsal(a):
> Hi All,
>
> I'm running LTP (I'm using ltp-full-20090731....but asap I will upgrade
> to latest) on SH based platforms.
> Now, during a test-session. I've noted that the test "mtest01" reduced
> drastically the system memory and after its execution this memory wasn't
> de-allocated.
>
> I've analysed the mtest01.c code and I've noted that no "free()"
> istruction was associated to the related malloc:

Does this mean the kernel doesn't free processes' allocated memory on exit? Is 
this intentional (and documented somewhere)?

> ......
> if((mem = (char*)malloc(chunksize)) == NULL) {
> ......
>
> I've simply added a "free(mem)" of the allocated memory and the issue
> was addressed successfully.

This isn't complete by far. You don't free all the allocations, and there are 
code paths which don't pass your line before exit.

Regards
     Jiri Palecek

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
