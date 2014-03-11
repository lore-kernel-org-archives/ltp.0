Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Message-ID: <531F3008.8040901@oracle.com>
Date: Tue, 11 Mar 2014 19:47:20 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <5318674C.9010602@oracle.com>
	<5C05564D-9678-4A77-9904-AEDD496204C0@gmail.com>
	<53199C4F.209@oracle.com>
	<FC239229-AFB2-4D2A-9138-C20FF2780936@gmail.com>
	<531E13B6.2040003@oracle.com>
	<A0CACF04-F2D5-4E26-9EDF-720CCED714AE@gmail.com>
In-Reply-To: <A0CACF04-F2D5-4E26-9EDF-720CCED714AE@gmail.com>
Subject: Re: [LTP] [Libtirpc-devel] svcfd_create differences between
 libtirpc and glibc
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, libtirpc List <libtirpc-devel@lists.sourceforge.net>

CC-in LTP mailing list (I should have do it in the first e-mail)

On 11.03.2014 18:52, Chuck Lever wrote:
>
> On Mar 10, 2014, at 3:34 PM, Stanislav Kholmanskikh <stanislav.kholmanski=
kh@oracle.com> wrote:
>
>>
>> On 07.03.2014 18:53, Chuck Lever wrote:
>>>> Is this patch a suitable fix to this bug (sorry for spaces):
>>>>
>>>> diff --git a/src/svc_vc.c b/src/svc_vc.c
>>>> index d65a35e..fcd472d 100644
>>>> --- a/src/svc_vc.c
>>>> +++ b/src/svc_vc.c
>>>> @@ -218,6 +218,12 @@ svc_fd_create(fd, sendsize, recvsize)
>>>>
>>>>         slen =3D sizeof (struct sockaddr_storage);
>>>>         if (getsockname(fd, (struct sockaddr *)(void *)&ss, &slen) < 0=
) {
>>>> +               /* if fd is not a network socket, leave the address
>>>> +                * fields unitialized
>>>> +                */
>>>> +               if (errno =3D=3D ENOTSOCK)
>>>> +                       return ret;
>>>> +
>>>>                 warnx("svc_fd_create: could not retrieve local addr");
>>>>                 goto freedata;
>>>>         }
>>>>
>>>> ?
>>>>
>>>> It works in my case.
>>>>
>>>> Since makefd_xprt() returns a SVCXPRT structure which has xp_ltaddr, x=
p_rtaddr and xp_raddr filled with zeroes, both xp_ltaddr.buf and xp_rtaddr.=
buf will point to NULL in my case.
>>>> I suppose, that it should not be an issue, but I'm unsure :)
>>>>
>>>> If it's ok I'll resend it the right way.
>>>
>>> The library now returns an xprt that is not fully initialized. That may=
 not be terribly useful behavior.
>>>
>>> But that seems like the only way to get test-for-test compatibility wit=
h glibc. Perhaps the new comment could reflect that.
>>>
>>> Is there any information about exactly what that test is trying to dete=
rmine? What is fd 0 when that test is run?
>>
>> fd 0 is stdin in the tests. And svcfd_create() function is used to perfo=
rm a functional testing of itself and other functions (like svc_destroy).
>
> To be clear, I=92m not formally objecting to your patch. As a reviewer, I=
=92m just trying to understand whether the proposed fix is appropriate. Tha=
nks for sticking with it!
>

To be clear, I don't insist on applying any changes to the libtirpc =

code. :) In general, I just want to find the failing part. Whether it's =

the test or libtirpc.

>> For example:
>>
>> https://github.com/linux-test-project/ltp/blob/master/testcases/network/=
rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_sv=
cfd_create/1-basic.c
>>
>> and here fd is not explicitly set to 0 (but I'm inclined that this is a =
bug):
>> https://github.com/linux-test-project/ltp/blob/master/testcases/network/=
rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_sv=
c_destroy/1-basic.c
>
> It would be nice to have some code samples other than test cases so we ca=
n see how svcfd_create() is used in the real world. So far, my search resul=
ts have produced only documentation and header files.
>
> However, this:
>
>    http://publib.boulder.ibm.com/infocenter/aix/v6r1/index.jsp?topic=3D%2=
Fcom.ibm.aix.progcomm%2Fdoc%2Fprogcomc%2Fstart_rpc_inetd.htm
>
> suggests that svcfd_create() expects a connected TCP socket.
>
> This is why the test case confuses me: Although the inetd daemon would pa=
ss fd 0 to svcfd_create(), as the test case does, NULL should be the correc=
t result when passing in a socket that is not a connected TCP socket, I wou=
ld think.
>
> Is the test program simply run from a terminal, or is it part of some lar=
ger infrastructure that would actually provide a TCP socket as fd 0?

This suite has an infrastructure to execute such programs. In general =

the logic is:
* It starts an rpc server like this (in background):
   ./rpc_svc_1 <program number>
   This server registers <program number> and version 1 to rpcbind
* Then it executes a test binary, passing it the host where rpc_svc_1 is =

running and the program number. Like this:
   ./test_binary 127.0.0.1 <program number>
* The test binary do its job and returns/prints either 0 or 1 (success =

or failure).

Of course, there are some variations.

But the programs I mentioned above, in fact, don't perform any calls to =

the running rpc server, therefore they can be executed simply from a =

terminal, therefore (I think), fd is stdin.

So, to sums up, the evil is in the tests and the right action would be =

modifying the tests to pass svcfd_create() a connected TCP socket. Right?

>
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
