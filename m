Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OXzxt-0007Mz-68
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 17:05:17 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXzxs-0000ue-AK
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 17:05:17 +0000
Received: by iwn34 with SMTP id 34so2820926iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 10:05:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikfCl19jt_BQyJWXGvF-nrjaWW4Wk7QGAPb5zYq@mail.gmail.com>
References: <1278855268.8660.44.camel@sumit>
	<AANLkTikfCl19jt_BQyJWXGvF-nrjaWW4Wk7QGAPb5zYq@mail.gmail.com>
Date: Sun, 11 Jul 2010 10:05:10 -0700
Message-ID: <AANLkTikGBcFAEomRi8HiOU_6cf3eS-CbJvl2oGIl1Mzg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/3] nfs02: testcases/network/nfs/nfs02/nfs02
	script - bug fixing
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

On Sun, Jul 11, 2010 at 7:20 AM, Sumit Dhoot <sumitbd@linsyssoft.com> wrote:
> Hi All,
>
> I failed to add "Signed-off-by". Apologies for this.
>
> On Sun, Jul 11, 2010 at 7:04 PM, =A0<sumitbd@linsyssoft.com> wrote:
>>
>> Hi,
>>
>> Testcase "nfs02" fails with following message
>> "Test Failed: Removal of write permissions not honored on ascii.sm"
>> This is because ascii.sm has a rwx file permission for others when It
>> got installed. The script first tried to remove only write permission
>> for others and then it tests it with the r-- permission so test get
>> fails as it has r-x permission for others.
>>
>> This is fixed with following patch.
>>
> Signed-off-by: =A0Sumit Dhoot <sumitbd@linsyssoft.com>
>
> =3D=3D=3D=3D=3D=3D
>
>> Index: ltp-full-20100630/testcases/network/nfs/nfs02/nfs02
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ltp-full-20100630.orig/testcases/network/nfs/nfs02/nfs02
>> +++ ltp-full-20100630/testcases/network/nfs/nfs02/nfs02
>> @@ -179,7 +179,7 @@ do_test3()
>> =A0{
>> =A0$trace_logic
>> =A0 =A0echo "do_test3 $TC "
>> - =A0 chmod a-w $TCtmp/ascii.sm &
>> + =A0 chmod a-wx $TCtmp/ascii.sm &
>> =A0 =A0wait $!
>> =A0 =A0ls -l $TCtmp/ascii.sm | grep "r--"
>> =A0 =A0[ $? -eq 0 ] || end_testcase "Removal of write permissions not
>> honored on ascii.sm"

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
