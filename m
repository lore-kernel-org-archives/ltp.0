Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ol278-000630-4K
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 16:00:42 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol276-0002Ws-V9
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 16:00:42 +0000
Received: by bwz12 with SMTP id 12so2677271bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Aug 2010 09:00:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C68F324.30108@windriver.com>
References: <4C63AD3C.2090909@windriver.com>
	<AANLkTin5XdJw7Vwc2NK8trJ2-vaYuC90s6dk9KhodFBu@mail.gmail.com>
	<4C68F324.30108@windriver.com>
Date: Mon, 16 Aug 2010 09:00:34 -0700
Message-ID: <AANLkTimcw8Qi4P5Y1Ba0OTbyzU_E8GK4sLf2Z20rPSFA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [patch]hugeshmat issue
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
To: "lina.zhao" <lina.zhao@windriver.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Mon, Aug 16, 2010 at 1:13 AM, lina.zhao <lina.zhao@windriver.com> wrote:
> See Mips run(2nd edition): 14.4 :MIPS/Linux system address transfer: linux
> address map:see the attachment
>>
>> On Thu, Aug 12, 2010 at 1:13 AM, lina.zhao <lina.zhao@windriver.com>
>> wrote:
>>
>>>
>>> Hi,
>>>
>>> In hugeshmat01 and hugeshmat02, the attach address for shard memory is
>>> 0x90000eee.
>>> For 32bits mips/Linux system, user space is under 0x7FFFFFFF,
>>> 0x90000eee is too big. The new address 0x60000eee has been tested
>>> on mips and other arch systems, it hasn't caused a issue yet.
>>>
>>
>> =A0 =A0Interesting. Do you have documentation to back up your claim?

Thanks for the info -- committed!
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
