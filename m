Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSbV3-0007kx-H8
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 19:24:57 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSbV2-0004cM-Do
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 19:24:57 +0000
Received: by pwj11 with SMTP id 11so12458217pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 06 Jan 2010 11:24:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B447E4E.5040203@petalogix.com>
References: <4B4204D2.70204@petalogix.com> <4B43E6FD.3020906@web.de>
	<364299f41001051741v7a2bb1d0p91d28aa25967b93e@mail.gmail.com>
	<364299f41001051831r6a0f4930t6ba61e4273c797e3@mail.gmail.com>
	<4B447E4E.5040203@petalogix.com>
Date: Wed, 6 Jan 2010 11:24:36 -0800
Message-ID: <364299f41001061124o492a8e82i2867efe685b1684e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] lchown test case
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
To: michal.simek@petalogix.com
Cc: Jiri Palecek <jpalecek@web.de>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Wed, Jan 6, 2010 at 4:13 AM, Michal Simek <michal.simek@petalogix.com> w=
rote:
> Garrett Cooper wrote:
>>
>> On Tue, Jan 5, 2010 at 5:41 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>>>
>>> On Tue, Jan 5, 2010 at 5:27 PM, Jiri Palecek <jpalecek@web.de> wrote:
>>>>
>>>> Michal Simek napsal(a):
>>>>>
>>>>> Hi,
>>>>
>>>> Hi,
>>>>>
>>>>> I have some problems with lchown02 test which is caused with this
>>>>> patch.
>>>>> What is prep_create_link?
>>>>>
>>>>> Thanks,
>>>>> Michal
>>>>>
>>>>>
>>>>>
>>>>> http://git.kernel.org/?p=3Dlinux/kernel/git/galak/ltp.git;a=3Dcommitd=
iff;h=3Dee1a022fc76076d7fc1b6b1797c195244414c038
>>>>>
>>>>>
>>>>>
>>>>> diff --git a/runtest/syscalls b/runtest/syscalls
>>>>> index fbe8641..34631ed 100644 (file)
>>>>> --- a/runtest/syscalls
>>>>> +++ b/runtest/syscalls
>>>>> @@ -462,10 +462,10 @@ kill12 kill12
>>>>>
>>>>> lchown01 lchown01
>>>>> lchown01_16 lchown01_16
>>>>> -lchown02 cp -p $LTPROOT/testcases/bin/create_link $TMP; lchown02
>>>>> -lchown02_16 cp -p $LTPROOT/testcases/bin/create_link $TMP; lchown02_=
16
>>>>> +lchown02 prep_create_link; lchown02
>>>>> +lchown02_16 prep_create_link; lchown02_16
>>>>
>>>> IMHO it should do the same as the line above. But I think the whole
>>>> thing
>>>> could be deleted without causing any grief:
>>>>
>>>>
>>>> http://repo.or.cz/w/ltp-debian.git?a=3Dcommit;h=3Da5499edcf368fa88df92=
4f94ffcbe63c22b46e82
>>>
>>> The test needs create_link in $TMP; that's why I scripted it as a
>>> one-liner (but stupid me probably forgot to add the script to CVS
>>> -_-).
>>> Let me look and I'll get back to you shortly.
>>
>> Fixed. The executable needed CAP_CHOWN capability and that's part of
>> the point behind that script...
>
> ok. I rerun the latest code and lchown02 testcases still failing.
> I added two printf messages (path:Path_name - =A0and buffer:Cmd_buffer) w=
hich
> you can see below. And remove tst_rmdir to see if file exist or not.
>
>
> path /tmp/ltp-XXXX1ZaUjj/lch6m6mr0
> buffer /mnt/4/ltp/build/testcases/bin/create_link
> /tmp/ltp-XXXX1ZaUjj/lch6m6mr0/tfile_1
> change_owner: chown() of /tmp/ltp-XXXX1ZaUjj/lch6m6mr0/tfile_1 failed, er=
ror
> 1
> lchown02 =A0 =A01 =A0TBROK =A0: =A0Fail to modify tfile_1 ownership(s)!
> lchown02 =A0 =A02 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A03 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A04 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A05 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A06 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A07 =A0TBROK =A0: =A0Remaining cases broken
> path /tmp/ltp-XXXX1ZaUjj/lchouwHqq
> buffer /mnt/4/ltp/build/testcases/bin/create_link
> /tmp/ltp-XXXX1ZaUjj/lchouwHqq/tfile_1
> change_owner: chown() of /tmp/ltp-XXXX1ZaUjj/lchouwHqq/tfile_1 failed, er=
ror
> 1
> lchown02 =A0 =A01 =A0TBROK =A0: =A0Fail to modify tfile_1 ownership(s)!
> lchown02 =A0 =A02 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A03 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A04 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A05 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A06 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A07 =A0TBROK =A0: =A0Remaining cases broken
>
>
> The problem is at first with create_link because there is used
> /mnt/4/ltp/build/testcases/bin/create_link instead of
> /tmp/ltp-XXXX1ZaUjj/create_link which is setup by prep_create_link
>
> Please test the patch below which run correct version on my system
>
> Then I tried to run lchown02 test under user and I think that this line in
> prep_create_link is addtional
> #chown root:root "$TMP/create_link"
>
> lchown test must be run under root that's why create_link will have root
> rights and under user test reports that must be run as root.
>
> lchown02 =A0 =A01 =A0TBROK =A0: =A0Test must be run as root
> lchown02 =A0 =A02 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A03 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A04 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A05 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A06 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A07 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A01 =A0TBROK =A0: =A0Test must be run as root
> lchown02 =A0 =A02 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A03 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A04 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A05 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A06 =A0TBROK =A0: =A0Remaining cases broken
> lchown02 =A0 =A07 =A0TBROK =A0: =A0Remaining cases broken
>
>
> Thanks for testing,
> Michal
>
>
> --- lchown02-old.c =A0 =A0 =A02010-01-06 12:59:32.000000000 +0100
> +++ lchown02.c =A02010-01-06 13:00:49.000000000 +0100
> @@ -112,7 +112,6 @@
> =A0char Longpathname[PATH_MAX + 2];
> =A0char High_address_node[64];
> =A0char EXEC_DIR[PATH_MAX];
> -char main_test_dir[PATH_MAX + 2];
>
> =A0struct test_case_t { =A0 =A0 =A0 =A0 =A0 /* test case struct. to hold =
ref. test
> cond's */
> =A0 =A0 =A0 =A0char *pathname;
> @@ -265,12 +264,6 @@
> =A0 =A0 =A0 =A0/* Pause if that option was specified */
> =A0 =A0 =A0 =A0TEST_PAUSE;
>
> - =A0 =A0 =A0 /* remember current dir, because create_link has been copie=
d here */
> - =A0 =A0 =A0 if (getcwd(main_test_dir, sizeof(main_test_dir)) =3D=3D NUL=
L) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK | TERRNO, cleanup,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed to get the curre=
nt working directory.");
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* Make a temp dir and cd to it */
> =A0 =A0 =A0 =A0tst_tmpdir();
>
> @@ -339,12 +332,13 @@
>
> =A0 =A0 =A0 =A0strcpy(Path2_name, Path_name);
>
> + =A0 =A0 =A0 /* Get the command name to be executed as setuid to root */
> + =A0 =A0 =A0 strcat((char *)Cmd_buffer, Path_name);
> + =A0 =A0 =A0 strcat((char *)Cmd_buffer, (const char *)"/../create_link "=
);
> +
> =A0 =A0 =A0 =A0/* Get the path of test file created under temporary direc=
tory */
> =A0 =A0 =A0 =A0strcat(Path_name, "/" TEST_FILE1);
>
> - =A0 =A0 =A0 /* Get the command name to be executed as setuid to root */
> - =A0 =A0 =A0 strcat((char *)Cmd_buffer, main_test_dir);
> - =A0 =A0 =A0 strcat((char *)Cmd_buffer, (const char *)"/create_link ");
> =A0 =A0 =A0 =A0strcat((char *)Cmd_buffer, Path_name);
>
> =A0 =A0 =A0 =A0if (system((const char *)Cmd_buffer) !=3D 0) {

    I'll look at this and resolve it tonight, but I think your
solution is correct... I just need to look at the source a bit
better...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
