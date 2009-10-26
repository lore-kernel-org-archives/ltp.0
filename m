Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N2VNa-0005Gf-Rw
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 19:37:22 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N2VNU-0002WC-Gc
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 19:37:22 +0000
Received: by pwj6 with SMTP id 6so1989781pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Oct 2009 12:37:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1256576544.4929.54.camel@subratamodak.linux.ibm.com>
References: <200910211528.n9LFST8q028289@e35.co.us.ibm.com>
	<1256576544.4929.54.camel@subratamodak.linux.ibm.com>
Date: Mon, 26 Oct 2009 12:37:10 -0700
Message-ID: <364299f40910261237ka450dbcoe5f553167af01659@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix some bashisms
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: Jiri Palecek <jpalecek@web.de>, ltp-list@lists.sourceforge.net

On Mon, Oct 26, 2009 at 10:02 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Wed, 2009-10-21 at 02:19 +0200, Jiri Palecek wrote:
>> Hello,
>>
>> this is another patch fixing bashisms in LTP tests (the fixes are more o=
r less the same as in the previous patches, except for a few exceptions). N=
ote that the patch is not complete, in the sense that there may remain furt=
her bashisms in the source even after applying the patch (like use of array=
s, which is visible even from this patch).
>>
>> Regards
>> =A0 =A0 Jiri Palecek
>>
>> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>
> Hmm,. Some of them failed to apply. Can you please resend only the error
> part(s):

Sorry for not catching this sooner. netstat01 (and a lot of other
items under tcp_cmds) were rewritten to 1) remove bashisms, 2) make
the testing procedures more uniform, and 3) (the most important)
remove duplicate code in ipv6 and tcp_cmds.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
