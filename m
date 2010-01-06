Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1NSVAv-0001lK-6n
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 12:39:45 +0000
Received: from mail-bw0-f212.google.com ([209.85.218.212])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSVAs-0006zQ-NK
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 12:39:45 +0000
Received: by mail-bw0-f212.google.com with SMTP id 4so10780200bwz.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 06 Jan 2010 04:39:28 -0800 (PST)
Message-ID: <4B447E4E.5040203@petalogix.com>
Date: Wed, 06 Jan 2010 13:13:02 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4B4204D2.70204@petalogix.com> <4B43E6FD.3020906@web.de>	
	<364299f41001051741v7a2bb1d0p91d28aa25967b93e@mail.gmail.com>
	<364299f41001051831r6a0f4930t6ba61e4273c797e3@mail.gmail.com>
In-Reply-To: <364299f41001051831r6a0f4930t6ba61e4273c797e3@mail.gmail.com>
Subject: Re: [LTP] lchown test case
Reply-To: michal.simek@petalogix.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Jiri Palecek <jpalecek@web.de>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Garrett Cooper wrote:
> On Tue, Jan 5, 2010 at 5:41 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>> On Tue, Jan 5, 2010 at 5:27 PM, Jiri Palecek <jpalecek@web.de> wrote:
>>> Michal Simek napsal(a):
>>>> Hi,
>>> Hi,
>>>> I have some problems with lchown02 test which is caused with this patch.
>>>> What is prep_create_link?
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>>
>>>> http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=commitdiff;h=ee1a022fc76076d7fc1b6b1797c195244414c038
>>>>
>>>>
>>>>
>>>> diff --git a/runtest/syscalls b/runtest/syscalls
>>>> index fbe8641..34631ed 100644 (file)
>>>> --- a/runtest/syscalls
>>>> +++ b/runtest/syscalls
>>>> @@ -462,10 +462,10 @@ kill12 kill12
>>>>
>>>> lchown01 lchown01
>>>> lchown01_16 lchown01_16
>>>> -lchown02 cp -p $LTPROOT/testcases/bin/create_link $TMP; lchown02
>>>> -lchown02_16 cp -p $LTPROOT/testcases/bin/create_link $TMP; lchown02_16
>>>> +lchown02 prep_create_link; lchown02
>>>> +lchown02_16 prep_create_link; lchown02_16
>>> IMHO it should do the same as the line above. But I think the whole thing
>>> could be deleted without causing any grief:
>>>
>>> http://repo.or.cz/w/ltp-debian.git?a=commit;h=a5499edcf368fa88df924f94ffcbe63c22b46e82
>> The test needs create_link in $TMP; that's why I scripted it as a
>> one-liner (but stupid me probably forgot to add the script to CVS
>> -_-).
>> Let me look and I'll get back to you shortly.
> 
> Fixed. The executable needed CAP_CHOWN capability and that's part of
> the point behind that script...

ok. I rerun the latest code and lchown02 testcases still failing.
I added two printf messages (path:Path_name -  and buffer:Cmd_buffer) 
which you can see below. And remove tst_rmdir to see if file exist or not.


path /tmp/ltp-XXXX1ZaUjj/lch6m6mr0
buffer /mnt/4/ltp/build/testcases/bin/create_link 
/tmp/ltp-XXXX1ZaUjj/lch6m6mr0/tfile_1
change_owner: chown() of /tmp/ltp-XXXX1ZaUjj/lch6m6mr0/tfile_1 failed, 
error 1
lchown02    1  TBROK  :  Fail to modify tfile_1 ownership(s)!
lchown02    2  TBROK  :  Remaining cases broken
lchown02    3  TBROK  :  Remaining cases broken
lchown02    4  TBROK  :  Remaining cases broken
lchown02    5  TBROK  :  Remaining cases broken
lchown02    6  TBROK  :  Remaining cases broken
lchown02    7  TBROK  :  Remaining cases broken
path /tmp/ltp-XXXX1ZaUjj/lchouwHqq
buffer /mnt/4/ltp/build/testcases/bin/create_link 
/tmp/ltp-XXXX1ZaUjj/lchouwHqq/tfile_1
change_owner: chown() of /tmp/ltp-XXXX1ZaUjj/lchouwHqq/tfile_1 failed, 
error 1
lchown02    1  TBROK  :  Fail to modify tfile_1 ownership(s)!
lchown02    2  TBROK  :  Remaining cases broken
lchown02    3  TBROK  :  Remaining cases broken
lchown02    4  TBROK  :  Remaining cases broken
lchown02    5  TBROK  :  Remaining cases broken
lchown02    6  TBROK  :  Remaining cases broken
lchown02    7  TBROK  :  Remaining cases broken


The problem is at first with create_link because there is used 
/mnt/4/ltp/build/testcases/bin/create_link instead of 
/tmp/ltp-XXXX1ZaUjj/create_link which is setup by prep_create_link

Please test the patch below which run correct version on my system

Then I tried to run lchown02 test under user and I think that this line 
in prep_create_link is addtional
#chown root:root "$TMP/create_link"

lchown test must be run under root that's why create_link will have root 
rights and under user test reports that must be run as root.

lchown02    1  TBROK  :  Test must be run as root
lchown02    2  TBROK  :  Remaining cases broken
lchown02    3  TBROK  :  Remaining cases broken
lchown02    4  TBROK  :  Remaining cases broken
lchown02    5  TBROK  :  Remaining cases broken
lchown02    6  TBROK  :  Remaining cases broken
lchown02    7  TBROK  :  Remaining cases broken
lchown02    1  TBROK  :  Test must be run as root
lchown02    2  TBROK  :  Remaining cases broken
lchown02    3  TBROK  :  Remaining cases broken
lchown02    4  TBROK  :  Remaining cases broken
lchown02    5  TBROK  :  Remaining cases broken
lchown02    6  TBROK  :  Remaining cases broken
lchown02    7  TBROK  :  Remaining cases broken


Thanks for testing,
Michal


--- lchown02-old.c      2010-01-06 12:59:32.000000000 +0100
+++ lchown02.c  2010-01-06 13:00:49.000000000 +0100
@@ -112,7 +112,6 @@
  char Longpathname[PATH_MAX + 2];
  char High_address_node[64];
  char EXEC_DIR[PATH_MAX];
-char main_test_dir[PATH_MAX + 2];

  struct test_case_t {           /* test case struct. to hold ref. test 
cond's */
         char *pathname;
@@ -265,12 +264,6 @@
         /* Pause if that option was specified */
         TEST_PAUSE;

-       /* remember current dir, because create_link has been copied here */
-       if (getcwd(main_test_dir, sizeof(main_test_dir)) == NULL) {
-               tst_brkm(TBROK | TERRNO, cleanup,
-                        "failed to get the current working directory.");
-       }
-
         /* Make a temp dir and cd to it */
         tst_tmpdir();

@@ -339,12 +332,13 @@

         strcpy(Path2_name, Path_name);

+       /* Get the command name to be executed as setuid to root */
+       strcat((char *)Cmd_buffer, Path_name);
+       strcat((char *)Cmd_buffer, (const char *)"/../create_link ");
+
         /* Get the path of test file created under temporary directory */
         strcat(Path_name, "/" TEST_FILE1);

-       /* Get the command name to be executed as setuid to root */
-       strcat((char *)Cmd_buffer, main_test_dir);
-       strcat((char *)Cmd_buffer, (const char *)"/create_link ");
         strcat((char *)Cmd_buffer, Path_name);

         if (system((const char *)Cmd_buffer) != 0) {






> -Garrett


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
