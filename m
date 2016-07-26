From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 26 Jul 2016 07:56:01 -0700
Subject: [LTP] [PATCH V3 02/23] Add knob to control tirpc support
In-Reply-To: <20160726143554.GH11679@rei.lan>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-2-raj.khem@gmail.com>
 <20160726143554.GH11679@rei.lan>
Message-ID: <CAMKF1sqxM_i04fZoGnT45_Xg6Ei3RjmRsV5S80g9pDQ+BdGyqQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jul 26, 2016 at 7:35 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> allow to disable tirpc. Helps to disable it at top level for eg. musl it
>> does not yet work.
>
> This is the same as the numa one, should be done in the m4/ltp-tirpc.m4

OK. I have few other patches related to configure which I havent yet submitted
I will fix redo it and send it with the second set.

>
> --
> Cyril Hrubis
> chrubis@suse.cz
