Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PbjDv-00057E-Uv
	for ltp-list@lists.sourceforge.net; Sun, 09 Jan 2011 00:33:31 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PbjDu-0004f2-Qn
	for ltp-list@lists.sourceforge.net; Sun, 09 Jan 2011 00:33:31 +0000
Received: by pzk12 with SMTP id 12so3550956pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 08 Jan 2011 16:33:25 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1721058193.119579.1294116494383.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Sat, 8 Jan 2011 16:33:20 -0800
Message-Id: <783A1EB7-BF40-4188-BF63-81C2C43EAAAE@gmail.com>
References: <1721058193.119579.1294116494383.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] hugemmap05 issues
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
To: CAI Qian <caiqian@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Jan 3, 2011, at 8:48 PM, CAI Qian wrote:

> 
>> TESTDIR isn't publicly visible anymore because people really shouldn't
>> be mucking around with that value, or querying it if they haven't
>> called tst_tmpdir (which is actually what you did in this test!).
> I am sorry about that. That is why I had sent a follow-up patch to address
> it,
> http://marc.info/?l=ltp-list&m=129379291515012&w=2
> 
>>> Again, what issues are your facing with this code?
>>>> + char *tmp_tstdir;
>>>> +
>>>> + tmp_tstdir = get_tst_tmpdir();
>>>> + if (tmp_tstdir == NULL)
>>>> + tst_brkm(TBROK|TERRNO, cleanup, "get_tmp_tstdir failed");
>>>> + snprintf(s, BUFSIZ, "%s/hugemmap05/file", tmp_tstdir);
>>>> + free(tmp_tstdir);
>>>> +
>>>> + fd = open(s, O_CREAT|O_RDWR, 0755);
>>>> if (fd == -1)
>>>> tst_brkm(TBROK|TERRNO, cleanup, "open");
>>>> addr = mmap(ADDR, (long)(length * MB), PROTECTION, FLAGS, fd,
>>>> @@ -195,19 +203,14 @@ static void overcommit(void)
>>>> return;
>>>> fclose(fp);
>>>> }
>>>> - if (shmid != -1) {
>>>> - tst_resm(TINFO, "shmid: 0x%x", shmid);
>>>> - shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
>>>> - if (shmaddr == (void *)-1)
>>>> - tst_brkm(TBROK|TERRNO, cleanup, "shmat");
>>>> - write_bytes(shmaddr);
>>>> - read_bytes(shmaddr);
>>>> - } else {
>>>> - write_bytes(addr);
>>>> - read_bytes(addr);
>>>> - }
>>> As you can read from the help(), the test can allocate hugepages
>>> either
>>> from shmget() or mmap(). In case of shmget(), a global variable
>>> shmid with
>>> the default value -1 will be change to 1 via command-line,
>> 
>> Ok, I must have missed that part. Sorry...
>> 
>>> static option_t options[] = {
>>>        { "s", &opt_sysfs, NULL},
>>>        { "m", &shmid, NULL},
>>>        { "a:", &opt_alloc, &opt_allocstr},
>>>        { NULL, NULL, NULL}
>>> };
>>> 
>>> Therefore, there is a need to call shmat(). That is why it only call
>>> it
>>> when shmid != -1. In case of mmap(), there is no need to call
>>> shmat().
>>>> + tst_resm(TINFO, "shmid: 0x%x", shmid);
>>>> + shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
>>>> + if (shmaddr == (void *)-1)
>>>> + tst_brkm(TBROK|TERRNO, cleanup, "shmat");
>>>> + write_bytes(shmaddr);
>>>> + read_bytes(shmaddr);
>>>> if (opt_sysfs) {
>>>> - tst_resm(TINFO, "check sysfs.");
>>>> + tst_resm(TINFO, "checking sysfs.");
>>>> if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
>>>> length / 2) != 0)
>>>> return;
>>>> @@ -221,7 +224,7 @@ static void overcommit(void)
>>>> != 0)
>>>> return;
>>>> } else {
>>>> - tst_resm(TINFO, "check /proc/meminfo.");
>>>> + tst_resm(TINFO, "checking /proc/meminfo.");
>>> If you are going to change the syntax here, there are many other
>>> places
>>> also need to changed to be consistent like,
>>> "check sysfs."
>>> "check /proc/meminfo before allocation."
>>> etc
>> 
>> Agreed. It was just an example, and the point was to clearly state
>> with proper verb tenses so that people could get a clear idea of what
>> the test was doing instead of having to read the code to decypher the
>> intent of the test writer. Granted, I've gotten lazy and stopped
>> fixing some of these items in later commits because of all of the LOCs
>> I've made, but it needs to be fixed later because the grammar and
>> spelling used by test writers is less than desirable, which makes it
>> hard for folks trying to understand what the intention is behind these
>> tests.
> OK.

I applied your fixes but the test is still buggy in the following ways:

1. It has to be run as root (otherwise it fails with EPERM opening the file).
2. Even when the test is run as root it leaves around allocated hugepages, despite the fact that the temporary filesystem has been unmounted.

Please address these issues.
Thanks,
-Garrett
------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
