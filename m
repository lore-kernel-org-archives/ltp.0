From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 30 May 2016 17:53:41 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <20160530153220.GB8207@rei.lan>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
 <20160530142131.GA7416@rei>
 <CA+icZUWRAiAx6bJKNC=Ci6bjR8+jk61ea+xBLcD1Rchu6u7GYg@mail.gmail.com>
 <20160530151115.GA8207@rei.lan>
 <CA+icZUVDvU2JK8AbPn2hVE8QHRUAxmk0k1QHeFgw+Ncsb2V9FA@mail.gmail.com>
 <20160530153220.GB8207@rei.lan>
Message-ID: <CA+icZUXB6jxR6Ro==fZ8SSAKpHQ5PLd412CNg-x7SzD+vatBxg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 5/30/16, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> root# echo $PATH
>> /opt/cmake/bin:/opt/xorg/bin:/opt/llvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
>
> The path is added to the $PATH at the start of the runltp script, if you
> want to know if it was added correctly you have to do echo $PATH at the
> end of the setup() in runltp script.
>
>> root# cd /opt/ltp ; LC_ALL=C ./runltp -s acl_test01 | tee acl_test01.log
>>
>> [...]
>> TESTING ACLS FOR USER root
>> Trying extended acls for files
>> acltest01 1 TPASS : Extended acls for files.
>> Trying extended acls for file links
>> acltest01 2 TPASS : Extended acls for links.
>> /opt/ltp/testcases/bin/acl_test01: 44: .: test.sh: not found
>
> This is certainly unexpected.
>
> What is /bin/sh pointing to? Is this debian with dash?
>
> Still this should really work.
>

Hi,

# echo $PATH
/opt/cmake/bin:/opt/xorg/bin:/opt/llvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# cd /opt/ltp ; LC_ALL=C ./runltp -s acl_test01 | tee acl_test01.log
...
TESTING ACLS FOR USER root
Trying extended acls for files
acltest01 1 TPASS : Extended acls for files.
Trying extended acls for file links
acltest01 2 TPASS : Extended acls for links.
/opt/ltp/testcases/bin/acl_test01: 44: .: test.sh: not found

loop: can't delete device /dev/loop2: No such device or address
incrementing stop
<<<execution_status>>>
...

# echo $PATH
/opt/cmake/bin:/opt/xorg/bin:/opt/llvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

No change in $PATH after executing runltp.
The loop-thingie fails once now.

YES, dash is the default-shell on Ubuntu/precise.

# LC_ALL=C ls -l /bin/sh
lrwxrwxrwx 1 root root 4 Mar 29  2012 /bin/sh -> dash

>> > Should be fixed -> I'm about to push a fix, stay tuned.
>> >
>> > The cleanup has been executefd twice at least since 2010 and possibly
>> > since the testcase was introduced.
>> >
>>
>> OK, I am patient.
>> Thanks for the explanations.
>
> Fixed in:
>
> https://github.com/linux-test-project/ltp/commit/ee2d3ee269264198837726304873195134a4232c
>

Yupp, I tested with this new version of acl_test01.

>> > And I am only a test maintainer.
>> >
>> > But seriously I've glanced over the patches and it seems to implement
>> > {get,set,remove}xattr via generic handlers instead of fs specific
>> > handlers. And we have syscall tests for {get,set,remove}xattr...
>> >
>>
>> Is there a testcase around - runnable via "runltp -s $testcase_script".
>
> These are executed as a part of syscall tests.
>
> You can simply do ./runltp -s xattr to execute all testcases that have
> xattr in their name.
>

Thanks.

This looks good - only the cgroup_xattr FAILS.
Andreas might have a look.

# cat results/LTP_RUN_ON-2016_05_30-17h_49m_41s.log
Test Start Time: Mon May 30 17:49:42 2016
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
getxattr01                     PASS       0
getxattr02                     PASS       0
getxattr03                     PASS       0
llistxattr01                   PASS       0
llistxattr02                   PASS       0
llistxattr03                   PASS       0
removexattr01                  PASS       0
removexattr02                  PASS       0
setxattr01                     PASS       0
setxattr02                     PASS       0
setxattr03                     PASS       0
cgroup_xattr                   FAIL       1

-----------------------------------------------
Total Tests: 12
Total Skipped Tests: 0
Total Failures: 1
Kernel Version: 4.7.0-rc1-2-iniza-small
Machine Architecture: x86_64
Hostname: fambox

- Sedat -
-------------- next part --------------
A non-text attachment was scrubbed...
Name: LTP_RUN_ON-2016_05_30-17h_49m_41s.log
Type: application/octet-stream
Size: 959 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160530/bf3d9ddb/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xattr.log
Type: application/octet-stream
Size: 205062 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160530/bf3d9ddb/attachment-0003.obj>
