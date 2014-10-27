Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XihPl-0004nP-Dd
	for ltp-list@lists.sourceforge.net; Mon, 27 Oct 2014 10:20:41 +0000
Date: Mon, 27 Oct 2014 11:20:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141027102013.GA9534@rei.suse.de>
References: <20141001171032.698f1356@as>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141001171032.698f1356@as>
Subject: Re: [LTP] recvfrom01: fix test for invalid message flags
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
To: Chuck Ebbert <cebbert.lkml@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The recv tests were making invalid assumptions about how flags are
> checked by the kernel. (It makes no explicit tests for invalid flags
> or combinations of flags.) [1] So the current method of setting every
> possible flag and checking for a specific error is not valid.
> 
> Before kernel 3.17 we were effectively just testing having the MSG_OOB
> flag set with no out-of-band data available. With 3.17 and later we
> were testing having MSG_ERRQUEUE set with no error data available,
> which returns a different error (and causes the existing test to fail).
> 
> Replace the bogus test for invalid flags with two new tests that check
> return codes for invalid MSG_OOB and MSG_ERRQUEUE flags.
> 
> Note that this introduces a failure on kernels before 3.17, which has
> a bug fix for MSG_ERRQUEUE flag handling. This failure is a legitimate
> bug on these older kernels. (They should not be returning success with
> no data available.)

Sorry for the delay, acked, tested and pushed, thanks.

Will you also send similar patches for the rest of the recv testcases?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
