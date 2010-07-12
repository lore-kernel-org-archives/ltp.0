Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OYNoF-0000Oh-UQ
	for ltp-list@lists.sourceforge.net; Mon, 12 Jul 2010 18:32:55 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OYNoD-0001LG-3s
	for ltp-list@lists.sourceforge.net; Mon, 12 Jul 2010 18:32:55 +0000
Received: by iwn34 with SMTP id 34so4165955iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Jul 2010 11:32:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinztRlk00v7cvOHHhpwuX4sLgVhmRDb3ZBM2wm8@mail.gmail.com>
References: <52CF90264091A14888078A031D780F4305D0247B@ism-mail03.corp.ad.wrs.com>
	<AANLkTinztRlk00v7cvOHHhpwuX4sLgVhmRDb3ZBM2wm8@mail.gmail.com>
Date: Mon, 12 Jul 2010 11:32:47 -0700
Message-ID: <AANLkTilOAvBQAkAkWMfKDpqr6uO6J0h7H1E0QK4RR2R1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Contribute to LTP
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
To: Subrata Modak <tosubrata@gmail.com>
Cc: ltp-list@lists.sourceforge.net, "Fu, Yingang" <Yingang.Fu@windriver.com>

On Mon, Jul 12, 2010 at 10:20 AM, Subrata Modak <tosubrata@gmail.com> wrote:
> Hi,
>
> On Mon, Jul 12, 2010 at 1:36 PM, Fu, Yingang <Yingang.Fu@windriver.com>
> wrote:
>>
>> hi,
>>
>> We have lots of fixes for ltp. What's the process of contribution to it?
>
> Good to know that you have lot of fixes for LTP. You need to follow the
> following procedure:
>
> Subscribe to this list first
> Send patches to this list with your Sign-off,
> Also attach supporting test results against your patches,

    Please make sure to pull the git based sources as well, not the
CVS ones, and be sure to pull the ltp-dev.git git module, not the
ltp.git one like the directions say up on the git pull page (I really
need to fix that).
Thanks!
-Garrett

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
