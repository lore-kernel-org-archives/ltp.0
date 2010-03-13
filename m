Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1NqV6f-0004fX-B2
	for ltp-list@lists.sourceforge.net; Sat, 13 Mar 2010 17:26:33 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NqV6e-0007vj-F1
	for ltp-list@lists.sourceforge.net; Sat, 13 Mar 2010 17:26:33 +0000
Message-Id: <4B9B684F020000E80005FE67@sinclair.provo.novell.com>
Date: Sat, 13 Mar 2010 10:26:23 -0700
From: "Murlin Wenzel" <mwenzel@novell.com>
References: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
	<364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
	<20100225062615.GB3377@linux.vnet.ibm.com>
	<20100310121544.GB11404@linux.vnet.ibm.com>
	<4B98AE5B020000E80005FC3D@sinclair.provo.novell.com>
	<364299f41003122332u3c4f93a7td3c1f9db1a360bec@mail.gmail.com>
In-Reply-To: <364299f41003122332u3c4f93a7td3c1f9db1a360bec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartDDF700AF.2__="
Subject: Re: [LTP] [patch] swapon03 cleanup v2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--=__PartDDF700AF.2__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>>> On 3/13/2010 at 12:32 AM, in message
<364299f41003122332u3c4f93a7td3c1f9db1a360bec@mail.gmail.com>, Garrett =
Cooper
<yanegomi@gmail.com> wrote:
> On Thu, Mar 11, 2010 at 7:48 AM, Murlin Wenzel <mwenzel@novell.com> =
wrote:
>>>>> On 3/10/2010 at 05:15 AM, in message
>> <20100310121544.GB11404@linux.vnet.ibm.com>, Rishikesh K Rajak
>> <risrajak@linux.vnet.ibm.com> wrote:
>>> On Thu, Feb 25, 2010 at 11:56:15AM +0530, Rishikesh K Rajak wrote:
>>>> On Wed, Feb 24, 2010 at 05:08:56PM -0800, Garrett Cooper wrote:
>>>> > On Wed, Feb 24, 2010 at 3:49 PM, Murlin Wenzel <mwenzel@novell.com> =
wrote:
>>>> > > Added clean_swap() to cleanup routine.  This makes sure all =
leftover swap
>>> files are removed.
>>>> > >
>>>> > > Signed-off-By:  Murlin Ray Wenzel mwenzel@novell.com=20
>>>> >
>>>> > Committed -- thanks!
>>>> > -Garrett
>>>>
>>>> Thanks Garret & Murlin.
>>>
>>>
>>> Hi Murlin,
>>>
>>> can you please look into this failure as it still fails on my SLES11 &
>>> RHEl5.4
>>> boxes.
>>>
>>> [root@mx3455a bin]# ./swapon03
>>> swapon03    1  TFAIL  :  Failed swapon for file swapfile29: errno=3DEPE=
RM(1):
>>> Operation not permitted
>>> swapon03    0  TWARN  :  tst_rmdir(): rmobj(/tmp/swasf2sLb) failed:
>>> unlink(/tmp/swasf2sLb/swapfile22) failed; errno=3D1: Operation not =
permitted
>>> swapon03    1  TFAIL  :  Failed to setup swaps
>>>
>>> attached is the strace log.
>>
>> That's the other part of the problem that I'm not sure what to do with =
yet. =20
> The original test was written entirely based on the assumption that =
there=20
> were always a max of 30 swap files available.  With newer kernels =
(SLE11=20
> RHEL5.4) the kernel can be configured so that the max could be as low as =
29=20
> if not 28.  The kernel is doing the right thing returning EPERM, but the =
test=20
> needs to be re-worked to deal with new maximum limits/possibilites.
>=20
> It should actually be KERNEL_MAX - (CONFIG_MIGRATION enabled ? 2 : 0)
> - used_swap_devices ...
>=20
> NOTES
>        The partition or path must be prepared with mkswap(8).
>=20
>        There is an upper limit on the number of swap files that may  be =
=20
> used,
>        defined  by  the  kernel constant MAX_SWAPFILES.  Before =
kernel=20
> 2.4.10,
>        MAX_SWAPFILES has the value 8; since kernel 2.4.10, it  has  the =
=20
> value
>        32.  Since kernel 2.6.18, the limit is decreased by 2 (thus: 30) =
if=20
> the
>        kernel is built with the CONFIG_MIGRATION option  (which  =
reserves =20
> two
>        swap  table  entries  for  the  page migration features of =
mbind(2)=20
> and
>        migrate_pages(2)).
>=20
>     The fun unknown is CONFIG_MIGRATION -- how do you know whether or
> not this is set from userspace? There's too much handwaving in this
> testcase that needs to be fixed.

That's my point.  There are even more config options in newer kernels =
which affect the number of swap files.  AFAIK none of that info is =
available to userspace app.  The only known is MAX_SWAPFILES which is 32, =
or 8 on 2.4 kernels.  The current test makes an assumption that there =
would always be 32 or 30 swapfiles available based on a kernel config at =
some point in the past.  I'm thinking the test should just use MAX_SWAPFILE=
S(32 in this case), try to create that many until EPERM error is returned, =
provide that TINFO to tester, clean up everything and if that succeeds =
call the test a pass.  It is too ugly trying to start guessing about is 29 =
ok, or 30 ok or 32 ok with no way of knowing how the kernel was configured.=


--=20

Murlin Ray Wenzel
mwenzel@novell.com
Office: 801 861 5748
Cell: 801 380 4520

Novell,
Making IT work as one.
http://www.novell.com





--=__PartDDF700AF.2__=
Content-Type: application/octet-stream; name="Murlin Wenzel.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Murlin Wenzel.vcf"

QkVHSU46VkNBUkQNClZFUlNJT046Mi4xDQpQUk9ESUQ6LS8vTm92ZWxsIEluYy8vR3JvdXB3aXNl
IDguMC4xIA0KWC1HV1RZUEU6VVNFUg0KRk46TXVybGluIFdlbnplbA0KTjpXZW56ZWw7TXVybGlu
OztTci4gRW5naW5lZXINCkVNQUlMO0lOVEVSTkVUO1BSRUY6TVdFTlpFTEBub3ZlbGwuY29tDQpB
RFI7V09SSztQUkVGOjtQUlYtRC0xMzE7MTgwMCBTb3V0aCBOb3ZlbGwgUGxhY2U7UHJvdm87VVQ7
ODQ2MDY7DQpMQUJFTDtXT1JLO1BSRUY7RU5DT0RJTkc9UVVPVEVELVBSSU5UQUJMRToxODAwIFNv
dXRoIE5vdmVsbCBQbGFjZT0wRD0wQT0NClByb3ZvLCBVVCA4NDYwNg0KVUlEOjEzRDRCNTIwLTA5
MkYtMDAwMC04NkRFLTAwODA1RjhBMDlDNQ0KVEVMO1ZPSUNFO1BSRUY6MS04MDEtODYxLTU3NDgN
ClRFTDtWT0lDRTtXT1JLOjEtODAxLTg2MS01NzQ4DQpURUw7RkFYO1BSRUY6ODAxLzg2MS01NDE1
DQpUSVRMRTpTci4gRW5naW5lZXINClJFVjoyMDEwMDMwOFQwMzMxNDJaDQpYLUdXVURGOjkoTWFp
bCBTdG9wKVBSVi1ELTEzMQ0KWC1HV1VERjoxMShFbXBsb3llZSBJRCkwMjY2MQ0KWC1HV1VERjo4
KE1haWxzdG9wKVBSVi1FLTE0MQ0KWC1HV1VERjoxMihXb3JrZm9yY2UgSUQpMDI2NjENClgtR1dV
REY6NyhDb3VudHJ5KVVTQQ0KWC1HV1VERjoyNChBT0wgSW5zdGFudCBNZXNzYWdpbmcgSUQpbXdl
bnplbHNlcw0KRU5EOlZDQVJEDQoNCg==

--=__PartDDF700AF.2__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--=__PartDDF700AF.2__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=__PartDDF700AF.2__=--

