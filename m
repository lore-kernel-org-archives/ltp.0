From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 30 May 2016 17:25:32 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <20160530151115.GA8207@rei.lan>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
 <20160530142131.GA7416@rei>
 <CA+icZUWRAiAx6bJKNC=Ci6bjR8+jk61ea+xBLcD1Rchu6u7GYg@mail.gmail.com>
 <20160530151115.GA8207@rei.lan>
Message-ID: <CA+icZUVDvU2JK8AbPn2hVE8QHRUAxmk0k1QHeFgw+Ncsb2V9FA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 5/30/16, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> I am bit confused.
>> Add /path/to/testcases/bin into $PATH or should it work without this?
>
> If you run a testcase by hand you have to add it to $PATH. If you run a
> testcase via runltp script the script does that for you. And it has been
> so for last few years.
>
>> OOTB it does not work here w/o the hackery.
>
> Even if you start the test via runltp?
>
> I've tried that and this works fine for me.
>

Hmmm.

root# echo $PATH
/opt/cmake/bin:/opt/xorg/bin:/opt/llvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

root# cd /opt/ltp ; LC_ALL=C ./runltp -s acl_test01 | tee acl_test01.log

[...]
TESTING ACLS FOR USER root
Trying extended acls for files
acltest01 1 TPASS : Extended acls for files.
Trying extended acls for file links
acltest01 2 TPASS : Extended acls for links.
/opt/ltp/testcases/bin/acl_test01: 44: .: test.sh: not found

/dev/loop2 on /tmp/ltp-y9NKWCxzX3/tacl/mount-ext3 type ext3
(rw,relatime,data=ordered)
loop: can't delete device /dev/loop2: No such device or address
loop: can't delete device /dev/loop2: No such device or address
incrementing stop
...

>> >> For the 2nd issue - dunno what's going on.
>> >
>> > Looks like the do_cleanup is executed twice. Once via trap do_cleanup
>> > EXIT and once at the end of the script. This should be fixed.
>> >
>>
>> As said I use now v20160510.
>> Was this fixed post-v20160510?
>> Can you give me a hand - which commit/patch do you mean?
>
> Should be fixed -> I'm about to push a fix, stay tuned.
>
> The cleanup has been executefd twice at least since 2010 and possibly
> since the testcase was introduced.
>

OK, I am patient.
Thanks for the explanations.

>> >> Beyond all this, how can I test the work of Andreas with LTP?
>> >> Any help appreciated.
>> >
>> > I guess that kernel/syscalls/*xattr* should be relevant.
>> >
>>
>> I am only a tester - not more not less.
>
> And I am only a test maintainer.
>
> But seriously I've glanced over the patches and it seems to implement
> {get,set,remove}xattr via generic handlers instead of fs specific
> handlers. And we have syscall tests for {get,set,remove}xattr...
>

Is there a testcase around - runnable via "runltp -s $testcase_script".

Thanks in advance.

- Sedat -
