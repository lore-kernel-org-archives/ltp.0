Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Message-ID: <53327AAD.2030402@oracle.com>
Date: Wed, 26 Mar 2014 10:58:53 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <5331A238.3020003@oracle.com>
	<4BA9BC50-10B8-425F-973D-19CC6439F9AA@gmail.com>
In-Reply-To: <4BA9BC50-10B8-425F-973D-19CC6439F9AA@gmail.com>
Subject: Re: [LTP] [Libtirpc-devel] svc_vc_create/clnt_vc_create and
	RPC_ANYFD
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
To: Chuck Lever <chucklever@gmail.com>
Cc: vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>, libtirpc List <libtirpc-devel@lists.sourceforge.net>



On 03/25/2014 07:56 PM, Chuck Lever wrote:
>
> On Mar 25, 2014, at 8:35 AM, Stanislav Kholmanskikh <stanislav.kholmanski=
kh@oracle.com> wrote:
>
>> Hi!
>>
>> Sorry, but yet another question regarding rpc-tirpc-full-test-suite.
>>
>> Some binaries from this suite pass RPC_ANYFD to svc_vc_create() or
>> clnt_vc_create().
>>
>> Like this one -
>> https://github.com/linux-test-project/ltp/blob/master/testcases/network/=
rpc/rpc-tirpc-full-test-suite/tests_pack/tirpc_svc_5/tirpc_svc_5.c
>> :
>>
>> transp =3D svc_vc_create(RPC_ANYFD, 1024, 1024);
>>
>> And, of course, the tests using this fail.
>>
>> I dig into the libtirpc sources and didn't found anything that could
>> state that we may pass RPC_ANYFD to these functions.
>>
>>  From svc_vc_create() comments:
>> "The filedescriptor passed in is expected to refer to a bound, but
>> not yet connected socket."
>>
>> and from clnt_vc_create():
>> "fd should be an open socket"
>>
>> So invoking svc_vc_create(RPC_ANYFD,...) or clnt_vc_create(RPC_ANYFD,
>> ...) is incorrect. Right?
>
> I don=92t see anything in
>
>    http://docs.oracle.com/cd/E19504-01/802-5885/802-5885.pdf
>
> that contradicts that.
>
> AFAICT RPC_ANYFD is OK for the so-called =93expert level=94 API, which me=
ans clnt_tli_create(3t) and svc_tli_create(3t).
>
> It is also OK for the legacy APIs svctcp_create() and clnttcp_create() to=
 take RPC_ANYSOCK.
>

Thank you.


> --
> Chuck Lever
> chucklever@gmail.com
>
>
>

---------------------------------------------------------------------------=
---
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
