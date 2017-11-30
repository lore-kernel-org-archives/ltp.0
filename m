From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 30 Nov 2017 16:06:33 +0000
Subject: [LTP] [PATCH v2 10/13] getdtablesize01: Handle ENFILE errno
In-Reply-To: <20171130131259.GB2924@rei> (Cyril Hrubis's message of "Thu, 30
 Nov 2017 14:12:59 +0100")
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-11-punit.agrawal@arm.com>
 <20171130131259.GB2924@rei>
Message-ID: <87k1y7zr7a.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>>  //Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
>>  
>> -	if (count > 0)
>> -		close(count);
>>  	if (count == (max_val_opfiles - 1))
>>  		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
>
> We may also check for EMFILE here.

I don't understand what you're suggesting here.

>
>> +	else if (fd < 0 && errno == ENFILE)
>> +		tst_brkm(TBROK, cleanup, "Reached maximum number of open files for the system");
>                            ^
> 			   This should rather be TCONF i.e. skipped.

I've changed TBROK to TCONF now.

Thanks.

[...]

