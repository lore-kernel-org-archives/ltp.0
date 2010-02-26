Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nl6Yw-00052Q-1w
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 20:13:26 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nl6Yv-0000dp-5s
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 20:13:25 +0000
Received: by pzk8 with SMTP id 8so360036pzk.11
	for <ltp-list@lists.sourceforge.net>;
	Fri, 26 Feb 2010 12:13:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d270b4401002202353pec0431w4a2bb947544ff444@mail.gmail.com>
References: <d270b4400912250122y371c4d4dq6fa729b60e03f8a5@mail.gmail.com>
	<20100111162256.GB19010@saboteur.suse.cz>
	<20100128041619.GB16209@malik-laptop.in.ibm.com>
	<d270b4401002202353pec0431w4a2bb947544ff444@mail.gmail.com>
Date: Fri, 26 Feb 2010 12:13:19 -0800
Message-ID: <364299f41002261213q24890454jac60233bd8f92ded@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Testcase to validate the memory usage limit imposed by
	the topmost memory cgroup
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
To: Mohamed Naufal <naufal11@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Sat, Feb 20, 2010 at 11:53 PM, Mohamed Naufal <naufal11@gmail.com> wrote:
>
>
> On 28 January 2010 09:46, Sudhir Kumar <skumar@linux.vnet.ibm.com> wrote:
>>
>> On Mon, Jan 11, 2010 at 05:22:56PM +0100, Cyril Hrubis wrote:
>> > Hi!
>> >
>>
>
> [...]
>
>
>>
>> >
>> > You can't allocate memory from signal handler. There is a list of signal
>> > safe
>> > functions in 'man 7 signal'. The correct solution for this is to create
>> > something like named pipe and sleep in read() on it (instead of
>> > 'while(!flag_exit) sleep(1)').
>> Naufel,
>> You might like to address the comments by Cyril. For named pipes you can
>> see man mkfifo in bash or open in c where you can specify the file as a
>> pipe or FIFO. A busy wait like you implemented is not a good practice.
>> Repost your patches with the comments addressed.
>>
>
> [...]
>
> These are the testcases I plan to implement (taken from
> http://workouts.foss.in/2009/index.php/Hacking_Linux_Kernel_Through_testing)
>
> 1. Validate the upper limit imposed by the topmost hierarchy.
>
> 2. Test the testcase no 1 for subgroups far below in hierarchy.
>
> 3. A group has n siblings. They start consuming memory and the total
> increases to more than parent's limit. Check if the group with max memory
> consumption gets it's task killed.
>
> 4. Write a test which uses lots of memory, reaches swap limits and ensure it
> gets killed.
>
> 5. A task is running in a group which has a limit N on memory.limit_in_bytes
> but no limit on memory.memsw.limit_in_bytes. The system has swap memory in
> use and the task's memory consumption is >> N. Therefore the task should be
> using a big amount of swap memory(say M) > N. Try to set the
> memory.memsw.limit_in_bytes to a low value say N. It should fail to change
> the limits.
>
> 6. In test no 5 instead of changing the mem+swap limits turn the swap off.
> Since the memory usage of the task is more than the current limits the task
> should be killed.
>
> The first testcase has been attached. Reimplemented using named pipes.

Next time please attach and also paste the diff inline in the email as
some MTAs will remove attachments.

1. Avoid for i in $(seq ). Use i=0; while [ $i -lt $TST_TOTAL ] ; do
... : $(( i += 1 )); done (it's POSIXly correct and doesn't require
external utilities).
2. Use hard tabs instead of 4 space tabs.
3. Semi-colons at the end of lines in bourne shell aren't required;
please remove them.
4. Why are you doing this?

+    pushd $TST_PATH/mnt > /dev/null
+    mkdir $TST_PATH/mnt/$i 2> /dev/null
+    pushd $i > /dev/null

mkdir $TST_PATH/mnt/$i should be enough. Don't do 2> /dev/null please!

5. This isn't standard:

+    popd > /dev/null
+    rmdir $i 2> /dev/null
+    popd > /dev/null

Please use rm -Rf $i

6. sleep 1 may not be long enough is mmapping a large section of memory.
7. What if I specified a negative value via -m ?

+  if(!memsize)
+      errx(3, "Invalid usage");

8. Run through a spellchecker.
9. You can assume that $LTPROOT/testcases/bin is automatically added
to $PATH; thus implicitly hardcoding the path to the executable seems
rather silly.
10. if [ ! $(grep -w memory /proc/cgroups | cut -f4) == "1" ] <-- a.
`==' is a bashism. b. you can do != in place of ! $(grep ... ) c.
please quote the value that you're grabbing on the left via grep so it
doesn't emit nasty noise from test(1).
11. KILLED_CNT=$(($KILLED_CNT + 1)) could be : $(( KILLED_CNT += 1 ))
(POSIXly correct).
12. #define STATUS_PIPE "/tmp/status_pipe" is poorly hardcoded. Set
$TMP in the script like so:

export TMP=${TMP:-/tmp}

cd to $TMP at the start of the test.

Remove /tmp/ from the constant above.

Thanks,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
