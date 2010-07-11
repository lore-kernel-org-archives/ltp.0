Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OXzyW-0001rc-Of
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 17:05:56 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXzyU-0000ue-Jc
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 17:05:56 +0000
Received: by mail-iw0-f175.google.com with SMTP id 34so2820926iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 10:05:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikm0i8xOwFa040XXamt3MXBSwkhFLBOrMGpwK9o@mail.gmail.com>
References: <1278854732.8660.34.camel@sumit>
	<AANLkTikm0i8xOwFa040XXamt3MXBSwkhFLBOrMGpwK9o@mail.gmail.com>
Date: Sun, 11 Jul 2010 10:05:54 -0700
Message-ID: <AANLkTimLcwtjPp6J7k8hvh5X3Dk4mjxiHv-tLs9Dh5j1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/3] MAKEFILE: testcases/network/Makefile - bug
	fixing
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
To: Sumit Dhoot <sumitbd@linsyssoft.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, Jul 11, 2010 at 7:18 AM, Sumit Dhoot <sumitbd@linsyssoft.com> wrote:
> Hi All,
>
> I failed to add "Signed-off-by". Apologies for this.
>
> On Sun, Jul 11, 2010 at 6:55 PM, =A0<sumitbd@linsyssoft.com> wrote:
>> Hi,
>>
>> Testcase "nfs02" fails as script does not able to find =A0following files
>> ascii.jmb
>> ascii.lg
>> ascii.med
>> ascii.sm
>> This is because ltp's testcases/network/Makefile doesn't installed
>> those. It is fixed with following patch.
>>
>
> Signed-off-by: =A0Sumit Dhoot <sumitbd@linsyssoft.com>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Index: ltp-full-20100630/testcases/network/Makefile
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ltp-full-20100630.orig/testcases/network/Makefile
>> +++ ltp-full-20100630/testcases/network/Makefile
>> @@ -31,6 +31,7 @@ CLEAN_TARGETS =A0 =A0 =A0 =A0 +=3D $(DIR)
>> =A0INSTALL_DIR =A0 =A0 =A0 =A0 =A0 =A0:=3D testcases/bin
>>
>> =A0INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(addprefix $(DIR=
)/bin.,sm med lg jmb)
>> +INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D $(addprefix $(DIR)/=
ascii.,sm med lg jmb)
>>
>> =A0RM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -r

ACK.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
