Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyBQ9-0001NC-NJ
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 21:30:09 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyBQ2-0000jp-Ie
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 21:30:09 +0000
Received: by pzk26 with SMTP id 26so177543pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 14:29:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A0780153D52A@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A0780153D4DC@svexch01.mvista.com>
	<364299f40910141219q59e9b87evdfe4a5f2e131b7f4@mail.gmail.com>
	<8368651DACC1964480F951191B94A0780153D52A@svexch01.mvista.com>
Date: Wed, 14 Oct 2009 14:29:49 -0700
Message-ID: <364299f40910141429yad16b3fr19946daf53f7d878@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][rwtest] use default size for blks if parsing df
	output fails to return numeric argument
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Wed, Oct 14, 2009 at 2:04 PM, Henry Yei <hyei@mvista.com> wrote:
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Wednesday, October 14, 2009 12:19 PM
>> To: Henry Yei
>> Cc: LTP Mailing List
>> Subject: Re: [LTP] [PATCH][rwtest] use default size for blks if parsing
>> df output fails to return numeric argument
>>
>> On Wed, Oct 14, 2009 at 12:04 PM, Henry Yei <hyei@mvista.com> wrote:
>> > All,
>> >
>> > This patch for rwtest.sh sets a default size for the number of blocks
>> within the filesystem the test is executing on if parsing "df output"
>> somehow results in a non-numeric value(unexpected df output). Also
>> removes trailing whitespace.
>> >
>> > Signed-off-by: Henry Yei <hyei@mvista.com>
>> >
>> >
>> > Garret,
>> >
>> > Per message Subject: [LTP] [issue 8] rwtest*: iogen / rwtest needs to
>> createprerequisite directory paths,
>> > Would a simple mkdir suffice inside the rwtest script to handle that
>> issue?
>>
>> mkdir -p would, yup!
>> Thanks,
>> -Garrett
>
> Here is the updated rwtest.sh patch that includes creation of the directo=
ry if it doesn=92t exist, and cleanup of the directory afterwards to resolv=
e issue # pointed out by Garrett Cooper.

Henry,

Looks good as far as your fix to my item is concerned.

Two things:

+                       # check if blks is a number, else set a
default value for blks
+                       default_sz=3D1000000

Is this a good default?

Could you also please change this:

                               max=3D${size##*\%}
                               if [[ "$max" =3D "" ]]
                               then
                                       max=3D$default_sz
                               fi

to this?

                               max=3D${size##*\%}
                               [ "x$max" =3D "x" ] && max=3D$default_sz

Thanks!
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
