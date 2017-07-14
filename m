From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Jul 2017 11:16:08 +0800
Subject: [LTP] [PATCH V2 03/14] mem/oom: fix the timeout issue
In-Reply-To: <87lgnsiu3f.fsf@our.domain.is.not.set>
References: <20170410100556.4465-1-liwang@redhat.com>
 <20170410100556.4465-4-liwang@redhat.com>
 <20170707151137.GF28534@rei.lan>
 <CAEemH2fbJmvYQapOJ1A-1BqeGa5QuY_03ncNY_3qbk7by3XufA@mail.gmail.com>
 <87lgnsiu3f.fsf@our.domain.is.not.set>
Message-ID: <CAEemH2dvgWj0NaiGOLHauMzYu1g-zK9q1UomSF+AXomXqfB+-w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 13, 2017 at 5:06 PM, Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Li Wang writes:
>
>> +       if (tst_test->timeout) {
>> +               if (tst_test->timeout > 0)
>> +                       tst_set_timeout(tst_test->timeout);
>> +       } else {
>>                 tst_set_timeout(300);
>> +       }
>
> Only a minor nit, but it is easier to read without nesting, so we could have:
>
> if (tst_test->timeout > 0) {
>    tst_set_timeout(tst_test->timeout);
> } else if (tst_test->timeout == 0) {
>    tst_set_timeout(300);
> }

Yes, seems the brace is also redundant.



-- 
Li Wang
liwang@redhat.com
