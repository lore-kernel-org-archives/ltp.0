Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MF5R8-0000LX-EV
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 12:00:46 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MF5R4-00024b-2j
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 12:00:46 +0000
From: Jiri Palecek <jpalecek@web.de>
Date: Fri, 12 Jun 2009 14:08:11 +0200
References: <1244635585.9465.14.camel@munipradeep-laptop>
In-Reply-To: <1244635585.9465.14.camel@munipradeep-laptop>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906121408.15925.jpalecek@web.de>
Subject: Re: [LTP]
 =?iso-8859-15?q?Some_of_the_testcases_which_are_resulting_i?=
 =?iso-8859-15?q?n_FAIL_even_though_they=09might_not_be?=
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
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, iranna.ankad@in.ibm.com

On Wednesday 10 June 2009 14:06:25 Munipradeep Beerakam wrote:
> Hi,

Hi,

> Here is the list of testcases in May 2009 LTP, which *may* result in
> FAIL even though it is a configuration error, not the error due to the
> functionality we are testing. Those tests should give "CONF" message,
> not "FAIL". I ran LTP on 2.6.18 kernel, x86 architecture.
> 
> 
>    3. get_mempolicy01
> Part of code, which is not correct
> tst_resm(TFAIL, "set_mempolicy() failed - errno = %d : %s",TEST_ERRNO,
> strerror(TEST_ERRNO));
> ...
> ...
> tst_resm(TFAIL, "malloc failed - errno = %d : %s",TEST_ERRNO,
> strerror(TEST_ERRNO));
> 
>    4. mq_open01
> Part of code, which is not correct
> if (TEST_RETURN < 0) {
>                         tst_resm(TFAIL, "mq_getsetattr failed - errno =
> %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));

Not that I'd say this code is stellar, it may even be incorrect, but changing these to TCONF wouldn't be correct either. These error messages should be TCONF only if errno is ENOSYS, otherwise, they should be reported as TBROK, because it would be an error that prevents the test to run. The best option, however, would probably be to add a tst_kvercmp check for kernel versions that contain the respective functions.

Regards
    Jiri Palecek

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
