From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 05 Dec 2017 10:20:50 +0000
Subject: [LTP] [PATCH v3 12/12] hotplug/cpu_hotplug: Remove bashism
	disown from kill_pid()
In-Reply-To: <20171205082107.c3pfhqhtqe7c3kef@dell5510> (Petr Vorel's message
 of "Tue, 5 Dec 2017 09:21:07 +0100")
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-13-punit.agrawal@arm.com>
 <20171205082107.c3pfhqhtqe7c3kef@dell5510>
Message-ID: <87po7twk59.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Petr Vorel <pvorel@suse.cz> writes:

>> From: James Morse <james.morse@arm.com>
>
>> disown is a bashism not present in dash. kill_pid() already sends the
>> process SIGKILL.
>
>> Remove the "disown" to allow running in shells that don't support
>> disown.
>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---
> Acked-by: Petr Vorel <pvorel@suse.cz>

Thanks for looking through the patches and providing Acks.

Regards,
Punit
