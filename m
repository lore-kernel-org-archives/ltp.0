Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MBK4g-0004Y6-BL
	for ltp-list@lists.sourceforge.net; Tue, 02 Jun 2009 02:50:02 +0000
Received: from smtp105.biz.mail.mud.yahoo.com ([68.142.200.253])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MBK4e-0000zQ-Ov
	for ltp-list@lists.sourceforge.net; Tue, 02 Jun 2009 02:50:02 +0000
Date: Tue, 02 Jun 2009 10:50:34 +0800 (CST)
Message-Id: <20090602.105034.226785759.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <20090602001451.GA19251@schrodinger.suse.cz>
References: <20090601193622.GA690@schrodinger.suse.cz>
	<20090602.074642.226786039.caiqian@cclom.cn>
	<20090602001451.GA19251@schrodinger.suse.cz>
Mime-Version: 1.0
Subject: Re: [LTP] [chrubis@suse.cz: Re: [PATCH] fix missing return in
 several files.]
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
To: ltp-list@lists.sourceforge.net

From: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [chrubis@suse.cz: Re: [PATCH] fix missing return in several files.]
Date: Tue, 2 Jun 2009 02:14:51 +0200

> Hi,
>> Well, in this case, tst_brkm() looks like unnecessary here.
>> 
>>    /*
>>     * If no cleanup function was specified, just return to the caller.
>>     * Otherwise call the specified function.  If specified function
>>     * returns, call tst_exit().
>>     */
>>    if ( func != NULL ) {
>>       (*func)();
>>       tst_exit();
>>    }
>> 
>> The tst_exit() you just added will not be called anyway.
> 
> I'm passing NULL to tst_brkm, so we should never enter this code.  But
> tst_brkm() calls tst_exit() in some circumstances so we should either add
> __atribute__ ((noreturn)) to tst_brkm too or remove tst_exit() from it.
> 

OK. How about we do,

    	tst_resm(TCONF, "libaio missing");
	tst_exit();

instead of,

	tst_brkm(TCONF, NULL, "libaio missing");
	tst_exit();

since I can't see the reason to use tst_brkm() in this case?

CAI Qian

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
