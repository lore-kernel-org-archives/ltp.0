From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 12 May 2021 12:34:29 +0200
Subject: [LTP] [PATCH v3 3/4] lib: ignore SIGINT in _tst_kill_test
In-Reply-To: <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
References: <20210508055109.16914-4-liwang@redhat.com>
 <dfdd8e9a-90ca-642d-1c21-da169ca3878f@jv-coder.de>
 <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
Message-ID: <c83db09b-81b7-abad-1c8c-6375f7c2c63d@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,
>> A possible fix could be using SIGTERM instead of SIGINT. This signal
>> does not seem to have some "intelligent" handling for background processes.
> I agree. Can you make a patch to replace that INT?
>
> (and this is only a timeout issue, so patch merging may be delayed due
> to LTP new release)
I'd like to supply the patch, I've placed it on my todo list. I will 
probably not finish it before the release,
but since it will probably not be included anyway, it doesn't matter.
I do not know why LTP used SIGINT in the first place. My first thought
>> would have been to use SIGTERM.  It is the way to "politely ask
>> processes to terminate"
> Yes, but that not strange to me, the possible reason is just to
> stop(ctrl ^c) the LTP test manually for debugging, so we went
> too far for using SIGINT but forget the original purpose :).
Ok sounds reasonable. The nice think about changing timeout to SIGTERM 
would be,
that abort using CTRL+C is clearly distinguishable from a timeout.

J?rg
