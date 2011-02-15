Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PpLvT-0001Ln-CI
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 14:30:47 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PpLvP-0008SQ-C8
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 14:30:47 +0000
Received: by wyb40 with SMTP id 40so206612wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Feb 2011 06:30:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110215132603.GA3092@localhost>
References: <4D5A47E5.3060108@cn.fujitsu.com> <20110215132603.GA3092@localhost>
Date: Tue, 15 Feb 2011 06:30:36 -0800
Message-ID: <AANLkTikNC8VgJiK3fzxTBX_9PXF6rw_F3KLakF-1+c45@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] unshare01.c: TEST_RETURN is used wrong
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
To: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Feb 15, 2011 at 5:26 AM, Serge E. Hallyn
<serge.hallyn@canonical.com> wrote:
> Quoting Peng Haitao (penght@cn.fujitsu.com):
>> Hi Garrett,
>>
>> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
>> ---
>> =A0testcases/kernel/syscalls/unshare/unshare01.c | =A0 =A06 +++---
>> =A01 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/k=
ernel/syscalls/unshare/unshare01.c
>> index e19d73d..9ae5e8f 100644
>> --- a/testcases/kernel/syscalls/unshare/unshare01.c
>> +++ b/testcases/kernel/syscalls/unshare/unshare01.c
>> @@ -206,7 +206,7 @@ int main(int ac, char **av) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pid1 =3D fork();
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_RETURN =3D=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pid1 =3D=3D -1) {
>
> Looking at the rest of that file, isn't the right fix to
> wrap 'pid1 =3D fork();' in a TEST() macro?

Hi Serge!
    I would agree with you, but in my firm opinion this testcase
abuses TEST_ERRNO, etc way too much for no good reason.
    I just didn't remember to follow through finishing off this file
for some odd reason.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
