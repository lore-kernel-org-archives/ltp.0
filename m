From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 30 Jun 2017 16:26:09 +0200
Subject: [LTP] [PATCH] tutorial: Add a step-by-step C test tutorial
In-Reply-To: <20170630113858.GA18305@rei.lan>
References: <20170629142724.20004-1-rpalethorpe@suse.com>
 <20170630113858.GA18305@rei.lan>
Message-ID: <87y3s9y2ke.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
>> A tutorial for writing a complete, if simple test.
>
> Great work, a few comments below.
>

Thanks!

>> +2.1. Find an untested System call
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Try to find an untested system call which has a manual page (i.e. `man
>> +syscall` produces a result). You get extra points for finding one which is not
>> +tested by the kernel self tests either.
>
> For newly added syscalls checking out man-pages git makes much more
> sense, the manpages package tends to be at least a year old for stable
> distros.

OK.
>
> I tend to omit comments in examle source code and rather explain the
> code in a dedicated paragraph or two. Otherwise newbies send patches
> with overly commented code.
>

OK, I will try, it could be too difficult for some things, but I can
warn about over commenting.

>> +[source,make]
>> +------------------------------------------------------------------------------
>> +# Copyright (c) 2017 Linux Test Project
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation; either version 2 of
>> +# the License, or (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>
> Let's keep the headers consistent, we should put the URL instead of the
> address here as well.

Whoops!

>
>> +top_srcdir		?= ../../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> +
>> +------------------------------------------------------------------------------
>> +
>> +This will automatically add 'statx01.c' as a build target producing a
>> +'statx01' executable. Unless you have heavily deviated from the tutorial, and
>> +probably need to change 'top_srcdir', nothing else needs to be done.
>> +
>> +Assuming you are in the test's subdirectory 'testcases/kernel/syscalls/statx',
>> +do
>> +
>> +[source,shell]
>> +--------------------------------------------------------------------------------
>> +$ make
>> +$ ./statx01
>> +--------------------------------------------------------------------------------
>> +
>> +This should build the test and then run it. However, even though the test is
>> +in the syscalls directory it won't be automatically ran as part of the
>> +syscall's test group (remember './runltp -f syscalls' from the README?). For
>> +this we need to add it to the 'runtest' file. So open 'runtest/statx' and add
>> +the lines starting with a '+'.
>
> I would add sentence or two explaining the runtest format. At least tell
> the user that it's test_id whitespace(s) executable_name.

OK and mention the help file on it.

>
>> +[source,diff]
>> +--------------------------------------------------------------------------------
>> + statvfs01 statvfs01
>> + statvfs02 statvfs02
>> + 
>> ++statx01 statx01
>> ++
>> + stime01 stime01
>> + stime02 stime02
>> + 
>> +--------------------------------------------------------------------------------
>> +
>> +3.1 Report TCONF instead of TPASS
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Maybe the test should report "TCONF: Not implemented" instead or perhaps
>> +'TBROK'. Try changing it do so (see doc/test-writing-guidelines.txt).
>> +
>> +3.2 Check Git ignores the executable
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Create a new branch and commit the new files, but makes sure the 'statx01'
>> +executable is ignored.
>
> Git will not allow commiting files that are listed in .gitignore
> files.

That is basically what the reader is supposed to be checking (that they
have created the .gitignore correctly). If they copy and pasted my
instructions then the .gitignore is wrong and statx01 won't be ignored
:-p. I will hint that they should pay close attention to the output of
'git status'.

>
> Also we should probably expand this section with setting up git
> user.name and email, adding files to a commit and finally commiting the
> changes. I know that there is pleny of git tutorials out there, but
> let's keep this howto reasonably complete.

OK, I think I can cover this in limited detail and also mention rebasing
and formating patches. Submitting clean patches to a mailing list will
be totally alien to a lot of open source newbies.

>
> Here again, I would preffere less comments in the code and more
> description in the text. Or maybe we should show the whole test code
> without any comments, then follow up with a pieces of it with a
> paragraph that describes it. Something as:
>
> [source,c]
> --------------------------------------------------------------------------------
> static void run(void)
> {
> 	struct statx statxbuf = { 0 };
>
> 	TEST(sys_statx(0, NULL, 0, 0, &statxbuf));
>
> 	if (TEST_RETURN == 0)
> 		tst_res(TFAIL, "statx thinks it can stat NULL");
> 	else if (TEST_ERRNO == EFAULT)
> 		tst_res(TPASS, "statx set errno to EFAULT as expected");
> 	else
> 		tst_res(TFAIL | TERRNO, "statx set errno to some unexpected value");
> }
> --------------------------------------------------------------------------------
>
> This is the main testing function. According to the man page statx with
> NULL path should fail with EFAULT. The TEST macro just runs statx and
> sets TEST_RETURN and TEST_ERRNO. Also note that setting TERRNO in
> tst_res() flags will cause a description of the current errno (not
> TEST_ERRNO) value to be printed.
>
> I know that commenting example code is much easier than this, but as far
> as I can tell this will produce better results in long term. I happened
> to spend a few days deleting comments copy&pasted from example test
> source code in LTP and I do not want to repeat that mistake.

LOL.

>> +
>> +If you have begun to explore the LTP library headers or older tests then you
>> +may have come across functions from the old API such as 'tst_brkm'. The first
>> +argument of 'tst_brkm' is a pointer to a cleanup function and it does not use
>> +the 'tst_test' structure. The old API is being phased out, so you should not
>> +use these functions.
>
> I would have removed the sentence that describes the old API. All that
> reader needs to know at this point is that it lives simultaneously to
> the new one and that it's being phased out.
>
> The first rule of the old API is that we do not talk about the old API.
> Unless we do, of course, but we should at least pretend that we dont
> :-).

I take this to mean that you want me to remove the middle sentence and
not the whole paragraph.

>
>> +So far the 'statx' test and its 'cleanup' function are very simple. Our
>> +example doesn't answer the question "what happens if part of the cleanup
>> +fails?". We can answer this by modifying the test to call 'statx' on a
>> +symbolic link instead of the original file. This naturally expands our 'setup'
>> +and 'cleanup' callbacks. I will just include the relevant parts below.
>> +
>> +[source,c]
>> +--------------------------------------------------------------------------------
>> +#define SNAME "This is an additional name for the file"
>                     ^
> 		    Here again just "test_file_symlink" or something.

:-(

OK.

>> +
>> +...
>> +
>> +static void setup(void)
>> +{
>> +	SAFE_TOUCH(FNAME, 0777, NULL);
>> +	SAFE_SYMLINK(FNAME, SNAME);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_UNLINK(SNAME);
>> +	SAFE_UNLINK(FNAME);
>> +}
>> +
>> +static void run(void)
>> +{
>> +        ...
>> +	
>> +	TEST(sys_statx(AT_FDCWD, SNAME, 0, STATX_BASIC_STATS, &statxbuf));
>> +	if (TEST_RETURN == 0)
>> +		tst_res(TPASS, "It returned zero so it must have worked!");
>> +	else
>> +		tst_res(TFAIL | TERRNO, "statx can not stat a basic file");
>> +}
>> +--------------------------------------------------------------------------------
>> +
>> +If 'SAFE_TOUCH' succeeds, but 'SAFE_SYMLINK' fails, then cleanup will still be
>> +completed correctly. The behavior of 'tst_brk' is different inside of the
>> +'cleanup' function. Instead of exiting the callback, it merely prints a
>> +warning (TWARN) and returns to the cleanup method.
>
> We may also explain why it's different, something along the lines that
> we want to continue cleanup anyway in order to give a best shot on
> getting the system in a clean state.

OK,

>
>> +However this code is not following best practices. Generally you should avoid
>> +creating lots of unnecessary warning messages by checking if a resource exits
>> +before attempting to clean it up. If 'SAFE_TOUCH' or 'SAFE_SYMLINK' failed, we
>> +will already have an error message for that. It is not necessary to check if
>> +the file actually exists before calling 'SAFE_UNLINK', instead we can use a
>> +heuristic, such as checking if a variable has been set (see the mount example
>> +in 2.2.1 of the test writing guide).
>
> Also the test library removes the temporary directory recursively,
> hence we may as well note here that this kind of cleanup is not needed
> at all.

It says in the Test Writing Guidelines that we should delete it manually
due to funny behavior on NFS? If this is not the case then I should
contrive another reason to have cleanup.

>
> This is off topic but I guess that it's time to introduce .tests pointer
> to tst_test that takes array of pointers to test functions so that we
> avoid creating dispatch functions like this...

Yeah.

> I guess that we should probably cover forking in a sepratate document
> like this one.

If people read this document :-p. I'm sure they will, but it might be
useful to get some feedback first.

-- 
Thank you,
Richard.
