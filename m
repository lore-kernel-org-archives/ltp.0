Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RqQnj-00055L-Bf
	for ltp-list@lists.sourceforge.net; Thu, 26 Jan 2012 14:59:47 +0000
Date: Thu, 26 Jan 2012 16:12:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120126151234.GB6666@saboteur.suse.cz>
References: <1326989959-24434-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326989959-24434-1-git-send-email-carmelo.amoroso@st.com>
Subject: Re: [LTP] [PATCH] mount1234: invert the logic in handling failures
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sf.net

Hi!
> mount is expected to fail if the device is a 'tty', so it seems that
> the original idea of this testcase were to test mount failures.
> If this is true, then the logic to handle the test results has to be inverted
> and consider the test case as PASSED if mount fails, while FAILED
> if mount erroneuosly succeeded to mount a tty device.
> 
> It also fixes a syntax error in substring expansion ( ${parameter:offset} )
> 
> The last check "mount04" has been removed as it does not cehck the device type
> but only the permission so that it is incosistent with the overall logic.
> 
> That said, rename the test case as mount123

Hmm, still the output of the testcases would say FAILED from the
respective mount testcases and then PASSED from the test script. My
guess is that this was some leftover testing script for testing the
testcase failures. What about removing it entirely?

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
