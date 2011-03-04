Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvS20-0005RP-DA
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 10:14:44 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvS1z-0006Hh-J9
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 10:14:44 +0000
Received: by wwb29 with SMTP id 29so2716281wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 02:14:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D70B17C.6010202@redhat.com>
References: <4D6FD1D5.30209@redhat.com> <4D6FD518.1040503@redhat.com>
	<20110304093711.7c022f74@regolo> <4D70A86B.3000800@redhat.com>
	<AANLkTimspgQ+vhic29iSFrcWyXjT88WjKVvXY8uRELo0@mail.gmail.com>
	<4D70B17C.6010202@redhat.com>
Date: Fri, 4 Mar 2011 02:14:37 -0800
Message-ID: <AANLkTimQnP_1q3LpRhmp3VvfRb1rH6DhNKktiR+wBCRe@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2] syscalls: getdents0[234]: add tst_exit()
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Mar 4, 2011 at 1:31 AM, Caspar Zhang <czhang@redhat.com> wrote:
> On 03/04/2011 05:27 PM, Garrett Cooper wrote:
>> On Fri, Mar 4, 2011 at 12:52 AM, Caspar Zhang <czhang@redhat.com> wrote:
>>> On 03/04/2011 04:37 PM, Cristian Greco wrote:
>>>> wouldn't it be better to call tst_resm() with TCONF instead of TINFO,
>>>> for the sake of consistency?
>>>
>>> Agree. Updated to v3:
>>>
>>> These tests contain x86 asm so that they wouldn't be run on x86_64
>>> machine, but run into a simple main() functions instead. However all of
>>> them are missing tst_exit() which could result in a exit_code=10
>>> failure.
>>
>> Fixing it with equivalent:
>>
>> tst_brkm(TBROK, NULL, ...);
>
> TBROK returns a non-zero value, which may result in a FAIL in log...

Sorry... meant TCONF.
Thanks,
-Garrett

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
