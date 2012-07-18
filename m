Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <marios.makris@gmail.com>) id 1SrUKD-0003kn-1D
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 13:29:57 +0000
Received: from mail-wi0-f175.google.com ([209.85.212.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SrUK7-00027a-9S
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 13:29:56 +0000
Received: by wibhm2 with SMTP id hm2so3704809wib.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Jul 2012 06:29:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5006829C.7080308@cn.fujitsu.com>
References: <1342194676-15275-1-git-send-email-marios.makris@gmail.com>
	<1342194676-15275-4-git-send-email-marios.makris@gmail.com>
	<5006829C.7080308@cn.fujitsu.com>
Date: Wed, 18 Jul 2012 16:29:44 +0300
Message-ID: <CAMYrgfQP3WbVWeT_qVOAbiGUsZnSeLGY6LY03juBYbEWqZckHA@mail.gmail.com>
From: "marios.makris" <marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 4/6] /lib/tst_tmpdir.c removed / and * checks
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
To: ltp-list@lists.sourceforge.net

On 18 July 2012 12:32, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> On 07/13/2012 11:51 PM, Marios Makris wrote:
>> These checks are implemented in the rmobj.c file therefore there is no
>> need to repeat them here since rmobj() is called for deletions.
>>
>> Signed-off-by: Marios Makris <marios.makris@gmail.com>
>> ---
>>  lib/tst_tmpdir.c |   17 -----------------
>>  1 file changed, 17 deletions(-)
>>
>> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
>> index b6f4d2e..a9dd78c 100644
>> --- a/lib/tst_tmpdir.c
>> +++ b/lib/tst_tmpdir.c
>> @@ -194,8 +194,6 @@ void tst_tmpdir(void)
>>
>>  void tst_rmdir(void)
>>  {
>> -     struct stat buf1;
>> -     struct stat buf2;
>>       char current_dir[PATH_MAX];
>>       char *errmsg;
>>       char *parent_dir;
>> @@ -229,21 +227,6 @@ void tst_rmdir(void)
>>       }
>>
>>       /*
>> -      * Check that the value of TESTDIR is not "*" or "/".  These could
>> -      * have disastrous effects in a test run by root.
>> -      */
>> -     if (stat(TESTDIR, &buf1) == 0 && stat("/", &buf2) == 0 &&
>> -             buf1.st_ino == buf2.st_ino) {
>> -             tst_resm(TWARN, "%s: will not remove /", __func__);
>> -             return;
>> -     }
>> -
>> -     if (strchr(TESTDIR, '*') != NULL) {
>> -             tst_resm(TWARN, "%s: will not remove *", __func__);
>> -             return;
>> -     }
>
> Seems that rmobj() doesn't check the "*" there?
>
> Thanks,
> Wanlong Gao
>

Hi and thanks for reviewing.

Well rmobj doesn't check for "*", but it uses remove and unlink and
if i am not wrong they don't do the "*" expansion?



-- 
Marios Makris

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
