From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 24 Sep 2020 09:55:47 +0100
Subject: [LTP] [PATCH v4 1/4] lib: add new cgroup test API
In-Reply-To: <CAEemH2eCEyebEBZhuQJ+FHs9UpWw_+A=D0vJbx6g8KixPTH4jA@mail.gmail.com>
References: <20200609095102.21153-1-liwang@redhat.com> <87pn6cycui.fsf@suse.de>
 <CAEemH2eqPgS=2n5NAgiVgE6Q+mie0=hiu-wn1OCrxPNEHnd1BA@mail.gmail.com>
 <87mu1gy6r8.fsf@suse.de>
 <CAEemH2eCEyebEBZhuQJ+FHs9UpWw_+A=D0vJbx6g8KixPTH4jA@mail.gmail.com>
Message-ID: <87blhvy2ng.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

>> Perhaps you meant:
>>
>> if (tst_is_mounted("cgroup"))
>>    cg_ver = TST_CGROUP_V1;
>> else
>>    cg_ver = TST_CGROUP_V2;
>>
>
> This is not enough for the version choice. As tst_is_mounted(?cgroup?) can't
> distinguish precisely what "cgroup" or "cgroup2" has been mounted. Because
> the function is fuzzy matching a string.
>> >
>> > To be honest, I hope a Linux distribution provides a pure way in cgroup
>> > using, which means just mounting V1 or V2 but not to mix together. Or, do
>> > you think LTP should handle the situation for the v1&v2 mixing mount?
>>
>> For now, I think we just need to use V1 if it is mounted. I don't like
>> the fact we have both mounted, but it seems most software can handle it,
>> so LTP should as well.
>>
>
> Agreed.

OK, I will send a patch unless you send one first.

-- 
Thank you,
Richard.
