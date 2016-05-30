From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 30 May 2016 16:56:28 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <20160530142131.GA7416@rei>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
 <20160530142131.GA7416@rei>
Message-ID: <CA+icZUWRAiAx6bJKNC=Ci6bjR8+jk61ea+xBLcD1Rchu6u7GYg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 5/30/16, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> The 1st issue I tried to hack by...
>>
>> # diff -uprN testcases/bin/acl_test01.orig testcases/bin/acl_test01
>> --- testcases/bin/acl_test01.orig       2016-05-30 15:11:10.771931080
>> +0200
>> +++ testcases/bin/acl_test01    2016-05-30 15:22:31.627909726 +0200
>> @@ -41,8 +41,6 @@ export TCID=acltest01
>>  export TST_TOTAL=5
>>  export TST_COUNT=1
>>
>> -. test.sh
>> -
>>  TMP=${TMP:=/tmp}
>>
>>  TEST_USER1="acltest1"
>> @@ -54,6 +52,8 @@ FILE_ACL="$TMP/tacl/mount-ext3/test_file
>>  FILE_ACL_LINK="$TMP/tacl/mount-ext3/test_file_link"
>>  TCbin=`pwd`
>>
>> +. $TCbin/test.sh
>> +
>>  COMMAND=$(command -v "getenforce" "setenforce" |wc -l)
>>  if [ $COMMAND -eq 2 ]; then
>>         SELINUX=$(getenforce)
>>
>> Not sure if this correct.
>
> No it's not. You have to have path to testcases/bin/ directory in $PATH
> in order to run a LTP testcase (and it's even written in
> documentation...).
>
> Strangely enough the $PATH should be set correctly when you run
> testcases via runltp. That is one of the first things done in setup() in
> that script. And it works fine for me.
>
> The TCbin should be removed from the test entirely.
>

Hi,

Sorry, I jumped to v20160510 w/o reading the new docs.

I am bit confused.
Add /path/to/testcases/bin into $PATH or should it work without this?
OOTB it does not work here w/o the hackery.

>> For the 2nd issue - dunno what's going on.
>
> Looks like the do_cleanup is executed twice. Once via trap do_cleanup
> EXIT and once at the end of the script. This should be fixed.
>

As said I use now v20160510.
Was this fixed post-v20160510?
Can you give me a hand - which commit/patch do you mean?

>> Beyond all this, how can I test the work of Andreas with LTP?
>> Any help appreciated.
>
> I guess that kernel/syscalls/*xattr* should be relevant.
>

I am only a tester - not more not less.

- Sedat -
