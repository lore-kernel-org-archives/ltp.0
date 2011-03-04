Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvRI6-0004BP-VF
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 09:27:20 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvRI6-0001Rf-0V
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 09:27:18 +0000
Received: by wyb38 with SMTP id 38so2223432wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 01:27:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D70A86B.3000800@redhat.com>
References: <4D6FD1D5.30209@redhat.com> <4D6FD518.1040503@redhat.com>
	<20110304093711.7c022f74@regolo> <4D70A86B.3000800@redhat.com>
Date: Fri, 4 Mar 2011 01:27:11 -0800
Message-ID: <AANLkTimspgQ+vhic29iSFrcWyXjT88WjKVvXY8uRELo0@mail.gmail.com>
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

On Fri, Mar 4, 2011 at 12:52 AM, Caspar Zhang <czhang@redhat.com> wrote:
> On 03/04/2011 04:37 PM, Cristian Greco wrote:
>> wouldn't it be better to call tst_resm() with TCONF instead of TINFO,
>> for the sake of consistency?
>
> Agree. Updated to v3:
>
> These tests contain x86 asm so that they wouldn't be run on x86_64
> machine, but run into a simple main() functions instead. However all of
> them are missing tst_exit() which could result in a exit_code=10
> failure.

Fixing it with equivalent:

tst_brkm(TBROK, NULL, ...);

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
