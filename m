Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ol1zL-0000I3-6d
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 15:52:39 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol1zK-0000Om-Ap
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 15:52:39 +0000
Received: by bwz12 with SMTP id 12so2668762bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Aug 2010 08:52:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1281968496.5120.12.camel@subratamodak.linux.ibm.com>
References: <1281958501-17087-1-git-send-email-harsh@linux.vnet.ibm.com>
	<1281968496.5120.12.camel@subratamodak.linux.ibm.com>
Date: Mon, 16 Aug 2010 08:52:32 -0700
Message-ID: <AANLkTinO-wfFsoQmCChRXSC0FpVSs0SGOkp4726yuyJF@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ltp setrlimit testcase patch for RLIMIT_FSIZE
	resource
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

On Mon, Aug 16, 2010 at 7:21 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Mon, 2010-08-16 at 17:05 +0530, Harsh Prateek Bora wrote:
>> Current testcase for setrlimit resource RLIMIT_FSIZE
>> is using a global integer variable to communicate the number of
>> bytes from child to parent which is incorrect. This
>> has been corrected by introducing a pipe to transfer
>> this information from child to parent process.
>>
>> Signed-off-by: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
>> ---
>> =A0testcases/kernel/syscalls/setrlimit/setrlimit01.c | =A0 15 ++++++++++=
+++++
>> =A01 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcas=
es/kernel/syscalls/setrlimit/setrlimit01.c
>> index 6952eb3..2bb1e9d 100644
>> --- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
>> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
>> @@ -156,7 +156,11 @@ void test2()
>> =A0 =A0 =A0 =A0* an wired value! =A0So, it is essential to fflush the pa=
rent's
>> =A0 =A0 =A0 =A0* write buffer HERE
>> =A0 =A0 =A0 =A0*/
>> + =A0 =A0 int pipefd[2];
>> =A0 =A0 =A0 fflush(stdout);
>> + =A0 =A0 if (pipe(pipefd) =3D=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK | TERRNO, NULL, "pipe creation =
failed");
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Spawn a child process, and reduce the filesize to
>> @@ -170,6 +174,7 @@ void test2()
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (pid =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 close(pipefd[0]); /* close unused read end */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rlim.rlim_cur =3D 10;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rlim.rlim_max =3D 10;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((setrlimit(RLIMIT_FSIZE, &rlim)) =3D=3D =
-1) {
>> @@ -181,6 +186,11 @@ void test2()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((bytes =3D write(fd, buf, 26)) !=3D 10) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write(pipefd[1], &bytes, s=
izeof(bytes))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 < sizeof(bytes=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror("child:=
 write to pipe failed");
>
> You still uses perror() here. Use tst_resm() instead.

This patch is actually ok. If you look at the test in context (as
Harsh pointed out), the perror(3) call was within a forked process,
and that's fine. It's the other areas that need to be tst_resm(3)
calls because they're in the parent process and actually affect the
final outcome of the test, and provide a uniform means of reporting.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
