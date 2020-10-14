From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Date: Wed, 14 Oct 2020 09:44:05 +0900
Subject: [LTP] [PATCH] syscalls/mq_notify: Don't fail if mq_notify is
 not supported
In-Reply-To: <20201013122555.GC29925@yuki.lan> (Cyril Hrubis's message of
 "Tue, 13 Oct 2020 14:25:55 +0200")
References: <20201005092029.3482531-1-punit1.agrawal@toshiba.co.jp>
 <20201013122555.GC29925@yuki.lan>
Message-ID: <871ri1d4bu.fsf@kokedama.swc.toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +	} else if (TEST_ERRNO == ENOSYS) {
>> +		tst_resm(TCONF | TTERRNO, "mq_notify not available (ENOSYS)");
>
> Pushed with a minor change, removed the ENOSYS from the string since it
> will be printed because of the TTERRNO flag, thanks.

I see the committed patch. Thanks for fixing it up.
