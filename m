Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hakehuang@gmail.com>) id 1QYusR-0006eH-KZ
	for ltp-list@lists.sourceforge.net; Tue, 21 Jun 2011 06:55:59 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QYusQ-00055f-9B
	for ltp-list@lists.sourceforge.net; Tue, 21 Jun 2011 06:55:59 +0000
Received: by gyd12 with SMTP id 12so668140gyd.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Jun 2011 23:55:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mailman.181450.1307593246.21896.ltp-list@lists.sourceforge.net>
References: <mailman.181450.1307593246.21896.ltp-list@lists.sourceforge.net>
Date: Tue, 21 Jun 2011 14:55:52 +0800
Message-ID: <BANLkTikpV2jpTJ8_N3FhV0Y1S5p_8n-fPA@mail.gmail.com>
From: hake huang <hakehuang@gmail.com>
Subject: Re: [LTP] Ltp-list Digest, Vol 61, Issue 3
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
To: ltp-list@lists.sourceforge.net

Hi,

I am rebasing my local git repository with ltp May release from
git://ltp.git.sourceforge.net/gitroot/ltp/ltp, but I see no tag for
May release. which commit is the last one for May release?

Regards,

Hake

2011/6/9  <ltp-list-request@lists.sourceforge.net>:
> Send Ltp-list mailing list submissions to
> =A0 =A0 =A0 =A0ltp-list@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
> =A0 =A0 =A0 =A0https://lists.sourceforge.net/lists/listinfo/ltp-list
> or, via email, send a message with subject or body 'help' to
> =A0 =A0 =A0 =A0ltp-list-request@lists.sourceforge.net
>
> You can reach the person managing the list at
> =A0 =A0 =A0 =A0ltp-list-owner@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Ltp-list digest..."
>
>
> Today's Topics:
>
> =A0 1. Re: open posix "sigpause" test defect (Cyril Hrubis)
> =A0 2. Re: open posix "sigpause" test defect (Kevin R. Whitney)
> =A0 3. [ANNOUNCE] The Linux Test Project has been released for MAY
> =A0 =A0 =A02011. (Shubham Goyal)
> =A0 4. [PATCH v2] cgroups/cpuacct_setup: fix task_kill() search for
> =A0 =A0 =A0process (Jan Stancek)
> =A0 5. [PATCH] acl_test01: fix incorrect failure losetup.1 (Po-Yu Chuang)
> =A0 6. [PATCH] gzip_tests.sh: fix error message typo (Po-Yu Chuang)
> =A0 7. Re: [PATCH] acl_test01: fix incorrect failure losetup.1
> =A0 =A0 =A0(Garrett Cooper)
> =A0 8. Re: [PATCH] gzip_tests.sh: fix error message typo (Garrett Cooper)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Fri, 3 Jun 2011 15:00:36 +0200
> From: Cyril Hrubis <chrubis@suse.cz>
> Subject: Re: [LTP] open posix "sigpause" test defect
> To: "Kevin R. Whitney" <krwhitney@gmail.com>
> Cc: ltp-list@lists.sourceforge.net
> Message-ID: <20110603130036.GA7155@saboteur.suse.cz>
> Content-Type: text/plain; charset=3Dus-ascii
>
> Hi!
>> This is my first post, so if I'm in the wrong place, please direct me to=
 the
>> correct place!
>>
>> I found that
>> test testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.=
c is
>> unstable because of a defect in the code. =A0Of course I can provide the=
 logic
>> and diffs, but where/who should I send it to?
>
> You got to the right place ;). Send a signed patch here.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
>
>
> ------------------------------
>
> Message: 2
> Date: Sat, 4 Jun 2011 20:43:34 -0400
> From: "Kevin R. Whitney" <krwhitney@gmail.com>
> Subject: Re: [LTP] open posix "sigpause" test defect
> To: Cyril Hrubis <chrubis@suse.cz>
> Cc: ltp-list@lists.sourceforge.net
> Message-ID: <BANLkTi=3DMR+H7htd3XmqkHGGxoQvfBFRerQ@mail.gmail.com>
> Content-Type: text/plain; charset=3D"utf-8"
>
> I'm new- I don't know how to do that. =A0I'll look around the website, bu=
t if
> you have the
> info handy it'd be great if you could give me a pointer.
>
> Thanks,
>
> Kevin
>
>
> On Fri, Jun 3, 2011 at 9:00 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> Hi!
>> > This is my first post, so if I'm in the wrong place, please direct me =
to
>> the
>> > correct place!
>> >
>> > I found that
>> > test testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-=
1.c
>> is
>> > unstable because of a defect in the code. =A0Of course I can provide t=
he
>> logic
>> > and diffs, but where/who should I send it to?
>>
>> You got to the right place ;). Send a signed patch here.
>>
>> --
>> Cyril Hrubis
>> chrubis@suse.cz
>>
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 3
> Date: Mon, 06 Jun 2011 15:56:38 +0530
> From: Shubham Goyal <shubham@linux.vnet.ibm.com>
> Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
> =A0 =A0 =A0 =A0MAY =A0 =A0 2011.
> To: LTP list <ltp-list@lists.sourceforge.net>,
> =A0 =A0 =A0 =A0linux-kernel@vger.kernel.org
> Cc: vapier@gentoo.org, torvalds@linux-foundation.org,
> =A0 =A0 =A0 =A0akpm@linux-foundation.org
> Message-ID: <4DECAB5E.8030700@linux.vnet.ibm.com>
> Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
>
> Hi,
>
> The Linux Test Project test suite has been released for the month of
> MAY 2011. Please see ltp/INSTALL file carefully, as there has been multip=
le
> changes for building/installing the test suite after the recent changes in
> Makefile infrastructure.
>
> The latest version of the test-suite contains 3000+ tests for the Linux
> OS and can be found at:
> http://ltp.sourceforge.net/,
> Latest happenings in LTP can also be found at:
> http://ltp.sourceforge.net/wiki/,
> http://ltp.sourceforge.net/wikiArchives.php, and,
> IRC: irc.freenode.org #ltp.
>
> Our web site also contains other information such as:
> - A Linux test tools matrix
> - Technical papers
> - How To's on Linux testing
> - Code coverage analysis tool.
>
> We would encourage the community to post results to
> ltp-results@lists.sf.net,
>
> patches, new tests, bugs or comments/questions to ltp-list@lists.sf.net,
>
> http://sourceforge.net/tracker/?func=3Dadd&group_id=3D3382&atid=3D103382 =
=A0(for
> New Bug(s)),
> http://sourceforge.net/tracker/?func=3Dadd&group_id=3D3382&atid=3D303382 =
=A0(for
> New Patch(s)),
> http://sourceforge.net/tracker/?func=3Dadd&group_id=3D3382&atid=3D353382 =
=A0(for
> New Feature Request(s))
>
> **Note: Some pending patches will be checked in for next release.
>
> Happy testing,
> Regards,
> Shubham
>
>
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 07 Jun 2011 16:19:52 +0200
> From: Jan Stancek <jstancek@redhat.com>
> Subject: [LTP] [PATCH v2] cgroups/cpuacct_setup: fix task_kill()
> =A0 =A0 =A0 =A0search for =A0 =A0 =A0process
> To: ltp-list@lists.sourceforge.net
> Message-ID: <4DEE3388.5010307@redhat.com>
> Content-Type: text/plain; charset=3D"utf-8"
>
>
> 1. "i* in "grep cpuacct_taski*" seems pointless as
> its target is cpuacct_task01
>
> 2. using cut fails when ps indents the output as following:
> =A0 99 cpuacct_task01
> =A0112 cpuacct_task01
> 1111 cpuacct_task01
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> =A0.../kernel/controllers/cpuacct/cpuacct_setup.sh =A0 =A0| =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: 0001-cgroups-cpuacct_setup-fix-task_kill-search-for-proce.patch
> Type: text/x-patch
> Size: 470 bytes
> Desc: not available
>
> ------------------------------
>
> Message: 5
> Date: Thu, =A09 Jun 2011 11:53:58 +0800
> From: Po-Yu Chuang <ratbert.chuang@gmail.com>
> Subject: [LTP] [PATCH] acl_test01: fix incorrect failure losetup.1
> To: ltp-list@lists.sourceforge.net
> Cc: Po-Yu Chuang <ratbert@faraday-tech.com>
> Message-ID:
> =A0 =A0 =A0 =A0<1307591638-1662-1-git-send-email-ratbert.chuang@gmail.com>
>
> From: Po-Yu Chuang <ratbert@faraday-tech.com>
>
> The LOOP_DEV empty checking was incorrect.
>
> Use `command` for command substitution.
>
> Also move the assignment out of condition expression. Bash 3.2.9 and
> Busybox 1.17.3 ash do not seem to support this kind of usage.
>
> Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
> ---
> =A0testcases/kernel/fs/acls/acl_test01 | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/ac=
ls/acl_test01
> index 7901002..7f883c6 100755
> --- a/testcases/kernel/fs/acls/acl_test01
> +++ b/testcases/kernel/fs/acls/acl_test01
> @@ -125,7 +125,8 @@ else
>
> =A0 =A0 =A0 =A0# Avoid hardcoded loopback device values (-f tries to find=
 the first
> =A0 =A0 =A0 =A0# available loopback device name)!
> - =A0 =A0 =A0 if ! (LOOP_DEV=3D$(losetup -f) && [ "x$LOOP_DEV" =3D x ]); =
then
> + =A0 =A0 =A0 LOOP_DEV=3D`losetup -f`
> + =A0 =A0 =A0 if [ "x$LOOP_DEV" =3D x ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm TCONF "[ losetup.1 ] Failed to fi=
nd an available loopback device -- is the required support compiled in your=
 kernel?"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit 0
> =A0 =A0 =A0 =A0fi
> --
> 1.6.3.3
>
>
>
>
> ------------------------------
>
> Message: 6
> Date: Thu, =A09 Jun 2011 11:56:24 +0800
> From: Po-Yu Chuang <ratbert.chuang@gmail.com>
> Subject: [LTP] [PATCH] gzip_tests.sh: fix error message typo
> To: ltp-list@lists.sourceforge.net
> Cc: Po-Yu Chuang <ratbert@faraday-tech.com>
> Message-ID:
> =A0 =A0 =A0 =A0<1307591784-1735-1-git-send-email-ratbert.chuang@gmail.com>
>
> From: Po-Yu Chuang <ratbert@faraday-tech.com>
>
>
> Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
> ---
> =A0testcases/commands/gzip/gzip_tests.sh | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/g=
zip/gzip_tests.sh
> index 99cafa4..5dba859 100755
> --- a/testcases/commands/gzip/gzip_tests.sh
> +++ b/testcases/commands/gzip/gzip_tests.sh
> @@ -265,7 +265,7 @@ test02()
> =A0 =A0 if [ $RC -ne 0 ]
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #2: uncompressing directory $LTPTMP/t=
st_gzip.tmp failed. =A0Reason"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Test #2: compressing directory $LTPTMP/tst=
_gzip.tmp failed. =A0Reason"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return $RC
> =A0 =A0 =A0 =A0fi
>
> --
> 1.6.3.3
>
>
>
>
> ------------------------------
>
> Message: 7
> Date: Wed, 8 Jun 2011 21:12:07 -0700
> From: Garrett Cooper <yanegomi@gmail.com>
> Subject: Re: [LTP] [PATCH] acl_test01: fix incorrect failure losetup.1
> To: Po-Yu Chuang <ratbert.chuang@gmail.com>
> Cc: ltp-list@lists.sourceforge.net, Po-Yu Chuang
> =A0 =A0 =A0 =A0<ratbert@faraday-tech.com>
> Message-ID: <CA7435E1-1588-4A21-A380-45D13479AC69@gmail.com>
> Content-Type: text/plain; charset=3Dus-ascii
>
> On Jun 8, 2011, at 8:53 PM, Po-Yu Chuang wrote:
>
>> From: Po-Yu Chuang <ratbert@faraday-tech.com>
>>
>> The LOOP_DEV empty checking was incorrect.
>>
>> Use `command` for command substitution.
>>
>> Also move the assignment out of condition expression. Bash 3.2.9 and
>> Busybox 1.17.3 ash do not seem to support this kind of usage.
>
> =A0 =A0 =A0 =A0Yeah... looking back and knowing what I do now, that would=
 never work because that's executed in a subshell.
> Thanks!
> -Garrett
>
>
> ------------------------------
>
> Message: 8
> Date: Wed, 8 Jun 2011 21:20:40 -0700
> From: Garrett Cooper <yanegomi@gmail.com>
> Subject: Re: [LTP] [PATCH] gzip_tests.sh: fix error message typo
> To: Po-Yu Chuang <ratbert.chuang@gmail.com>
> Cc: ltp-list@lists.sourceforge.net, Po-Yu Chuang
> =A0 =A0 =A0 =A0<ratbert@faraday-tech.com>
> Message-ID: <9507E9B4-F82A-4118-B4A4-D1D1DC466780@gmail.com>
> Content-Type: text/plain; charset=3Dus-ascii
>
> On Jun 8, 2011, at 8:56 PM, Po-Yu Chuang wrote:
>
>> From: Po-Yu Chuang <ratbert@faraday-tech.com>
>>
>>
>> Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
>> ---
>> testcases/commands/gzip/gzip_tests.sh | =A0 =A02 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/=
gzip/gzip_tests.sh
>> index 99cafa4..5dba859 100755
>> --- a/testcases/commands/gzip/gzip_tests.sh
>> +++ b/testcases/commands/gzip/gzip_tests.sh
>> @@ -265,7 +265,7 @@ test02()
>> =A0 =A0 if [ $RC -ne 0 ]
>> =A0 =A0 =A0 then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
>> - =A0 =A0 =A0 =A0 =A0 =A0 "Test #2: uncompressing directory $LTPTMP/tst_=
gzip.tmp failed. =A0Reason"
>> + =A0 =A0 =A0 =A0 =A0 =A0 "Test #2: compressing directory $LTPTMP/tst_gz=
ip.tmp failed. =A0Reason"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return $RC
>
> Committed -- thanks :).
> -Garrett
>
>
>
>
> ------------------------------
>
> -------------------------------------------------------------------------=
-----
> EditLive Enterprise is the world's most technically advanced content
> authoring tool. Experience the power of Track Changes, Inline Image
> Editing and ensure content is compliant with Accessibility Checking.
> http://p.sf.net/sfu/ephox-dev2dev
>
> ------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>
> End of Ltp-list Digest, Vol 61, Issue 3
> ***************************************
>

---------------------------------------------------------------------------=
---
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
