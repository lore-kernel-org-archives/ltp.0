Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OXzyC-00024G-Ne
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 17:05:36 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXzyB-0000ue-DX
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 17:05:36 +0000
Received: by mail-iw0-f175.google.com with SMTP id 34so2820926iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 10:05:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimjpmS4PdPnO6jW7w6qrD7zkKopA4blPZufS_eq@mail.gmail.com>
References: <1278855498.8660.48.camel@sumit>
	<AANLkTimjpmS4PdPnO6jW7w6qrD7zkKopA4blPZufS_eq@mail.gmail.com>
Date: Sun, 11 Jul 2010 10:05:35 -0700
Message-ID: <AANLkTikQEi6hJTy2V4AUr0jJVQp52LDVp5RG0DFfsgG4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/3] runtest/nfs: TCbin path not exported for few
	tests
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

On Sun, Jul 11, 2010 at 7:22 AM, Sumit Dhoot <sumitbd@linsyssoft.com> wrote:
> Hi All,
>
> I failed to add "Signed-off-by". Apologies for this.
>
> On Sun, Jul 11, 2010 at 7:08 PM, =A0<sumitbd@linsyssoft.com> wrote:
>> Hi,
>>
>> While running networktest for nfs; nfsstress & =A0nfsstat01 test gets
>> fail. Because TCbin is not exported with required path. Following
>> patch fixed the above problem.
>>
> Signed-off-by: =A0Sumit Dhoot <sumitbd@linsyssoft.com>
>
> =3D=3D=3D=3D=3D=3D=3D
>
>> Index: ltp-full-20100630/runtest/nfs
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ltp-full-20100630.orig/runtest/nfs
>> +++ ltp-full-20100630/runtest/nfs
>> @@ -6,10 +6,10 @@ nfs01 export VERSION SOCKET_TYPE; TCbin=3D
>> =A0nfs02 export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs02
>> =A0nfs03 export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs03
>> =A0nfs04 export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs04
>> -nfslock01 export VERSION; nfslock01
>> +nfslock01 export VERSION; TCbin=3D$LTPROOT/testcases/bin nfslock01
>>
>> =A0# This will run 1 thread on 20 directories with 50 files in each.
>> -nfsstress export VERSION SOCKET_TYPE; nfsstress 20 50 1
>> +nfsstress export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin
>> nfsstress 20 50 1
>>
>> =A0nfsstat01 export VERSION; TCbin=3D$LTPROOT/testcases/bin nfsstat01
>> =A0nfsx-linux export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin
>> fsx.sh

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
