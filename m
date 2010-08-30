Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1OqAH8-00065l-Lm
	for ltp-list@lists.sourceforge.net; Mon, 30 Aug 2010 19:44:14 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OqAH7-0000vj-Mb
	for ltp-list@lists.sourceforge.net; Mon, 30 Aug 2010 19:44:14 +0000
Received: by yxk30 with SMTP id 30so2685467yxk.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Aug 2010 12:44:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=rR1Jsk_Z09ESnfJX0Jp3vPU2R8xGo1Bv7k5J4@mail.gmail.com>
References: <52CF90264091A14888078A031D780F43064456F9@ism-mail03.corp.ad.wrs.com>
	<1282647757.4833.7.camel@subratamodak.linux.ibm.com>
	<AANLkTimM3YR5ArZgBG+s2mwW5fMWpYEXfahHSLUgSFjR@mail.gmail.com>
	<AANLkTi=rR1Jsk_Z09ESnfJX0Jp3vPU2R8xGo1Bv7k5J4@mail.gmail.com>
From: Henry Yei <hyei@mvista.com>
Date: Mon, 30 Aug 2010 12:43:48 -0700
Message-ID: <AANLkTim4HWktqf7PX15WcR23tyZcc+=rvqAc3QnKv0Fr@mail.gmail.com>
Subject: Re: [LTP] Rt_sigprocmask01 test case caused "segment fault" on x86
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, "Fu, Yingang" <Yingang.Fu@windriver.com>

My mistake, I can find the code just fine now. I suspect I had a bad
Friday and was looking at sigprocmask01 instead of rt_sigprocmask01
directory.



Henry Yei <hyei@mvista.com>





On Sat, Aug 28, 2010 at 1:30 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Aug 27, 2010 at 7:25 PM, Henry Yei <hyei@mvista.com> wrote:
>> Subrata,
>>
>>
>> I do not see this patch committed in the ltp-dev git tree on
>> sourceforge. Perhaps I am looking in the wrong place?
>
> This was committed 3 days ago.
> HTH,
> -Garrett
>

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
