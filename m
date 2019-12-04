From: Li Wang <liwang@redhat.com>
Date: Wed, 4 Dec 2019 17:26:59 +0800
Subject: [LTP] [PATCH 1/2] lib: add tst_request_hugepages
In-Reply-To: <CAEemH2d0KJ_oi7j5sjcT=uUo28crB_hCs-gJzvWhczvKOG-mdA@mail.gmail.com>
References: <20191128084506.7587-1-liwang@redhat.com>
 <20191203104917.GA2844@rei>
 <CAEemH2d0KJ_oi7j5sjcT=uUo28crB_hCs-gJzvWhczvKOG-mdA@mail.gmail.com>
Message-ID: <CAEemH2doR7C6J4ROgLw=cJsWfH2-6y8-YwDwdGM8coH6ovM6_Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Dec 4, 2019 at 2:40 PM Li Wang <liwang@redhat.com> wrote:

> ...
> if the .needs_hugepages is set to an expected number, we should verify
> strictly if the system can provide that.
>

Oh, I guess maybe I misunderstand your suggestion here. you mean just to
let .needs_hugepages = 1 but not set an expected number, right? if so, that
will more easy to achieve.


>
>> Also this fails to cleanup after itself, we have to restore the system
>> after the test, which is one more reason why we need .needs_hugepages in
>> the tst_test structure because the test library can cleanup after the
>> test with that.
>>
>
> Agree, I will add the save/restore part for this.
>

Or just go with .save_restore in the testcase?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191204/6ae5a7b1/attachment.htm>
