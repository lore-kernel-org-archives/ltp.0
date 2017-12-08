From: Punit Agrawal <punit.agrawal@arm.com>
Date: Fri, 08 Dec 2017 10:41:37 +0000
Subject: [LTP] [PATCH v3 10/12] getdtablesize01: Handle ENFILE errno
In-Reply-To: <20171208102737.GB13286@rei> (Cyril Hrubis's message of "Fri, 8
 Dec 2017 11:27:37 +0100")
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-11-punit.agrawal@arm.com>
 <20171208102737.GB13286@rei>
Message-ID: <87zi6tv6vy.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> -	for (loop = 1; loop <= max_val_opfiles; loop++) {
>> +	for (loop = 0; ; loop++) {
>
> Why not just for (;;) ?
>
> I do not see that we use the loop variable anywhere in the code.

You're right - the loop variable can be dropped entirely.
