From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 29 Nov 2017 16:50:30 +0000
Subject: [LTP] [PATCH v2 09/13] syscalls/mount03: Copy setuid_test to
	execute instead of 'TEST FILE'
In-Reply-To: <20171129132019.GC18489@rei> (Cyril Hrubis's message of "Wed, 29
 Nov 2017 14:20:19 +0100")
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-10-punit.agrawal@arm.com>
 <20171129132019.GC18489@rei>
Message-ID: <87609t112h.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> When testing the MS_NOSUID mount flag, mount03 forgets to copy
>> setuid_test into the new filesystem. Instead it writes 'TEST FILE' into
>> a new file and attempts to execute it with S_ISUID. This fails, but not
>> for the reasons ltp expects.
>
> What is the exact error here? I guess that the file does not have
> execute bit set and that check kicks in first?

I have a feeling that we might be cross-talking on this one.

IIUC, the intention for the test is to try and execute the binary
setuid_test (built from setuid_test.c). Instead, the test creates a file
named "setuid_test" at the mount location and writes "TEST FILE" into
it.

       snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
       SAFE_FILE_PRINTF(cleanup, file, "TEST FILE");

It then tries to execute this file containing the text string which
fails with the message -

/bin/sh: 0: Can't open /tmp/mouc0EQuB/mntpoint/setuid_test
mount03     6  TPASS  :  mount(2) passed with rwflag = 2

The patch copies the file setuid_test into the mounted filesystem at
which point we no longer get the "/bin/sh:" message.

>
> Anyway we really should check the errno from the exec() is EPERM which
> should have caught this problem.

I would argue that this is another problem with the test and should be
fixed in a separate patch on top.

Let me now if that makes sense. Or have I missed something?

Thanks,
Punit
