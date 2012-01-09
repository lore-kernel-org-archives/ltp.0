Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RkIih-0003W4-C0
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:09:15 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RkIib-0004DV-Q7
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:09:15 +0000
Received: by obcwn6 with SMTP id wn6so5755213obc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jan 2012 09:09:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F0AB938.9050504@imgtec.com>
References: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
	<4F0AB938.9050504@imgtec.com>
Date: Mon, 9 Jan 2012 09:09:04 -0800
Message-ID: <CAGH67wTEBjdyz7_9FXWSuN_YkJkxT9XBzk=ssXoObfrX+4_aOg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] syscalls/xattr: fix compile when xattr.h not exist
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

On Mon, Jan 9, 2012 at 1:54 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> On 01/09/2012 09:44 AM, Caspar Zhang wrote:
>>
>> if<attr/xattr.h> =A0doesn't exist, compliation will fail. Fix it in
>> autotools level.
>>
>> Signed-off-by: Caspar Zhang<caspar@casparzhang.com>
>> ---
>> =A0 configure.ac =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0 testcases/kernel/syscalls/getxattr/getxattr01.c | =A0 15 +++++++++++=
++--
>> =A0 testcases/kernel/syscalls/getxattr/getxattr02.c | =A0 16 +++++++++++=
++---
>> =A0 testcases/kernel/syscalls/setxattr/setxattr01.c | =A0 15 +++++++++++=
++--
>> =A0 testcases/kernel/syscalls/setxattr/setxattr02.c | =A0 16 +++++++++++=
++---
>> =A0 5 files changed, 53 insertions(+), 10 deletions(-)
>>
>>
>>
>>
> The patch looks good to me. Another approach would be to disable these
> two tests for all UCLINUX targets (uClibc does not have attr/xattr.h>)
> from testcases/kernel/syscalls Makefile.

The proposed method is best because it produces something sane if
someone tries to run the testcase from the directory and the headers
were missing.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual =

desktops for less than the cost of PCs and save 60% on VDI infrastructure =

costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
