From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 17 Aug 2021 12:53:34 +0100
Subject: [LTP] [PATCH 3/3] Add test for CVE 2018-13405
In-Reply-To: <f1b416ce-cacf-55be-a7cd-bcff821d0ec7@suse.cz>
References: <20210806154557.19551-1-mdoucha@suse.cz>
 <20210806154557.19551-3-mdoucha@suse.cz> <87sfz8l68q.fsf@suse.de>
 <f1b416ce-cacf-55be-a7cd-bcff821d0ec7@suse.cz>
Message-ID: <87pmucl22p.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Martin,

Martin Doucha <mdoucha@suse.cz> writes:

> On 17. 08. 21 12:23, Richard Palethorpe wrote:
>> Hello Martin,
>> 
>> Martin Doucha <mdoucha@suse.cz> writes:
>>> +static void setup(void)
>>> +{
>>> +	struct stat buf;
>>> +	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
>>> +	struct group *ltpgroup = SAFE_GETGRNAM("bin");
>> 
>> These might not exist on some systems. I think you can just pick
>> arbitrary UID/GID numbers instead. No need to check the user/group
>> databases.
>
> I'm planning to rewrite this test after the first two patches get
> merged. See previous discussion under the creat08 patch.

Ah, yes, sorry.

>
>
>>> +static void cleanup(void)
>>> +{
>>> +	SAFE_SETREUID(-1, orig_uid);
>> 
>> Why are you doing this? I am assuming the temp dir will be deleted by
>> the parent process.
>
> That assumption is incorrect.
>
> https://github.com/linux-test-project/ltp/commit/3833d44a2ba3773359d3b35a2108af691d75b4f9

This looks different as we call semctl in the cleanup callback. It
appears the testdir/tempdir cleanup is done from the parent
process. i.e. from do_exit() which is only called if pid == lib_pid.

-- 
Thank you,
Richard.
