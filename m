From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 30 Nov 2017 12:56:17 +0000
Subject: [LTP] [PATCH v2 09/13] syscalls/mount03: Copy setuid_test to
	execute instead of 'TEST FILE'
In-Reply-To: <20171130122142.GA2924@rei> (Cyril Hrubis's message of "Thu, 30
 Nov 2017 13:21:43 +0100")
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-10-punit.agrawal@arm.com>
 <20171129132019.GC18489@rei>
 <87609t112h.fsf@e105922-lin.cambridge.arm.com>
 <20171130122142.GA2924@rei>
Message-ID: <87tvxcylfy.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > What is the exact error here? I guess that the file does not have
>> > execute bit set and that check kicks in first?
>> 
>> I have a feeling that we might be cross-talking on this one.
>> 
>> IIUC, the intention for the test is to try and execute the binary
>> setuid_test (built from setuid_test.c). Instead, the test creates a file
>> named "setuid_test" at the mount location and writes "TEST FILE" into
>> it.
>> 
>>        snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
>>        SAFE_FILE_PRINTF(cleanup, file, "TEST FILE");
>> 
>> It then tries to execute this file containing the text string which
>> fails with the message -
>> 
>> /bin/sh: 0: Can't open /tmp/mouc0EQuB/mntpoint/setuid_test
>> mount03     6  TPASS  :  mount(2) passed with rwflag = 2
>> 
>> The patch copies the file setuid_test into the mounted filesystem at
>> which point we no longer get the "/bin/sh:" message.
>
> Ah, right, I was under an impression that suid programs cannot be
> executed on MS_NOSUID mounted FS. But after consulting mount() manual
> page that was true for ancient kernels before 2.4 and the suid bits are
> simply ignored in this case on newer kernels.
>
> So yes we need to execute a helper that tries to set privileged uid.
>
> The idea of this patch is correct then, but we need to clean up a bit.
>
> First of all all binary helpers should start with the prefix of the test
> that uses them, so in this case the helper should be renamed to
> mount03_setuid.c, secondly you are supposed to use the
> TST_RESOURCE_COPY() macro instead of the function itself and it should
> be done once in the test setup as well as the code that sets the actual
> setuid bit.

The copying can't be done in setup() as the test filesystem hasn't been
mounted yet.

I've folded the rest of your suggestions into the patch.

Let me know if you're done reviewing the rest of the series - I can send
out an update with the changes we've discussed in the next day or so
after a bit of testing and tidy-up.

Thanks,
Punit

