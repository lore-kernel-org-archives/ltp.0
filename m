Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlSIt-0006Hz-Ss
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 19:58:35 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSIs-0005ik-Vq
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 19:58:35 +0000
Received: by fxm6 with SMTP id 6so4744740fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 12:58:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikeApsK=CMUjO6B26GDZmWkFWTWwBn0RUE9bPC3@mail.gmail.com>
References: <4C6AB19B.6060706@redhat.com>
	<AANLkTimurpbzZtn50_UNh0SRWsBPNWDcCYpbinNPH4Gj@mail.gmail.com>
	<AANLkTikdoWmHJT0-J_tSEar1698-_pO9mepCZp27ZWnZ@mail.gmail.com>
	<AANLkTikeApsK=CMUjO6B26GDZmWkFWTWwBn0RUE9bPC3@mail.gmail.com>
Date: Tue, 17 Aug 2010 15:58:29 -0400
Message-ID: <AANLkTin4Fcwsf6dQU6mSmBJgGhGWpWXntVtQQ4sk157K@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] running LTP on uClinux
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
Cc: dmarlin@redhat.com, ltp-list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 3:51 PM, Garrett Cooper wrote:
> On Tue, Aug 17, 2010 at 9:42 AM, Mike Frysinger wrote:
>> On Tue, Aug 17, 2010 at 12:31 PM, Garrett Cooper wrote:
>>> Let me know how this patch works for you.
>>
>> the logic in lib/Makefile should be unified with this
>
> lib.mk picks up env_post.mk, so it's already caught there. Or are you
> referring to how libltp is built and what headers are picked up from
> include/ ?

i mean there should not be more than one place in the whole tree which
adds -DUCLINUX/etc...  if we merge your patch, there will be.  i'm not
saying your patch is wrong, just that something needs fixing to avoid
the aforementioned scenario.
-mike

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
