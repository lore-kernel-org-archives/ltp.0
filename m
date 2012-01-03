Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Ri8g3-0004Ye-BH
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 18:01:35 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ri8g2-0007sn-Ho
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 18:01:35 +0000
Received: by obcwn6 with SMTP id wn6so18013867obc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jan 2012 10:01:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F02DB32.1050503@imgtec.com>
References: <4F02CBDE.70400@imgtec.com>
	<CAGH67wSFbMM+3Dr_pe=_+w_B4Su6p6wZ42LpP5vUwVE1hiH6QQ@mail.gmail.com>
	<4F02D122.7090704@imgtec.com> <4F02DB32.1050503@imgtec.com>
Date: Tue, 3 Jan 2012 10:01:28 -0800
Message-ID: <CAGH67wQWdBMJKo8AuBm+d50Scy55W3Dr+SeMjh85xaibXXiBBw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 02/21] lib/self_exec: Remove extra argument from
 tst_resm function call
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 3, 2012 at 2:40 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> On 01/03/2012 09:57 AM, Markos Chandras wrote:
>>
>> On 01/03/2012 09:50 AM, Garrett Cooper wrote:
>>>
>>> On Tue, Jan 3, 2012 at 1:35 AM, Markos Chandras
>>> <Markos.Chandras@imgtec.com> =A0 wrote:
>>>>
>>>> Hi, please review the attached patch
>>>
>>>
>>> =A0 =A0 =A0Converting the function to tst_brkm and removing the tst_exi=
t call
>>> below it would be better.
>>
>> Agreed, but to make this consistent, all the tst_resm&& =A0tst_exit pairs
>>
>> should be replaced with tst_brkm. I will prepare a patch
>>
> Here is a patch that converts all tst_resm && tst_exit calls to tst_brkm.
> Please review it.

Looks ok!

Reviewed-by: Garrett Cooper <yanegomi@gmail.com>

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create =

new or port existing apps to sell to consumers worldwide. Explore the =

Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
